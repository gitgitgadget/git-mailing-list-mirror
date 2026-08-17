Received: from smtp-1a.his.com (dc-17.his.net [108.56.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407F13D4114
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.56.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001911; cv=none; b=VxWT2mDjDOqraUOGLdHKN3W7/XB9rJuDAHvWkl+Xjm39o0URyW3nESCPgHYuBXdzGWMkf3fd0aHDDevvW8wug+qOG+mHKw3U58Ph1Gog+Y9b/EWbwa2GOEEW3JV+UD9C919M/0RrigGIjDA9iQEfOaRqUrcfACfPtXZiGhVRoM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001911; c=relaxed/simple;
	bh=ksX6Jij3nUdrjS1fm559wAwHMvdH8KTz/Ml5+UTm7Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WQUFQYDB7ZbcmZPEa9Vdc072WI6G36P4Fs+DhH9mpxdOWBhaXT7d/nnZ/D/y1zCx6m/pCJ8Im4O2ZWONHEGBp2i0alYveuMAyNZvd5pGpCTHUBj/dWdWfYQBunL1spxuqSGNMg1tKOfPvUCuVxi5qYAzwe3YOL5YaBwxEE3RA8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=his.com; spf=pass smtp.mailfrom=his.com; arc=none smtp.client-ip=108.56.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=his.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=his.com
Received: from proxmail102.his.com (dc-15.his.net [108.56.65.15])
	by smtp-1a.his.com (Postfix) with ESMTPS id 0F86E567;
	Mon, 17 Aug 2026 17:19:51 -0400 (EDT)
Received: from proxmail102.his.com (localhost.localdomain [127.0.0.1])
	by proxmail102.his.com (Proxmox) with ESMTP id D8AA4A8EF2E;
	Mon, 17 Aug 2026 17:19:50 -0400 (EDT)
Received: from smtp-4a.his.com (dc-25.his.net [108.56.65.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by proxmail102.his.com (Proxmox) with ESMTPS id 899BCA8EF20;
	Mon, 17 Aug 2026 17:19:49 -0400 (EDT)
Received: from mail2.his.com (ec2-3-149-70-92.us-east-2.compute.amazonaws.com [3.149.70.92])
	by smtp-4a.his.com (Postfix) with ESMTPS id 6BDBD1C0F;
	Mon, 17 Aug 2026 17:19:49 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail2.his.com (Postfix) with ESMTP id 3F7163C1731;
	Mon, 17 Aug 2026 21:19:49 +0000 (UTC)
Received: from mail2.his.com ([127.0.0.1])
 by localhost (mail2.his.com [127.0.0.1]) (amavis, port 10032) with ESMTP
 id dml87evgVdNc; Mon, 17 Aug 2026 21:19:48 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail2.his.com (Postfix) with ESMTP id D1CD03C1736;
	Mon, 17 Aug 2026 21:19:48 +0000 (UTC)
X-Virus-Scanned: amavis at his.com
Received: from mail2.his.com ([127.0.0.1])
 by localhost (mail2.his.com [127.0.0.1]) (amavis, port 10026) with ESMTP
 id kILMaZLD62ag; Mon, 17 Aug 2026 21:19:48 +0000 (UTC)
Received: from wings.localdomain (unknown [69.53.104.42])
	by mail2.his.com (Postfix) with ESMTPSA id 832973C1731;
	Mon, 17 Aug 2026 21:19:48 +0000 (UTC)
From: Kenneth Lorber <keni@his.com>
To: git@vger.kernel.org
Cc: Kenneth Lorber <keni@his.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 0/1] config: surface editor failure in exit code
Date: Mon, 17 Aug 2026 17:19:32 -0400
Message-ID: <20260817211936.2943278-1-keni@his.com>
X-Mailer: git-send-email 2.55.GIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SPAM-LEVEL: Spam detection results:  0
	AWL                     0.571 Adjusted score from AWL reputation of From: address
	BAYES_00                 -1.9 Bayes spam probability is 0 to 1%
	DMARC_PASS               -0.1 DMARC pass policy
	KAM_DMARC_STATUS         0.01 Test Rule for DKIM or SPF Failure with Strict Alignment
	SPF_HELO_NONE           0.001 SPF: HELO does not publish an SPF Record
	SPF_PASS               -0.001 SPF: sender matches SPF record

When the editor invoked by 'git config -e' fails (crashes or calls exit(3=
)
with a non-zero value), git notices and give an error:
	editor.c:launch_specified_editor()
		return error("there was a problem with the editor '%s'", editor);
which is then lost:
	builtin/config.c:show_editor()
		launch_editor(config_file, NULL, NULL);
which results in git always calling exit(0).  Note that the value is
not explicitly thrown away with "(void)", so this may not have been
intentional.

This patch simply passes the returned error out of show_editor(), which
currently has an unconditional "return 0" even though its callers
both check the return value.

While this didn't trigger anything in 'make test', it's possible that
someone is relying on 'git config -e' always succeeding, even if the
editor failed, so this could be considered a breaking change.

The 2 new tests set GIT_EDITOR to true and false and check the return
from git.

RFC because the community may not want to change this behavior and
I'm not thrilled with my test code.

Kenneth Lorber (1):
  config: surface editor failure in exit code

 builtin/config.c  |  5 +++--
 t/t1300-config.sh | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)


base-commit: 010afd3166ddc64c9863b1506f12cbcdda0d4ea1
--=20
2.43.0


