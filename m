Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3112C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 15:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjBAP5y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 10:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjBAP5m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 10:57:42 -0500
Received: from mail.wijmailenveilig.nl (unknown [IPv6:2a01:7c8:d004:1ea:5054:ff:fec3:44d3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276B0273B
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 07:57:21 -0800 (PST)
Received: from mail.wijmailenveilig.nl (localhost [127.0.0.1])
        by mail.wijmailenveilig.nl (Postfix) with ESMTP id 4P6RPp2M1hzGpHW
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 16:57:18 +0100 (CET)
Authentication-Results: mail.wijmailenveilig.nl (amavisd-new);
        dkim=pass (1024-bit key) reason="pass (just generated, assumed good)"
        header.d=dulfer.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dulfer.be; h=
        content-transfer-encoding:mime-version:x-mailer:message-id:date
        :subject:to:from; s=dkim; t=1675267037; x=1676131038; bh=SFgXY9H
        ZxTd7KKGW1RrZ4RagIWm33XWQ9iF9V73Iz28=; b=UdSo/QfaKsxQLHHH/E4cBZC
        wCT6Yh/gSb4+c0ZhjnTATqRIXw+Fjjp7rnfqjUBSsdMVLqOsBHtmtq8tcVSgnsqw
        kIOzLJMShY15NWX43jLzfnuFCXdNjUYQPvwXRDD6nRtVXju+q+W95RHrKKD5lkAm
        XDwf8FiXK3pDsjY6SmYE=
X-Virus-Scanned: Debian amavisd-new at mail.wijmailenveilig.nl
Received: from mail.wijmailenveilig.nl ([127.0.0.1])
        by mail.wijmailenveilig.nl (mail.wijmailenveilig.nl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gxE6PZGLi7mk for <git@vger.kernel.org>;
        Wed,  1 Feb 2023 16:57:17 +0100 (CET)
Received: from BIG-LINUX-BOY.roaming.utwente.nl (mobiel503eaa12060b.roaming.utwente.nl [130.89.170.192])
        by mail.wijmailenveilig.nl (Postfix) with ESMTPSA id 4P6RPn4lMfzGp64;
        Wed,  1 Feb 2023 16:57:17 +0100 (CET)
From:   Rafael Dulfer <rafael@dulfer.be>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Andrei Rybak <rybak.a.v@gmail.com>,
        Rafael Dulfer <rafael.dulfer@gmail.com>
Subject: [PATCH] rev-list: clarify git-log default date format
Date:   Wed,  1 Feb 2023 16:57:12 +0100
Message-Id: <20230201155712.86577-1-rafael@dulfer.be>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Rafael Dulfer <rafael.dulfer@gmail.com>

Currently, the documentation is slightly incomplete, not explaining all t=
he differences the default format has with rfc2822. Leading to confusion =
for people trying to parse the date format outputted by git log

This patch adds 2 more exceptions when compared to rfc2822. Also adds an =
example of what the format looks like (I originally wanted to specify thi=
s in strftime notation, but because of the way day-of-month is formatted =
this is impossible)

Signed-off-by: Rafael Dulfer <rafael.dulfer@gmail.com>
---
 Documentation/rev-list-options.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-=
options.txt
index ff68e48406..8bc8475f3e 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -1103,9 +1103,15 @@ format placeholders. When using `-local`, the corr=
ect syntax is
 `--date=3Ddefault` is the default format, and is similar to
 `--date=3Drfc2822`, with a few exceptions:
 --
-	- there is no comma after the day-of-week
+	- There is no comma after the day-of-week
=20
-	- the time zone is omitted when the local time zone is used
+	- The time zone is omitted when the local time zone is used
+
+	- Day-of-month and month are switched around
+
+	- Time-of-day and the year are switched around
+
+As a result, the format looks as follows: `Thu Jan 1 00:00:00 1970 +0000=
` with `+0000` being omitted when the local time zone is used.
=20
 ifdef::git-rev-list[]
 --header::
--=20
2.39.1

