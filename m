From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 6/6] t1500: be considerate to future potential tests
Date: Tue, 10 May 2016 01:20:55 -0400
Message-ID: <20160510052055.32924-7-sunshine@sunshineco.com>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 07:21:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0076-0003ga-Id
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 07:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbcEJFVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 01:21:38 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34280 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbcEJFVg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 01:21:36 -0400
Received: by mail-io0-f195.google.com with SMTP id d62so414058iof.1
        for <git@vger.kernel.org>; Mon, 09 May 2016 22:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NJbI8Uqsxv/lrFVA/uRDNin0VFbHoWdY6tfSZLHL8nk=;
        b=yOP/K66vPki9dQUsbRLq0hmGYtUkbVL6QEwiVq5jJGKMv/Iq0vEy/Fj0BnKHqBIdcG
         hqykpDKYrIfigF67Ja6DAfFQA8luWUh+4lwvUTt/E7XmnwXj2UNNlCuexv4RuPVHdkZS
         4gGfI+Sdjbg0W/0sEFil2tuL0miRls5xNglsw+iLTd06fE300fRuRjv19nnIP2aOk7ne
         K39PNrm9yE40K4UcVjuhsV13QoVICavdTKh+Dd6CVnl4ME4/DRXmTHIaq0xx50ejZtV2
         83pCOG0E5XKMPO7TLXijNew/EMb/0jom/kWdW64UmNBb0VR7xVT3XuIftzvg0lFmeL+P
         f9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=NJbI8Uqsxv/lrFVA/uRDNin0VFbHoWdY6tfSZLHL8nk=;
        b=iWwg69Mr9ndPVSa6gbF6wEVXtqFwniLPY6Tn/5lf3p7moXcid+eH85AeSxwGAsJoS2
         QZsY4Bn6DbQuS5jFALjOfHa57Kn654Cb1aWg9ahm0cavKJv2NVDGPmv5/hrqqDw4A+0j
         BusMyGnRh9nufOY5kyLQoKo3Ij71yHSffbxTx7l1lTo3/MXs0aevf8fWoD0yaiWJROim
         zjOCuA0ZytLAHyk+ilu9fXGOPeFV/7Wr3MRHw+orxn7kBxpiK0oKUdp9rz/zLBLjwQ5H
         fCyWx4d1Kdl1x4YaHQ0yM5Xz3cm1jxtrpaQAf3+LwFsC9gphpRdq/wRLIahLqqcgr323
         auXQ==
X-Gm-Message-State: AOPr4FW8/I/fKGMKonlIW0O3AwY9aVjCcWjG2M88mHpX2PaZ57BERTCOyW34a9NJw8hsAQ==
X-Received: by 10.107.24.6 with SMTP id 6mr8313775ioy.195.1462857696129;
        Mon, 09 May 2016 22:21:36 -0700 (PDT)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id vu8sm458336igb.1.2016.05.09.22.21.35
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 09 May 2016 22:21:35 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.530.g51d527d
In-Reply-To: <20160510052055.32924-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294091>

The final batch of git-rev-parse tests work against a non-local object
database named ../repo.git rather than the typically-named ../.git. It
prepares by renaming .git/ to repo.git/ and pointing GIT_DIR at
../repo.git, but never restores the name to .git/, which can be
problematic for tests added in the future. Be more friendly by instead
making repo.git/ a copy of .git/.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1500-rev-parse.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 525e6d3..af223ed 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -72,7 +72,7 @@ test_rev_parse -C work -g ../.git -b t 'GIT_DIR=../.git, core.bare = true' true
 
 test_rev_parse -C work -g ../.git -b u 'GIT_DIR=../.git, core.bare undefined' false false true ''
 
-test_expect_success 'setup non-local database ../repo.git' 'mv .git repo.git'
+test_expect_success 'setup non-local database ../repo.git' 'cp -R .git repo.git'
 
 test_rev_parse -C work -g ../repo.git -b f 'GIT_DIR=../repo.git, core.bare = false' false false true ''
 
-- 
2.8.2.530.g51d527d
