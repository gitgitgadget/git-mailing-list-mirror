From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 33/41] run-command.c: use error_errno()
Date: Sun,  8 May 2016 16:47:53 +0700
Message-ID: <1462700881-25108-34-git-send-email-pclouds@gmail.com>
References: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
 <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 11:53:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLNY-0002mJ-9N
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbcEHJv4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:51:56 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:32863 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbcEHJvz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:51:55 -0400
Received: by mail-pa0-f65.google.com with SMTP id gh9so13697397pac.0
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UHO+kv4XdLapel/fDeP654YK4xCQ/QV/SKzmL4Zh9VY=;
        b=ZfBoYpgkZKadursWv9wO4EM2Drdtj6KBxd7BM1okMG8neLKRdd6ZtWiaHxmmI0EIdn
         c/fZpAHpNB+/LGSVf3yHWjK8oglrYiLZZGru/6vHTxmkWDq7B/OgY5YRYxVrlyJrVg4d
         HF58GqGiTWDUt/mgvtHDsFxtflsCxnao/IM70KLEapfDZ0+nBLVL/KwCViOoX0ZDz0aZ
         WFPUzfzZOP707oI0ZwxNNpP+L3qWn2ioDxPboZA0A3jcvH/0tM5DnaXqcfGIGrYiL1mK
         7NxZFtaxW88rLgpxTfMyBcJkH0L31+Te/uQPAragOhkcLWJrRUeFIX+NwkydTa8/faaH
         IuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UHO+kv4XdLapel/fDeP654YK4xCQ/QV/SKzmL4Zh9VY=;
        b=N2pSdojJk5MaMmxgLjntAgIZ3DkDp9swSjs8eR5F0wyp79j+bn6Vx+CI7vHzGdXvsc
         pLS1Tk1L0TX17tvByWK1qSJv0tMz+S/Ce5B6Y0s1UXHKT991PTC20G+ZcGUULWsuZZ5Z
         tt0o6mvTb0ozLS9PGCzITLdjADaztLjl4+2WROIInwGYTgdoi3Rl9QTHvfyYvsSzzBXr
         wjJ+EKc3VeutFlXVxz7e5VUsHtHeSfE+sj33NQXSG8MeQI906/OhDKOjROiWNCY5+ylz
         Ev6sR88+O6iAKVqeeqEuMoppivjyODsQZsLmVLV+WgZjS5+E3eFZvzO5X0BCyHjwe/3n
         zC/Q==
X-Gm-Message-State: AOPr4FVNog/i2Qu03OlZLUKnr4dy6E+ZmyMpgqFXX/R7if4RyOAIjsn0t1keHNPCthtVmg==
X-Received: by 10.66.66.234 with SMTP id i10mr42571060pat.114.1462701115214;
        Sun, 08 May 2016 02:51:55 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id 64sm24627681pfk.69.2016.05.08.02.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:51:53 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:51:54 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293953>

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
