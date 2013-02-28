From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: zsh completion broken for file completion
Date: Thu, 28 Feb 2013 19:59:33 +0100
Message-ID: <512FA915.4080203@gmail.com>
References: <vpqtxowp9e2.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Feb 28 20:00:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UB8iR-0003x5-Up
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 20:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933069Ab3B1TAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2013 14:00:01 -0500
Received: from mail-ea0-f173.google.com ([209.85.215.173]:65390 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933067Ab3B1TAA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2013 14:00:00 -0500
Received: by mail-ea0-f173.google.com with SMTP id i1so206198eaa.18
        for <git@vger.kernel.org>; Thu, 28 Feb 2013 10:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=vqQFuSHhWD+oV5Mb3sOedpEfgtD51zvOMB7KXN85jRg=;
        b=oXLmQLoRVfZ1n3Q8F5qQOUB4BtFo1tnzeiDti1hu0hWzNH6rFPB8MYKrq0XSMLULSN
         uaz90qQkBkMN2BEdodWSw0PniwhPqrTbN7aV7dAi5i4O/SjO0xTKBycUoXtiiDpntItt
         8Qg4AnCD0bDSSICWkeH5b/Uu+kM9qAt0bL7C5FeI1EIj771wMZDbINsQbFt7vPSklMZx
         bdHgMUicQsJOsub/+jG6fULGfy64fFFz7YG/do0w1M0K0yumv170qE3V0pkFoeRL241Z
         vHJk1MhL9K2JaJrc3dX8pan+11Vhz4dZwzeIgV+K3rxskPiXwshtGYM8AHIc9Xn0kbwT
         ZxFg==
X-Received: by 10.15.101.204 with SMTP id bp52mr19262638eeb.31.1362077999142;
        Thu, 28 Feb 2013 10:59:59 -0800 (PST)
Received: from [192.168.0.3] ([151.70.216.108])
        by mx.google.com with ESMTPS id s3sm13288491eem.4.2013.02.28.10.59.56
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 28 Feb 2013 10:59:58 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <vpqtxowp9e2.fsf@grenoble-inp.fr>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217250>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 28/02/2013 19:43, Matthieu Moy ha scritto:
> Hi,
> 
> The completion for e.g. "git add file<tab>" is broken in master. I get
> the following result:
> 
> git add fo__gitcomp_file:8: command not found: compgen
> 
> The guilty commit is fea16b47b60 (Fri Jan 11 19:48:43 2013, Manlio
> Perillo, git-completion.bash: add support for path completion), which
> introduces a new __gitcomp_file function that uses the bash builtin
> "compgen", without redefining the function in git-completion.zsh.
> 
> [...] 
> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
> index 4577502..0ba1dcf 100644
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -60,6 +60,15 @@ __gitcomp_nl ()
>         compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
>  }
>  
> +__gitcomp_file ()
> +{
> +       emulate -L zsh
> +
> +       local IFS=$'\n'
> +       compset -P '*[=:]'
> +       compadd -Q -p "${2-}" -- ${=1} && _ret=0
> +}
> +

This patch is implemented in fea16b47b60, but only for the deprecated
zsh compatibility code inside git-completion.bash.

The reason I did not provided a patch for git-completion.zsh was because
there was a bug in this script [1].

If any changes are made to git-completion.zsh, please update
git-completion.bash, too.


[1] Basically, on my system I need the following change at the end of
    the file:

	-_git
	+autoload -U +X compinit && compinit
	+compdef _git git gitk

    I don't know the reason, however; and it seems that it is a problem
    only for me

> [...]


Regards  Malio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlEvqRUACgkQscQJ24LbaURASgCeILUTXAiZA6Ndf2DHByJfv4nT
2bMAn1gPqSdfIBzb0cexwYNoAuD5j2+O
=sKTR
-----END PGP SIGNATURE-----
