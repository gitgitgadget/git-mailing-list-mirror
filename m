From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: [PATCH] Test atomic git-commit --interactive
Date: Tue, 10 May 2011 12:12:31 -0700
Message-ID: <1305054751-12327-1-git-send-email-conrad.irwin@gmail.com>
References: <BANLkTikwjZkzMxksBsVTFRYdhE3L6ZQM0A@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Conrad Irwin <conrad.irwin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 21:13:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJsMh-0008Rz-OV
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 21:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567Ab1EJTM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 15:12:59 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46616 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020Ab1EJTM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 15:12:58 -0400
Received: by pwi15 with SMTP id 15so2956658pwi.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 12:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=dkGqUmwnDSJoewzncFjL+RzNlBfQkyPIRu87thgVNyw=;
        b=d7bxAEOulz+rZWB8fXzwKWl4OkdnA0Cuc/HSxbX/tTqj70iqegUURMK7pWWGIxyK9F
         Loz/DCZf5zcRmlaZ7nRgKhHVVNXG4llgOLjfX2jYjuKeY+nyns7BTIAXiqAPoCEoEMO5
         HYh6OKGPiQvEgMIRE8eOp8DIh+vbUydNc5jCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WyRWOnFykfZ0ofY9DDs+bYD5wjJiRP78Xvkh4p14Sgl0xMuGRwqhfuzLINxvSPsLIP
         ZPfVymV1rN7a0flIF8YNhxDB9trpXxccJS+Ei/3ztXMxmoBiPn2SKWPfZhFznDMxynl6
         F1K7JyDvI1jPcLLDEGUMlNfqq6m2+v+pvrxwI=
Received: by 10.68.30.8 with SMTP id o8mr5501014pbh.359.1305054777720;
        Tue, 10 May 2011 12:12:57 -0700 (PDT)
Received: from scarlatti.dunvegan.biz ([173.228.114.197])
        by mx.google.com with ESMTPS id f5sm4616537pbt.92.2011.05.10.12.12.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 May 2011 12:12:57 -0700 (PDT)
Received: from conrad by scarlatti.dunvegan.biz with local (Exim 4.75)
	(envelope-from <conrad@scarlatti.dunvegan.biz>)
	id 1QJsMZ-0003GO-7R; Tue, 10 May 2011 12:12:55 -0700
X-Mailer: git-send-email 1.7.5.188.g4817
In-Reply-To: <BANLkTikwjZkzMxksBsVTFRYdhE3L6ZQM0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173348>

Signed-off-by: Conrad Irwin <conrad.irwin@gmail.com>
---
 t/t7501-commit.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index a76c474..2a4e453 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -130,6 +130,15 @@ test_expect_success PERL \
 	"interactive add" \
 	"echo 7 | git commit --interactive | grep 'What now'"
 
+test_expect_success PERL \
+	"--interactive doesn't change index if editor aborts" \
+	"EDITOR=false echo zoo >file && \
+	test_must_fail git diff --exit-code > diff1 && \
+	(echo u ; echo '*' ; echo q) |\
+	test_must_fail git commit --interactive && \
+	git diff > diff2 && \
+	git diff --no-index diff1 diff2"
+
 test_expect_success \
 	"showing committed revisions" \
 	"git rev-list HEAD >current"
-- 
1.7.5.188.g4817
