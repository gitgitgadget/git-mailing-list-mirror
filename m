Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C816EB64DC
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjFZQxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjFZQxM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:53:12 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2077310C
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:53:11 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-766fd5f9536so25206885a.3
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687798390; x=1690390390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYAWG925XucEtVExn2YfJB+XnaQKy0qCYkIeiItCJ4E=;
        b=b+1sGZ+XPLU5+qcfC3Gz5LY9f/TWX0ynBMqmyU2UWl1AOdWXEso1cLuG9r+eAvAlnC
         2hTVEnschzcHumXGcnNs+9gX5asnh6C0pF7uvNYXvsK4Evvw+F/IEHqltl7gEJA32knr
         L9Us5YIm2lVIiOf5aJ2Q4tL3QJsxMQrvSMpCeMuskppaIs95bYr992dHDZC2PnUdPTbU
         0SrspNJN08VKADyrVAvbY9TBaxNJx67WuUkwSCusQ07YKFUuhVMtoY7kO/I5zmCAztLK
         3chsX8JQ70k7Rvo7td4ZaflY3sZzE+T+oJayxLZ7Q9EUCHpscYeEzHX2m6OMUs3828RF
         GYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687798390; x=1690390390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYAWG925XucEtVExn2YfJB+XnaQKy0qCYkIeiItCJ4E=;
        b=BpYBC3badC1bM9ljtRwgz4r1UixagHVyBxYEMtZy6pTYLXeyCanQ1KBHLuCJQdp6E2
         I0gPCGd6742f4yLMgexCWRgsfrYdpG1tlQJIUUo/7MGiEVxP9QcI/vCeAPK71eBWWwX8
         Lga8qGs27c2YQx26nhAHrY6crzbSR1JxAyjHmP7tnCyYFd6K3tL1jZimlqWuU1BbQI/U
         wJ5yCrIqA0woYwCkXTog4kst5iQ7tvns9s+kGsd744AW62NDo33EC2AInOsjiR/1JrN+
         JNVQlu8tlhI9vOfIbLGeDp1Hf+JH0j2KABDj2zyRodmvVxfSbBD2LxUHbNt4VJLa6HT7
         W3GQ==
X-Gm-Message-State: AC+VfDyWMfVMSNXHJYprpOs4nQHoeG7eAtBc2xKEP9Yl8h5YdOc6iI0w
        9sNyVss1G2ZBr1oIefLjQEU=
X-Google-Smtp-Source: ACHHUZ6/mgS1TNaKBlWaKNrVQsyC4hHEQbdKrkWdx0Wa6l0a+Tkqevll+01knWO6CheunaQrj2E5VQ==
X-Received: by 2002:a05:620a:17a4:b0:765:35ec:5ff7 with SMTP id ay36-20020a05620a17a400b0076535ec5ff7mr11896510qkb.20.1687798390193;
        Mon, 26 Jun 2023 09:53:10 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:266e:4d00::387])
        by smtp.gmail.com with ESMTPSA id p5-20020a05620a112500b00765acdc4f56sm922819qkk.60.2023.06.26.09.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:53:09 -0700 (PDT)
From:   Mark Levedahl <mlevedahl@gmail.com>
To:     mdl123@verizon.net, git@vger.kernel.org
Cc:     adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de, gitster@pobox.com,
        sunshine@sunshineco.com, Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v1 3/4] git-gui - use cygstart to browse on Cygwin
Date:   Mon, 26 Jun 2023 12:53:04 -0400
Message-ID: <20230626165305.37488-4-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.41.0.99.19
In-Reply-To: <20230626165305.37488-1-mlevedahl@gmail.com>
References: <20230624212347.179656-1-mlevedahl@gmail.com>
 <20230626165305.37488-1-mlevedahl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-gui enables the "Repository->Explore Working Copy" menu on Cygwin,
offering to open a Windows graphical file browser at the root of the
working directory. This code, shared with Git For Windows support,
depends upon use of Windows pathnames. However, git gui on Cygwin uses
unix pathnames, so this shared code will not work on Cygwin.

A base install of Cygwin provides the /bin/cygstart utility that runs
a registered Windows application based upon the file type, after
translating unix pathnames to Windows.  Adding the --explore option
guarantees that the Windows file explorer is opened, regardless of the
supplied pathname's file type and avoiding possibility of some other
action being taken.

So, teach git-gui to use cygstart --explore on Cygwin, restoring the
pre-2012 behavior of opening a Windows file explorer for browsing. This
separates the Git For Windows and Cygwin code paths. Note that
is_Windows is never true on Cygwin, and is_Cygwin is never true on Git
for Windows, though this is not obvious by examining the code for those
independent functions.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
changes since v0
 -- assumes the if/else tree being modified is untouched by prior
    patches making the changes minimal and easier to review.

 git-gui.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-gui.sh b/git-gui.sh
index 3f7c31e..8bc8892 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2274,7 +2274,9 @@ proc do_git_gui {} {
 
 # Get the system-specific explorer app/command.
 proc get_explorer {} {
-	if {[is_Cygwin] || [is_Windows]} {
+	if {[is_Cygwin]} {
+		set explorer "/bin/cygstart.exe --explore"
+	} elseif {[is_Windows]} {
 		set explorer "explorer.exe"
 	} elseif {[is_MacOSX]} {
 		set explorer "open"
-- 
2.41.0.99.19

