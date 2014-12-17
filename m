From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 0/6] atomic pushes
Date: Wed, 17 Dec 2014 10:32:51 -0800
Message-ID: <1418841177-12152-1-git-send-email-sbeller@google.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Wed Dec 17 19:33:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1JPd-0000VR-JB
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 19:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbaLQSdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 13:33:05 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:65320 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbaLQSdE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 13:33:04 -0500
Received: by mail-ig0-f173.google.com with SMTP id r2so9247768igi.6
        for <git@vger.kernel.org>; Wed, 17 Dec 2014 10:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=thjiaT4wMgIwqijs+ac+OAnd/iGqF0fID+jbdezHuZQ=;
        b=UFBfJDW1EUKmWmWmSgZ/7HW4Vj6sdZwWjN4MpJKpWTd3tRBjW7G7MplYv5dYe16tNr
         T+aY/hsTdmBcPaXgsDu5OTC1hV4PCezBXD1LiwtCE6xVAUixc4BGvQAPDRYcBZOUFEyE
         lSKqhK6B1a4Cb1A2EHcE7qRXTcc/spIpBP3a4uo1e2WK427dRySa6Qxo71zpb6CX1Uee
         Fh1c3eBtLpKJWEdSksPVDMjar1Rpl0WOlC8F2JThBcdZ1TfpnJ/OsJJZD3chFILiaFys
         P/e1syZV7cpvGgBkaKy6pJPLR9BbgqrWSbKmgJzHSZ6bbAcRPKdLfF+TMIZUndw93xtv
         gADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=thjiaT4wMgIwqijs+ac+OAnd/iGqF0fID+jbdezHuZQ=;
        b=IpeMYGssuLO5/2iML/Cbo2T+17Zu13LSzHl/Ff7VZgyL7UVomBu3+Boh5CkJ9oozYK
         c5cNQM7CVHLzRdJpSHnBnU23n5wd435Ak82Dhv17z1qJwva3x8pA68eK93G/R2POBkJf
         ohI9jmk9QnFUMSZvn3Wy8fpZUj28J0rRpcwa4CK7++bx+WiziCkzl59XNsLBjWJA1lDt
         oQumWQeQA1sIlBXjM9PmsiUvSvlK+4auDum072vq7jqH6ZJ0qWIglRcnFwo5fX/iPlWW
         um2Lb7F6s6pqL75MGHUiPjLRsm2gS6VQaY6nlCrKLtQOa3Enyju2Zv5GGXKD3uG1skDd
         CQDQ==
X-Gm-Message-State: ALoCoQlJJdppTJFCOhXxSBYV+YCPeAPutZHvMTjHYTdKizM+QDRz031K2J+8e6vZ+KSleMap14RB
X-Received: by 10.50.28.20 with SMTP id x20mr9723164igg.27.1418841182765;
        Wed, 17 Dec 2014 10:33:02 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:9f5:d31a:4ba2:b65d])
        by mx.google.com with ESMTPSA id c204sm2120904ioc.16.2014.12.17.10.33.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Dec 2014 10:33:02 -0800 (PST)
X-Mailer: git-send-email 2.2.0.31.gad78000.dirty
In-Reply-To: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261492>

This patch series adds a flag to git push to update the remote refs atomically.

This series applies on top of origin/mh/reflog-expire
It can also be found at github[2].

Changes v3->v3 are annotated in each patch.

[2] https://github.com/stefanbeller/git/tree/atomic-push-v3

Ronnie Sahlberg (4):
  receive-pack.c: add protocol support to negotiate atomic-push
  send-pack.c: add --atomic command line argument
  receive-pack.c: use a single transaction when atomic-push is
    negotiated
  push.c: add an --atomic argument

Stefan Beller (2):
  send-pack: Rename ref_update_to_be_sent to check_to_send_update
  t5543-atomic-push.sh: add basic tests for atomic pushes

 Documentation/git-push.txt                        |   7 +-
 Documentation/git-send-pack.txt                   |   7 +-
 Documentation/technical/protocol-capabilities.txt |  13 +-
 builtin/push.c                                    |   2 +
 builtin/receive-pack.c                            |  89 +++++++++--
 builtin/send-pack.c                               |   6 +-
 remote.h                                          |   3 +-
 send-pack.c                                       |  66 +++++++-
 send-pack.h                                       |   3 +-
 t/t5543-atomic-push.sh                            | 178 ++++++++++++++++++++++
 transport.c                                       |   5 +
 transport.h                                       |   1 +
 12 files changed, 349 insertions(+), 31 deletions(-)
 create mode 100755 t/t5543-atomic-push.sh

-- 
2.2.0.31.gad78000.dirty
