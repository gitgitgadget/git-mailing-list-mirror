Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095B5219F9
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713725959; cv=none; b=eNyM3UVSvWSDxEaiNPFg6P9gK/qmS7Oc8f5sW1BgH9LR66RABw+28lLwDpoteiDwyuN4IxjAGBzVrvYYsMu+taFJ6k9ED5hQR1Uc5dCpLwulUU5VUraa5uRLODSg39hJPqQ2fHhPQJjiJTp4hNEw8dZXyzJAl8huNxnS3DvWAfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713725959; c=relaxed/simple;
	bh=LbbQq3piD6dnhpYKEqEYHxtiuyiTfdYci0NG3X+aOhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ntu1ORF1Ra6ZVE3OqRGpXPCIyVCiML/ilstRrbLtgou6DN819SSOR+QQcj2p/0VfhWKx2O0dQxuefdmkaqm697aRUxKOyCGGDikTApFTb2JorU3SeA2du7SoXNj9rwsCX2F9g68Jdc2fep81GwwX2DWdMSjHaMZqzdc7e0Hime4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AUtZImj4; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AUtZImj4"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F013F1E19B0;
	Sun, 21 Apr 2024 14:59:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=LbbQq3piD6dnhpYKEqEYHxtiu
	yiTfdYci0NG3X+aOhI=; b=AUtZImj4M7b3Asj+pOQLV7aTtaXzdVo89gibYmpop
	qtYRZ5A2fWJ7AtxOavUzsw6TnxRKVLYP3VyL1NBhocfrDlHCkUuz8N5ll+yjNbem
	aaJIRn7W1A3pXEM2eJBjz90hXOrHe577pLRkg5c3OdfR58vOgXWncWhyXHtPGddD
	DE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E81461E19AF;
	Sun, 21 Apr 2024 14:59:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F0A41E19AE;
	Sun, 21 Apr 2024 14:59:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH v3 0/2] format-patch --rfc=WIP
Date: Sun, 21 Apr 2024 11:59:13 -0700
Message-ID: <20240421185915.1031590-1-gitster@pobox.com>
X-Mailer: git-send-email 2.45.0-rc0
In-Reply-To: <xmqqy1993tc1.fsf@gitster.g>
References: <xmqqy1993tc1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 4034AD72-0011-11EF-BF40-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

So here is the hopefully final round.  I think the first one is
good, but the second one is of dubious and possibly negative value
(for the reasons, see its proposed log message), so I am undecided.

Junio C Hamano (2):
  format-patch: allow --rfc to optionally take a value, like --rfc=3DWIP
  format-patch: "--rfc=3D-(WIP)" appends to produce [PATCH (WIP)]

 Documentation/git-format-patch.txt | 19 ++++++++++++++-----
 builtin/log.c                      | 25 +++++++++++++++++++++----
 t/t4014-format-patch.sh            | 28 +++++++++++++++++++++++++++-
 3 files changed, 62 insertions(+), 10 deletions(-)

Range-diff against v2:
1:  bffe0055d0 ! 1:  a874b85cb5 format-patch: allow --rfc to optionally t=
ake a value, like --rfc=3DWIP
    @@ builtin/log.c: static int subject_prefix_callback(const struct opt=
ion *opt, cons
     +static int rfc_callback(const struct option *opt, const char *arg,
     +			int unset)
     +{
    -+	struct strbuf *rfc;
    ++	const char **rfc =3D opt->value;
     +
    -+	rfc =3D opt->value;
    -+	strbuf_reset(rfc);
    ++	*rfc =3D opt->value;
     +	if (!unset)
    -+		strbuf_addstr(rfc, arg ? arg : "RFC");
    ++		*rfc =3D arg ? arg : "RFC";
     +	return 0;
     +}
     +
    @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, c=
onst char *pre
      	struct strbuf rdiff2 =3D STRBUF_INIT;
      	struct strbuf rdiff_title =3D STRBUF_INIT;
      	struct strbuf sprefix =3D STRBUF_INIT;
    -+	struct strbuf rfc =3D STRBUF_INIT;
    ++	const char *rfc =3D NULL;
      	int creation_factor =3D -1;
     -	int rfc =3D 0;
     =20
    @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, c=
onst char *pre
      			    N_("cover-from-description-mode"),
      			    N_("generate parts of a cover letter based on a branch's des=
cription")),
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, =
const char *prefix)
    - 	if (cover_from_description_arg)
      		cover_from_description_mode =3D parse_cover_from_description(cove=
r_from_description_arg);
     =20
    --	if (rfc)
    + 	if (rfc)
     -		strbuf_insertstr(&sprefix, 0, "RFC ");
    -+	if (rfc.len)
    -+		strbuf_insertf(&sprefix, 0, "%s ", rfc.buf);
    ++		strbuf_insertf(&sprefix, 0, "%s ", rfc);
     =20
      	if (reroll_count) {
      		strbuf_addf(&sprefix, " v%s", reroll_count);
-:  ---------- > 2:  6b82e903b6 format-patch: "--rfc=3D-(WIP)" appends to=
 produce [PATCH (WIP)]
--=20
2.45.0-rc0

