From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 0/5] ref-transactions-send-pack
Date: Thu, 31 Jul 2014 14:39:06 -0700
Message-ID: <1406842751-6657-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 23:39:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCy4H-00055i-6K
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 23:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbaGaVjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 17:39:16 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:58845 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbaGaVjO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 17:39:14 -0400
Received: by mail-ie0-f201.google.com with SMTP id tr6so962010ieb.0
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TcueVh5nBCvCuzNLmTzJfooe7X0BNho67cPa+6KNk88=;
        b=Kp31tUwtkdqs1Cx1HMIzR76svH96NEoXKcz+GFcoSHHqWUz0H87t3+g+xftpPOegd7
         mEee0uJTcavjqDqI4HXjkZfzKWeA7QxDsdL7o3+hipBTIabzVXANJK2uA8Ol1qCjcF04
         0/Z4LUJ9BgJO13CuAb26cDfAU9aUtZgIwdLg2nUihaaZ6gywqbtd9//gqru4cAnRxll2
         KQouKsG68rp5vSIQ1AHYEpYpcNi07u8XnFPmKdOWImgcMtb5+hAHhSCgVP+jjqBMvl5c
         cVSHSZFZEUCmIvWAlqYgn0BDdo2eZO1PFg4uTVks7Nw7DH6ChLBnaQXP89poqJy9IPDI
         5LLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TcueVh5nBCvCuzNLmTzJfooe7X0BNho67cPa+6KNk88=;
        b=d5z1SXw98UICgd3k0klRhaPIFZNqVb02o+Vvziyml+dWMQce0VsV/todSdIngGQ8RU
         ZH3oq4Nnd9qws1K//oN+QxOKS1KGSho85gV3t6CPWt1wsJieNqu2ooHAEwM/4QubRbvo
         rqOBDkpkIBKn/gNx56yrUwCAcmi0p/0o9NsSAjm96uqHU4xAWc+74LWphKppi4XH27n3
         SaBlHk9dd/t7NfQLyMl343hc6YXYi0zWWlpig9OkCiEBEXEQ0h8f4yZGWkdtzWZTO5i2
         v4AlX+UBxApFrgV/y11LHvLuwPtNJJDu0d8b0AfWwEWtcY7o7tTdJwGloZ85D9VYiVBb
         LMGw==
X-Gm-Message-State: ALoCoQnhKoH49yj1vA5cySd/Hvx/JZpwyHRoZILiSR63UvE3Iq/L3fdDmGa5bhwy7M4wQXlUbVUz
X-Received: by 10.182.56.200 with SMTP id c8mr478390obq.7.1406842754322;
        Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a66si420724yhg.7.2014.07.31.14.39.14
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 2EB0D31C60D;
	Thu, 31 Jul 2014 14:39:14 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C87DFE06DA; Thu, 31 Jul 2014 14:39:13 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.528.gd0e7a84
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254609>

List,

This small patch series adds atomic-push support to for pushes.
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

 Documentation/config.txt        |  5 ++++
 Documentation/git-push.txt      |  7 ++++-
 Documentation/git-send-pack.txt |  7 ++++-
 builtin/push.c                  |  2 ++
 builtin/receive-pack.c          | 66 +++++++++++++++++++++++++++++++++--------
 builtin/send-pack.c             |  6 +++-
 send-pack.c                     | 18 +++++++++--
 send-pack.h                     |  1 +
 transport.c                     |  1 +
 transport.h                     |  1 +
 10 files changed, 96 insertions(+), 18 deletions(-)

-- 
2.0.1.528.gd0e7a84
