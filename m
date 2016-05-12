From: Armin Kunaschik <megabreit@googlemail.com>
Subject: t0008 test fails with ksh
Date: Thu, 12 May 2016 19:53:28 +0200
Message-ID: <CALR6jEjWjJA0X2qXsxqObqc_yxrgX87LYf8cmJ0MmJFF6PkmTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 12 19:53:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0uno-0004jD-4k
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 19:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbcELRx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 13:53:29 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33774 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbcELRx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 13:53:29 -0400
Received: by mail-yw0-f169.google.com with SMTP id t10so90639080ywa.0
        for <git@vger.kernel.org>; Thu, 12 May 2016 10:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=v66q2cLHQnBWL/y7yoWGScZtsXBM0AcaQyxP2VnoxUY=;
        b=A5uQgcfkbk6+uiV+bNkoRBEV+CpKA/Pz1Xfaq/cseQhM/MhITeQxBjmLWpTuFvlXxN
         /ptdBtCnEB5jgDuDaDQG1XYPCF4Z1/w06NNgcCNGpPGBu2Dm6QXFIqQAgzT4Y2TlgASo
         EF+uytnQNYuFxyG3779DiSGNS4olbICG1ly01lJg8x+Z7iQNTZxOpUbdhU5SfPoKcWwK
         vvGLOxmYl+14siIpLFtailcRawMz9CLQb6ugFkQAqP6zAivdn+btZ9TCp3EQIMpqCsnC
         +Xz5cMiFvS1mhx7lUrySDKdwGr9B9sqAssFfSZtcEnmq/vxC7V9mtxrkvuEo/yhf09qf
         VU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=v66q2cLHQnBWL/y7yoWGScZtsXBM0AcaQyxP2VnoxUY=;
        b=Iy9pN05dOnLnChVaFR3S6Z+QTKe78pRg5oY9Qf2zI/2oqWVszCYyS9TMSNDcf8iiq4
         WQJJqZ+0fbtb9D/4GdpAtTFk1lijc1USQ9EKJfqdy4I/hGqITFfoR7dum4wYZQDHMuhi
         SAF7Ni+QjhyIBxe4Hk79t7hsj14jJkaaiBeiSqXv9R/ZRaCvK2GD2k16FOM1pVWji4y3
         dyieBsPOW2wrh6KveC+UxAXBI9+PkcjmYYpAW7cr3/r3PEMBWwtPUcKZvXMkA3YeRNzJ
         8uUgAyUv8aJOW3RKSbYGWAUgHylH86TesPisOsUHwCurBn2P/z09JkfnMgcfX4MSF7cJ
         4o5g==
X-Gm-Message-State: AOPr4FVYNgVMsvR3nPSxBFLbqeKbJXi8IHthSabETmgzmnJ0FD9giI3dJJfWSCCw7zQEvR3QL2GkAVE2d8vB+g==
X-Received: by 10.129.160.74 with SMTP id x71mr5277115ywg.131.1463075608211;
 Thu, 12 May 2016 10:53:28 -0700 (PDT)
Received: by 10.129.45.132 with HTTP; Thu, 12 May 2016 10:53:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294422>

Hello,

in t0008 I see tests fails with
not ok 374 - --stdin -v
#
#               expect_from_stdin <expected-verbose &&
#               test_check_ignore "-v --stdin" <stdin
#
[....]
not ok 381 - --stdin from subdirectory
#
#               expect_from_stdin <expected-default &&
#               (
#                       cd a &&
#                       test_check_ignore "--stdin" <../stdin
#               )
#
not ok 382 - --stdin from subdirectory with -v
#
#               expect_from_stdin <expected-verbose &&
#               (
#                       cd a &&
#                       test_check_ignore "--stdin -v" <../stdin
#               )
#
not ok 383 - --stdin from subdirectory with -v -n
#
#               expect_from_stdin <expected-all &&
#               (
#                       cd a &&
#                       test_check_ignore "--stdin -v -n" <../stdin
#               )
#

The reason seems that the snippet
cat <<-EOF >expected-all
        .gitignore:1:one        ../one
        ::      ../not-ignored
        .gitignore:1:one        one
        ::      not-ignored
        a/b/.gitignore:8:!on*   b/on
        a/b/.gitignore:8:!on*   b/one
        a/b/.gitignore:8:!on*   b/one one
        a/b/.gitignore:8:!on*   b/one two
        a/b/.gitignore:8:!on*   "b/one\"three"
        a/b/.gitignore:9:!two   b/two
        ::      b/not-ignored
        a/.gitignore:1:two*     b/twooo
        $global_excludes:2:!globaltwo   ../globaltwo
        $global_excludes:2:!globaltwo   globaltwo
        $global_excludes:2:!globaltwo   b/globaltwo
        $global_excludes:2:!globaltwo   ../b/globaltwo
        ::      c/not-ignored
EOF

behaves differently in bash and in ksh.
        a/b/.gitignore:8:!on*   "b/one\"three" comes out unmodified
with bash but with ksh it becomes
        a/b/.gitignore:8:!on*   "b/one"three"
I'm not sure what shell is "wrong" here, but when I modify the line to
        a/b/.gitignore:8:!on*   "b/one\\"three"
both shells generate the "right" output:
        a/b/.gitignore:8:!on*   "b/one\"three"

>From what I've learned I'd expect the double backslash to be the
"right" way to escape one
backslash. Do you agree or am I wrong?

This snippet appears twice in this test, generates expected-all and
expected-verbose.

Armin
