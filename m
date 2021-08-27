Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D32C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 19:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4FB960EE7
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 19:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhH0UAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 16:00:11 -0400
Received: from mout.web.de ([212.227.15.3]:52589 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231296AbhH0UAK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 16:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1630094357;
        bh=WFhw8flEkGxGC9IZqWZFhSBu72G7Cf6tBzrtVeXSov0=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=SMCgKVdckmklIakq45No6INXuBZW3yGSyx+qit1oArm3xVhcBCpf4oV82jvo0/QQa
         Br94Y/FvTOXaEsOIUaKNzPq85Ax3kWb3ZSU+hB2YpI2vdfqL8Bfh3LBmA+K4XU8fWv
         2jCCbnyVC2MJiSqCjBQie+tqyvWIKVM31u7mBM3g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MBY4U-1mCajz0jYs-00AXc5; Fri, 27 Aug 2021 21:59:17 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] archive: convert queue_directory to struct object_id
Message-ID: <bfdb36fc-3b92-fe62-e928-dc235cede31d@web.de>
Date:   Fri, 27 Aug 2021 21:59:16 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:haifkSdhFEXItN04h95TBwvin02KVtYOPEG0bIVZ5O8vnxwx3X0
 8an7CGDnTIE6yK3k+W45ibZIzbxX+eZCbwGq1TUuiVj9S9H2lvhJZx1YkBPdMsjJkTSiCj0
 qoMkzZ80cu+zLes9H0WMpC0IR+f1TaQYjym5wR64SMyCaow+fbHUcOMOm14OMJia95WOHya
 KUjs5ddB9BiCJbG3En0LA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9skXwlbWU1U=:us/ru37PQf9ATQL3KaveCO
 BlBieAs24XaBteqHxsIs9RiVWcjOLvNWfTvMDGAaBDmEde322esQe4x7PiJFeLDbdDSr8zSLm
 YWZSGNOCP3X3slGMQv9wxfCC/wob+zD6rTh6KRwuc4k2RHKsEdEEGYOuJ7YA5+k2j6xM10Xnj
 Y5LRq4v5qXP0lSGKDuN2AjQ8I0X6Uwc7pe6cKA9vBqMAmkfbeUlYVZAx04+zIB46ATyCNj6je
 13tQ5hxnazLFV2rAis0pAKF63W5KurhcApy3shpCiM64Suj2PeA9UxVIAY/m4+uZpbH/87Qjd
 mg66TWXYz2FXkHiaHn0ikdplvQm5mrhFas0IyeeDKGcOpdMlqBuIfBSKVVVeftYEecZ6WV6EY
 TOV8idUAeqrf+KMSW03ctflq5C/UtRXv5pV4bf7Px4h2mnU7aOvvTq9/iDoonu7gbFOX1wQpU
 aXPk9FUB0alMalMDL/xK3k3D8NKoBDQFKb2h2VhwxbxkkgQhYLduiua7xff5leJn7/8SnDrd8
 hRSVR0OAXxHlUA4kpbH8fyBCA+UHvnxqx9UqUQKs2kVw4hbc5hdYEAhDxMnNxOGK3qE/zL2hh
 mprrfTjTmK8MFDe5D1La6mqVBKmnMhXMdNMCj0C4BWLbF6fK5fVmGpjICYav7v4YGe5rP6vSV
 tIqM8EfBuNRp1iAJfzCIuBxzIEPNyDi404ZERHqAElG45cQZirLqxzzlAJ1/O7D8Ubxx8Jizi
 JG8FozLJHYuhEXQUbg+sIGI5dTi3aM5x4GxX8WrpDGyVyQTGGNXwPDTvU0xR/W6WzDvHEUgdd
 8cSX4XuPJsdw5L0v6CONKG57P9kllp5lJzCzYtq1KTOp0sE6oVLjycEQ9ESYX5VfFIxtK8fck
 wmjcRdkG3HOfWFCljQW2qukRunJI5hPFuwRgI3xH0dDXwDswMuu0b7nv8aZwxDwN43sS2yGQi
 BVR8DWJ45BV08wLp0SlMHcvUt9VLA2Mi7AKh2kYTy2hjCaqxjBg8YH92qyZbPEuNU/EMXK9gZ
 iyAt6KL2B6MQzyms5Kq7UGTuBRq7JGcLimbBDCzDux1i7OnH8tJa+Mjz6jRV7L5dMmVnzjd5a
 fu7sHfkCswL5vUruDd4GaByaSUQvCrio5lG
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass the struct object_id on instead of just its hash member.
This is simpler and avoids the need to guess the algorithm.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 archive.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/archive.c b/archive.c
index 3c266d1d7b..a3bbb09125 100644
=2D-- a/archive.c
+++ b/archive.c
@@ -191,7 +191,7 @@ static int write_archive_entry(const struct object_id =
*oid, const char *base,
 	return err;
 }

-static void queue_directory(const unsigned char *sha1,
+static void queue_directory(const struct object_id *oid,
 		struct strbuf *base, const char *filename,
 		unsigned mode, struct archiver_context *c)
 {
@@ -203,7 +203,7 @@ static void queue_directory(const unsigned char *sha1,
 	d->mode	   =3D mode;
 	c->bottom  =3D d;
 	d->len =3D xsnprintf(d->path, len, "%.*s%s/", (int)base->len, base->buf,=
 filename);
-	oidread(&d->oid, sha1);
+	oidcpy(&d->oid, oid);
 }

 static int write_directory(struct archiver_context *c)
@@ -250,8 +250,7 @@ static int queue_or_write_archive_entry(const struct o=
bject_id *oid,

 		if (check_attr_export_ignore(check))
 			return 0;
-		queue_directory(oid->hash, base, filename,
-				mode, c);
+		queue_directory(oid, base, filename, mode, c);
 		return READ_TREE_RECURSIVE;
 	}

=2D-
2.33.0
