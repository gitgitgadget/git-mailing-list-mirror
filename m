From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 14/17] index-helper: don't run if already running
Date: Fri, 18 Mar 2016 21:04:47 -0400
Message-ID: <1458349490-1704-15-git-send-email-dturner@twopensource.com>
References: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 19 02:08:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah5Na-00012F-0Q
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 02:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302AbcCSBIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 21:08:31 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:35473 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbcCSBIY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 21:08:24 -0400
Received: by mail-qg0-f43.google.com with SMTP id y89so115401194qge.2
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 18:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y/P4lsT/dM/1EbzIgu4hdvnvp0HWiLJWZhmi4V2+XnQ=;
        b=aPHNiUCN9P0LVadOMKVAwMFcb4FpqYVgkBNpyiK6f53ZSfTumH55/GXMzl2xcQyfj5
         vXzhSd4golyjALfVWEhQkjezsSepZ4arv2nTlizq1HyqL7OzDFvc0NlyXaYRCaJlNzqY
         JJDGTMjnGihrHjvEbuVKNOVBLrSJf+Wh4VxN4m3p/Q0GeNtcBhrqbMc+WdzqzqeyW0+E
         SRfO5RHQQrCAmImbeZomhO+I9kw2NCo/7furaTAC5C4MjTJhUwB684hr8TasVRcXeeRW
         ke5hDeEEnwG4mrS7KEW1/H35xwv4TjTAWcUv2vWYX0JyT2dILNTxFtiCIBlbWpBkmu1c
         j9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y/P4lsT/dM/1EbzIgu4hdvnvp0HWiLJWZhmi4V2+XnQ=;
        b=Jxr1JR0dZP/WPIRkf/Chv2p7B7LRnoLhQkSe81ikpqwbHTLmr05+lcS1Vx8WwX7uuT
         k4W3e/nHOJia/MZfzSRdCkKL3f41YJn0E68e9aZ+bRYq+G7flAwbIPg4QdiZHlxURrAs
         AQLAE0EbBebksOfS1r40bezOTq77EMj3DHhhTuXBZq7X2CKRK+4T1/QGAmxtlz9CLAWd
         sS2bQY04MbF9/PsBfAVd+ya5mntXElOcMNwCI+HPxbBK13juyO6TPsQ6bwj/dlx4eU92
         Pz9ROgUsOdk4/lwwz7xc+b3xFa4JfBiSVP158hjMdw0JOYhRxZ6rdkhQ7FDhRAzmFXfW
         hD8A==
X-Gm-Message-State: AD7BkJJrQzCBekjdtNWFVI04ND5F+Vqe4BUIgXB6qvXqTOYDv1KVuEk6MFKDiSprH4krjg==
X-Received: by 10.140.141.6 with SMTP id 6mr27191935qhn.82.1458349704009;
        Fri, 18 Mar 2016 18:08:24 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id 139sm7186154qho.2.2016.03.18.18.08.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2016 18:08:23 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289281>

Signed-off-by: David Turner <dturner@twopensource.com>
---
 index-helper.c          | 7 +++++++
 t/t7900-index-helper.sh | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/index-helper.c b/index-helper.c
index ffa3c2a..7362abb 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -400,6 +400,13 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
+	/* check that no other copy is running */
+	fd = open(pipe_path.buf, O_RDONLY | O_NONBLOCK);
+	if (fd > 0)
+		die(_("Already running"));
+	if (errno != ENXIO && errno != ENOENT)
+		die_errno(_("Unexpected error checking pipe"));
+
 	atexit(cleanup);
 	sigchain_push_common(cleanup_on_signal);
 
diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
index 14b5a6c..ce0cc27 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -24,4 +24,13 @@ test_expect_success 'index-helper creates usable pipe file and can be killed' '
 	test_path_is_missing .git/index-helper.pipe
 '
 
+test_expect_success 'index-helper will not start if already running' '
+	test_when_finished "git index-helper --kill" &&
+	git index-helper --detach &&
+	test -p .git/index-helper.pipe &&
+	test_must_fail git index-helper 2>err &&
+	test -p .git/index-helper.pipe &&
+	grep "Already running" err
+'
+
 test_done
-- 
2.4.2.767.g62658d5-twtrsrc
