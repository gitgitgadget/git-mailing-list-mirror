Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6506C20B3E
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717871882; cv=none; b=AkLJKVhwzZvwvWkmCvL9NgVXwDQIPWAD8qXXVF2x2co4kEDdJpwp5c4xOuwmVhWzQ5fFPilJP1YhErkHtxWCnPybvduwpM/mrrJ1A78K0WK7xQMFVmA601RC7bDJZi5QK9LN4f0B8qOaDPe22BTQjWgP8pozzeQlOfRgn+7bv5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717871882; c=relaxed/simple;
	bh=29eQvUCTRMD/W0/Vx1p6+SlqGNQzgWr2QXEUZDywyfA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZMAU4IyWE12CYYyzL0GLTDPQRoHbmMPdBp97PFmwAr7olJHLZ+Q7SI+dTmTkq7pF29d44YpucomhjFv4EM5XI/6n/BtCp0lxW24ntr5iseXzUxIU6cqQ1Zz2udkcqEcXM7zXESeq/hlOW4hfF5RiP/jXQfGWMOVDOW/gNtJm9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UNApbzd6; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UNApbzd6"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 13368331AE;
	Sat,  8 Jun 2024 14:37:55 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=29eQvUCTRMD/W0/Vx1p6+SlqG
	NQzgWr2QXEUZDywyfA=; b=UNApbzd6VDWoIhdmAT2w2t9+6jemxI0y4mU3WkvW2
	/H9eFtSdwSGTWCEw6QPy+rFweSdRr4KtEsmginNvqZ8YOoIuY2Yym9YyoFDOUoEO
	umG7Z26tPknc/mZcoi7yopJkXwzlcoXKFTv4ThlOka0tKC2ol3zLR0x8iUqtBpTJ
	yU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0BD4A331AD;
	Sat,  8 Jun 2024 14:37:55 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BAD46331AB;
	Sat,  8 Jun 2024 14:37:51 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/4] __attribute__: remove redundant attribute declaration for git_die_config()
Date: Sat,  8 Jun 2024 11:37:45 -0700
Message-ID: <20240608183747.2084294-3-gitster@pobox.com>
X-Mailer: git-send-email 2.45.2-445-g1b76f06508
In-Reply-To: <20240608183747.2084294-1-gitster@pobox.com>
References: <20240608183747.2084294-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 365FED36-25C6-11EF-B810-ACC938F0AE34-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

The convention is to declare the function attribute to an extern
function together with its declaration in the header file, without
repeating the attribute declaration with its definition in the .c
source file (a file-scope static function declares its attribute
together with its definition in the .c file it is defined, as there
is no other place to do so).

The definition of git_die_config() in config.c did not follow the
convention and had its attribute declared with both its declaration
in the header and its definition in the .c source file.

Remove the one in the config.c to match everybody else.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.c b/config.c
index abce05b774..ea355f28ec 100644
--- a/config.c
+++ b/config.c
@@ -2844,7 +2844,6 @@ void git_die_config_linenr(const char *key, const c=
har *filename, int linenr)
 		    key, filename, linenr);
 }
=20
-NORETURN __attribute__((format(printf, 2, 3)))
 void git_die_config(const char *key, const char *err, ...)
 {
 	const struct string_list *values;
--=20
2.45.2-445-g1b76f06508

