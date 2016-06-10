From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 0/3] Persistent submodule pathspec specification
Date: Fri, 10 Jun 2016 16:07:50 -0700
Message-ID: <20160610230753.11641-1-sbeller@google.com>
Cc: pclouds@gmail.com, sunshine@sunshineco.com,
	ramsay@ramsayjones.plus.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jun 11 01:08:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBVXK-0008KT-LG
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jun 2016 01:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbcFJXIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 19:08:18 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36161 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbcFJXIR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 19:08:17 -0400
Received: by mail-pf0-f171.google.com with SMTP id t190so27321718pfb.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 16:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wvRi55eZJL0g82OBgzZl5qhybqhAov+e9gsFCMGzZ+I=;
        b=GHQhZ2vG5DQWLCPgf0Pnp4w0ibP1eHXl6QSHmTxxW5EkXBZFtp/7M+zpvMBmW1NJAa
         TA9XaVaWiLS1VLwddIy3wHOIwgpUM4F5HtIXHx7WgkrITKcNkmf87tdMBgXebgaAhtu1
         bqcRt+pF86cdzGQh0Wcb1TfJEDEyBTg/x++SMjbHlHpGpH7JL1wnZW7yhX2aXTz9zDK9
         XPhPwdViMAhC+RUhIXVwLw6dxQw950TnW669/S23sAxJFysn06HAV3/S5G2Zl8tpChy3
         zbIOu4omMxUFkSdU0j9PJ/Wsd5b4OCjYKMu0d4Vi1jl16e1OI5z04/331IHBz5nbHAjY
         Wqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wvRi55eZJL0g82OBgzZl5qhybqhAov+e9gsFCMGzZ+I=;
        b=GNWuXyuv2zlfffvhcVURgmwylsi3wlcx489Dq9d1VqMEZVuxUpmV35HIUM9T+rIOF0
         ZvPEDwY45f1Z87PCk7vbEqstd3aGyUU7+75qV4FxTNDbQrIVGbk76mX2Lwl7Xsj5S7fw
         8aT8hs8GJTMmS8gELX9PPmFnDfwmY39cGOW8E3nYiwdvoA1fQLFNXFMhFFjFTAghPPV5
         4RRRv7mX6chwfFpMQdFw5+My5TbNdrH15nsSzG5UFdkSTyHMAIgVMW/0PfjYhzkwiflO
         kULLHesbpB+jRTegmoSXJiAQbwiysC8jYeqimZuztzg4e7/90RzA+vP9QdOiPKXwzOKa
         i/6g==
X-Gm-Message-State: ALyK8tJblLIXQdLk3uPWbeUJYsnVvEYk1nAd90kAxV9g09HpPn10RwRpA/tEDRVcr9g6y0jd
X-Received: by 10.98.18.9 with SMTP id a9mr4886248pfj.14.1465600096489;
        Fri, 10 Jun 2016 16:08:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:2099:4ff:ce85:68a])
        by smtp.gmail.com with ESMTPSA id x67sm20107444pff.47.2016.06.10.16.08.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 16:08:15 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.141.g4e46f88
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297081>

This is a reroll of origin/sb/submodule-default-paths.

It is based on top of the current origin/sb/pathspec-label (d8e47e7d5c62e,
2016-06-02 pathspec: disable preload-index when attribute pathspec magic is in use)
which got merged with the current origin/sb/clone-shallow-passthru (d22eb0447,
clone: add `--shallow-submodules` flag, 2016-04-25)

As the merge itself produced merge conflicts, you can find my version of
resolving the merge at [1].

After the resolved conflict, this reroll
 * fixes 2 typos:
    s/Pass ultiple/Pass multiple/ in builtin/clone.c and
    s/submodulespec/pathspec/ in Documentation/git-clone.txt
 * adds another patch on top for bash completion of clone to include
    --recurse and --init-submodule

Thanks,
Stefan

[1] https://github.com/stefanbeller/git/tree/submodule-default-paths

Stefan Beller (3):
  submodule update: add `--init-default-path` switch
  clone: add --init-submodule=<pathspec> switch
  completion: clone can recurse into submodules

 Documentation/config.txt               |   5 ++
 Documentation/git-clone.txt            |  23 ++++--
 Documentation/git-submodule.txt        |  13 +++-
 builtin/clone.c                        |  36 ++++++++-
 contrib/completion/git-completion.bash |   2 +
 git-submodule.sh                       |  23 +++++-
 t/t7400-submodule-basic.sh             | 134 +++++++++++++++++++++++++++++++++
 7 files changed, 221 insertions(+), 15 deletions(-)

-- 
2.8.2.141.g4e46f88
