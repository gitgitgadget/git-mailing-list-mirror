Received: from well.jabatus.fr (well.jabatus.fr [109.234.163.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D7A1667FA
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.234.163.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706629; cv=none; b=pKyKI6WdWm4X2QRZjav9qOBbDrJ4onSbP3EJdgbKYRWIDvq6SOtnYApouDzveVqpT20gn4M4tnpo8n6PwsxKZVIrWIk7aFmu1UWHzsiNt1p3aFfhKZqP08y35/AdA3LhFT9MFJFue6PjJYibbqEAVO8mSNjc+vlOD6p58c0JeKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706629; c=relaxed/simple;
	bh=xau9RRIEBT/bKXY8AnkHGrFQKDSChdeoQynE4oll9s8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dPrKUu3uGdSNbnlegCY+418DO8sVujWoNdqaQ4lyZKdQ6UqcsHe3ZSMyTzbLy7CvcOgEvzCYF9iNF6sKjzPjzYkBf/wbhVqaPlx9OrjXonnG3Su71y2jtgpzaPHqwvoRCEsxzOzWHfpOZVA4HhLiCPUVORnjh3LlwYwBgxnkdWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loiseau.fr; spf=pass smtp.mailfrom=loiseau.fr; dkim=pass (2048-bit key) header.d=loiseau.fr header.i=@loiseau.fr header.b=vRtXeAD9; arc=none smtp.client-ip=109.234.163.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loiseau.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loiseau.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=loiseau.fr header.i=@loiseau.fr header.b="vRtXeAD9"
X-MailPropre-MailScanner-From: anthony@loiseau.fr
X-MailPropre-MailScanner-SpamCheck: not spam, SpamAssassin (cached,
	score=-23.959, required 5, autolearn=disabled, BAYES_05 2.00,
	MED_SPX 1.00, RCVD_IN_DNSWL_HI 0.01, SPF_HELO_NONE 0.00,
	SPF_PASS -1.50, SUKC_2 0.01, SUKEN_2 0.01, VM03 0.01,
	WHLISHOS -25.50)
X-MailPropre-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-MailPropre-MailScanner-ID: 85115E04D6.A56DE
X-MailPropre-MailScanner-Information: Please contact the ISP for more information
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=loiseau.fr;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HKbrh/Fibc0jCYiOR9ZanejpcBZ9lm+e+T9VdvGPGnA=; b=vRtXeAD9VqYUkCzFCMsRs3qFeP
	8qlstWxM38hwW47jtHmk0/LcrKhfrDl9PTMqIH/XtLUMCCYZIyyL2lJw3eYZvY28HNcp/jg+K8mwp
	oo1yGvwCWdmMxMgXP3Vk1+R8qbV+ijO4uzX1I2jrqejiyBCdbmDuaYUWOOZmTRY9eT0mmzi4Upwmc
	8z8UwWfRDsPniO+O3fbFlZUzKmYZNN6jjjJjouWM1tJFUPfms0vSRA7CNuDcaj/IIX2fsbijkdZx+
	ILlEzBmTigYUFAOY5q5cr1pCc7fZPeocHMKmubEyy8JeaVJgKtygXYh9w5EEzAUsc53jE4vSOWBLW
	JKOfOOHQ==;
From: Anthony Loiseau <anthony@loiseau.fr>
To: git@vger.kernel.org
Cc: Anthony Loiseau <anthony@loiseau.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Joshua Williams <joshua.williams@qlogic.com>,
	"Shawn O . Pearce" <spearce@spearce.org>
Subject: [PATCH] git-gui: do not exit upon prepare-commit-msg hook failure
Date: Thu, 11 Jul 2024 15:25:39 +0200
Message-ID: <20240711132542.9792-1-anthony@loiseau.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - sucre.o2switch.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - loiseau.fr
X-Get-Message-Sender-Via: sucre.o2switch.net: authenticated_id: anthony@loiseau.fr
X-Authenticated-Sender: sucre.o2switch.net: anthony@loiseau.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Targeted issue
==============

git-gui is currently unusable when prepare-commit-msg hook fails, since
it closes as soon as user dismiss modal error popup shown on start.

Proposal
========

Next mail is a proposal to make this failure non-fatal. Popup is still
shown but not in its fatal variant (which removes the "you must fix this
before commiting" unwanted sentence), and git-gui is not terminated upon
popup dismiss.

With this proposal, user is clearly aware of a prepare-commit-msg hook
failure but is not denied to use git-gui and can even commit.
Pre-filled commit message content is likely empty or not filled in this
case, which is not a big issue.

Other hooks are not affected. commit-msg hook and next ones are still
triggered upon commit action, telling commit can not be performed (fatal
variant of the popup) without terminating git-gui upon dismiss.

How to test
===========

cat > .git/hooks/fake_failing_hook <<EOF
#!/bin/sh
echo 'FAKE FAILING HOOK $0' >&2
exit 1
EOF

for i in .git/hooks/*.sample
do
	ln -svf fake_failing_hook "${i%%.sample}"
done

chmod u+x .git/hooks/*
rm .git/GITGUI_MSG
git gui


Anthony Loiseau (1):
  git-gui: do not exit upon prepare-commit-msg hook failure

 git-gui/git-gui.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.45.2

