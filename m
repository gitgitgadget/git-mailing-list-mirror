Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C111F326D57
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255703; cv=none; b=RitglA2PTHzJ/ME5N6lK7Pm1NJrMibH8Da37+li4g3hW+0O/YnGf+kt2NH47a6l37OKSUMyk9XiXTlakhHPIJ2IjFvdxRYwc6eHeu/EXNIuRUA3b9M0vsjXwk8xtmRoHu4/sZv+I2lZOrwh82xbd2oS40vofRfo1mJ05yroLAwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255703; c=relaxed/simple;
	bh=wLv7jS+SabPW8OMiuWtHaEP3ykAS5hpHu9aoqLALl1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vaw0pIQCstbACFDCpOu30sj29uIT29FOPQO08xYq0dFW4AyOgVo/kI0MxFlzGI8JBmMvHcRmpQDMY6etuZ6DVUb7G+JQqfun7mXRydLV6Jnj5wTPxMQ0hEi7EC17/TSNdVCU9CvXJxj4XAV5uMQ6VRfmnfGx+OaSf/m7XI1uq0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=kVV6PIlY; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="kVV6PIlY"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1771255692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=04VB25iSChwcDNpCdWDDtb2m+gVnOyuYX69hmxzPz2M=;
	b=kVV6PIlYQflIAVstB+9miBO33qY86yOhZ5UEpm04fmdZQrD/7/khgdbra4NkZ24ZTHhZmA
	HR8HDF/nK4MaaMrdYoQL0kLmjQ3szZUc+/XeId1iptfmoIYDSKN3PIgjvMIwzx73qSuqm2
	uHoEVVodF1CjhGig/4/aCBqjVolUsb/Pr3POm5uc9PySRdlVZyfxzkVGoHoUAFOAsM07h8
	vr0qaZrBAJlh/w38STzWohjn5QhIWOpyuAKWyN0SsJwdHXFWOetQB7VmP9mQC4BFwmPOy4
	fryhuncvIofAKAwpuvV3UTFUHbBT3L6MWf+ZK7ZtXh9ZHx4uN9h8lJvVQCHLQQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Mirko Faina <mroik@delayed.space>
Subject: [PATCH v2] format-patch: fix From header in cover letter
Date: Mon, 16 Feb 2026 16:27:30 +0100
Message-ID: <20260216152730.37478-1-mroik@delayed.space>
In-Reply-To: <aZAMr6XOwKkTa55q@exploit>
References: <aZAMr6XOwKkTa55q@exploit>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2949; i=mroik@delayed.space; h=from:subject; bh=wLv7jS+SabPW8OMiuWtHaEP3ykAS5hpHu9aoqLALl1Y=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpkzazMn5vXtnGAHGUDxUeQHyAII+mPD/XLfOx7 8EPiXeGXRWJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZM2swAKCRBIeX6hnBm+ 0QAVD/9vpr+fPCXFc9UK247ozlClzf6hwwJmxhLYSwi67fk2gMLL/ahl/Tam0mjkei4+0KmB8cM 64sVphFv91YvsSAwSZJYt+7u2muKj3yH/SV2TQlZdpV43JXmaEKEz5oXbSStBTi7W3pgyKzdvRW a2ZdXRQB0BPwEUj6if13ZkiEcLR4ct6VTY3FaL1BVo4pDAN43aHiSGf7cboMGiVg0DNHYB9L/hr IY4mBJRtfqzymG846cYV5Af6vajGYdaT0Xs5QCPPYnnU2ZGTpF4Mc9nHGuyBKEFIK1IDlkF46QA iVkuuftzRBn4bCw0uuMvUhOoWDMGJqdxtZL975r3ka6RVH87RAR8JoePg+5EOX3IKWUVgDz2Ore zDmKnDfW3/JhPGNwZ3sTnmuWefnH16H9VHvU88gzsbNflivFSZlj8ozJMc3rMaPuffRa3dTIAcC vfWNz0urf4uUs4BvYVzKtdOoQ9Vmfhcw2mJ2sPROQW4v1nAAE6c46BEeV+5pl14+Y4ZEkgNojWw TXVKF+39EkU9yaHkSLUbkPulZIeL+e9rejF5jfmkkZDFIjkXstcQ8gr29vXWA0HZJiLcaNw4uQe ZFXwG/QzhKnJpKkEF325iYtC4Ib0kLYAd81S7Q4JirM5dZ3xuuItEBbmnHm0ZGqBIMPndMU0f5v UAtAVcSF28AY+Iw==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -

"git format-patch" takes "--from=<user ident>" command line option and
uses the given ident for patch e-mails, but this is not applied to the
cover letter, the option is ignored and the committer ident of the
current user is used.

Teach the make_cover_letter() function to honor the option, instead of
always using the current committer identity.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
I'm sorry about the poor quality of the previous commit message, I
realise it did a poor job at explaining what the patch did.

I've applied the changes you suggested and wrote the test.
Thank you for the review.

 builtin/log.c           |  6 +++---
 t/t4014-format-patch.sh | 12 ++++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index d43ca693bf..42648dda54 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1332,7 +1332,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			      int quiet,
 			      const struct format_config *cfg)
 {
-	const char *committer;
+	const char *from;
 	struct shortlog log;
 	struct strbuf sb = STRBUF_INIT;
 	int i;
@@ -1345,7 +1345,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	if (!cmit_fmt_is_mail(rev->commit_format))
 		die(_("cover letter needs email format"));
 
-	committer = git_committer_info(0);
+	from = cfg->from ? cfg->from : git_committer_info(0);
 
 	if (use_separate_file &&
 	    open_next_file(NULL, rev->numbered_files ? NULL : "cover-letter", rev, quiet))
@@ -1368,7 +1368,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	pp.date_mode.type = DATE_RFC2822;
 	pp.rev = rev;
 	pp.encode_email_headers = rev->encode_email_headers;
-	pp_user_info(&pp, NULL, &sb, committer, encoding);
+	pp_user_info(&pp, NULL, &sb, from, encoding);
 	prepare_cover_text(&pp, description_file, branch_name, &sb,
 			   encoding, need_8bit_cte, cfg);
 	fprintf(rev->diffopt.file, "%s\n", sb.buf);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 21d6d0cd9e..cb04a9c47b 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1472,6 +1472,18 @@ test_expect_success '--from uses committer ident' '
 	test_cmp expect patch.head
 '
 
+test_expect_success '--from applies to cover letter' '
+	echo "This is a test text" >file_to_commit &&
+	git format-patch -1 --stdout --cover-letter --from="Foo Bar <author@example.com>" >patch &&
+	cat >expect <<-\EOF &&
+	From: Foo Bar <author@example.com>
+	From: Foo Bar <author@example.com>
+	From: A U Thor <author@example.com>
+	EOF
+	sed -ne "/^From:/p; /^[[:space:]]$/d" patch >patch.head &&
+	test_cmp expect patch.head
+'
+
 test_expect_success '--from omits redundant in-body header' '
 	git format-patch -1 --stdout --from="A U Thor <author@example.com>" >patch &&
 	cat >expect <<-\EOF &&
-- 
2.53.0

