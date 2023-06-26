Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DF3EB64DA
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjFZQxM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFZQxK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:53:10 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A94A10C
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:53:08 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-765ae938b1bso82868185a.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687798387; x=1690390387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=809IOvmVKRYXbNvuQJLTlV4PWoTTWrzzQku32/aaKJk=;
        b=sPdFMxT5wGBgVstJDPbsWXpiGf9Se+3YV0dGxxjxkYmDvOWIiwCp6v278UB/UjXMFg
         rTXxMZgxPoFpMg7XwWfyjbWh8H67snkI2gOGLzZlVUGBcpT3gN6bEbOvZPcMo/Q1kmEi
         gMyv9jtuMJ7oUFpb4VmV0duFvBdwUx8Wx62vw0BQZSf3f10g6MddmDDpLGkr+xSAEhuG
         /XzidyY5BsEQqSRfNPUtk6p0A2THzqVrUTw/mnyz3Uv8xMbeVVUWtAw6GwMB006sLPyx
         vZMd0FnW4UjMiO1Xc89gz3/9tsaZUJDaTNa8sgNvg9XDLhSBnPKzm4pciTEpO2KKVgZW
         ioeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687798387; x=1690390387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=809IOvmVKRYXbNvuQJLTlV4PWoTTWrzzQku32/aaKJk=;
        b=NDx32ITBBEXfWY7D7NHd5zFLTJp1sEqSMrlNkO+9pW+x2lvABRNNpAjn8sNQzJpjze
         vY2ABogssFc1Q1J6+9Hhv3p16HylbMBdJpVPySo85WSXyUgN7362w0QoKpob6db3+VhQ
         UI8fScky5y0r63WwFWnN0AHBFcSWN94AmolENhKzA+FwibcqAMbhILqM5jVfJdXmkz+k
         FPMFRwsAMNtsfnTJYR88rSj4XHFgPIdymKVWYLi7/YCN/zxS+MojlsiAIA0cvy8AR1TH
         Kyxaf+2HV/463m5bUOkNTuJXnNymbDdz52TIzDN7xBcsZRMuoQKXttnKk8ffOGL2QNyq
         wCgQ==
X-Gm-Message-State: AC+VfDwS0J75S9uaLMxL1b46gobJuM1CD6v+4HFgHvAGUfbE/C+nlffC
        P8sdp32m++FVc9JsGCdhjNs=
X-Google-Smtp-Source: ACHHUZ5OdUGV0HnYqJ+oljaL6cI90CkzSKZgumXK/OSz8s1/qjmmftHXtRjFFANkh8T0vM7ubbQlDg==
X-Received: by 2002:a05:620a:372b:b0:765:49c4:f2c3 with SMTP id de43-20020a05620a372b00b0076549c4f2c3mr11283741qkb.10.1687798387264;
        Mon, 26 Jun 2023 09:53:07 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:266e:4d00::387])
        by smtp.gmail.com with ESMTPSA id p5-20020a05620a112500b00765acdc4f56sm922819qkk.60.2023.06.26.09.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:53:06 -0700 (PDT)
From:   Mark Levedahl <mlevedahl@gmail.com>
To:     mdl123@verizon.net, git@vger.kernel.org
Cc:     adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de, gitster@pobox.com,
        sunshine@sunshineco.com, Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v1 0/4] Remove obsolete Cygwin support from git-gui
Date:   Mon, 26 Jun 2023 12:53:01 -0400
Message-ID: <20230626165305.37488-1-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.41.0.99.19
In-Reply-To: <20230624212347.179656-1-mlevedahl@gmail.com>
References: <20230624212347.179656-1-mlevedahl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=== This is an update, incorporating responses to Junio's and Eric's
comments:
  -- clarified what the "upstream" git-gui branch is
  -- Removed some changes from patch 2 as requested by Junio, reducing
     changes in patch 3 and patch 4
       All code is fixed only after applying patch 4
       Differences in patch 3 and 4 are minimimized
   -- updated comments to clarify G4w dedicated code.
   -- updated all comments to (hopefully) clarify points of confusion
===

git-gui has many snippets of code guarded by an is_Cygwin test, all of
which target a problematic hybrid Cygwin/Windows 8.4.1 Tcl/Tk removed
from the Cygwin project in March 2012. That is when Cygwin switched to a
well-supported unix/X11 Tcl/Tk package.  64-bit Cygwin was released
later so has always had the unix/X11 package.  git-gui runs as-is on
more recent Cygwin, treating it as a Linux variant, though two functions
are disabled.

The old Tcl/Tk understands Windows pathnames but has incomplete support
for unix pathnames (for instance, all pathnames output by that Tcl are
Windows, not unix). The Cygwin git executables all use unix pathnames
(though like all Cygwin executables have some capability to accept
Windows pathnames). git-gui's Cygwin specific code causes git-gui to use
Windows pathnames everywhere.  The unix/X11 Tcl/Tk requires use of unix
pathname, so none of the Cygwin specific code is compatible.

git-gui is maintained at https://github.com/prati0100/git-gui. The
git-gui in Junio's tree corresponds to commit c0698df057, behind the
current git-gui master which is a5005ded.

Fortunately, the git-gui/is_Cygwin function in Junio's tree relies upon
the old Tcl/Tk that outputs Windows pathnames.  As this fails to detect
Cygwin, git-gui treats Cygwin as a unix variant with no platform
specific code enabled and git-gui currently runs on Cygwin.

But, commit c5766eae6f on the git-gui master branch fixes is_Cygwin to
work with the new Tcl/Tk's signature (which is not that of a Windows
Tcl/Tk). Thus, Cygwin is detected, the incompatible Cygwin code is
enabled, and git-gui no longer runs on Cygwin.

Also, there is Cygwin specific code in the Makefile, intended to allow a
completely unsupported configuration with a Windows Tcl/Tk.  However,
the Makefile code mis-identifies the unix/X11 Tcl/Tk as Windows,
triggering insertion of a hardcoded Windows path to the library
directory into git-gui making it non-portable. The Cygwin git maintainer
comments this code out, but the code should be removed as it is
demonstrated to be incompatible with Cygwin and targets a configuration
Cygwin does not support.

The existing code for file browsing and creating a desktop icon is
shared with Git For Windows support, and supports only Windows
pathnames. This code does not work on Cygwin and needs replacement or
update.  The menu items for these functions are enabled by is_Cygwin, so
appear only after is_Cygwin is fixed as discussed above.

patch 1 removes the obsolete Makefile code
patch 2 removes obsolete git-gui.sh code, wrapped in is_Cygwin
     except for code fixed in patches 3 and 4
patch 3 implements Cygwin specific file browsing support
patch 4 implements Cygwin specific desktop icon support

The end result is that git-gui on Cygwin is restored to the full
capabilities existing prior to the Tcl/Tk switch in 2012. Also, the
remaining Cygwin specific code, updated in patches 3 and 4, no longer
overlaps with Git For Windows support.

Any argument for keeping the old Cygwin code must address who is going
to test and maintain that code, on what platform, and who the target
audience is. The old Tcl/Tk was only on 32-bit Cygwin and only supported
for the Insight debugger, 32-bit Cygwin is no longer supported, git-gui
is not supported on 8.4.1 Tcl/Tk, and the Windows versions targeted by
2012'ish 32-bit Cygwin are no longer supported.

Mark Levedahl (4):
  git gui Makefile - remove Cygwin modifications
  git-gui - remove obsolete Cygwin specific code
  git-gui - use cygstart to browse on Cygwin
  git-gui - use mkshortcut on Cygwin

 Makefile                  |  21 +------
 git-gui.sh                | 118 +++-----------------------------------
 lib/choose_repository.tcl |  27 +--------
 lib/shortcut.tcl          |  31 +++++-----
 4 files changed, 27 insertions(+), 170 deletions(-)

-- 
2.41.0.99.19

