Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3AAC433DF
	for <git@archiver.kernel.org>; Tue, 26 May 2020 08:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1C332075F
	for <git@archiver.kernel.org>; Tue, 26 May 2020 08:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="OGUi/HK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgEZIhe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 04:37:34 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:30384 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgEZIhe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 04:37:34 -0400
Date:   Tue, 26 May 2020 08:37:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1590482251;
        bh=F2tH06bCGSwpOOuFT8LAJb5XHd294ozvwwoVbKGr5jI=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=OGUi/HK2MRzMMsV2GLLQqxnsSeJ4zycY1/CMi2QxmSoBELtb5sJAV2iKACwgqKqt+
         CbrPlc6hTNyRrwFcSzIQzF6fcZFdVZSUbLWIS/f0Pg0UpCE8wdgRcb10b/pr87YH1C
         HJAKyTNoZJQmuMUeD9/PzO9FC0C5gpj7ZgCvFZQo=
To:     git@vger.kernel.org
From:   Simon Ser <contact@emersion.fr>
Cc:     gitster@pobox.com, me@ttaylorr.com
Reply-To: Simon Ser <contact@emersion.fr>
Subject: [PATCH] grep: add configuration variables for --heading
Message-ID: <4WK2xPaKLXPbLE0jjY0rBR9M_BVt69rzJKBN17M0ily4VPYuMNC_a2kXsIKWR8y6lc7j58WpBmaIqdbJ1whnjonrfEWz7YE-WpdQqCu_lN0=@emersion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are already configuration variables for -n and --column. Add one
for --heading, allowing users to customize the default behaviour.

Signed-off-by: Simon Ser <contact@emersion.fr>
---
 Documentation/git-grep.txt | 3 +++
 grep.c                     | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index a7f9bc99eaf1..ed4f05d885a2 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -47,6 +47,9 @@ grep.lineNumber::
 grep.column::
 =09If set to true, enable the `--column` option by default.
=20
+grep.heading::
+=09If set to true, enable the `--heading` option by default.
+
 grep.patternType::
 =09Set the default matching behavior. Using a value of 'basic', 'extended'=
,
 =09'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp=
`,
diff --git a/grep.c b/grep.c
index 13232a904aca..4549bc722650 100644
--- a/grep.c
+++ b/grep.c
@@ -133,6 +133,10 @@ int grep_config(const char *var, const char *value, vo=
id *cb)
 =09=09opt->columnnum =3D git_config_bool(var, value);
 =09=09return 0;
 =09}
+=09if (!strcmp(var, "grep.heading")) {
+=09=09opt->heading =3D git_config_bool(var, value);
+=09=09return 0;
+=09}
=20
 =09if (!strcmp(var, "grep.fullname")) {
 =09=09opt->relative =3D !git_config_bool(var, value);
@@ -199,6 +203,7 @@ void grep_init(struct grep_opt *opt, struct repository =
*repo, const char *prefix
 =09opt->pattern_type_option =3D def->pattern_type_option;
 =09opt->linenum =3D def->linenum;
 =09opt->columnnum =3D def->columnnum;
+=09opt->heading =3D def->heading;
 =09opt->max_depth =3D def->max_depth;
 =09opt->pathname =3D def->pathname;
 =09opt->relative =3D def->relative;
--=20
2.26.2


