From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] Fix linking with OpenSSL
Date: Fri, 5 May 2006 11:57:54 +0400
Message-ID: <20060505075754.GA7237@mipter.zuzino.mipt.ru>
References: <20060504222550.GA7236@mipter.zuzino.mipt.ru> <7vwtd12z6h.fsf@assigned-by-dhcp.cox.net> <7vslnp2y5x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 09:59:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbvDy-00051Y-KM
	for gcvg-git@gmane.org; Fri, 05 May 2006 09:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWEEH7j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 03:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbWEEH7j
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 03:59:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:1656 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030339AbWEEH7j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 May 2006 03:59:39 -0400
Received: by nf-out-0910.google.com with SMTP id k27so299596nfc
        for <git@vger.kernel.org>; Fri, 05 May 2006 00:59:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ZyPWREbsjsnu6MeQDDuY+tZHUilJN3deZNbaq1Gz8oac1bBj41lZZVJnpdXCGisbpTpMRrHnCTPBB94XXrywnZdwmIZtNlURPX5c0hUdHV1TBlre6CpLYoKfke5OI82ylNSZ9GRkOOoeto0HfvR27wjSm8og3r8yM4RVwBn0PXs=
Received: by 10.49.43.12 with SMTP id v12mr323676nfj;
        Fri, 05 May 2006 00:59:37 -0700 (PDT)
Received: from gmail.com ( [217.10.38.130])
        by mx.gmail.com with ESMTP id y24sm906700nfb.2006.05.05.00.59.36;
        Fri, 05 May 2006 00:59:37 -0700 (PDT)
Received: by gmail.com (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	adobriyan@gmail.com; Fri,  5 May 2006 11:57:56 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vslnp2y5x.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19603>

On Thu, May 04, 2006 at 04:00:26PM -0700, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> > Alexey Dobriyan <adobriyan@gmail.com> writes:
> >> For those who put it into interesting (read: default) place.
> >>
> >> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> >>
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -559,7 +559,7 @@ git-http-push$X: revision.o http.o http-
> >>  
> >>  git-rev-list$X: rev-list.o $(LIB_FILE)
> >>  	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> >> -		$(LIBS) $(OPENSSL_LIBSSL)
> >> +		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
> >>  
> >>  init-db.o: init-db.c
> >>  	$(CC) -c $(ALL_CFLAGS) \
> >
> > We used to depend on bignum from openssl for rev-list
> > (merge-order), and if I remember correctly that was the only
> > reason built recipe for rev-list is different from other
> > programs.  I wonder if we can just get rid of this thing, and
> > have it built with git-%$X rule like everybody else.
> >
> > Can somebody try that out and report what happens?
> 
> Well, I did.  Alexey, does this work for you?

It does. It also crashes busybox patch applet. Oh, well...

> --- a/Makefile
> +++ b/Makefile
> @@ -564,10 +564,6 @@ git-http-push$X: revision.o http.o http-
>  	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
>  		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
>  
> -git-rev-list$X: rev-list.o $(LIB_FILE)
> -	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> -		$(LIBS) $(OPENSSL_LIBSSL)
> -
>  init-db.o: init-db.c
>  	$(CC) -c $(ALL_CFLAGS) \
>  		-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"' $*.c
