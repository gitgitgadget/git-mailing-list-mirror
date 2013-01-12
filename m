From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH v5] git-completion.bash: add support for path completion
Date: Sat, 12 Jan 2013 13:53:13 +0100
Message-ID: <50F15CB9.5090603@gmail.com>
References: <1357930123-26310-1-git-send-email-manlio.perillo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, szeder@ira.uka.de,
	felipe.contreras@gmail.com, peff@peff.net
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 13:53:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu0as-0002GR-GM
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 13:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100Ab3ALMx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 07:53:29 -0500
Received: from mail-bk0-f51.google.com ([209.85.214.51]:48199 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab3ALMx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 07:53:29 -0500
Received: by mail-bk0-f51.google.com with SMTP id ik5so1316335bkc.24
        for <git@vger.kernel.org>; Sat, 12 Jan 2013 04:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=KacKQjJVIjD6adRhLj1JricIjKRTijD91K3M1an5h4A=;
        b=PBF/r+/ktPmP38rNC+zvwxlk/vY5jGMfaODJWPoN06xPMdid+nS71Ncrg1gK2WGeqO
         nQjKUutpNrfSeAp/I7Ffwkael0ztptxozq02zq8QUQUNHzeAolQNtYgN02rxc7Ayvort
         7WbDuWF5jSWwli1Xxa4kH1DoAdw4BCw1ofHNPlFBwudsE3zTzwZ9I/am3UvA/hJrhmTu
         zgySxq+/yUIHg73c5Ea/jsb53MSj5phzGHdwA7V+c0fQR3Dr+U0d6V9FhC59EJRWs9Y9
         e4dW+U8w+LFjIyas+zKRd1otQIxQMBRsiUh7gujRf1KoQ1D97Sg/xD5L7638KHuuJ9G4
         0qHQ==
X-Received: by 10.204.146.6 with SMTP id f6mr36846015bkv.69.1357995207582;
        Sat, 12 Jan 2013 04:53:27 -0800 (PST)
Received: from [192.168.0.3] ([151.70.213.78])
        by mx.google.com with ESMTPS id i20sm6164449bkw.5.2013.01.12.04.53.25
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Jan 2013 04:53:26 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <1357930123-26310-1-git-send-email-manlio.perillo@gmail.com>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213280>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 11/01/2013 19:48, Manlio Perillo ha scritto:
> The git-completion.bash script did not implemented full, git aware,
> support to complete paths, for git commands that operate on files within
> the current working directory or the index.
> [...]
>  
> +# Try to count non option arguments passed on the command line for the
> +# specified git command.
> +# When options are used, it is necessary to use the special -- option to
> +# tell the implementation were non option arguments begin.
> +# XXX this can not be improved, since options can appear everywhere, as
> +# an example:
> +#	git mv x -n y
> +#
> +# __git_count_arguments requires 1 argument: the git command executed.
> +__git_count_arguments ()
> +{
> +	local word i c=0
> +
> +	# Skip "git" (first argument)
> +	for ((i=1; i < ${#words[@]}; i++)); do
> +		word="${words[i]}"
> +
> +		case "$word" in
> +			--)

Sorry, I have incorrectly (again) indented the case labels.
I have now configured my editor to correctly indent this.

> +				# Good; we can assume that the following are only non
> +				# option arguments.
> +				((c = 0))
> +				;;

Here I was thinking to do something like this (not tested):

		-*)
			if [ -n ${2-} ]; then
				# Assume specified git command only
                                # accepts simple options
				# (without arguments)
				((c = 0))

Since git mv only accepts simple options, this will make the use of '--'
not required.

Note that I'm assuming the single '-' character is used as a non-option
argument; not sure this is the case of Git.

> [...]


Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDxXLkACgkQscQJ24LbaUR+QQCaA4WZP5h5lktXJqSB7c494fAY
B6IAoIRWyIzBq29S7+l+TfRjbyp19HNL
=JRpR
-----END PGP SIGNATURE-----
