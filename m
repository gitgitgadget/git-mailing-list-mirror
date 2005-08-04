From: Petr Baudis <pasky@suse.cz>
Subject: Re: Can't build RPM's from current cogito tree
Date: Fri, 5 Aug 2005 01:54:29 +0200
Message-ID: <20050804235428.GC3900@pasky.ji.cz>
References: <20050804204719.23F9D353C13@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 02:00:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0pdS-0006WC-5h
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 02:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262779AbVHDX5x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 19:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVHDXzG
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 19:55:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:28430 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262783AbVHDXyb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 19:54:31 -0400
Received: (qmail 15503 invoked by uid 2001); 4 Aug 2005 23:54:29 -0000
To: Wolfgang Denk <wd@denx.de>
Content-Disposition: inline
In-Reply-To: <20050804204719.23F9D353C13@atlas.denx.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Aug 04, 2005 at 10:47:19PM CEST, I got a letter
where Wolfgang Denk <wd@denx.de> told me that...
> Building of RPM's from the current cogito tree fails:
> 
> -> rpmbuild -ba cogito.spec 
> ...
> make -C tools install
> make[1]: Entering directory `/usr/local/BUILD/cogito-0.12.1/tools'
> gcc -g -O2 -Wall -o git-mailsplit mailsplit.c
> gcc -g -O2 -Wall -o git-mailinfo mailinfo.c
> install -m755 -d /usr/bin
> install: cannot change permissions of `/usr/bin': Operation not permitted
> make[1]: *** [install] Error 1
> make[1]: Leaving directory `/usr/local/BUILD/cogito-0.12.1/tools'
> make: *** [install-tools] Error 2
> error: Bad exit status from /var/tmp/rpm-tmp.6363 (%install)
> 
> 
> This fixes it:
> 
> diff --git a/Makefile b/Makefile
> --- a/Makefile
> +++ b/Makefile
> @@ -245,10 +245,10 @@ install-cogito: $(SCRIPT) $(LIB_SCRIPT) 
>  	done
>  
>  install-tools:
> -	$(MAKE) -C tools install
> +	$(MAKE) -C tools dest=$(DESTDIR) install
>  
>  install-doc:
> -	$(MAKE) -C Documentation install
> +	$(MAKE) -C Documentation dest=$(DESTDIR) install
>  
>  uninstall:
>  	cd $(DESTDIR)$(bindir) && rm -f $(PROG) $(SCRIPTS) $(SCRIPT) $(GEN_SCRIPT)

Thanks, I fixed it the other way around, changing Documentation/Makefile
to use $DESTDIR. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
