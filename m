From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-quiltimport.sh: disallow fuzz
Date: Wed, 24 Sep 2014 22:09:33 -0700
Message-ID: <xmqqwq8sb81e.fsf@gitster.dls.corp.google.com>
References: <20140924213512.GA7619@logfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?J=C3=B6rn?= Engel <joern@logfs.org>
X-From: git-owner@vger.kernel.org Thu Sep 25 07:09:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XX1JF-0004je-Da
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 07:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbaIYFJh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2014 01:09:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58108 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbaIYFJh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Sep 2014 01:09:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8AE743DD84;
	Thu, 25 Sep 2014 01:09:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RJ4iHCfAr+pa
	G9jbQ1dRjDAQeek=; b=MrBA+3DAwVezKzyQ8PbAb8oyWOaToLticaqF0JExtdtb
	YdjE/CcePf4srLB9s8JhzH/ZSqwreVwsfZ9xug5qVy8CthQqEIXYVnMVzR8YhEjC
	WCh4lXaD0Z+DMXWmEH5QlXcXAad1Ut8NgGYC3qQAIcdefHSQZYPylxVLYTzXYAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XWFtss
	Yp8dWX+qFUiIk1usrCUc6jfOTQcycFtBLK/LhfXS7rD791/ieg9vNJp7UtOuyIWQ
	FtjFm6pVyZrN1FhaxBltER4qvM//k19WMasK1oCXsG1OvUe463/czhiP5K3HuxdC
	raGBtylxxAlaBtdAsKVjwhR9kXTbxKH7LTwFc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8144B3DD83;
	Thu, 25 Sep 2014 01:09:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 03BAC3DD82;
	Thu, 25 Sep 2014 01:09:35 -0400 (EDT)
In-Reply-To: <20140924213512.GA7619@logfs.org> (=?utf-8?Q?=22J=C3=B6rn?=
 Engel"'s message of
	"Wed, 24 Sep 2014 17:35:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 24AD424A-4472-11E4-9CCE-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257471>

J=C3=B6rn Engel <joern@logfs.org> writes:

> git-quiltimport passed "-C1" to git-apply, supposedly to roughly matc=
h
> the quilt default of --fuzz 2.  This is against the spirit of git.
> Quoting Linus:
>   Except unlike the standard "patch" program, "git apply" doesn't acc=
ept
>   fuzz by default (which to me is a huge deal - I hate how "patch" tr=
ies
>   to apply stuff that clearly isn't valid any more)
>
> It also causes active harm when combining git-quiltimport with regula=
r
> quilt and quilt is used with --fuzz=3D0,...

This is fine for those who use quilt with --fuzz=3D0, but how are you
helping those who use quilt without --fuzz=3D0?

I agree that unconditionally passing -C1 is a bad thing, but
unconditionally passing -C2 is not that better.  Shouldn't this be
done by introducing a new --fuzz=3D<number> option to quiltimport?


>
> Signed-off-by: Joern Engel <joern@logfs.org>
> ---
>  git-quiltimport.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-quiltimport.sh b/git-quiltimport.sh
> index 167d79fea809..3eb2e2fd3648 100755
> --- a/git-quiltimport.sh
> +++ b/git-quiltimport.sh
> @@ -130,7 +130,7 @@ do
>  	fi
> =20
>  	if [ -z "$dry_run" ] ; then
> -		git apply --index -C1 ${level:+"$level"} "$tmp_patch" &&
> +		git apply --index ${level:+"$level"} "$tmp_patch" &&
>  		tree=3D$(git write-tree) &&
>  		commit=3D$( (echo "$SUBJECT"; echo; cat "$tmp_msg") | git commit-t=
ree $tree -p $commit) &&
>  		git update-ref -m "quiltimport: $patch_name" HEAD $commit || exit =
4
