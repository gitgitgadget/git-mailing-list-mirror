From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH v2] tg.sh: simplify cat_file
Date: Mon,  4 Oct 2010 20:47:01 +0200
Message-ID: <064ca64cad83076e419ef2cb8bfa5d80e72915bb.1286217942.git.bert.wesarg@googlemail.com>
References: <85c8c215f362c4b57e7646d536ef1ca77ade1591.1286217707.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Mon Oct 04 20:47:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2q4A-0003PE-SS
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 20:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174Ab0JDSrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 14:47:08 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59726 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755955Ab0JDSrH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 14:47:07 -0400
Received: by bwz11 with SMTP id 11so3868092bwz.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 11:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=rNVHsu/+5rwSSPOHclqEGXAwoyTDyTWYX11tQerUrxw=;
        b=Z/HoXdeU6Q4eS/YLMJCfytISb1lMj8l3LgBBy5c4qMdJm2sfO3npbonZyYDDDQG4vp
         /LUPw1phtycfzClW6DboH5ZBkvfcZx9756iSDrd1fsBUQNLGenV182YjKHDEfYPJAKTu
         T28UhBCtUhviDBj0UsOCKPI15Z8yf4gdQA1vY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eHJIE1VedVxreTvzsya+rYK+iQVoZVWzC6M3zKPSg4GtV2WF+HsFP0pAuQWPU8V8nz
         ovljAdCiHsttNBgHjStzMq7K0FktLHWh5mnYU4ZuYogJ9dr27P5TqZAVWMikNf3Bv56M
         JwaTXCFfQEkIpTDYfSMLmzeoL5+orsd2QT1Zk=
Received: by 10.204.112.146 with SMTP id w18mr7315903bkp.16.1286218025654;
        Mon, 04 Oct 2010 11:47:05 -0700 (PDT)
Received: from localhost (p5B0F7A6E.dip.t-dialin.net [91.15.122.110])
        by mx.google.com with ESMTPS id 24sm4037510bkr.19.2010.10.04.11.47.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 11:47:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <85c8c215f362c4b57e7646d536ef1ca77ade1591.1286217707.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158089>

Use shell parameter expansion to strip the leading (w): and (i)

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---

No need to use wildcards, we know exactly what we want to strip.

 tg.sh |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tg.sh b/tg.sh
index 9d08d63..0e72865 100644 tg.sh
--- a/tg.sh
+++ b/tg.sh
@@ -25,17 +25,15 @@ cat_file()
 	arg="$1"
 	case "$arg" in
 	'(w):'*)
-		arg=$(echo "$arg" | tail --bytes=+5)
-		cat "$arg"
-		return
+		cat "${arg#(w):}"
 		;;
 	'(i):'*)
 		# ':file' means cat from index
-		arg=$(echo "$arg" | tail --bytes=+5)
-		git cat-file blob ":$arg"
+		git cat-file blob "${arg#(i)}"
 		;;
 	*)
 		git cat-file blob "$arg"
+		;;
 	esac
 }
 
-- 
1.7.1.1067.g5aeb7
