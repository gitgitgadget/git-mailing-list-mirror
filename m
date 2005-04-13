From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Slight enhancement of GIT wrapper
Date: Thu, 14 Apr 2005 00:55:10 +0200
Message-ID: <20050413225509.GL25711@pasky.ji.cz>
References: <200504132249.16848.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 00:52:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLqiZ-00016D-DM
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 00:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVDMWzY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 18:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVDMWzY
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 18:55:24 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40632 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261218AbVDMWzL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2005 18:55:11 -0400
Received: (qmail 21257 invoked by uid 2001); 13 Apr 2005 22:55:10 -0000
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Content-Disposition: inline
In-Reply-To: <200504132249.16848.pisa@cmp.felk.cvut.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Apr 13, 2005 at 10:49:16PM CEST, I got a letter
where Pavel Pisa <pisa@cmp.felk.cvut.cz> told me that...
> Ahoj Petre,

Hi,

cc'ing git@vger.kernel.org so that we hopefully get less of duplicated
work (and maybe even some more insights).

> Index: commit-id
> ===================================================================
> Index: git
> ===================================================================
> --- 6c355da7a316f50742eeffa49405a15e75526012/git  (mode:100755 sha1:f766a87adff6e17d24cd97417d7303f2cdab6f3c)
> +++ 85f2d458ffebf52569e777af222accc1268afdf9/git  (mode:100755 sha1:c179a65c3955e39bda18dc8a314b061bc0fb5de7)
> @@ -9,6 +9,7 @@
>  # This command mostly only multiplexes to the individual script based
>  # on the first argument.
>  
> +
>  error () {
>  	echo git: $@ >&2
>  }
> @@ -17,6 +18,25 @@
>  	exit 1
>  }
>  
> +cwd="`pwd 2> /dev/null`"

Please use $() instead of ``.

Why do you silence stderr?

> +
> +if [ -h "$0" ]; then
> +  GIT_DIR=`ls -l "$0" | sed 's/^.*-> *\(.*\) *$/\1/'`

Well, I don't like this much, but I'm not sure how to do better.

> +  GIT_DIR=`dirname "$GIT_DIR"`
> +else
> +  GIT_DIR=`dirname "$0"`
> +fi

We use tabs for indentation.

> +cd "$GIT_DIR"
> +GIT_DIR="`pwd 2> /dev/null`"

Why do you silence stderr?

> +cd "$cwd" 2> /dev/null
> +if [ $? -gt 0 ] ; then
> +  die "Cannot return back to the CWD $cwd"
> +fi

I'd personally just cd "$cwd" || exit 1

> +
> +export PATH=$GIT_DIR:$PATH

You should add $GIT_DIR to $PATH only when it is not there already. This
way you can still override some of the git tools by stuffing your
overrides to $PATH.

> +
> +#echo GIT_DIR=$GIT_DIR
> +#echo PATH=$PATH

?

>  
>  help () {
>  	cat <<__END__

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
