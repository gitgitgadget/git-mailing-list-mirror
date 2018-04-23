Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 942931F424
	for <e@80x24.org>; Mon, 23 Apr 2018 19:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932345AbeDWTpI (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 15:45:08 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33386 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932244AbeDWTpH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 15:45:07 -0400
Received: by mail-wr0-f196.google.com with SMTP id z73-v6so44457815wrb.0
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 12:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4F93TPKu93M0O7wgXhA4JkU9HGS8R1npq1TkrnjuObc=;
        b=OoK6kdjLjGbUySxYBz5m23j43mDaoe9JgQanN1oBIpx2Ft8knGs/Lag5f5wNT98tXA
         yGuM5+i+YByBFsZSVAZNtzO5w4PaRoVQ0TDSpvPwDW1z4KsDVIuzRfqG/Dv4YlCZnWM1
         LXTWSo4tgpa9psaLwR8IjeX9hpW1IJln6pf3umwxpJW2JDgIPDwJ+udlWUevIO0b0U1o
         KO0KwTC0QwtBgOqsvcuGipGHa4TIXQrkE03me+loRJIeqFa0xy2Tfx4enocN4c4eVszV
         BVunBkFV7HrUJ9E2cHR0esTtHVBgne7oItPKCwCpn+XvErTIwnM30JV0oE4NxZio0oHp
         Z6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4F93TPKu93M0O7wgXhA4JkU9HGS8R1npq1TkrnjuObc=;
        b=kfBAr6V4m++DqwBsHzZUym8Xrq3fBrcEdbO3/oeRr6NXFiEI/t/Fkk3yeDCfkb20jY
         ABMGleQEmlFgf5ejrcFmDGm8gbHdWGmFFtDjqciKnP9YGt4GL7KpcMJR6NlpzQJ1KN0X
         8NeKJHhiUt33hkwzTQzCDyr7PE4J+gsdttoCUuqEsQBP1Jncy0TG5Q3OOxHZlKewWw+j
         7Dkx8WqkfVMGp++aOudJyDJfyiu/QXkZREv0PmJjnQUKQONhnCNTn8YU7tQdyGwpsl26
         7r7qPlIUFneBNRyoUSUCxRrI8kYxjgVQcVo8+Av2GouS04fzIrxsuvKbhKcOcyx1V2xU
         FypA==
X-Gm-Message-State: ALQs6tD4JBTpJhqb2i+8SvuNpE6gW1OanY+27lvg4j+KfRNe5AclCgTt
        b10QIBjtV2deANAno5yQDKoCTUPG
X-Google-Smtp-Source: AIpwx4/iYXnfcl7QH+EjBAHrSCszdA+1X5h08UXOUlvq0QHJxk6SjeLIgnyVIU0woTAB/nJA9Ok5qg==
X-Received: by 2002:adf:b067:: with SMTP id g36-v6mr18618569wra.128.1524512706063;
        Mon, 23 Apr 2018 12:45:06 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id f5-v6sm169184wrh.35.2018.04.23.12.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 12:45:04 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v8 0/4] worktree: teach "add" to check out existing branches
Date:   Mon, 23 Apr 2018 20:38:44 +0100
Message-Id: <20180423193848.5159-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.74.g7afd1c25cc.dirty
In-Reply-To: <20180415202917.4360-1-t.gummerer@gmail.com>
References: <20180415202917.4360-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Eric and Junio for the review the suggestions in the last
round.

Previous rounds are at <20180121120208.12760-1-t.gummerer@gmail.com>,
<20180204221305.28300-1-t.gummerer@gmail.com>,
<20180317220830.30963-1-t.gummerer@gmail.com>,
<20180317222219.4940-1-t.gummerer@gmail.com>,
<20180325134947.25828-1-t.gummerer@gmail.com>,
<20180331151804.30380-1-t.gummerer@gmail.com> and
<20180415202917.4360-1-t.gummerer@gmail.com>.

This round updates the output for "resetting branch ..." to not have
braces embedded inside of another pair of braces, and is not correctly
printing "checking out '<branch>'" when 'git worktree add <path>
<local-branch>' is used.  Both these changes are in patch 2/4, the
other patches are the same as in the previous round.

Interdiff below:

diff --git a/builtin/worktree.c b/builtin/worktree.c
index f5a5283b39..d52495f312 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -353,7 +353,8 @@ static int add_worktree(const char *path, const char *refname,
 	return ret;
 }
 
-static void print_preparing_worktree_line(const char *branch,
+static void print_preparing_worktree_line(int detach,
+					  const char *branch,
 					  const char *new_branch,
 					  const char *new_branch_force,
 					  int checkout_existing_branch)
@@ -365,19 +366,27 @@ static void print_preparing_worktree_line(const char *branch,
 		if (!commit)
 			printf_ln(_("Preparing worktree (new branch '%s')"), new_branch_force);
 		else
-			printf_ln(_("Preparing worktree (resetting branch '%s' (was at %s))"),
+			printf_ln(_("Preparing worktree (resetting branch '%s'; was at %s)"),
 				  new_branch_force,
 				  find_unique_abbrev(commit->object.oid.hash,
 						     DEFAULT_ABBREV));
 	} else if (new_branch) {
 		printf_ln(_("Preparing worktree (new branch '%s')"), new_branch);
 	} else {
-		struct commit *commit = lookup_commit_reference_by_name(branch);
-		if (!commit)
-			die(_("invalid reference: %s"), branch);
-		printf_ln(_("Preparing worktree (detached HEAD %s)"),
-			  find_unique_abbrev(commit->object.oid.hash,
-					     DEFAULT_ABBREV));
+		struct strbuf s = STRBUF_INIT;
+		if (!detach && !strbuf_check_branch_ref(&s, branch) &&
+		    ref_exists(s.buf))
+			printf_ln(_("Preparing worktree (checking out '%s')"),
+				  branch);
+		else {
+			struct commit *commit = lookup_commit_reference_by_name(branch);
+			if (!commit)
+				die(_("invalid reference: %s"), branch);
+			printf_ln(_("Preparing worktree (detached HEAD %s)"),
+				  find_unique_abbrev(commit->object.oid.hash,
+						     DEFAULT_ABBREV));
+		}
+		strbuf_release(&s);
 	}
 }
 
@@ -481,7 +490,7 @@ static int add(int ac, const char **av, const char *prefix)
 		}
 	}
 
-	print_preparing_worktree_line(branch, new_branch, new_branch_force,
+	print_preparing_worktree_line(opts.detach, branch, new_branch, new_branch_force,
 				      checkout_existing_branch);
 
 	if (new_branch) {

Thomas Gummerer (4):
  worktree: remove extra members from struct add_opts
  worktree: improve message when creating a new worktree
  worktree: factor out dwim_branch function
  worktree: teach "add" to check out existing branches

 Documentation/git-worktree.txt |   9 +++-
 builtin/worktree.c             | 111 +++++++++++++++++++++++++++++++----------
 t/t2025-worktree-add.sh        |  26 +++++++---
 3 files changed, 110 insertions(+), 36 deletions(-)

-- 
2.16.1.74.g7afd1c25cc.dirty

