From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/24] Documentation: Add variable-substitution script
Date: Mon, 26 Jul 2010 14:51:44 -0500
Message-ID: <20100726195144.GC1043@burratino>
References: <cover.1280169048.git.trast@student.ethz.ch>
 <049043aa444288fd9409a3706fe3190fd679cb7d.1280169048.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 26 21:53:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdTjQ-0000c6-6E
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 21:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161Ab0GZTwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 15:52:55 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49353 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955Ab0GZTwy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 15:52:54 -0400
Received: by wyf19 with SMTP id 19so2460611wyf.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 12:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kz8852kaintEN5c1LCRkrws4ph/EcCk0aa5MKWGvcFA=;
        b=AVI5TUSv8GtoT9UQeeQj9XH5fFl8o6Wwxrze4p8cUfeKPEl7akYTTLrEMfFISb369K
         VESu997wnc82/rxcdGBgfAlOkZfkZ5lkyKSA5LlW3LByrK59fJWk3UzUhheL85OuQf3v
         cg1yJNk9PkgbEbzjXbqdNJgLRfZuEH0sYV7Go=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vbx3M12uNgz1Qwk3L9AtX1/mvr/x4hs0uECtUDzqG0lIpENK3xTIgKV14r14cb3gMy
         Wg5MV26SOSDdTc+vMhuf+IkOxzmiL16THxKM4dMpBtWGDzGOFVZXOCJNG3GGAQIfndBC
         I6cjI8jRMwGs6+uBnHFAUoQMFOhQv51Wxn//o=
Received: by 10.216.158.80 with SMTP id p58mr7890057wek.44.1280173973345;
        Mon, 26 Jul 2010 12:52:53 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v16sm2201572weq.8.2010.07.26.12.52.50
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 12:52:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <049043aa444288fd9409a3706fe3190fd679cb7d.1280169048.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151888>

Thomas Rast wrote:

>   ./subst-config.perl <vars> <in> <out>
> 
> It first reads <vars> for variable-documenting blocks.  A line
> consisting of '<name>::' starts the block for <name>, except inside a
> '--' delimited block (which is used to generate sub-lists).  A block
> extends until the first blank line, which is what asciidoc also looks
> for.
> 
> Then it copies from <in> to <out>, substituting lines of the form
> 
>   @@CONFIG(<name>)@@
> 
> with the documentation block for <name>.

Neat.  Thanks for picking this up.  

I would like to make the git-config(1) man page more like the command
list in git(1) and less like a concatenation of CONFIGURATION
sections, but regardless, this is a good first step.

> diff --git a/Documentation/config-vars.txt b/Documentation/config-vars.txt
> index b82fada..3fcefe9 100644
> --- a/Documentation/config-vars.txt
> +++ b/Documentation/config-vars.txt
> @@ -689,6 +689,7 @@ diff.mnemonicprefix::
>  	standard "a/" and "b/" depending on what is being compared.  When
>  	this configuration is in effect, reverse diff output also swaps
>  	the order of the prefixes:
> +
>  diff.noprefix::
>  	If set, 'git diff' does not show any source or destination prefix.
>  `git diff`;;

Does this have an effect on the resulting markup?  It looks like an
independent syntax fix.

> +++ b/Documentation/subst-config.perl
> @@ -0,0 +1,74 @@
[...]
> +if (!$rc or (!-r $varlist or !-r $input)) {
> +    print "$0 --varlist=<varlist> --input=<in> --output=<out>\n";
> +    exit 1;
> +}

So the commit message is out of date (the new usage is more clear,
anyway).

> +%.txt.cv : %.txt subst-config.perl config-vars.txt

The asciidoc markup is supposed to itself be suitable documentation.
Maybe eventually we will have to drop that pretence and generate .txt
files at build time.

Acked-by: Jonathan Nieder <jrnieder@gmail.com>
