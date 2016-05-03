From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 33/41] run-command.c: use error_errno()
Date: Tue,  3 May 2016 19:04:06 +0700
Message-ID: <1462277054-5943-34-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
 <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 14:09:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ95-0001EV-TL
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933091AbcECMJj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:09:39 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34058 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274AbcECMJi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:09:38 -0400
Received: by mail-pf0-f181.google.com with SMTP id y69so9210211pfb.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UHO+kv4XdLapel/fDeP654YK4xCQ/QV/SKzmL4Zh9VY=;
        b=ao4LumSMDCSzEmQsnYE7kRdIRb1/kianYnDq8Svm20r4yNVyo8lp8rgOg6h+P/e4rN
         mdFgxpyDXxx/2eoQ5t2IUxoTq6DZ5n59Hk/5JHdtZZbJyTXpjS9LTLe8m8qxpuqkQ8wS
         iLqpYDuKUTZyK5CEVlXh4X7bxXi36e6lyR02LjqqL7w2e2BA8P0WK6DzJYJO4y0c2ukY
         +UcnguGfOiElvGEh6cVjhfi6Zjv7VPzTm9g2gwUIcbcaO9ISQ09E+EKHIM90X9sJPiBA
         yGyzCXUaxc0rjBh/oeHMKRNhNlcR5E30ZuluQCRVjWZgeVpCUpzjG2cooIdtNrhNVtCx
         iN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UHO+kv4XdLapel/fDeP654YK4xCQ/QV/SKzmL4Zh9VY=;
        b=YwJPKhihiNt4XzstaWR/Wd4mwWwtCCNon2jLMldyrE/6A2aDo5t7tk26qVsLABmfKT
         HxQZBIW20ZnaF7uFhM7OHTRtfafoFnvRHTq5xmoCwEOUf7ubMoQrYLTm8wYvCoSFQp8R
         hm/yb4w0VtkncCCngrrQ5l1snM2uOPWpiMEnuOegyFJyMgrhmkPR64m6pLF18JreT1/F
         3AP29/VRb6cIfSaMXxLSuK1pGGXIhwhKVXf1yaIkNPtRxfzqvbrdB43fIITkbH4vHot/
         75+BR5U9jD5pJfWmkh25QRsWpmFxFJxIQKTSRWQHOHwlH5Xhs3f6SVjgoa2ue4dXWdtm
         G4Hw==
X-Gm-Message-State: AOPr4FWsMgYJ9QTrl9tU5tgQ6GhMYPH1yHJpkaCKTyCeBRkoNTgVpgQRA9QUNsW9qh6IKw==
X-Received: by 10.98.79.199 with SMTP id f68mr2951834pfj.44.1462277378067;
        Tue, 03 May 2016 05:09:38 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id w27sm5530709pfi.24.2016.05.03.05.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:09:36 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:09:33 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293386>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 run-command.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/run-command.c b/run-command.c
index e4593cd..842c8d1 100644
--- a/run-command.c
+++ b/run-command.c
@@ -233,7 +233,7 @@ static int wait_or_whine(pid_t pid, const char *arg=
v0, int in_signal)
=20
 	if (waiting < 0) {
 		failed_errno =3D errno;
-		error("waitpid for %s failed: %s", argv0, strerror(errno));
+		error_errno("waitpid for %s failed", argv0);
 	} else if (waiting !=3D pid) {
 		error("waitpid is confused (%s)", argv0);
 	} else if (WIFSIGNALED(status)) {
@@ -420,8 +420,7 @@ fail_pipe:
 		}
 	}
 	if (cmd->pid < 0)
-		error("cannot fork() for %s: %s", cmd->argv[0],
-			strerror(errno));
+		error_errno("cannot fork() for %s", cmd->argv[0]);
 	else if (cmd->clean_on_exit)
 		mark_child_for_cleanup(cmd->pid);
=20
@@ -482,7 +481,7 @@ fail_pipe:
 			cmd->dir, fhin, fhout, fherr);
 	failed_errno =3D errno;
 	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno !=3D ENOENT))
-		error("cannot spawn %s: %s", cmd->argv[0], strerror(errno));
+		error_errno("cannot spawn %s", cmd->argv[0]);
 	if (cmd->clean_on_exit && cmd->pid >=3D 0)
 		mark_child_for_cleanup(cmd->pid);
=20
@@ -703,7 +702,7 @@ int start_async(struct async *async)
 		if (pipe(fdin) < 0) {
 			if (async->out > 0)
 				close(async->out);
-			return error("cannot create pipe: %s", strerror(errno));
+			return error_errno("cannot create pipe");
 		}
 		async->in =3D fdin[1];
 	}
@@ -715,7 +714,7 @@ int start_async(struct async *async)
 				close_pair(fdin);
 			else if (async->in)
 				close(async->in);
-			return error("cannot create pipe: %s", strerror(errno));
+			return error_errno("cannot create pipe");
 		}
 		async->out =3D fdout[0];
 	}
@@ -740,7 +739,7 @@ int start_async(struct async *async)
=20
 	async->pid =3D fork();
 	if (async->pid < 0) {
-		error("fork (async) failed: %s", strerror(errno));
+		error_errno("fork (async) failed");
 		goto error;
 	}
 	if (!async->pid) {
@@ -787,7 +786,7 @@ int start_async(struct async *async)
 	{
 		int err =3D pthread_create(&async->tid, NULL, run_thread, async);
 		if (err) {
-			error("cannot create thread: %s", strerror(err));
+			error_errno("cannot create thread");
 			goto error;
 		}
 	}
--=20
2.8.0.rc0.210.gd302cd2
