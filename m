From: mike.gorchak.qnx@gmail.com
Subject: Re: [PATCH] use child_process_init() to initialize struct child_process variables
Date: Tue, 28 Oct 2014 17:58:56 -0400
Message-ID: <20141028215856.6643859.60752.16778@gmail.com>
References: <54500212.7040603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 28 22:59:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjEnD-0000Vy-7Q
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 22:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755758AbaJ1V7A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Oct 2014 17:59:00 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:43931 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755720AbaJ1V65 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Oct 2014 17:58:57 -0400
Received: by mail-ie0-f172.google.com with SMTP id rl12so1756827iec.3
        for <git@vger.kernel.org>; Tue, 28 Oct 2014 14:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :subject:from:in-reply-to:references:to:cc;
        bh=h4GoQQhN+nKCwYiMJcgukGA1Q/sI+xUx4iirux6Xfrg=;
        b=X1XwKqXJq7jnzbkk1e3NBHm6BA1dbyRxFYs/IL5svGwmKhi2OxqLCBi4pB0BHrQRqn
         RJ8FDyjfITMSNs9ZEmmhAZljwG90NYJuQDFr/MbcCBuZtjRYTxA5ocSDnXiQSwymxr5/
         GevD85qEm1bBj6tk0a42JyIFYTt9D0V4wsTvjmPdWHo0uM4rlDxkgSNoTnlSMOGIt5/z
         nWQ+x0Qx/Nk/NqrDwZ5oL/NGVj657zMmkFtOnzDB5DLQxNBkYojy4hTYhfvXri/njiG0
         Wy6Z4kDLWqJmsE08eH6fubSKw69opNRm6fmrP3J976vSx8c7KOuKDVzFr0UeiZrwCGj/
         wHlg==
X-Received: by 10.107.150.213 with SMTP id y204mr7087272iod.59.1414533537308;
        Tue, 28 Oct 2014 14:58:57 -0700 (PDT)
Received: from [127.0.0.1] ([24.114.84.210])
        by mx.google.com with ESMTPSA id xb4sm1465654igc.11.2014.10.28.14.58.56
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 28 Oct 2014 14:58:56 -0700 (PDT)
X-Mailer: BlackBerry Email (10.2.1.3247)
In-Reply-To: <54500212.7040603@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my BlackBerry 10 smartphone on the Rogers network.
=A0 Original Message =A0
=46rom: Ren=E9 Scharfe
Sent: Tuesday, October 28, 2014 16:59
To: Git Mailing List
Cc: Junio C Hamano
Subject: [PATCH] use child_process_init() to initialize struct child_pr=
ocess variables

Call child_process_init() instead of zeroing the memory of variables of
type struct child_process by hand before use because the former is both
clearer and shorter.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
bundle.c | 2 +-
column.c | 2 +-
trailer.c | 2 +-
transport-helper.c | 2 +-
4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/bundle.c b/bundle.c
index fa67057..c846092 100644
--- a/bundle.c
+++ b/bundle.c
@@ -381,7 +381,7 @@ int create_bundle(struct bundle_header *header, con=
st char *path,
write_or_die(bundle_fd, "\n", 1);

/* write pack */
-	memset(&rls, 0, sizeof(rls));
+	child_process_init(&rls);
argv_array_pushl(&rls.args,
"pack-objects", "--all-progress-implied",
"--stdout", "--thin", "--delta-base-offset",
diff --git a/column.c b/column.c
index 8082a94..786abe6 100644
--- a/column.c
+++ b/column.c
@@ -374,7 +374,7 @@ int run_column_filter(int colopts, const struct col=
umn_options *opts)
if (fd_out !=3D -1)
return -1;

-	memset(&column_process, 0, sizeof(column_process));
+	child_process_init(&column_process);
argv =3D &column_process.args;

argv_array_push(argv, "column");
diff --git a/trailer.c b/trailer.c
index 8514566..7ff036c 100644
--- a/trailer.c
+++ b/trailer.c
@@ -237,7 +237,7 @@ static const char *apply_command(const char *comman=
d, const char *arg)
strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);

argv[0] =3D cmd.buf;
-	memset(&cp, 0, sizeof(cp));
+	child_process_init(&cp);
cp.argv =3D argv;
cp.env =3D local_repo_env;
cp.no_stdin =3D 1;
diff --git a/transport-helper.c b/transport-helper.c
index 6cd9dd1..0224687 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -414,7 +414,7 @@ static int get_exporter(struct transport *transport=
,
struct child_process *helper =3D get_helper(transport);
int i;

-	memset(fastexport, 0, sizeof(*fastexport));
+	child_process_init(fastexport);

/* we need to duplicate helper->in because we want to use it after
* fastexport is done with it. */
--=20
2.1.2

