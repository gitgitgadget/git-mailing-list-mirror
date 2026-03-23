Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAAE1A3029
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285081; cv=none; b=ccxTPh/wQYNa/PpJ9Ofo2AhbCmqKsdUM6sKBVEtK7DaGBqXygYGlutV50xRTBi/kxT/bGruPjFqiIcryUr+qAS9iGVLVeJl4uSf6NFp2T1W+/uLW3K0HYFzvkEf4OD40FEfpOp20f/5P9C1n85WcKKCeCh3FEncJ8fTbxv3RBbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285081; c=relaxed/simple;
	bh=pvcwx7O17efr1o+FvP0bFU9mDVV9lYlCmynkHPGwVhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xi4flTfih+ljMApZjUO60KMGvcNYKz/AxMuWQvFLIPNf8UST4yDx4EjiTmKU/wMQEMvdXqrSAwc6d0S/PLlzDnXrbW56usQVv0ZVw6+T8TcLieLB8Xq2erJtDdUEOonyBZr8vViAR4Bb3llVZe1QVowefcICMXL2sEOY/p4Fn70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=UYWEe3fj; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="UYWEe3fj"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774285075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pMg+QaapXE1Jx4ooj/JKPUdo5SJ2sA8Wg+mB0gaMUZ8=;
	b=UYWEe3fjNOSb/qaa6TIaC9q30/8sWOY10ASECtOwctfyB42Soh0d0oIvp4/rS90MHHJGZh
	YhT2PT6+Z/TaEl88Fr98YudV3gBM9HUmL9l12y558SEffrJ1m1pXAIZek+mTnVtUnsGzWE
	pHAKZ6GJHw8PiDe3V+OlquK6XaCP524IW0L5cR6R1R7VaTYlaVnMCeNrIgJCO3L5iF5xZP
	Im3CvvHCAKverY8m2LYZ2y08megd+UOYOzW6dJdIXYnB7j/ObBnja0R5ZEpHDsiOaMkTJ1
	+4gQgfhxUsXOl1iWr1NZNR0YTIUY/zWQfWLs3+zIVX7sHBjQ0ZZqR2pO8JBK6g==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v3 0/8] improve "git format-patch --commit-list-format"
Date: Mon, 23 Mar 2026 17:57:27 +0100
Message-ID: <cover.1774284699.git.mroik@delayed.space>
In-Reply-To: <cover.1773959395.git.mroik@delayed.space>
References: <cover.1773959395.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3301; i=mroik@delayed.space; h=from:subject:message-id; bh=pvcwx7O17efr1o+FvP0bFU9mDVV9lYlCmynkHPGwVhM=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpwXDwyYpOulEJTqLyo8E2X2mvbtdL5AjVSJWXD Vj4qARY9XuJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCacFw8AAKCRBIeX6hnBm+ 0SiJD/9zMn5jZC6FmFKD8IoBocvvz1cNqrYPc5bqZogU6S4BT1liO8GlASCi4Iqv2VvcXTU85ZL hhVrZFSRpu5zJ+m+1gaNwpiaJvnU5lrGbx1/ftFvZsBsnjFeAoX2DYfdoChh42xuLv8FSMeSptc KgBRjX0kJXOGAVk8hDas4D7ET/2oIDD00fK1jK+vwENLCs7BdaSmN2ufPHqtvy5RUBm4gFlzAcO fn9TS2Ugt+9KioVy5A3GhepaxJECZIc+RuG7utX87XbpMXyHUEj1ri63IqVQaJ/y7uG6kMwr4DM z9yvpg4Jp+bzrSr4yOXJ36jWAg7RpkN1xBWBBDZ0En3mZLjGpVmiYefa8PYpB3BQRRmgfAP33/X 2/oZDATpcKwVPUBMxzY7o5uNQxzHB17epMEWrGCwaqtLezrr37Ob+wIjP9mGDofUWVizHhSFyUA XW4+tCa8CPq0FLaK4sfauWX31uV4ovCTBgBd48sfbJhPYzYpchfIndVACgMK2Ee0OgiI3+m+F0x VjFx+ep4QLH8tmyxynijcqYi9zaTd3b52SLQBIuv5YB5fWF/keW7rsFdV2/CYRbV/D7Xnj9/sVp PQyb8UVrj4KQrbYIylbk13ibrRS+pe0UtzJAq8WTsvhVzaiVe13xxKPPbrxtaMs6Si3se1lYFIU PpsHdW1bU
 Gg98pg==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -

Not much has changed, just applied the suggestions Kristoffer made.
Thank you again for the review

[1/8] pretty.c: better die message %(count) and %(total) (Mirko Faina)
[2/8] format-patch: refactor generate_commit_list_cover (Mirko Faina)
[3/8] format-patch: rename --cover-letter-format option (Mirko Faina)
[4/8] docs/pretty-formats: add %(count) and %(total) (Mirko Faina)
[5/8] format.commitListFormat: strip meaning from empty (Mirko Faina)
[6/8] format-patch: wrap generate_commit_list_cover() (Mirko Faina)
[7/8] format-patch: add preset for --commit-list-format (Mirko Faina)
[8/8] format-patch: --commit-list-format without prefix (Mirko Faina)

 Documentation/config/format.adoc    |  2 +-
 Documentation/git-format-patch.adoc | 19 ++++----
 Documentation/pretty-formats.adoc   |  4 ++
 builtin/log.c                       | 35 +++++++-------
 pretty.c                            |  4 +-
 t/t4014-format-patch.sh             | 72 +++++++++++++++++++----------
 t/t9902-completion.sh               |  1 -
 7 files changed, 84 insertions(+), 53 deletions(-)

Range-diff against v2:
1:  a0d26c5999 = 1:  a0d26c5999 pretty.c: better die message %(count) and %(total)
2:  883dd358b6 = 2:  883dd358b6 format-patch: refactor generate_commit_list_cover
3:  5d061d6398 = 3:  5d061d6398 format-patch: rename --cover-letter-format option
4:  7b1e5cbb24 ! 4:  ce7d1bd1fe docs/pretty-formats: add %(count) and %(total)
    @@ Metadata
      ## Commit message ##
         docs/pretty-formats: add %(count) and %(total)
     
    -    When --commit-list-format has been introduced to format-patch, two new
    -    placeholders have been added to the PRETTY FORMATS code without being
    +    When --commit-list-format was introduced to format-patch, two new
    +    placeholders were added to the PRETTY FORMATS code without being
         documented. Do so now.
     
         Signed-off-by: Mirko Faina <mroik@delayed.space>
    @@ Documentation/pretty-formats.adoc: The placeholders are:
      +%D+:: ref names without the " (", ")" wrapping.
     ++%(count)+:: the number of a patch within a patch series. Used only in
     +	`--commit-list-format` in `format-patch`
    -++%(total)+:: the number of tatal patches in a patch series. Used only in
    +++%(total)+:: the total number of patches in a patch series. Used only in
     +	`--commit-list-format` in `format-patch`
      ++%(decorate++`[:<option>,...]`++)++::
      ref names with custom decorations. The `decorate` string may be followed by a
5:  3cb0a0a088 ! 5:  66d30249bb format.commitListFormat: strip meaning from empty
    @@ Commit message
     
         The configuration variable format.commitListFormat allows for an empty
         value. This is unusual and can create issues when interacting with this
    -    configuration variable through the cli interface.
    +    configuration variable through the CLI.
     
         Strip meaning to format.commitListFormat with an empty value.
     
6:  3f547451a2 = 6:  c722fc9d0f format-patch: wrap generate_commit_list_cover()
7:  fdcb68e650 = 7:  bdd8f1fb57 format-patch: add preset for --commit-list-format
8:  ef0d3ed876 = 8:  d125458e33 format-patch: --commit-list-format without prefix
-- 
2.53.0.1118.gaef5881109

