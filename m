Received: from vitre.jabatus.fr (vitre.jabatus.fr [109.234.163.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314F5161B43
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.234.163.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720709028; cv=none; b=hRGosdZQHkxAAu8PZi0yNRC0Wchbm1VdCtyTzQbhuwHQFZDIXpf17GkKYkl9KtF2FdWrxlh59OyO2Eou/tdE4r7xUH4Q1zH8bPVUs7Lec0fp3gyaDw3hIiVJmV75RC8EVyj5vhshv/+lCLJ0btRN4jMoqKWls1FGpFKEJmYcnk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720709028; c=relaxed/simple;
	bh=1JFDDyRUewKx93rZlzd4pAOb04nuGseD/bj1hP+lQ+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oo4sbYLrECvZiyw7U+RPiw2/2dmQEK8Sf6gpm0CUbPyC15uRGmIg7H4GFZ6HiFQX+Uc7EodblXF7clBsXAylsao97+lf8ZqQbFaCUSBrQRiql5SipU+nk5DpXHji9b1B7QxtIp0DtLu0ktn/Yy++i4vPJJEVJMHPjBJj3UIXIJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loiseau.fr; spf=pass smtp.mailfrom=loiseau.fr; dkim=pass (2048-bit key) header.d=loiseau.fr header.i=@loiseau.fr header.b=B0mIoqL/; arc=none smtp.client-ip=109.234.163.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loiseau.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loiseau.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=loiseau.fr header.i=@loiseau.fr header.b="B0mIoqL/"
X-MailPropre-MailScanner-From: anthony@loiseau.fr
X-MailPropre-MailScanner-SpamCheck: not spam, SpamAssassin (cached,
	score=-22.979, required 5, autolearn=disabled, BAYES_20 3.00,
	MED_SPX 1.00, RCVD_IN_DNSWL_HI 0.01, SPF_HELO_NONE 0.00,
	SPF_PASS -1.50, SUKC_2 0.01, WHLISHOS -25.50)
X-MailPropre-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-MailPropre-MailScanner-ID: EBCFFE051B.A8AD0
X-MailPropre-MailScanner-Information: Please contact the ISP for more information
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=loiseau.fr;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UhkoSd2eA8/fk/PtpdC1TbNFYwHvBtkbzPS3gUWCvBg=; b=B0mIoqL/wFSXAbh1IwDonM+Hl7
	Opmfti3MHdcA3eZ6PM1SAp2copKoEelfcGEaOke/GOq++jcRwB8ml2Wc9FO6QyVF2u406DIOFLqyp
	X6JWo/y6kCD/1F2rrhU4E1qomnBB913qy8wX3NfsYGSy+xIXI/LapqK7c4915cBKSYN/HKMLgGH+9
	hVLDRs9beSgG6Q7DNFF74iCPIr/NQOmvBxbl3DEe2+KbBtyk7qaiTiQ0wac5xbn2Z+jgv4uyYvq06
	hgYKsBMF4CsqTV9gKDssrNE+epekdtfKk50J07HDsm/UPZGWapl2IBF5tUfCnbIJDzeyTbmw+9Z03
	LUPS+vaQ==;
From: Anthony Loiseau <anthony@loiseau.fr>
To: git@vger.kernel.org
Cc: Anthony Loiseau <anthony@loiseau.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Joshua Williams <joshua.williams@qlogic.com>,
	"Shawn O . Pearce" <spearce@spearce.org>
Subject: [PATCH] git-gui: do not exit upon prepare-commit-msg hook failure
Date: Thu, 11 Jul 2024 15:25:40 +0200
Message-ID: <20240711132542.9792-2-anthony@loiseau.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711132542.9792-1-anthony@loiseau.fr>
References: <20240711132542.9792-1-anthony@loiseau.fr>
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

prepare-commit-msg hook is fired as soon git-gui is started
and upon F5 in order to pre-fill commit message area.

Having it fatal, forcibly exiting app when this hook fails
rendered git-gui unusable in this case. Fix this by not
treating this hook as fatal, and not exiting app when failure
popup is dismissed.

This way, user can use git-gui when he/she dismisses failure popup
of a failed prepare-commit-msg hook.

Note that this commit does not deny user from commiting when
prepare-commit-msg failed. Message is simply not pre-filled.

Signed-off-by: Anthony Loiseau <anthony@loiseau.fr>
---
 git-gui/git-gui.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 8fe7538e72..ab6caaf2ae 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1643,9 +1643,8 @@ proc prepare_commit_msg_hook_wait {fd_ph} {
 	if {[eof $fd_ph]} {
 		if {[catch {close $fd_ph}]} {
 			ui_status [mc "Commit declined by prepare-commit-msg hook."]
-			hook_failed_popup prepare-commit-msg $pch_error
+			hook_failed_popup prepare-commit-msg $pch_error 0
 			catch {file delete [gitdir PREPARE_COMMIT_MSG]}
-			exit 1
 		} else {
 			load_message PREPARE_COMMIT_MSG
 		}
-- 
2.45.2

