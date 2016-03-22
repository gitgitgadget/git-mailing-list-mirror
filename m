From: Per Cederqvist <cederp@opera.com>
Subject: "git submodule deinit -f ." no longer works when there are no submodules
Date: Tue, 22 Mar 2016 10:25:06 +0100
Message-ID: <CAP=KgsRjJ9JNKe07GRpcNP3eQK8+zYDvUpXkp-9WgiQUq0bgcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 10:25:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiIYq-0000eo-Lw
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 10:25:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757948AbcCVJZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 05:25:08 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:32877 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182AbcCVJZH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 05:25:07 -0400
Received: by mail-qk0-f169.google.com with SMTP id s5so89597623qkd.0
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 02:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opera-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:date:message-id:subject:from:to;
        bh=0YdWtQYLp81D8v9lBFC92QqDJh3u+TsCa8GzQZxLIV4=;
        b=jou7nnSWokk4t0q2CPZI5JkNOZUqLZLuXlclcKeqeFmkoYjt/7GEp5ay5q9DVyYWSD
         Qo6CZ/T9uZ9iXX1OUkDj1ZSgDvXI3Wc6QqyKXl5ypxM02CY4eTAS/x/wr6lH8phSV/+f
         aQGtGKDXpr9FKSznLvEMlQio3YepW4eywG0C3NAu7a2snEX1OaoClkaqhEbakO0NSQlL
         OU/3IDpUJRJ+ns1QsySs9DyBbv2/Mq0HLt2i/sFncyg8cOMdh9AN2MbWlEe9M1vnU1f8
         8HmZSL1DhdaoF1JDP0reBZT8+0z2EmcFwlH4vo6wuNGPWS6iPjdXihFg0gZrcgMoUqRk
         8ExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0YdWtQYLp81D8v9lBFC92QqDJh3u+TsCa8GzQZxLIV4=;
        b=K0h2dT/G7YCcDxEViOs0VfuQPzF7XxZwXATLHCTawQpI9d0dy8RBLgs22KEE2I0hDS
         ruCoyvP+zDY0sf5s1ylkm3alc+Dwx/m9Ct4rza2ULUkL6uVEbREZw9ZHwutgwYBMVglC
         QcUww8gMtQc8Edqhc+NjBH3s0ZmJTA0vr2rtkxX6BMWju+9SR2GFNVG05F/h9mDYYPv9
         vvzUJJueqKXkP8pPEe7p+YZiuH6v1faEl+VjM/NfqOysrLMPjJ/Amw258rWZ9Qge0dKg
         MmmnJwYF6qlS4v2Jyl5gHUwJlnekdiOTLUIZAwW6Vpu7wAkWUL4qdfo4j7HS8Xomnrr1
         7rtw==
X-Gm-Message-State: AD7BkJK0CuDaR027VgyK/FK4e8W7y/hHrvQlq+0Nl/TlPNFg4u8XenJtnHC/WPdbj6Lt1Gsu0g6ABiA/DSodoqJ0
X-Received: by 10.55.24.87 with SMTP id j84mr44903024qkh.92.1458638706192;
 Tue, 22 Mar 2016 02:25:06 -0700 (PDT)
Received: by 10.55.137.2 with HTTP; Tue, 22 Mar 2016 02:25:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289498>

It used to be possible to run

    git submodule deinit -f .

to remove any submodules, no matter how many submodules you had.  That
is no longer possible in projects that don't have any submodules at
all.  The command will fail with:

    error: pathspec '.' did not match any file(s) known to git.

But if I run "git submodule deinit" (without the ".") git tells me:

    Use '.' if you really want to deinitialize all submodules

This is a regression introduced in Git 2.7.0 (and v2.7.0-rv0).  "git
bisect" points to this commit:

    commit 74703a1e4dfc5affcb8944e78b53f0817b492246 (refs/bisect/bad)
    Author: Stefan Beller <sbeller@google.com>
    Date:   2015-09-02 14:42:24 -0700

        submodule: rewrite `module_list` shell function in C

One could argue that it makes no sense to run "git submodule deinit -f
." in a repository with no submodules.  I've written a continuous
integration system for a project where some branches have submodules
and other don't, and I found it convenient to don't have to treat
those branches differently.

The following shellscript demonstrates the issue.  It passes on git
version before 2.7.0, and fails on later versions.

--- cut here ---
#!/bin/sh
#
# This script demonstrates the "git submodule deinit ." bug.
#

if ! mkdir subdeinit
then
    echo 'Covardly refusing to alter the "subdeinit" directory.' >&2
    echo 'Please remove it, or run this script inside an empty directory.' >&2
    exit 1
fi

cd subdeinit
mkdir repo
cd repo
git init
echo test > test
git add test
git commit -m"Create an initial commit."
if git submodule deinit -f .
then
    echo PASS: git submodule deinit -f . is allowed.
    exit 0
else
    echo FAIL: git submodule deinit -f . is not allowed.
    exit 1
fi
--- cut here ---

Yours,
    /ceder
