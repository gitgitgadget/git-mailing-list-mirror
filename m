From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv3 0/3] git-p4: fix handling of multi-word P4EDITOR
Date: Tue, 19 May 2015 23:23:15 +0100
Message-ID: <1432074198-13806-1-git-send-email-luke@diamand.org>
References: <xmqqa8x0a7wq.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 00:24:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yupvl-0005aF-37
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 00:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbbESWYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 18:24:03 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36115 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbbESWYB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 18:24:01 -0400
Received: by wizk4 with SMTP id k4so134559522wiz.1
        for <git@vger.kernel.org>; Tue, 19 May 2015 15:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PNgLCLr3Ium1TtYLU/cIrXUdQbcv+g5dCPyoT1q9IsE=;
        b=QQiEqgNiBJ3e+uxWfjNUEWuTg/ApvD8AeRGAW7vxwhLYRvFHDjKTx9e3OvPbKb+q8r
         WglFs7GLRhNU7G1u9QyjXajprvIY+2xCQTwh/fCRl5kWFg3U/urU6XojzpS8OBZdh2Qs
         fcZxwGZ/YaNVBJfjoFD+sNTvV+wnfiAQgFe/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PNgLCLr3Ium1TtYLU/cIrXUdQbcv+g5dCPyoT1q9IsE=;
        b=OnM9fph0t0cigBXxKftv65k6JQTVuRYFe+6+nYYyR4IaNvRxb77O0pld+/iqz/riYA
         aeNjB5jFuisOjdYmm/SsR59L/egMzp2uPoQskzT1tMlHahNzAf4RTtcb4NfP4jH3Qi9h
         a6Qs8eZKEGTIN/FTiZyFdKsmdinIZl5Udr6shJ8nSpTUEKTjnxYil3fjyyjzuNP4Hihl
         b3o5uPZWeyVMSimL+FP2h31Pb8yRyZizfKgyavNGCBlasAAlkFMoM0ocQnBou+7naGB+
         B1v2aoEuT9j6JL7SwVoPmsb7VHtsUW0Pxs2B+DgWIIndoodXx2d3sThWclotkFkJSHDE
         4b/A==
X-Gm-Message-State: ALoCoQloUCzl6IH1QtxiNjKZHXKE4KkkByWDbtXQfS4SVl220ccL9WWDelaON++yZiw79I/EA0QY
X-Received: by 10.180.73.230 with SMTP id o6mr36440198wiv.11.1432074240050;
        Tue, 19 May 2015 15:24:00 -0700 (PDT)
Received: from ethel.local.diamand.org. (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id x10sm23711568wjf.45.2015.05.19.15.23.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 May 2015 15:23:58 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.502.gb11c5ab
In-Reply-To: <xmqqa8x0a7wq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269422>

Junio noticed that my new test was using touch, which is a bit
racetastic because git-p4 wants P4EDITOR to spend at least one
second editing the submit template or it will fail.

This updates the test to use test-chmtime, and also fixes the
other git-p4 tests in the same way.

Luke Diamand (3):
  git-p4: add failing test for P4EDITOR handling
  git-p4: fix handling of multi-word P4EDITOR
  git-p4: tests: use test-chmtime in place of touch

 git-p4.py                          |  2 +-
 t/t9803-git-p4-shell-metachars.sh  |  4 ++--
 t/t9805-git-p4-skip-submit-edit.sh |  4 ++--
 t/t9813-git-p4-preserve-users.sh   |  7 ++++---
 t/t9820-git-p4-editor-handling.sh  | 38 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 47 insertions(+), 8 deletions(-)
 create mode 100755 t/t9820-git-p4-editor-handling.sh

-- 
2.4.1.502.gb11c5ab
