Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2337DC432C3
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A8B208A1
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X31zfAOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbfKTVS2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:18:28 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:43312 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKTVS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 16:18:28 -0500
Received: by mail-pj1-f68.google.com with SMTP id a10so375911pju.10
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 13:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uucGx/V/YQ9g2IZSnCWQ6YylyHH0XRH29389+/A03mg=;
        b=X31zfAObm4D4FpN2Ng58DYtBqVIpVacna4GSC2AotXoV9t9etV6868ErCCNU1BhZtW
         iuTGYiEl2h4mNST+mLyMukW8II8e09rrdzkShSZ/07w/kTDIisOCU3HZcJVpJvbpEwpb
         YpB4JSnnFGCOu8ECqXwtuhk39tabz2WdBgaxB+8H+84cLmSuv6x1RJJYBPcwiAXmBMbg
         ggTbFFafPoR8oW0ifMY6VUsXIVORQjh1Bj0bsBPZBkpn8LuMXBRZBeye0Q1I1GsUWyCb
         mtWnHnRwU3YYV6EaAvxppC2DZUjBHcofCtpt5hepb20ZXcAzBDcSzT3oLFiDiKa+wF9r
         PLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uucGx/V/YQ9g2IZSnCWQ6YylyHH0XRH29389+/A03mg=;
        b=l+qSk6K8k3Prg1SNwRSJTURiVw7osKogfA/KSDZXreA9v+sn0RPai+d31kEBMnC+YX
         eZoBIKDm3vZheIiD+VLieRNewK08+/8HPau/gIO0pd3lwBle9YMC1HxOLPi7TP4uWK12
         1NSLS99BoywuEnkLpFy1y2fh5m9F/L+5DW68Xm8wj4hsDkxGpknGtUgueqF/2jvu/p7r
         rmnH++6C1+zr+VEbwJtPqTBljpYHKofPm7Uz8YLD+6RR/mljLUEi8i9K4bCvMEJT23fU
         KK8D3nrENkgKeQvI3zNY9tiELfYLaktl4rETM0XcYF5TWckDvCG9sTz23YPmBhpkGf+P
         iINw==
X-Gm-Message-State: APjAAAX1lcJXafNoD9jc4uBaXOuAUh478+b7IAbkodmYUfNjzkLF3oza
        4aTan9R+AStmbpEkg16Ej/QekOA4
X-Google-Smtp-Source: APXvYqyBGOqiS3Etyrb4xIcyPBEWejdk+8AwnIudIKNNAsjDoKshJNBnFLXPBJOTck26Ji93KREYoA==
X-Received: by 2002:a17:902:7c94:: with SMTP id y20mr5132755pll.241.1574284706240;
        Wed, 20 Nov 2019 13:18:26 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id y24sm314635pfr.116.2019.11.20.13.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 13:18:25 -0800 (PST)
Date:   Wed, 20 Nov 2019 13:18:23 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 00/10] range-diff: learn `--notes`
Message-ID: <cover.1574284470.git.liu.denton@gmail.com>
References: <cover.1574207673.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574207673.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset teaches range-diff and format-patch to pass `--notes`
options down to the `git log` machinery. This should make the behaviour
more configurable for users who either don't want notes to be displayed
or want multiple notes refs to be displayed.

Changes since v2:

* Changed --notes=<treeish> to --notes=<ref>

* Added "t3206: disable parameter substitution in heredoc"

* Updated the commit message of "range-diff: pass through --notes to `git log`"

Changes since v1:

* Complete overhaul of approach

Denton Liu (10):
  argv-array: add space after `while`
  rev-list-options.txt: remove reference to --show-notes
  pretty-options.txt: --notes accepts a ref instead of treeish
  t3206: remove spaces after redirect operators
  t3206: disable parameter substitution in heredoc
  t3206: s/expected/expect/
  t3206: range-diff compares logs with commit notes
  range-diff: output `## Notes ##` header
  range-diff: pass through --notes to `git log`
  format-patch: pass notes configuration to range-diff

 Documentation/git-range-diff.txt   |   6 +-
 Documentation/pretty-options.txt   |   8 +-
 Documentation/rev-list-options.txt |   2 +-
 argv-array.c                       |   2 +-
 builtin/log.c                      |  24 ++-
 builtin/range-diff.c               |   6 +-
 log-tree.c                         |   2 +-
 range-diff.c                       |  21 ++-
 range-diff.h                       |   4 +-
 t/t3206-range-diff.sh              | 266 +++++++++++++++++++++++++----
 10 files changed, 291 insertions(+), 50 deletions(-)

Range-diff against v2:
 1:  396ac06b0d =  1:  fd78742570 argv-array: add space after `while`
 2:  8cc7c8fe72 =  2:  e1b023a6fc rev-list-options.txt: remove reference to --show-notes
 -:  ---------- >  3:  4989956f12 pretty-options.txt: --notes accepts a ref instead of treeish
 3:  22f5f07ace =  4:  85fcacf3f9 t3206: remove spaces after redirect operators
 -:  ---------- >  5:  855a3df542 t3206: disable parameter substitution in heredoc
 4:  922db36e7e =  6:  92df18b261 t3206: s/expected/expect/
 5:  d8ecda2d5e !  7:  093d32ac4f t3206: demonstrate current notes behavior
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    t3206: demonstrate current notes behavior
    +    t3206: range-diff compares logs with commit notes
     
         The test suite had a blindspot where it did not check the behavior of
         range-diff and format-patch when notes were present. Cover this
 6:  7dd0b93b0b =  8:  2d1c849ecc range-diff: output `## Notes ##` header
 7:  587a02a39c !  9:  9c144e14c5 range-diff: passthrough --[no-]notes to `git log`
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    range-diff: passthrough --[no-]notes to `git log`
    +    range-diff: pass through --notes to `git log`
     
         When a commit being range-diff'd has a note attached to it, the note
         will be compared as well. However, if a user has multiple notes refs or
         if they want to suppress notes from being printed, there is currently no
         way to do this.
     
    -    Passthrough `---no--notes` to the `git log` call so that this option is
    -    customizable.
    +    Pass through `--[no-]notes[=<ref>]` to the `git log` call so that this
    +    option is customizable.
     
      ## Documentation/git-range-diff.txt ##
     @@ Documentation/git-range-diff.txt: to revert to color all lines according to the outer diff markers
      	See the ``Algorithm`` section below for an explanation why this is
      	needed.
      
    -+--[no-]notes[=<treeish>]::
    ++--[no-]notes[=<ref>]::
     +	This flag is passed to the `git log` program
     +	(see linkgit:git-log[1]) that generates the patches.
     +
 8:  ce8cff7d0c = 10:  86318b3fe7 format-patch: pass notes configuration to range-diff
-- 
2.24.0.450.g7a9a4598a9

