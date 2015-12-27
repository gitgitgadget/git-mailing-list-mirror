From: Mostyn Bramley-Moore <mostynb@opera.com>
Subject: [PATCH/RFC 0/2] add a perl compatible regex match flag to git describe
Date: Sun, 27 Dec 2015 23:59:50 +0100
Message-ID: <1451257192-5755-1-git-send-email-mostynb@opera.com>
Cc: Mostyn Bramley-Moore <mostynb@opera.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 28 00:00:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDKIX-000104-Vy
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 00:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646AbbL0XAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2015 18:00:17 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35676 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754573AbbL0XAP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2015 18:00:15 -0500
Received: by mail-wm0-f51.google.com with SMTP id l126so248770360wml.0
        for <git@vger.kernel.org>; Sun, 27 Dec 2015 15:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opera-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=qllu/4WsYBmbsO5qqRUNi9sZxsrwNlTJCwbiGsge+ek=;
        b=foycLaGUsvwCmwt9WschEh/1EbNuqqcIOHE0AWzVHYyfgKt0q1UXiIEEGs6r49C6mk
         CvmW7/uOpGarzz/aelK16kNn60RnUot0efpSQAG4k7G0nSBgcAiamNoE1RQv3sz2r5E0
         /5AANPtWzRVvw93m2hR1SRGu61C3dEBng+17HQaDTpj768z4oiasjVJXRg3q0zUos8/L
         Q9J/m7QfPu5R3leX4vf7iKtSLy7ZQYhqXmQ03LPFo/dXpogpu/h/oDH8xXlvSjfuai9k
         YXDudKcdUGay07YcIVNYbU6ZHEcKP/9hgyBKncb97pix7cD81W0vChi4pppwWZHZF/NW
         /ZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qllu/4WsYBmbsO5qqRUNi9sZxsrwNlTJCwbiGsge+ek=;
        b=Hv9mwc0oTTGSe92DGTKsad1U9mi87/zdHQxsHK3vh+/o4P/3OxBjTQPQ3275R+AdJP
         R6dbBUv6fjqNCcKeQFJ/O13MFnwuz57kZ0ndnECAP1mZQFo+hSmnf5ksk67p0aXQg99u
         jyxMGbPuP0ugWu1UMIFKKgyxrTCrM+LD/XFfMNYpafkNO1DF58yarkLqx8hiKtkDltNq
         tTw7Y1OcqeIzABs2l5bMkL7xjvM9pzeVSo9cGLqhMA9k5FJgbXOa+3diJ46sFL7PSfUF
         bMEWQF5vTJE6b2uQOIg6O8J609oxKNk//+PceNEb7lWcNwQycKvSJXiGGb0HPgmaCl2+
         npEA==
X-Gm-Message-State: ALoCoQn3xm3JubBBRBaR3mDLYeelNF70ZkWOTtS6do9RUt+0ggWx4JPBWp477UrCYj6eT5uE/MrqdVLYOhn+sAv53KSVPRrvuQ==
X-Received: by 10.28.17.8 with SMTP id 8mr10432514wmr.65.1451257214573;
        Sun, 27 Dec 2015 15:00:14 -0800 (PST)
Received: from teardrop.skrumpis (h151n12-g-kt-d2.ias.bredband.telia.com. [213.64.207.151])
        by smtp.gmail.com with ESMTPSA id w17sm12929872wmw.15.2015.12.27.15.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 27 Dec 2015 15:00:13 -0800 (PST)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283019>

git describe currently only supports glob matching with the --matches flag.
It would be useful to support regular expressions.

PCRE is already an optional dependency from git grep, I wonder if posix or
extended regexes would be preferable?

Some old discussion of this as a candidate feature is here, though nobody put
together a patch as far as I can see:
http://comments.gmane.org/gmane.comp.version-control.git/173873

Mostyn Bramley-Moore (2):
  describe: mention glob in the --matches help text
  describe: add --pcre-match option

 Documentation/git-describe.txt |  5 +++
 builtin/describe.c             | 73 ++++++++++++++++++++++++++++++++++++++++--
 t/README                       |  3 +-
 t/t6120-describe.sh            | 29 ++++++++++++++---
 4 files changed, 103 insertions(+), 7 deletions(-)

-- 
2.5.0
