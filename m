Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697703F12CE
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 06:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417445; cv=none; b=gqZhoH3w9XXLQf2yL+mub6pWUw7QJvLEiMpRIxj+nSw3d4N/tJeLsTxGzNxJaYNVJXQI6+dXkPS5QEYHbcmrYLrwd0pdvEYpTwYRelj+P3FfSd0BOtvkJxa4ql3hY2kaBTriGq13YS40Uh51mkDqNbKbcSeU0K4QMW2PJlIco+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417445; c=relaxed/simple;
	bh=fhpAA7vV39shfpd1Oe/iJGdu8kMV4cbZTixRznWE8cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZtXbiSdMMgDAgg3Cqb3fK33aLiyQ+Rt3yxYYezPF66H0ZRjpANSvr6VgV2FR3v76X56i8W4AB84S/l/35HL4o7kZlYeyUHMt87pJnUeANckhTBtvsUMdjPG6kCLq6kxfM8gfkfJWctmJnrm601b2u4NG7HnE/mKqhi5Nz+ciHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=M+7SKljR; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="M+7SKljR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=mLymMKE3XI+cwzWz30zX+KjWIlMLLfXdSj
	KE3noDtSQ=; b=M+7SKljRYCr56xeWhKJx8loAwhtyx4V2b9YUgPfyHFbADUOVBm
	OswyH9CGGgh2CwRVrt/D6T2hPWZMkDOEQNlG1XBu9R75LsY1PrF2f5/5gxMccNCb
	LG/8Y3GF/PIN0POG0ZN4/W4Ll7+/CnnYrDQTKS7wJVARtCDDi8S79zA5E=
Received: from c7393ccae90d.ustc.edu.cn (unknown [210.45.70.69])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgDn7DOJFZlqMKXVAA--.690S2;
	Thu, 03 Sep 2026 14:36:57 +0800 (CST)
From: Jinbao Chen <zkd18cjb@mail.ustc.edu.cn>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Toon Claes <toon@iotcl.com>,
	Jinbao Chen <zkd18cjb@mail.ustc.edu.cn>
Subject: Re: [PATCH v2] history: do not dereference NULL when parent tree is missing
Date: Thu,  3 Sep 2026 14:36:57 +0800
Message-ID: <20260903063657.2067303-1-zkd18cjb@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <5438d465.ab31e.1a062047bd5.Coremail.zkd18cjb@mail.ustc.edu.cn>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgDn7DOJFZlqMKXVAA--.690S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4fCF1rCF13XF1xJrWxCrg_yoW8Gr17p3
	929w4YkrWIvr43CFWkGF1rJFyj9w1xGr15CFWSk34xurnxCrn3tr1S9Fy5u3WUZaySva4F
	vF45Jas8WF4DCrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_GF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JUFQ6JUUUUU=
X-CM-SenderInfo: p2ngimxfmeqzxdloh3xvwfhvlgxou0/

write_ondisk_index() dereferences the return value of
repo_parse_tree_indirect() unconditionally.  If the parent commit's
tree object is missing from the object store (corrupt repository,
object removed by tooling, or incomplete restore), the function
returns NULL and "git history split" crashes with a SIGSEGV.

Guard the parse result and error out gracefully, following the
codebase convention for objects that cannot be loaded.

Signed-off-by: Jinbao Chen <zkd18cjb@mail.ustc.edu.cn>
---
Thanks for the review!

Changes since v1 (no functional changes):
- Dropped the parenthetical note about the UBSan diagnostic from the
  commit message, as suggested.
- Sent with the From address matching the Signed-off-by.

 builtin/history.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/history.c b/builtin/history.c
index 000155ad9c..097631f5ba 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -786,6 +786,10 @@ static int write_ondisk_index(struct repository *repo,
 	opts.dst_index = &index;
 
 	tree = repo_parse_tree_indirect(repo, oid);
+	if (!tree) {
+		ret = error(_("unable to parse tree %s"), oid_to_hex(oid));
+		goto out;
+	}
 	init_tree_desc(&tree_desc, &tree->object.oid, tree->buffer, tree->size);
 
 	if (unpack_trees(1, &tree_desc, &opts)) {
-- 
2.53.0

