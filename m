From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 0/3] git-p4: fixing p4ChangesForPaths
Date: Sat, 19 Dec 2015 09:39:37 +0000
Message-ID: <1450517980-1744-1-git-send-email-luke@diamand.org>
Cc: James Farwell <jfarwell@vmware.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sam Hocevar <sam@hocevar.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 10:40:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAE0C-0001Gi-TL
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 10:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbbLSJjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2015 04:39:40 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36599 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455AbbLSJjh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2015 04:39:37 -0500
Received: by mail-wm0-f41.google.com with SMTP id p187so13156256wmp.1
        for <git@vger.kernel.org>; Sat, 19 Dec 2015 01:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ws4zWoKQf1Hl69EQkImm/C+0WPvqcls8+8t5tr4+SWo=;
        b=F468qvAam2IlLdEtjd46iIqAstBJ4+VEsqOqDXewvOUmf4QriLfhG179Z/1FxA9oT7
         IBqJ2uN42JIiwRyx6hUuU00ieEtIMujSzVExGlzQ0/rpFKrlFPfgaKb0IckkZUVJl6L2
         qZWppe2mjIGq61OaLiQk2s2C+O738pWSI+3Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ws4zWoKQf1Hl69EQkImm/C+0WPvqcls8+8t5tr4+SWo=;
        b=fyu4Nm0GLTlzrnLmBLptd15IDqZ+p4cozJ9j2KhP2VeJnBd63fENg3wy2BebECK46G
         ULwKlfGMCmxirSPqVPwRyvpoRt3awZLN9GzQTVxZx9VjWCY1E4m4gZK+6eXQDlxD1aa1
         jtA6IcOhCL1MCPx7SyEbpymd0SoVp9SFnl/qO4yMDcRKNHmAF1GDaF/XWCYdmo7ft+uZ
         oitOgiC1VdiRCU+e43rrPjP0qVH/ks936zPDLntb/W9ubRfF5lTDG4X9I2RcUZ52rJbQ
         WHVSOAfxdPdDxB7kawpS6EvC9PU2s9+P7wojTPCBAtZpAAxm4/VC6cPcHlT6EHL1WPg0
         ac5g==
X-Gm-Message-State: ALoCoQlmMtmfO4DHTBr3TtZfm0JVpFFRHvOLGIB9porz+LlAu8alOshbpYbhi2hlw3qTeuf5ccslS1VaC4hDyne8cmqyAPLm7Q==
X-Received: by 10.28.87.131 with SMTP id l125mr7856592wmb.8.1450517975928;
        Sat, 19 Dec 2015 01:39:35 -0800 (PST)
Received: from ethel.local.diamand.org (cpc92798-cmbg19-2-0-cust327.5-4.cable.virginm.net. [80.1.41.72])
        by smtp.gmail.com with ESMTPSA id b84sm10211547wmh.15.2015.12.19.01.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 19 Dec 2015 01:39:34 -0800 (PST)
X-Mailer: git-send-email 2.6.2.474.g3eb3291
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282739>

James Farwell found a bug in p4ChangesForPaths() when handling
changes across multiple depot paths.

Sam Hocevar had already submitted a change to the same function
to get P4 to do queries across all of the depot paths, in order
to reduce server queries, which had the side effect of fixing
James' problem.

This followup just fixes Sam's original fix to restore the
behavior of p4ChangesForPaths() so that it returns a sorted list
of changes. That fixes a failing a testcase.

Luke Diamand (1):
  git-p4: failing test case for skipping changes with multiple depots

Sam Hocevar (2):
  git-p4: support multiple depot paths in p4 submit
  git-p4: reduce number of server queries for fetches

 git-p4.py               | 55 +++++++++++++++++++++++++++----------------------
 t/t9818-git-p4-block.sh | 28 ++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 26 deletions(-)

-- 
2.6.2.474.g3eb3291
