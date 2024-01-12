Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259796EB68
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSVYpPrH"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3368ae75082so4240125f8f.1
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 07:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705074657; x=1705679457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jc1JZkWtS1Ymauy6uyH9vLGUooYfVuhyIkxyuNS27Zg=;
        b=KSVYpPrHzzPFRD+Z8Ox0OyJpnJntYwPWU3yuhAAm3MbAqzkrldkZH7pdO+tbxoaHvE
         UCKh9UpB/R4j7+BzKiLTcWchJjg0zLYNiOk2gGyMbkUqLaI1Yl85YCkkxTXHa/NyliY+
         XNgJ/LTNCTBamHBXAjRcDnDzy0PC8rCaxeJks/Xi3pRPEjO4mBp68KcZtK821zl/jk2a
         3givFbRqpRRZ76LYzQUgULU4Ba3fIRj8Vmgs5ZEn1kD0F1AhBWbb1gM/W7OjubSQfZYe
         qvEM1gsGSv100P+eou9AKeqFkf2sEKLTt9PLWlISVx++mY7AK/mxZyDyXOCuStsqHKuJ
         SlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705074657; x=1705679457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jc1JZkWtS1Ymauy6uyH9vLGUooYfVuhyIkxyuNS27Zg=;
        b=aj3Ul/sFRovxTIaq00Uj1lI7iLw88cK5kcvJEj7maJoVRTpWmQUuD5EE/YLOXabOKE
         8STMKKW/h2y5Oy1qr/31nttYGIljSoJPf5cuZ6T2HmB+3ikV5UDy5rCVGXYG5S5iLKoV
         dRJcHNWXD0+6MQXLdY3WqScsoTpwJLKLs2ZqSmlNidIZ47tWevnkW9xx99swINwQy+Bq
         G8L8ng3KYPx2PhA6I2jqljRcvqmkW72dDRv8iBTjiAv/GVkHQ3L2nDcsDDQWU5H5FJqR
         3Vo0W64QuiDSxUAK28PYwH3y49SCwqjqK48vPjyspb2E/+4os5jwBdSz7HMLqrSnDFHm
         7caw==
X-Gm-Message-State: AOJu0Yyebt8kvL7gLneU1pLvTYK8cExzKCAfwC3XNC0M+lKSD0fiJlDB
	4oE9ShSrgvzT+OajjoM0RhM=
X-Google-Smtp-Source: AGHT+IHyGtEPsIqzMCS195XXT0bne0lfxILauNxHgEZ0JV2weLh3I12k+Ssc7Dkp816y3ngVQu1a7A==
X-Received: by 2002:a1c:7706:0:b0:40e:5660:c796 with SMTP id t6-20020a1c7706000000b0040e5660c796mr886009wmi.73.1705074657072;
        Fri, 12 Jan 2024 07:50:57 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd4-c452-0-6835-a146-250e-421c.ipv6dyn.netcologne.de. [2001:4dd4:c452:0:6835:a146:250e:421c])
        by smtp.gmail.com with ESMTPSA id q6-20020adf9dc6000000b003378e67fd2asm3569356wre.86.2024.01.12.07.50.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jan 2024 07:50:56 -0800 (PST)
Sender: Michael L <mial.lohmann@gmail.com>
From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	mi.al.lohmann@gmail.com,
	newren@gmail.com,
	phillip.wood123@gmail.com,
	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 2/2] revision: Implement `git log --merge` also for rebase/cherry_pick/revert
Date: Fri, 12 Jan 2024 16:50:33 +0100
Message-Id: <20240112155033.77204-2-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240112155033.77204-1-mi.al.lohmann@gmail.com>
References: <xmqqy1cvcsp3.fsf@gitster.g>
 <20240112155033.77204-1-mi.al.lohmann@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Co-authored-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
---

> I won't comment on the coding style violations in the patch below in
> this message.

I hope this one is better. The other one was just a proof of the general
concept and meant as a starting point for a discussion if this is wanted
at all. But I should still have taken more care.

On 12. Jan 2024, at 08:35, Johannes Sixt <j6t@kdbg.org> wrote:
> Ha! Very nice patch. For comparison, have a look at my patch to achieve
> the same that I never submitted (in particular, the author date):
> https://github.com/j6t/git/commit/2327526213bc2fc3c109c1d8b4b0d95032346ff0
> 
> This implementation is more complete than mine. I like it.

Ha! Nice one! I took a few of your changes as an inspiration and put you
as a co-author.

Cheers
Michael

Difference compared to v1: Basically complete rewrite using
"refs_resolve_ref_unsafe". Has to be applied after [PATCH v2 1/2] to
avoid conflict.

 revision.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/revision.c b/revision.c
index 786e1a3e89..b0b47dd241 100644
--- a/revision.c
+++ b/revision.c
@@ -1961,6 +1961,25 @@ static void add_pending_commit_list(struct rev_info *revs,
 	}
 }
 
+static const char *lookup_other_head(struct object_id *oid)
+{
+	struct ref_store *refs = get_main_ref_store(the_repository);
+	const char *name;
+	int i;
+	static const char *const other_head[] = {
+		"MERGE_HEAD", "REBASE_HEAD", "CHERRY_PICK_HEAD", "REVERT_HEAD"
+	};
+
+	for (i = 0; i < ARRAY_SIZE(other_head); i++) {
+		name = refs_resolve_ref_unsafe(refs, other_head[i],
+					       RESOLVE_REF_READING, oid, NULL);
+		if (name)
+			return name;
+	}
+
+	die("--merge without MERGE_HEAD, REBASE_HEAD, CHERRY_PICK_HEAD or REVERT_HEAD?");
+}
+
 static void prepare_show_merge(struct rev_info *revs)
 {
 	struct commit_list *bases;
@@ -1974,13 +1993,7 @@ static void prepare_show_merge(struct rev_info *revs)
 	if (repo_get_oid(the_repository, "HEAD", &oid))
 		die("--merge without HEAD?");
 	head = lookup_commit_or_die(&oid, "HEAD");
-	other_head = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-					     "MERGE_HEAD",
-					     RESOLVE_REF_READING,
-					     &oid,
-					     NULL);
-	if (!other_head)
-		die("--merge without MERGE_HEAD?");
+	other_head = lookup_other_head(&oid);
 	other = lookup_commit_or_die(&oid, other_head);
 	add_pending_object(revs, &head->object, "HEAD");
 	add_pending_object(revs, &other->object, other_head);
-- 
2.43.0.284.g6c31128a96

