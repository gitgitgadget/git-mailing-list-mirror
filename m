From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] cogito - split out cg-X* to prefix/lib/cogito
Date: Tue, 26 Apr 2005 22:25:19 +0200
Message-ID: <20050426202518.GK13224@pasky.ji.cz>
References: <200504260053.33506.jcorbin@wunjo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 22:22:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQWXr-0000np-2W
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 22:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVDZUZk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 16:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVDZUZk
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 16:25:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59023 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261573AbVDZUZU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 16:25:20 -0400
Received: (qmail 31543 invoked by uid 2001); 26 Apr 2005 20:25:19 -0000
To: "Joshua T. Corbin" <jcorbin@wunjo.org>
Content-Disposition: inline
In-Reply-To: <200504260053.33506.jcorbin@wunjo.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 26, 2005 at 06:53:33AM CEST, I got a letter
where "Joshua T. Corbin" <jcorbin@wunjo.org> told me that...
> The following patch does the following:
>   * Change the Makefile to install all cg-X* to $(prefix)/lib/cogito
>   * Modify all cg-* to use this lib prefix.
> 
> Basically the cg-* script looks at $0, if it appears to be in a prefix/bin 
> directory that also has a prefix/lib/cogito directory, look for the cg-X* 
> there; otherwise things will work as in old.
> 
> Signed-off-by: Joshua T. Corbin <jcorbin@wunjo.org>
> 
> Index: cg-Xdiffdo
> ===================================================================
> --- ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-Xdiffdo  (mode:100755 
> sha1:e3907b39ea105acb2f2ac3659f16898604b72d09)
> +++ bb131a04832677b22959ffe47f68900b94accc0c/cg-Xdiffdo  (mode:100755 
> sha1:832fd2c2a09274b5279327e1c31b99afc04fa7f1)
> @@ -12,7 +12,16 @@
>  #
>  # Outputs a diff converting the first tree to the second one.
>  
> -. cg-Xlib
> +if [ -z "$COGITO_LIB" ]; then
> +  COGITO_LIB=$(dirname $(dirname $0))/lib/cogito
> +  if [ -d $COGITO_LIB ]; then
> +    COGITO_LIB=$COGITO_LIB/
> +  else
> +    COGITO_LIB=
> +  fi
> +fi
> +
> +. ${COGITO_LIB}cg-Xlib
>  
>  
>  id1=$1; shift

I think this is wrong, stuffing too much redundant logic to all those
files. I'm fine with the last added line, but nothing more. What about
rewriting the scripts during make install, doing something like

	s/\${COGITO_LIB}/\${COGITO_LIB:-$(libdir)}/

?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
