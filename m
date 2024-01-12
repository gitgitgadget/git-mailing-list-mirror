Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD346E2C7
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A69I72X+"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e613b6afbso18455195e9.3
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 07:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705074657; x=1705679457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZT/9n9oED3woYx9+v4wz3rby+0IctAyuYMbl8NNAg8=;
        b=A69I72X+4jai6F0lFm6GO2UWwM7QzJVby3ifWHFXBslhSZu591WbcrZFciFrZqlMME
         DXN5H7rtk759gl6+XGRiMHBZi2fQqICUDOTLg+P1r8bFE/pnVlFW/20+BDoa1THyksd/
         Nv3CKck/oEIO/KfwCSwazEEjYRjOamLyoxIZD/U1g0JMTtZHf30YyEGCcCUTCX6EUkfJ
         FQhC7a5oxIaLs3DUU1dLINj1nR6J5OQdGZDmRxSgc8o9O/mYi1Nf1H8g4R57vcZSeRVL
         wGtqwsAc9j7S3oNTqnc7TNnce+igTL8SSpyLpm0Mbtv3cibjkkiGVN6rG3WdNKotVhuS
         /G9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705074657; x=1705679457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DZT/9n9oED3woYx9+v4wz3rby+0IctAyuYMbl8NNAg8=;
        b=XDmFr+PelzCi4k6a7ePvH1vw1CKWzrljH1ORb5ZKqUBnbUpt+LIVDd4MvDJbrtnHb+
         E2F+fpDgySJdSfWhWX100GoVtM2kmmLIL66Dq4ZO1cQYUAYcX+jitjlJQSnbgdEtKl86
         oFSimwvtuxLFNCuVpuQVEsdfLmy4rfNlkgnDZVNQh4A9Tt1gnZaMJOvFuKwFfp0SipAh
         1ZVuSKZ6/b4Sr0oXtzE7qeDH4ReRx8XyB4biHmezd4LWbKtKxdEOlY2UUBHFLmDFy3JV
         bJ/3EXMcV3/v58Hx9qnzN4qDb7KOSeUixtJYOh5AmrTqc3TOB5cozdS3z9Vu0wxGFJxv
         0hfQ==
X-Gm-Message-State: AOJu0YzXYF/ntJNw3zy+XTd3GK9n35APF5PBlIMnpBTyTMNb/+CylBWj
	1jRWjey/UJPGWwiRP64huXA=
X-Google-Smtp-Source: AGHT+IFVBaMBHRV9RgyGf3TlTJfYFSXkq8Xp7sodQmmDbreDrazrBBgbiPUR6NDyoiGhmjmPcTMi7g==
X-Received: by 2002:a05:600c:4ba8:b0:40d:8459:480e with SMTP id e40-20020a05600c4ba800b0040d8459480emr740041wmp.178.1705074656400;
        Fri, 12 Jan 2024 07:50:56 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd4-c452-0-6835-a146-250e-421c.ipv6dyn.netcologne.de. [2001:4dd4:c452:0:6835:a146:250e:421c])
        by smtp.gmail.com with ESMTPSA id q6-20020adf9dc6000000b003378e67fd2asm3569356wre.86.2024.01.12.07.50.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jan 2024 07:50:55 -0800 (PST)
Sender: Michael L <mial.lohmann@gmail.com>
From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	mi.al.lohmann@gmail.com,
	newren@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v2 1/2] revision: ensure MERGE_HEAD is a ref in prepare_show_merge
Date: Fri, 12 Jan 2024 16:50:32 +0100
Message-Id: <20240112155033.77204-1-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <xmqqy1cvcsp3.fsf@gitster.g>
References: <xmqqy1cvcsp3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is done to
(1) ensure MERGE_HEAD is a ref,
(2) obtain the oid without any prefixing by refs.c:repo_dwim_ref()

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
---
Hi!

On 12. Jan 2024, at 01:15, Junio C Hamano <gitster@pobox.com> wrote:
> > This extends the functionality of `git log --merge` to also work with
> > conflicts for rebase, cherry pick and revert.
> > 
> > Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
> > ---
> > ... It is basically the counterpart to
> > `git show ${ACTION}_HEAD` for understanding the source of the conflict.
> 
> I do not know about the validity of that approach to use *_HEAD,

What I wanted to convey is that e.g. "git show CHERRY_PICK_HEAD" will
tell you about the conflict from the perspective of the commit that is
currently to be applied while "git log --merge" tells the story from the
perspective of HEAD. So they are by no means the same, but can
complement each other in getting an understanding about the conflict.

> but we may want to tighten the original's use of repo_get
> > -	if (repo_get_oid(the_repository, "MERGE_HEAD", &oid))
> > -		die("--merge without MERGE_HEAD?");
> > -	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
> 
> ... so that we won't be confused in a repository that has a tag
> whose name happens to be MERGE_HEAD.  We probably should be using
> refs.c:refs_resolve_ref_unsafe() instead to _oid() here ...

Here I am really at the limit of my understanding of the core functions.
Is this roughly what you had in mind? From my testing it seems to do the
job, but I don't understand the details "refs_resolve_ref_unsafe"...

 revision.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index 2424c9bd67..786e1a3e89 100644
--- a/revision.c
+++ b/revision.c
@@ -1967,17 +1967,23 @@ static void prepare_show_merge(struct rev_info *revs)
 	struct commit *head, *other;
 	struct object_id oid;
 	const char **prune = NULL;
+	const char *other_head;
 	int i, prune_num = 1; /* counting terminating NULL */
 	struct index_state *istate = revs->repo->index;
 
 	if (repo_get_oid(the_repository, "HEAD", &oid))
 		die("--merge without HEAD?");
 	head = lookup_commit_or_die(&oid, "HEAD");
-	if (repo_get_oid(the_repository, "MERGE_HEAD", &oid))
+	other_head = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+					     "MERGE_HEAD",
+					     RESOLVE_REF_READING,
+					     &oid,
+					     NULL);
+	if (!other_head)
 		die("--merge without MERGE_HEAD?");
-	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
+	other = lookup_commit_or_die(&oid, other_head);
 	add_pending_object(revs, &head->object, "HEAD");
-	add_pending_object(revs, &other->object, "MERGE_HEAD");
+	add_pending_object(revs, &other->object, other_head);
 	bases = repo_get_merge_bases(the_repository, head, other);
 	add_rev_cmdline_list(revs, bases, REV_CMD_MERGE_BASE, UNINTERESTING | BOTTOM);
 	add_pending_commit_list(revs, bases, UNINTERESTING | BOTTOM);
-- 
2.43.0.284.g6c31128a96

