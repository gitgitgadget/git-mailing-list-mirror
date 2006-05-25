From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] Don't write directly to a make target ($@).
Date: Thu, 25 May 2006 19:41:25 +0300
Message-ID: <20060525194125.9380842a.tihirvon@gmail.com>
References: <87hd3e5ixw.fsf@rho.meyering.net>
	<7vejyixe5g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: jim@meyering.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 18:39:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjIsD-0004Do-4q
	for gcvg-git@gmane.org; Thu, 25 May 2006 18:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWEYQjh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 12:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbWEYQjh
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 12:39:37 -0400
Received: from hu-out-0102.google.com ([72.14.214.192]:17253 "EHLO
	hu-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030256AbWEYQjf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 12:39:35 -0400
Received: by hu-out-0102.google.com with SMTP id 23so1205764huc
        for <git@vger.kernel.org>; Thu, 25 May 2006 09:39:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=uS9wMnh6AQOWHW6IFCHWwW6IMimSDJB1e952ozTHRMT0jUbXgFjwqjFGOwXYd6rmsWXVAokYdricOCKhh/iOiBBLGJXyyBJTS2qGtF0NQ8WV2KJ21T/kLg1/EhHeYeUjvqjEQa8cA5e5//Q30a9UZlchAZFYUeE/mRstouMryuc=
Received: by 10.48.31.7 with SMTP id e7mr4209802nfe;
        Thu, 25 May 2006 09:39:33 -0700 (PDT)
Received: from garlic.home.net ( [82.128.200.31])
        by mx.gmail.com with ESMTP id o9sm5351373nfa.2006.05.25.09.39.31;
        Thu, 25 May 2006 09:39:32 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <7vejyixe5g.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20744>

Junio C Hamano <junkio@cox.net> wrote:

> Jim Meyering <jim@meyering.net> writes:
> 
> > Otherwise, if make is suspended, or killed with prejudice, or if the
> > system crashes, you could be left with an up-to-date, yet corrupt,
> > generated file.
> 
> Thanks.  Maybe you would want a "make clean" target for them too
> if you do this.  I often use $@+ instead of t$@ so that I can
> say "rm -f *+" there.
> 
> > @@ -496,37 +496,43 @@ builtin-help.o: common-cmds.h
> >  	rm -f $@ && ln git$X $@
> >  
> >  common-cmds.h: Documentation/git-*.txt
> > -	./generate-cmdlist.sh > $@
> > +	./generate-cmdlist.sh > t$@
> > +	mv t$@ $@
> >  
> 
> IOW, like this:
> 
> common-cmds.h: Documentation/git-*.txt
> 	rm -f $@+ $@
>         ./generate-cmdlist.sh > $@+
>         mv $@+ $@
> 
> clean::
> 	rm -f *+

Or just use one tmp file, i.e. ".tmp" instead of t$@.

-- 
http://onion.dynserv.net/~timo/
