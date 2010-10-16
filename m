From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 0/8] fix push --progress over file://, git://, etc.
Date: Sun, 17 Oct 2010 02:36:55 +0800
Message-ID: <1287254223-4496-1-git-send-email-rctay89@gmail.com>
References: <AANLkTimo=Bd_XGvX=TPzVsds3xQGy9126+7Qg+zvk=d2@mail.gmail.com>
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 16 20:37:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7BdL-0002cP-Kr
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 20:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470Ab0JPShZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Oct 2010 14:37:25 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51141 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410Ab0JPShY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 14:37:24 -0400
Received: by pwj4 with SMTP id 4so321570pwj.19
        for <git@vger.kernel.org>; Sat, 16 Oct 2010 11:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6cTuKWtOHXOElWtpjZMVgy67VRp4VW4tJ7GfEzuQU1k=;
        b=KwJAfqSmYBQ8MyrMU/ijLcTB0gGAgFAvQbi5nuzlSXl+Crpmk+Ibb+SRTVi7++cZx1
         NRhRo979kAalyi/QFOn7aguB4sKS75uIctM7mWhZ2NwkbSNxkMCOZt7yNItZBeQd9r+w
         2WXHTvmWTD5vUbE0IBuNBmsKmmHUjY9oMK8hw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Z+99P/xJfyDZcggbUTI+MlJv4/cE7e7TSq4KJDgMLjYD1nGdf4wwdhkB7G+lkqC8kH
         ur/kC4y4WxKFuLfkAroIr14et3SnnoZbQSoaMXYtoUNBhITd31FUeWZUaTOVjOeoOC0V
         jLXTPyo1t0SbuAYvDRP1wWvfhdBVLs+zdfoGs=
Received: by 10.142.212.20 with SMTP id k20mr1844707wfg.132.1287254244228;
        Sat, 16 Oct 2010 11:37:24 -0700 (PDT)
Received: from localhost.localdomain (cm147.zeta152.maxonline.com.sg [116.87.152.147])
        by mx.google.com with ESMTPS id x18sm8029156wfa.23.2010.10.16.11.37.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Oct 2010 11:37:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.513.ge1ef3
In-Reply-To: <AANLkTimo=Bd_XGvX=TPzVsds3xQGy9126+7Qg+zvk=d2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159169>

This patch series addresses the issue of git push not displaying
progress messages to non-tty stderr, even if --progress is used. As
suggested by the subject, this issue afflicts the "builtin smart
transports" - file://, git://, ssh://. (All of them use
git_transport_push() and thus git-pack-objects.)

The last patch contains the actual fix; most of the other patches
improve tests that depend on a tty.

Contents:
[PATCH v2 0/8] fix push --progress over file://, git://, etc.
[PATCH v2 1/8] tests: factor out terminal handling from t7006
[PATCH v2 2/8] tests: test terminal output to both stdout and stderr
[PATCH v2 3/8] test-lib: allow test code to check the list of declared prerequisites
[PATCH v2 4/8] test_terminal: catch use without TTY prerequisite
[PATCH v2 5/8] test_terminal: give priority to test-terminal.perl usage
[PATCH v2 6/8] t5523-push-upstream: add function to ensure fresh upstream repo
[PATCH v2 7/8] t5523-push-upstream: test progress messages
[PATCH v2 8/8] push: pass --progress down to git-pack-objects

Jeff King (3):
  tests: factor out terminal handling from t7006
  tests: test terminal output to both stdout and stderr
  push: pass --progress down to git-pack-objects

Jonathan Nieder (3):
  test-lib: allow test code to check the list of declared prerequisites
  test_terminal: catch use without TTY prerequisite
  test_terminal: give priority to test-terminal.perl usage

Tay Ray Chuan (2):
  t5523-push-upstream: add function to ensure fresh upstream repo
  t5523-push-upstream: test progress messages

 builtin/send-pack.c        |    3 ++
 send-pack.h                |    1 +
 t/lib-terminal.sh          |   39 +++++++++++++++++++++++
 t/t5523-push-upstream.sh   |   44 +++++++++++++++++++++++++-
 t/t7006-pager.sh           |   38 +---------------------
 t/t7006/test-terminal.perl |   58 ----------------------------------
 t/test-lib.sh              |   26 +++++++++++----
 t/test-terminal.perl       |   75 ++++++++++++++++++++++++++++++++++++++++++++
 transport.c                |    1 +
 9 files changed, 183 insertions(+), 102 deletions(-)
 create mode 100644 t/lib-terminal.sh
 delete mode 100755 t/t7006/test-terminal.perl
 create mode 100755 t/test-terminal.perl

-- 
1.7.2.2.513.ge1ef3
