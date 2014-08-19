From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 0/5] ref-transactions-send-pack
Date: Tue, 19 Aug 2014 09:24:46 -0700
Message-ID: <1408465491-25488-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:25:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmDV-0007Lf-TE
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbaHSQY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:24:57 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:51455 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbaHSQYz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:24:55 -0400
Received: by mail-ig0-f202.google.com with SMTP id r2so1087051igi.3
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xDacye+EuOhOsUZOnxQIH9CRUzzk1zL9/IJcbyOB5PY=;
        b=HUAsf09XValnlj0gjfBtME7UXnmzjHvo22XbB2X+PP7AnXeF2y6eyxFOSsjB6MrdYG
         cZuK4Aoo+CrNEq4dsWAsIr1BAh1MthwGq6qhqBzwXPzoBK793grJBhjpD27wYvTkao79
         srjeKUzwn77n8jeNnf3Mv8tkR/2eEMt04VgOe7wG6NGNW7iQeiRleyfn9Viv3zXOsx3o
         aC3G0i6tjolCnDJZK2Q3ShKKu3MOD2zirR2XvfeiUWW0bIg/Ds0k5oLrpxORiZxbrMQG
         F8bs4lfW7hj1w32nAx1PjPwnaq3L0F9WSgjJz5QWOSd73M+9ni0flfogL2jc6BWgKACn
         4U9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xDacye+EuOhOsUZOnxQIH9CRUzzk1zL9/IJcbyOB5PY=;
        b=WAc86VJ6XKlH8WNFVvzqoZyanXy8kiCqOrsZdrPgBRcTWMJ0ZZRGN/FiBhDnUZFgQw
         I7pZb4PpEJD9RFp3s09B52Vk2R9fWN1oIqB9m4+DH6NIyDBBVy3gmdTmWM4wsWJDQKcU
         50R540BAApvP2Vbslz27PH06wT3iAIXLjTwovReYVA9e6w7ZoJR2ODi6fBIFOLoZNalw
         u9q9tqLzwahgORYZV4p3ExcV6t6M7MUBgCsy0citmic2ksl3UfabuBajdi5C3bFLY2fx
         7aUZTX2oH4+keatckdM9iKbRMBRdPEBVxsiig5m6nWVl77KYrTyJ7AK3tKJVmP1FfxoS
         jxew==
X-Gm-Message-State: ALoCoQkrISDR4nVD6Hg9dhsUFRs4DhB21im6ixUdwAXH7EAYFhYk5l3qE2NrN3aCRFjj4x9OgXv7
X-Received: by 10.42.96.193 with SMTP id k1mr22279213icn.13.1408465495070;
        Tue, 19 Aug 2014 09:24:55 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id h42si331414yhj.3.2014.08.19.09.24.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:24:55 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id D939E31C1B4;
	Tue, 19 Aug 2014 09:24:54 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 79AFDE0F40; Tue, 19 Aug 2014 09:24:54 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.ge8f7cba.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255470>

List,

This small patch series adds atomic-push support for pushes.
By default git will use the old style non-atomic updates for pushes,
as not to cause disruption in client scripts that may depend on that
behaviour.

Command line arguments are introduced to allow the client side to request/
negotiate atomic pushes if the remote repo supports it.
There is also a new configuration variable where a repo can set that it
wants all pushes to become atomic whether the client requests it or not.

This patch series is called ref-transactions-send-pack and depends on/is built
ontop of the series called ref-transactions-req-strbuf-err

Ronnie Sahlberg (5):
  receive-pack.c: add protocol support to negotiate atomic-push
  send-pack.c: add an --atomic-push command line argument
  receive-pack.c: use a single transaction when atomic-push is
    negotiated
  receive-pack.c: add receive.atomicpush configuration option
  push.c: add an --atomic-push argument

 Documentation/config.txt                          |  5 ++
 Documentation/git-push.txt                        |  7 ++-
 Documentation/git-send-pack.txt                   |  7 ++-
 Documentation/technical/protocol-capabilities.txt |  7 +++
 builtin/push.c                                    |  2 +
 builtin/receive-pack.c                            | 66 ++++++++++++++++++-----
 builtin/send-pack.c                               |  6 ++-
 send-pack.c                                       | 18 +++++--
 send-pack.h                                       |  1 +
 transport.c                                       |  1 +
 transport.h                                       |  1 +
 11 files changed, 103 insertions(+), 18 deletions(-)

-- 
2.0.1.556.ge8f7cba.dirty
