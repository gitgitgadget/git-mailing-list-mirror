Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FFDC2D0A3
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 07:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 772AB2085B
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 07:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="a7EH/8AA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgKAHeS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 02:34:18 -0500
Received: from mout.web.de ([212.227.15.4]:39257 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgKAHeS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 02:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1604216052;
        bh=DjuKPswAEu7jR/GrpC50iDPJqQ5idqiUXi3gko2Z2u0=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:Date;
        b=a7EH/8AAjwp8W95wZ1bPATKCS08nCxXB1AP5478YwDuvtDQpw6WjfycNTwwH9Z42Z
         rytW/tT8fNgGnYO3IE/TfPDR2vA5o8eKnPKD5EyfPoONcV3E3GcnxCEZTuLB29fqcK
         vCpcuMIVyHICY5IVGgk4TpiY4diGz61l6Gan3Bkw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MZUjd-1kndWg3ndl-00LBHN; Sun, 01
 Nov 2020 08:34:11 +0100
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH RESEND] stash: simplify reflog emptiness check
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Marek Mrva <mrva@eof-studios.com>
X-Mozilla-News-Host: news://nntp.public-inbox.org
Message-ID: <532cf383-913c-5f33-e143-687f6d51a8da@web.de>
Date:   Sun, 1 Nov 2020 08:34:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XhpPDN4IRTYkXQXouBWn/WKhLd2ZPLuImbIuyNB5WQAibkdsjqz
 rxd5vn9GL6FgpPOLgZ/wLQqxcBjQDv++lQwR85N4UnQMITgqqEZt8iKqkVb4z9n6HU1MujF
 gAR9Yjx0EX8XAJC/kEHVOaI1wbkM9RhF1qaP7MDRAHslvlhd3LZQAoLIVrmil/LH+wFd4nE
 Ob8rejaKx5CYN8+rrZ1og==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5MtMEm7MMOo=:HRMJr///0NO1SyzmJOPyQR
 gir9kI4qZZrgUOyQbiVafPNWGpeppFQAAaDILKqUCc8SyUR4L69SUmHjeARvaKicklgG5c/WZ
 U9fYOtqYa28V0J3e6x48Mzd3lqAHCzqMue5j3LqUXDSsJ7IzsDuAUY0veHo8sr+VDGa68LGD8
 pAP1gZeVvAjgJpPwsw5gTJzDXSaf8MJjPGWAAKzsxZ+wuSQkx5ewFCsfVTgR8j5VINcXRL2wd
 nYdzfOFhlQShQ7WmrE2JypUOTFfxBpupdwOrI/dBBJsCIhPBpvgzSuO2ZTmSCqYXuprjfXTSg
 fG826ORwSFSSFhyjG0TxVC7UxxWW+VyXWumaPRlvUg7WVc+KNcFkv9yFCNCG9Y4eMQRGza9Mk
 nmLY9k8kqxk9hYBNHrAlgA8ym1PK/6DQtJPp5wqp3w2XnFBKzYr4xA2WAdoS+92M2XxdhmK9c
 YDIcvEJ9bJyUTOOuM65/adkjO4yctLThfVNdS7LLi//moUhRHCGuZ8vdfUdQ8RcGfOeymtDqG
 rzAaLJUSMoY6C/yzvjzqHPLrPNbyuxiIhid+TqVQdQXqa/FTRvNlSyIf2hTm08QBQJVfV6D1V
 LRIPxw5ujLUC9vjpgfxuQnYluhkV04KT3oBqsDHtHrYNR2PYYPuoH1kPFnZUqgtkArbpi4e/w
 fxFtti+S79+QVEj0tpSELXcsaYqPzSaEqHYgwtXtLNAEDSdecM/hPKa8IPqzAv2OvPcA4Sb3V
 tplgiMoLs+s+DH4cXmzqtsgMptajRq8nW49TQdUaEXY14jQWfxHpNsd70ESD2npTItb+Ci9dj
 5XmOeeWi+uoDZzz81ta0Dg9I5vROhDLpkFRjXmc3JttqwsofPyCef1aFSws4r3AmxiCxvYflc
 WCiFplg2YW0zf2Ka3Fpg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calling rev-parse to check if the drop subcommand removed the last stash
and treating its failure as confirmation is fragile, as the command can
fail for other reasons, e.g. because the system is out of memory.
Directly check if the reflog is empty instead, which is more robust.

Reported-by: Marek Mrva <mrva@eof-studios.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Original submission:
https://public-inbox.org/git/618d66a8-e2c1-241c-5200-2298bfe24ac0@web.de/

 builtin/stash.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 3f811f3050..24ddb1bffa 100644
=2D-- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -534,11 +534,22 @@ static int apply_stash(int argc, const char **argv, =
const char *prefix)
 	return ret;
 }

+static int reject_reflog_ent(struct object_id *ooid, struct object_id *no=
id,
+			     const char *email, timestamp_t timestamp, int tz,
+			     const char *message, void *cb_data)
+{
+	return 1;
+}
+
+static int reflog_is_empty(const char *refname)
+{
+	return !for_each_reflog_ent(refname, reject_reflog_ent, NULL);
+}
+
 static int do_drop_stash(struct stash_info *info, int quiet)
 {
 	int ret;
 	struct child_process cp_reflog =3D CHILD_PROCESS_INIT;
-	struct child_process cp =3D CHILD_PROCESS_INIT;

 	/*
 	 * reflog does not provide a simple function for deleting refs. One will
@@ -559,19 +570,7 @@ static int do_drop_stash(struct stash_info *info, int=
 quiet)
 			     info->revision.buf);
 	}

-	/*
-	 * This could easily be replaced by get_oid, but currently it will throw
-	 * a fatal error when a reflog is empty, which we can not recover from.
-	 */
-	cp.git_cmd =3D 1;
-	/* Even though --quiet is specified, rev-parse still outputs the hash */
-	cp.no_stdout =3D 1;
-	strvec_pushl(&cp.args, "rev-parse", "--verify", "--quiet", NULL);
-	strvec_pushf(&cp.args, "%s@{0}", ref_stash);
-	ret =3D run_command(&cp);
-
-	/* do_clear_stash if we just dropped the last stash entry */
-	if (ret)
+	if (reflog_is_empty(ref_stash))
 		do_clear_stash();

 	return 0;
=2D-
2.28.0
