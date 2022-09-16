Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366EAECAAA1
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 23:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIPXFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 19:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIPXE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 19:04:59 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E932E9D7
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 16:04:56 -0700 (PDT)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 28GN4tGx073375
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 19:04:55 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Git Mailing List'" <git@vger.kernel.org>
Subject: [BUG] Non-portable Construct Introduced in diagnose.c (dirent) at v2.38.0-rc0
Date:   Fri, 16 Sep 2022 19:04:49 -0400
Organization: Nexbridge Inc.
Message-ID: <011001d8ca20$bc4d81f0$34e885d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdjKILjsCtBhM3RpQU2n1cMHag6+hg==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The dirent d_type field is not available on every system. This was
introduced at 2.38.0-rc0 in diagnose.c

diagnose.c, line 79: error(1565): struct "dirent" has no field "d_type"

  		    e->d_type == DT_DIR && strlen(e->d_name) == 2 &&

(3 more issues in diagnose exist of this form).

The code should use the  NO_D_TYPE_IN_DIRENT knob to detect whether this is
an existing field as defined in cache.h.

This change breaks the build on NonStop systems (at least). I'm sorry I
missed this during review.

Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



