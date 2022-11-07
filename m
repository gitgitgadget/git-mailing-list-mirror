Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6BBC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiKGSpd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiKGSpY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:45:24 -0500
Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D891D1F9EC
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:45:22 -0800 (PST)
Received: from [192.168.5.3] (c-73-93-225-239.hsd1.ca.comcast.net [73.93.225.239])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 2A7IjLPX046223
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 7 Nov 2022 10:45:21 -0800 (PST)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-93-225-239.hsd1.ca.comcast.net [73.93.225.239] claimed to be [192.168.5.3]
Message-ID: <7766c9c8-1323-70fb-c6d2-efca6b77595f@tsoft.com>
Date:   Mon, 7 Nov 2022 10:45:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: 'git commit .' in a subdirectory also commits staged files in
 other subdirectories
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <3a4dfad5-0f2e-14d8-61f2-779616de1ae0@tsoft.com>
 <Y1MTtNcUHyv76UEV@nand.local>
From:   Yuri <yuri@rawbw.com>
In-Reply-To: <Y1MTtNcUHyv76UEV@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/21/22 14:48, Taylor Blau wrote:
> That isn't right, though I can't reproduce what you describe from your
> report. Try this script out:


I don't know how to reproduce this on purpose. But I just got another 
instance of the problem.

I am in the FreeBSD ports Git repository, in the math/cimod subfolder. 
Another subfolder, audio/sonic-visualiser, also has changes.

Here is the command:

[yuri@yv /disk-samsung/freebsd-ports/math/cimod]$ git commit .
hint: Waiting for your editor to close the file...
# Uncomment and add a short description of why things changed.
math/cimod: Update 1.4.43 -> 1.4.45

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# category/port: Subject goes here, max 50 cols -|
# <then a blank line>
#                                                         72 columns --|
#
# Do not add a Submitted by line.  If someone besides the committer sent 
in the
# change, the commit author should be set using `git commit --author`.
#
# Uncomment and complete these metadata fields, as appropriate:
#
# PR:           <If and which Problem Report is related.>
Reported by:    portscout
# Reviewed by:  <If someone else reviewed your modification.>
# Tested by:    <If someone else tested the change.>
# Approved by:  <If you needed approval for this commit.>
# Obtained from:        <If the change is from a third party.>
# Fixes:        <Short hash and title line of commit fixed by this change>
# MFH:          <Ports tree branch name you plan to merge to.>
# Relnotes:     <Set to 'yes' for mention in release notes.>
# Security:     <Vulnerability reference (one per line) or description.>
# Sponsored by: <If the change was sponsored by an organization.>
# Pull Request: <https://github.com/freebsd/freebsd-ports/pull/###>
# Differential Revision: <https://reviews.freebsd.org/D###>
#
# "Pull Request" and "Differential Revision" require the *full* GitHub or
# Phabricator URL.
#
# On branch main
# Your branch is up to date with 'origin/main'.
#
# Changes to be committed:
#       modified:   Makefile
#       modified:   distinfo
#
# Changes not staged for commit:
#       modified:   ../../audio/sonic-visualiser/Makefile
#       modified:   ../../audio/sonic-visualiser/distinfo
#       deleted: ../../audio/sonic-visualiser/files/patch-acinclude.m4
#       deleted: ../../audio/sonic-visualiser/files/patch-base.pro
#       deleted: ../../audio/sonic-visualiser/files/patch-config.pri.in
#       deleted: ../../audio/sonic-visualiser/files/patch-configure.ac
#       deleted: ../../audio/sonic-visualiser/files/patch-convert.pro
#       deleted: ../../audio/sonic-visualiser/files/patch-server.pro
#       deleted: 
../../audio/sonic-visualiser/files/patch-sonic-visualiser.pro


Git said that 2 files are to be committed, Makefile and distnfo. This is 
correct.


However, the resulting commit also has audio/sonic-visualiser:

  git diff 99f39b9798ff81b8fb529bea7c16d96e27aecfca~1 
99f39b9798ff81b8fb529bea7c16d96e27aecfca | grep diff
diff --git a/audio/sonic-visualiser/files/patch-acinclude.m4 
b/audio/sonic-visualiser/files/patch-acinclude.m4
diff --git a/audio/sonic-visualiser/files/patch-base.pro 
b/audio/sonic-visualiser/files/patch-base.pro
diff --git a/audio/sonic-visualiser/files/patch-config.pri.in 
b/audio/sonic-visualiser/files/patch-config.pri.in
diff --git a/audio/sonic-visualiser/files/patch-configure.ac 
b/audio/sonic-visualiser/files/patch-configure.ac
diff --git a/audio/sonic-visualiser/files/patch-convert.pro 
b/audio/sonic-visualiser/files/patch-convert.pro
diff --git a/audio/sonic-visualiser/files/patch-server.pro 
b/audio/sonic-visualiser/files/patch-server.pro
diff --git a/audio/sonic-visualiser/files/patch-sonic-visualiser.pro 
b/audio/sonic-visualiser/files/patch-sonic-visualiser.pro
- # (because of the difficulty of getting them running nicely in the
diff --git a/audio/sonic-visualiser/files/patch-sv.pro 
b/audio/sonic-visualiser/files/patch-sv.pro
diff --git a/audio/sonic-visualiser/files/patch-svapp_acinclude.m4 
b/audio/sonic-visualiser/files/patch-svapp_acinclude.m4
diff --git a/audio/sonic-visualiser/files/patch-svcore_acinclude.m4 
b/audio/sonic-visualiser/files/patch-svcore_acinclude.m4
diff --git a/audio/sonic-visualiser/files/patch-svcore_config.pri.in 
b/audio/sonic-visualiser/files/patch-svcore_config.pri.in
diff --git a/audio/sonic-visualiser/files/patch-svgui_acinclude.m4 
b/audio/sonic-visualiser/files/patch-svgui_acinclude.m4
diff --git 
a/audio/sonic-visualiser/files/patch-svgui_layer_WaveformLayer.cpp 
b/audio/sonic-visualiser/files/patch-svgui_layer_WaveformLayer.cpp
diff --git a/audio/sonic-visualiser/files/patch-svgui_view_Overview.cpp 
b/audio/sonic-visualiser/files/patch-svgui_view_Overview.cpp
diff --git a/math/cimod/Makefile b/math/cimod/Makefile
diff --git a/math/cimod/distinfo b/math/cimod/distinfo


This is WRONG!


There *is* a bug in Git.


Each commit needs to be individually checked to see if the right files 
were committed. The Git's commit description can't be trusted.

When it says "Changes not staged for commit" - these files should *not* 
be committed,

This has already hurt me several times.


This should be the highest priority bug.


Yuri


