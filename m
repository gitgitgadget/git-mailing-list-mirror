From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] index-pack: do not segfault when keep_name is NULL
Date: Mon, 17 Mar 2014 15:07:01 -0700
Message-ID: <xmqqmwgobhtm.fsf@gitster.dls.corp.google.com>
References: <1394965862-8173-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 23:07:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPfgh-0003zw-Gm
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 23:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbaCQWHI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Mar 2014 18:07:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57875 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752303AbaCQWHF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2014 18:07:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C6247562F;
	Mon, 17 Mar 2014 18:07:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=d1DAwLckqAcN
	x0imh04dwUEaJCk=; b=EwXzgsdHuYGLnx3GYFMQ1V4D9j5q7H7ElJDmhHfZ9cYr
	YzjYeceX7nytX/toe+yehvgu88GYoavhjymDncDP9zRuniLDjMCJaCYNPO0MAQan
	rEHlIC5/JcHFfM8PUBwHhrdlfr9fBXJoDFC7e1zDS6jQKTDchwsRzmanSyOKPCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RGe6P6
	hxph9xaFTRBUZcXt6R8UD/W/F9g1m9Qf9cXxNo+7GejyyGRVHWBGU/Ptp/B/HaF0
	SzA2kugkLCyU4jVq+a0djGr8vJvhGhSaGHt364Mj8yHM+lC3rb6C5Ig4t6JdNV4i
	QyY76msa5ot1LktVJ5OnMkDMJieZzww8CbXqg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00CF97562E;
	Mon, 17 Mar 2014 18:07:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49D927562A;
	Mon, 17 Mar 2014 18:07:04 -0400 (EDT)
In-Reply-To: <1394965862-8173-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 16
 Mar 2014 17:31:02 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 78FB0032-AE20-11E3-9E87-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244298>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> keep_name is used to print error messages a couple lines down. Reset
> it to the real path returned by odb_pack_keep() if it's set to NULL b=
y
> caller.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  One of these moments I will make git log and friends optionally reco=
gnize
>  "Diff-Options:" line in commit message. Adding -U14 in this case
>  should help the reviewer to see how those error messages are printed=
=2E
>
>  builtin/index-pack.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index a6b1c17..d95c3dc 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1283,9 +1283,10 @@ static void final(const char *final_pack_name,=
 const char *curr_pack_name,
>  	if (keep_msg) {
>  		int keep_fd, keep_msg_len =3D strlen(keep_msg);
> =20
> -		if (!keep_name)
> +		if (!keep_name) {
>  			keep_fd =3D odb_pack_keep(name, sizeof(name), sha1);
> -		else
> +			keep_name =3D name;
> +		} else
>  			keep_fd =3D open(keep_name, O_RDWR|O_CREAT|O_EXCL, 0600);

I think this fixes the right problem in a wrong way that hurts
longer-term maintainability.  Why not do

	keep_name ? keep_name : name

at the place where the name is used?  Otherwise you will have to
worry about affecting later codepaths that may want to try to use
!keep_name to switch between two codepaths, no?

> =20
>  		if (keep_fd < 0) {
