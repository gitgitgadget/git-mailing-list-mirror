Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D32C4321E
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 15:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiKXPjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 10:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiKXPjm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 10:39:42 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47575214E
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 07:39:40 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so1897359pjj.4
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 07:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRVnSpep1qlRswrNiE8Cg7USHImW3vHd0rLSMiWznFA=;
        b=QIUHyVZuD0Q4rilE5VTqWMPzshfzfJKFVUSpBsimGXDptDA0qKc8Rnp/mdAl0hqvMA
         ye9H5cn29eD3y6iq0mlHbTzIT/mulE/uzzBsBr61qjkEdmOVAc+H+w4GnuYKSqLCb04D
         xv0EFjmoddHFWo4qErVIucRfL0PlRGghWnIzvQO4m2KP+T7BFxDP6x4eztNGwIg3gZPm
         kRd+7F9G6v2bkK0Jde2Mh+sKhImzOAxVTxw27MAqVF6sLJekxPG+eeBT2iWFf63hT6f9
         HwZs3+Sm4/Q+Q53yb/UeUTFRYPsC5Kc3e52fbfwfyZ8WlybsUcnwdOsTCGvK55YS2AK3
         WKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRVnSpep1qlRswrNiE8Cg7USHImW3vHd0rLSMiWznFA=;
        b=ShPESa/jJHuIW+yOkQSL/wBXCYrbtivX/INhEaPGOhoAD3drUVrp4L30BZsD8YjLL/
         MA2Hew/FDj6xLOu2oZTrn1LBL/iE6+0pt9SJaPZJmb+yyZFilSFkHilKt13Ha8ozW6Jg
         Lv4VXy7ZoBi7ILKfZs3okfzI3XNHMP2j0hhryBWDJkQpjabicKtY9PeUxv3d0VAGClQZ
         cJwfTWpCPX8TAhDEQSVqCx/jq6RtbgwENMfxAGvb8QKxG7BhFWuoXlCz5wkpOAZW+HWN
         NuIqfHMnk4nWv1UrIAQvf4A2uCuD3uyebDwM58ZK9QMQNi1bv8e1baBmhS6m66zfMqX5
         PeJQ==
X-Gm-Message-State: ANoB5pmvy9QL8k6Haohc+4keZl+VZ8VWmYtBmd1wGgnzaYjRJNvl6vTs
        P/xuAgz/nun6LdsfV63whH9EH9U4C+c=
X-Google-Smtp-Source: AA0mqf7vN79ys9fiv/AEbBBMmARdTG/qW+UaIh+ZIHkJ276M+BeGiYInaL0DyTXS5vj9b47C+S22Vg==
X-Received: by 2002:a17:902:a418:b0:187:edc:82f3 with SMTP id p24-20020a170902a41800b001870edc82f3mr14444368plq.161.1669304380174;
        Thu, 24 Nov 2022 07:39:40 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b0017f48a9e2d6sm1413089pln.292.2022.11.24.07.39.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Nov 2022 07:39:39 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 2/4] ci: show error message of "p4 -V"
Date:   Thu, 24 Nov 2022 23:39:32 +0800
Message-Id: <20221124153934.12470-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221124090545.4790-1-worldhello.net@gmail.com>
References: <20221124090545.4790-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When installing p4 as a dependency, we used to pipe output of "p4 -V" to
validate the installation, but this would hide potential errors of p4.
E.g.: A broken p4 installation fails to run.

Add some instructions to show errors of command "p4 -V", so we can see
why the command output doesn't match.

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 ci/install-dependencies.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index f639263a62..291e49bdde 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -83,9 +83,9 @@ esac
 if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
 then
 	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
-	p4d -V | grep Rev.
+	p4d -V | grep Rev. || { echo >&2 "p4d: bad version"; p4d -V; exit 1; }
 	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
-	p4 -V | grep Rev.
+	p4 -V | grep Rev. || { echo >&2 "p4: bad version"; p4 -V; exit 1; }
 else
 	echo >&2 "WARNING: perforce wasn't installed, see above for clues why"
 fi
-- 
2.39.0.rc0

