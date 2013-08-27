From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2] Set core.precomposeunicode to true on e.g. HFS+
Date: Tue, 27 Aug 2013 07:33:16 -0700
Message-ID: <xmqqzjs3fbkj.fsf@gitster.dls.corp.google.com>
References: <201308271550.41448.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Aug 27 16:33:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEKKk-0002J7-6x
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 16:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354Ab3H0OdW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Aug 2013 10:33:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49158 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752059Ab3H0OdV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Aug 2013 10:33:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E7023CD5E;
	Tue, 27 Aug 2013 14:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/GdKHxrmtmzl
	qm+MF/iC5wCitJ0=; b=D5RiNfmE3lwao5Sn/dt4z0eIFi2zFi60oVK9xvmAJ1dt
	i1PFzMttC2lKj1ntBbYW4sYnLzRA4H87rATAV/8sWm8XAayNaraRsY1IaRlOo1hV
	3/QT5svXWt0BfXfEb/FcKefQfbAtsvHrBSPoxIIrPa7RHSxTczshiwoDkBt4Vnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=x9MCxT
	WVy7vPskjnXgpXOcER4NEKVS6Gt0Xa/iS/2FpBIcFUMgM0NfMq77n8xhrj4GIvb/
	XQBqEIfOFA0OoId0sbgallZ3zjHJcl6NtTc/fk7AuFvtc4B9Pzi/bNN7Rl+maY9H
	2JW28lkAq/oqCreYFt9Mg2bHYtDcNW9RYa6Sw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78D6A3CD5D;
	Tue, 27 Aug 2013 14:33:20 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A83623CD5B;
	Tue, 27 Aug 2013 14:33:19 +0000 (UTC)
In-Reply-To: <201308271550.41448.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Tue, 27 Aug 2013 15:50:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9E672322-0F25-11E3-BF88-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233091>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> When core.precomposeunicode was introduced in 76759c7d,
> it was set to false on a unicode decomposing file system like HFS+
> to be compatible with older versions of Git.
>
> The Mac OS users need to find out that this configuration exist
> and change it manually from false to true.

Yeah, I think this makes sense.

I actually wonder why we thought that the way 76759c7d (git on Mac
OS and precomposed unicode, 2012-07-08) did "add the variable to the
config but do not enable" was a good idea.  If I recall correctly,
the justification was "that way the users will not be suddenly
affected by the behaviour change, but can notice an unfamiliar
variable in their configuration and flip it as needed"; I said that
it did not make sense to me ($gmane/188940) back then and now I
think with this patch we are in agreement ;-).

> -		/* Indicate to the user, that we can configure it to true */
> -		if (!access(path, R_OK))
> -			git_config_set("core.precomposeunicode", "false");
> -		/* To be backward compatible, set precomposed_unicode to 0 */
> -		precomposed_unicode =3D 0;
> +		precomposed_unicode =3D access(path, R_OK) ? 0 : 1;
> +		git_config_set("core.precomposeunicode", precomposed_unicode ? "tr=
ue" : "false");

This test is very conservative in that only a successful access()
will flip the bit; I like it.

Will queue.  Thanks.

>  		strcpy(path + len, auml_nfc);
>  		if (unlink(path))
>  			die_errno(_("failed to unlink '%s'"), path);
> diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
> index 05d78d2..6b3cedc 100755
> --- a/t/t0050-filesystem.sh
> +++ b/t/t0050-filesystem.sh
> @@ -91,6 +91,7 @@ test_expect_failure CASE_INSENSITIVE_FS 'add (with =
different case)' '
>  test_expect_success "setup unicode normalization tests" '
>  	test_create_repo unicode &&
>  	cd unicode &&
> +	git config core.precomposeunicode false &&
>  	touch "$aumlcdiar" &&
>  	git add "$aumlcdiar" &&
>  	git commit -m initial &&
> diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose=
=2Esh
> index 5fe57c5..e4ba601 100755
> --- a/t/t3910-mac-os-precompose.sh
> +++ b/t/t3910-mac-os-precompose.sh
> @@ -36,7 +36,7 @@ Alongc=3D$Alongc$AEligatu$AEligatu                 =
    #254 Byte
> =20
>  test_expect_success "detect if nfd needed" '
>  	precomposeunicode=3D`git config core.precomposeunicode` &&
> -	test "$precomposeunicode" =3D false &&
> +	test "$precomposeunicode" =3D true &&
>  	git config core.precomposeunicode true
>  '
>  test_expect_success "setup" '
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 5ee97b0..f0f8cde 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -958,7 +958,6 @@ test_expect_success 'submodule with UTF-8 name' '
>  		git add sub &&
>  		git commit -m "init sub"
>  	) &&
> -	test_config core.precomposeunicode true &&
>  	git submodule add ./"$svname" &&
>  	git submodule >&2 &&
>  	test -n "$(git submodule | grep "$svname")"
