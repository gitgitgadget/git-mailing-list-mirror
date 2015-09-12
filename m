From: Julian Andres Klode <jak@debian.org>
Subject: Re: [PATCH] hooks/update: Add a hooks.denyunsignedtags option
Date: Sat, 12 Sep 2015 12:40:32 +0200
Message-ID: <20150912123905.GA15958@debian.org>
References: <1442054253-15780-1-git-send-email-jak@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bdwalton@gmail.com, davvid@gmail.com, hvoigt@hvoigt.net,
	johnflux@gmail.com, gitster@pobox.com, madcoder@debian.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 12 12:40:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaiEc-0006AG-4n
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 12:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269AbbILKkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2015 06:40:37 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35084 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbbILKkg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 06:40:36 -0400
Received: by wicge5 with SMTP id ge5so89106119wic.0
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 03:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=M9WOE3JTh5bjRk9Rglmu7wPaQOWGs8lHVKZYHTtohI8=;
        b=qLfHYEryrF+Ggy1kyFRYZEJ9R4O4g5GZ+nwRL3Rgrbjl1cfsZpITQ4IHUAIse7OWxo
         cVeVeRlGKotID25TZP9bQp0EHnavPk7u417/+OvVcnq7CcfBGymhjGYGLb5mHxIw1VvS
         gGLPyn9KtPALv2pPyC4zM6Q3ZmTHQdaYTrM+U/fwJmDd5hoHQm4/wB1m8YApXMBrMfWI
         mIZavLR8+6CgsXr9rWAffRJc7k/3RvdUdAyXB9gPk1NXztSEQJm4VWXinsF2OmZ47spe
         uIlqIfrmO4p6Sj5fYV46GGttPuOmrAvMmLb1rvfvPIQIllrHoSEPUS4LqBGc0dW1/vGF
         R8ew==
X-Received: by 10.194.204.198 with SMTP id la6mr6611898wjc.20.1442054434762;
        Sat, 12 Sep 2015 03:40:34 -0700 (PDT)
Received: from jak-x230 (p54B926B6.dip0.t-ipconnect.de. [84.185.38.182])
        by smtp.gmail.com with ESMTPSA id ej5sm4893024wjd.22.2015.09.12.03.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Sep 2015 03:40:34 -0700 (PDT)
Mail-Followup-To: Julian Andres Klode <jak@debian.org>, git@vger.kernel.org,
	bdwalton@gmail.com, davvid@gmail.com, hvoigt@hvoigt.net,
	johnflux@gmail.com, gitster@pobox.com, madcoder@debian.org
Content-Disposition: inline
In-Reply-To: <1442054253-15780-1-git-send-email-jak@debian.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277723>

On Sat, Sep 12, 2015 at 12:37:33PM +0200, Julian Andres Klode wrote:
> Introduce an option to deny unsigned tags from entering
> a repository. This is useful in teams where members forget
> to sign their release tags.
> 
> It does not actually check whether the signature is actually
> complete or valid, it just checks for the beginning of a
> signature, as further checks would be too involved.
> 
> This effectively also denies un-annotated tags, as those
> are unsigned by definition.
> 
> Signed-off-by: Julian Andres Klode <jak@debian.org>
> ---
>  templates/hooks--update.sample | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
[...]
> @@ -86,6 +90,14 @@ case "$refname","$newrev_type" in
>  		;;
>  	refs/tags/*,tag)
>  		# annotated tag
> +		if [ "$denyunsignedtag" != "true" ] || git cat-file -p $newrev | grep -q 'BEGIN PGP SIGNATURE'; then
> +			:
> +		else
> +			echo "*** Tag '$refname' is unsigned"
> +			echo "*** Unsigned tags are not allowed in this repository." >&2
> +	                exit 1

There are some accidental space characters in front of that, this is fixed locally
already. Sorry.

-- 
Julian Andres Klode  - Debian Developer, Ubuntu Member

See http://wiki.debian.org/JulianAndresKlode and http://jak-linux.org/.

Be friendly, do not top-post, and follow RFC 1855 "Netiquette".
    - If you don't I might ignore you.
