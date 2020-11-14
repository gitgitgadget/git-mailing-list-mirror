Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BE7C5519F
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 22:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84162223BD
	for <git@archiver.kernel.org>; Sat, 14 Nov 2020 22:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="NAzoa4zi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgKNWBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Nov 2020 17:01:10 -0500
Received: from mout.web.de ([212.227.15.4]:60909 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgKNWBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Nov 2020 17:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1605391264;
        bh=jDRxVFHkFYbsXsagZW7XzESTx0px3nzdzuZtKg8QjUo=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=NAzoa4ziAkPs+oR4bfI3ahhKmEan+su9ZrQ8F2TjJkzERTP6rc9mc6ig6Qic7omxZ
         YpadQsLDXQ7CCVtB92EkWW9kqy9forrEO5+/HAlaMav62oo5zsMxbbT138s1WZ3f8U
         4IbpiQ0OFekTN88/guQmvH5BebyP4AzfGE/c44Ns=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MECCP-1kWfbh2Drh-00AIAt; Sat, 14
 Nov 2020 23:01:04 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] archive: release refname after use
Message-ID: <7692d2f3-0a3b-91cd-c454-9725b0a395a7@web.de>
Date:   Sat, 14 Nov 2020 23:01:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yaB49SnireO+/EZPa7HuwW44g0+oP96bkZ9jzcAiHU+2d3M4zoW
 ncvXLq5PeoVYTq2KsZbPvLKjiyk+536eQFveujgvNWjg80EaxNdNgknRvMr3Mmby0zGQQ2L
 XNS9fzSj0RpR/6laDDyw/lpWbwsgW98bWPHuOaMp4qny4on8UpknccGyXye/mVZ2Kh1l7tn
 oxpp0OPf9eyxF7bbAtRCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6z7f6nlUthM=:5iKhIAE+9VDMjEpdJOEjCs
 xcbn1XSYhU5LNtFjKSufBi2alFMSX/hXMiZNudewVVmhsXL3cRtxVDNCmim7J0fmBxKSMD0gq
 H7nrY6EPvjCJNIkGioKGe/qsBezeP9RM0jhnIBzp6diav1sk3390gL2tOzPzQf7Jby8kKJRVj
 DbgHIIUHudrKRt6xeEOxNL97ir32n3Z/qCy/V/r5J+w3uteccI3HLqLqVVfWQoVYhMZU0dsVb
 5EO/nRCfkBxVFsU18ZVPmi3Hw0EMkRMfWiVMnrMbN7CBx6BYzVL22RQamyM7uciHBi5zygn9v
 0r/IeRtfB7Xgai7MEHWG4Dd0yTisd7WGrSbKZ09biZJGQDmY4oeTpd4FGBmyyg5n75EFH57U5
 P44yDZSqDlN83ShI2CBxLbM+nY494JAcqfhdCnEpOERtTwKyA6JR4cmEdRbsjJy1wsh3onIS7
 zFep6w1nv/6CW174GBOkXvtR8AKdYSem4JAE7MkIMvpxUCKnd6R/6KjfjOvNvzbBFb1ma1z9N
 38PkxRkFobcaI6rsQRLj8BdDJCIfKyVLm4PKXsURmoCZDnajyNG5qlB9kptuNQfr+cnaSQqol
 UZlFQNAeYcx6OJQPxU3mAqLyIWW+zdP55oPx7mH1fu17V0Y+kuer2YHW4hA7wtIPUvRGDtev8
 GqzjJSPKAY2ddAxSiESGRL0iud8snRH3er/TlGvUxXszvKeeoNB9HPGTIJpBpg4PohIh26E5T
 Pzbq5QbiQkh4xSdHM9XkxL+Dqq8xmB/n7J5NuMOc1Vmw6EENB5QhwiPtv+DC4oCizySxKfjHl
 DUP9BPL74EWDbfqPIZ688QoBMHvASBdU5C+MsjXoO6L0Pc6sN+hMXZh7WjPmNQ1BgQva2oXMC
 OUuNvVo7RGZkV5FsRr0w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

parse_treeish_arg() uses dwim_ref() to set refname to a strdup'd string.
Release it after use.  Also remove the const qualifier from the refname
member to signify that ownership of the string is handed to the struct,
leaving cleanup duty with the caller of parse_treeish_arg(), thus
avoiding a cast.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 archive.c | 1 +
 archive.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/archive.c b/archive.c
index 3c1541af9e..da89d292c2 100644
=2D-- a/archive.c
+++ b/archive.c
@@ -662,6 +662,7 @@ int write_archive(int argc, const char **argv, const c=
har *prefix,
 	rc =3D ar->write_archive(ar, &args);

 	string_list_clear_func(&args.extra_files, extra_file_info_clear);
+	free(args.refname);

 	return rc;
 }
diff --git a/archive.h b/archive.h
index 82b226011a..43028ffbf3 100644
=2D-- a/archive.h
+++ b/archive.h
@@ -8,7 +8,7 @@ struct repository;

 struct archiver_args {
 	struct repository *repo;
-	const char *refname;
+	char *refname;
 	const char *prefix;
 	const char *base;
 	size_t baselen;
=2D-
2.29.2
