Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D5D12B6E
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="GroErZ9i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1702971738; x=1703576538; i=l.s.r@web.de;
	bh=Qh07KF/xEGDs8SA5+69tVQXmza3y0dqx53oyoDMqrt8=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=GroErZ9iakKBCmAXx/mwUIavwnNsGffIWAf1A2K1ASlv4mx7G7XmsDItocMOMFWt
	 2qbbfOJlbiWUNtUlnv3sOZODPG/S51uHGeHhIwINCtI73fSGP106zHzEdi+Hl+rW7
	 CECNpcRQUB2xYt2f7T69XOD+2gnoWRDsmJT5uBvUxd174zHXgL75n/ZTFZeQHL9IJ
	 qvt8UTG5W2fSdl9Ndr+OCAzmYgoXG5H7F/Rzf6tOUugTgKKq+HVnoe173Rqo0I4Cn
	 gJMBOiBH405wHHYU9S1hpkLRFXEUzsVXrIw7BtVoy40yCG/dVxe5ELwSuTH0+CVpV
	 vpFmXBRfE0VQ6qVzJA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mdf89-1qg9vP1gn3-00ZDxT for
 <git@vger.kernel.org>; Tue, 19 Dec 2023 08:42:18 +0100
Message-ID: <4ab7431c-6c1b-448c-b4d2-e8b9be0e4eef@web.de>
Date: Tue, 19 Dec 2023 08:42:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] rebase: use strvec_pushf() for format-patch revisions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U94jBF/eWDU7tHsz/Bp1I003luMZyrVnsiSkOFrWKtsA6mZ8iyz
 Xqpuwn252cZpCwrmcuuSxiEuOyGxpMkyd/sjnhJHl8RHvGpo4ECRbNigYH1B+d8kJO4KiVC
 vCb4CbXp6SGYEo9RUVs79Vtrye0sEEUXSEv5+FHVHtoPKxugNqSPkXmrrtjiqWuO9bc0MVA
 7uV0tUkX4oXEiH3fXUCkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PO82wwY+DPA=;hTFbhoiGmeCDgmvpJLjJ4LoQ0kK
 Our4cQRw4mHCFO0lQg2zTJOQ1syAq9cQyXUxNUIw15Iz7DRWSJ2TNE7G7inWgUTzHSEmODEeD
 M6hn8E0WhxEr+B1uNrxBrx68Onkb7nOI4b/2YNYFDe7LEmRNpEuZwbbPf8t8UbeTrzkdc8aOp
 SpUmo1LXV7TILINKoyanGIwl9IPymi8LNSjCPnbaqoPBfb3BiHV9OHSkzv9hFG7FVouEqswp0
 85nR1seoIll+m2iipxkw4PVE9yY+tuZNitm1WH06SQVb1cUzxrV8NvhdP9dmC6lqHSEAM0Fom
 xzy1XuUxFKmHhGSm5VhgZ6ekFKkGS/lG49GEc62aiokcQPNQAThTW89f+EtTgSrArCKaB1rbw
 bluV5xZoJP/PiYlcOxf5R1Arja4oSnVFANtLJqjRTyMuA7vg7tuoT5o7/zIHSzG0rGx24snCB
 XeQITBD9JhUDXYgH3Du7VCiRCFWQt2MB9/HWoVCk/3A8ddG+RZTE5qVuhq1XVrLI6xDOtJNVH
 MspMHrkgmmHFaJ7CZAeZmrvMpT4vOGZP5Dq9KTPocFZVQrLc0hjnHooHjrMld1SSpDX392ENX
 OsAProC93Y58KWr7n8d1vobx24nNZxYP5Qn7JGftm5b07hIum1x/hJmACgDmOChYBGR3neYya
 SmcuWYd3CWyHhBFFzPdvPRos2lFdD2qL/GjRNitJ0mf9JANQH1zfEv+nh7LtcWvUamQUGClkp
 awL/FQgqBHDKeGV1mqpclA85h8GV7+anOvzbc7B8vQ/55ZDIWLAQtubyTlbBpS0KVXJ8z6z/T
 por1pZ6eHVm2x3dqC4La9pnRTGNZvR3kC3kwUd8i+zlryOwyAAwrQst+1SfOsqV85W4IUBecB
 +E7bymsoc3uFMh6mbMyRGJF6pnNoQJrPtXtI0pZA/30H9kLNzC1BxlPc9t2WvLRoSYMXoUkNi
 NtOi6g==

In run_am(), a strbuf is used to create a revision argument that is then
added to the argument list for git format-patch using strvec_push().
Use strvec_pushf() to add it directly instead, simplifying the code.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Formatted with --inter-hunk-context=3D14 for easier review.

 builtin/rebase.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 9f8192e0a5..ddde4cbb87 100644
=2D-- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -582,7 +582,6 @@ static int run_am(struct rebase_options *opts)
 {
 	struct child_process am =3D CHILD_PROCESS_INIT;
 	struct child_process format_patch =3D CHILD_PROCESS_INIT;
-	struct strbuf revisions =3D STRBUF_INIT;
 	int status;
 	char *rebased_patches;

@@ -615,34 +614,32 @@ static int run_am(struct rebase_options *opts)
 		return run_command(&am);
 	}

-	strbuf_addf(&revisions, "%s...%s",
-		    oid_to_hex(opts->root ?
-			       /* this is now equivalent to !opts->upstream */
-			       &opts->onto->object.oid :
-			       &opts->upstream->object.oid),
-		    oid_to_hex(&opts->orig_head->object.oid));
-
 	rebased_patches =3D xstrdup(git_path("rebased-patches"));
 	format_patch.out =3D open(rebased_patches,
 				O_WRONLY | O_CREAT | O_TRUNC, 0666);
 	if (format_patch.out < 0) {
 		status =3D error_errno(_("could not open '%s' for writing"),
 				     rebased_patches);
 		free(rebased_patches);
 		strvec_clear(&am.args);
 		return status;
 	}

 	format_patch.git_cmd =3D 1;
 	strvec_pushl(&format_patch.args, "format-patch", "-k", "--stdout",
 		     "--full-index", "--cherry-pick", "--right-only",
 		     "--default-prefix", "--no-renames",
 		     "--no-cover-letter", "--pretty=3Dmboxrd", "--topo-order",
 		     "--no-base", NULL);
 	if (opts->git_format_patch_opt.len)
 		strvec_split(&format_patch.args,
 			     opts->git_format_patch_opt.buf);
-	strvec_push(&format_patch.args, revisions.buf);
+	strvec_pushf(&format_patch.args, "%s...%s",
+		     oid_to_hex(opts->root ?
+				/* this is now equivalent to !opts->upstream */
+				&opts->onto->object.oid :
+				&opts->upstream->object.oid),
+		     oid_to_hex(&opts->orig_head->object.oid));
 	if (opts->restrict_revision)
 		strvec_pushf(&format_patch.args, "^%s",
 			     oid_to_hex(&opts->restrict_revision->object.oid));
@@ -665,10 +662,8 @@ static int run_am(struct rebase_options *opts)
 			"As a result, git cannot rebase them."),
 		      opts->revisions);

-		strbuf_release(&revisions);
 		return status;
 	}
-	strbuf_release(&revisions);

 	am.in =3D open(rebased_patches, O_RDONLY);
 	if (am.in < 0) {
=2D-
2.43.0
