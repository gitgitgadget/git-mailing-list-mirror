From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/10] t4124 (apply --whitespace): use test_might_fail
Date: Sun, 31 Oct 2010 02:41:08 -0500
Message-ID: <20101031074108.GK11483@burratino>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-16-git-send-email-newren@gmail.com>
 <20101031014654.GC29456@burratino>
 <7vr5f73umz.fsf@alter.siamese.dyndns.org>
 <20101031072640.GA11483@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	avarab@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 08:41:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCSXa-0007OQ-T9
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 08:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190Ab0JaHlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 03:41:19 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62050 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508Ab0JaHlS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 03:41:18 -0400
Received: by yxk8 with SMTP id 8so2332756yxk.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 00:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=yRwRVI9rJ6wJFPBvhc1PiFe55Oswl32kf0KtXNMDKM8=;
        b=wXJwTdpCTUeEoHrveCOkiaIfcsU6tGNtuG2xdGD8NtrbG95U+kTiwLlWPMEWnBvE2+
         p4S/khOPVFbsCqzJed0bwypNA25eWDTS6vZ/yoejc3/IEhUYKN+5j+mzIsZB510ZHGw/
         LBzcUHFSgo9Jnr2Nv1uGYMLvsAheAvoW/KB6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Lbdb8A5LSJVDZz8xzeQeeqU9KMggeOBGXiZFO+AbTzci/+18fj9A49ex1N0b/rbygF
         vYnZI1K0uYaPA7m5MKZZ1BUxTX3wUyiSQRzouJ8I2amKWgvML3X1kz8bYhG5lxNR5BQ/
         /dOHVKIzOYodlbQUyLKcvrTponZQ6uN9lgf4o=
Received: by 10.151.43.5 with SMTP id v5mr19656712ybj.280.1288510877434;
        Sun, 31 Oct 2010 00:41:17 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id z4sm3806074yhz.1.2010.10.31.00.41.15
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 00:41:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101031072640.GA11483@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160429>

Use test_might_fail instead of ignoring the exit status from git
config --unset, and let the exit status propagate past rm -f (which
does not fail on ENOENT).  Otherwise bugs that lead git config to
crash would not be detected when this test runs.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t4124-apply-ws-rule.sh |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 414b09b..61bfc56 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -176,9 +176,8 @@ test_expect_success 'trailing whitespace & no newline at the end of file' '
 '
 
 test_expect_success 'blank at EOF with --whitespace=fix (1)' '
-	: these can fail depending on what we did before
-	git config --unset core.whitespace
-	rm -f .gitattributes
+	test_might_fail git config --unset core.whitespace &&
+	rm -f .gitattributes &&
 
 	{ echo a; echo b; echo c; } >one &&
 	git add one &&
-- 
1.7.2.3.557.gab647.dirty
