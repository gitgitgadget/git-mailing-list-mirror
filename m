From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 15/25] setup.c: detect $GIT_COMMON_DIR in is_git_directory()
Date: Wed, 26 Feb 2014 16:16:27 -0800
Message-ID: <xmqqr46p1kbo.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-16-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 01:16:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIoeX-0005B3-GC
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 01:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171AbaB0AQc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Feb 2014 19:16:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59827 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607AbaB0AQb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Feb 2014 19:16:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A17DC70161;
	Wed, 26 Feb 2014 19:16:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zj/Ey3t2X5S7
	pXBb8uAi2tqzeog=; b=qqE8eLrmMsEdaaL+wxQnikOBWlbRJOUvAomTPFJD3dqu
	tE+dYK37v0nSCrzgY/WSl0xclQqEHJFufRTNNR83RSxPSgPI5txrZYRmFZnmD+ox
	panK/u8EMG+OGgR/gtFABppTL5lZgLXY+eYJSv8JhbPmUgnEJtHA/vIOpivjQxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AyCW1k
	zEkXMi11l2VxKORrUd8vWSDhqV+XSKkqEqHSf7XYjwpET2EsCCdVEXteoPpyY7f3
	wLloKt32U+duReHfQKnHm2KVuxFwzm1s+lSjfAwGShKFRSwQdTnpaQDA17aV0n61
	oO9x6SHmDOhhTMPjhTAiXlUCMCiO9Kv0pD9iU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 899AE70160;
	Wed, 26 Feb 2014 19:16:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BCD7F7015E;
	Wed, 26 Feb 2014 19:16:29 -0500 (EST)
In-Reply-To: <1392730814-19656-16-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 18
 Feb 2014 20:40:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 67B65FB4-9F44-11E3-B2AB-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242777>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> If the file "$GIT_DIR/commondir" exists, it contains the value of
> $GIT_COMMON_DIR.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/gitrepository-layout.txt |  4 ++++
>  setup.c                                | 38 ++++++++++++++++++++++++=
++++------
>  strbuf.c                               |  8 +++++++
>  strbuf.h                               |  1 +
>  4 files changed, 45 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/gitrepository-layout.txt b/Documentation/g=
itrepository-layout.txt
> index aa03882..9bfe0f1 100644
> --- a/Documentation/gitrepository-layout.txt
> +++ b/Documentation/gitrepository-layout.txt
> @@ -211,6 +211,10 @@ shallow::
>  	and maintained by shallow clone mechanism.  See `--depth`
>  	option to linkgit:git-clone[1] and linkgit:git-fetch[1].
> =20
> +commondir::
> +	If this file exists, $GIT_COMMON_DIR will be set to the path
> +	specified in this file if it is not set.
> +
>  modules::
>  	Contains the git-repositories of the submodules.

In a way similar to the "*Note*" in a very early part of this file
describes the .git-file redirected repositories, we would need to
mention that there now exist repositories borrowing from another
repository via this commondir mechanism, and what the caveats are
when using them (like, "do not ever nuke the original repository
somebody else is borrowing from with 'rm -rf' when you think you are
done with the original").

> +	if (file_exists(path.buf)) {
> +		if (strbuf_read_file(&data, path.buf, 0) <=3D 0)
> +			die_errno(_("failed to read %s"), path.buf);

Do we care about the case where we cannot tell if the file exists
(e.g. stat() fails due to EPERM or something), or would it be not
worth worrying about?

> +		strbuf_chomp(&data);
> +		strbuf_reset(&path);
> +		if (!is_absolute_path(data.buf))
> +			strbuf_addf(&path, "%s/", gitdir);
> +		strbuf_addbuf(&path, &data);

OK, so commondir can be relative to the containing gitdir
(e.g. /a/foo/.git/commondir with "../../bar/.git" would name
/a/bar/.git as the common dir).

It needs to be documented in the repository-layout somehow.

> @@ -188,14 +212,20 @@ int is_git_directory(const char *suspect)
>  	int ret =3D 0;
>  	size_t len;
> =20
> -	strbuf_addstr(&path, suspect);
> +	strbuf_addf(&path, "%s/HEAD", suspect);

> +	if (validate_headref(path.buf))
> +		goto done;

Is there a reason why we want to check HEAD before other stuff?
Just being curious, as I do not think of any (I am not saying that
we shouldn't change the order).

> +void strbuf_chomp(struct strbuf *sb)
> +{
> +	while (sb->len && (sb->buf[sb->len - 1] =3D=3D '\n' ||
> +			   sb->buf[sb->len - 1] =3D=3D '\r'))
> +		sb->len--;
> +	sb->buf[sb->len] =3D '\0';
> +}

It feels a bit yucky to ignore trailing \r on non-DOS filesystems
(if it were also removing any whitespace, then I would sort of
understand in the context of the expected caller of this function in
this series---except that it would no longer be a "chomp"), but I'd
let it pass.
