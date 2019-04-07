Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 811C020248
	for <e@80x24.org>; Sun,  7 Apr 2019 13:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfDGNI0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 09:08:26 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40152 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfDGNI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 09:08:26 -0400
Received: by mail-ot1-f68.google.com with SMTP id t8so9620522otp.7
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 06:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GInWLBST1qGU6znwJxlCmt/uE0ekdahoUjtz/trojeU=;
        b=MAKJBwCsR7RtBC8F4gMDc9AwwJMOWF36/mPGeprJUt9pJUwPP7BeVHb76rGOoNMhu0
         09ETJAHoJqfqfRjc4grg0xam9xVZM+UZlt83YTADUu2+VZ+a/9ADDIQAvQYZ/9J4kd9W
         +eBUJ9PAiJ+CC88rn66S9yzAdO6gohq3QSRhmOGTPOANYIaCDD7159SmtLgtCopYl7FB
         OUl4fOhCidZ9Ydv3P5C6GSlO2PVBoy42y5eF7iBZ9pR0v5J0a9Bs4rxbyqlHaHnGaoDr
         sB4NBr5wiRUc2S8LYRQEMPJhA8568yJhMV1BG9vnQIsedRA2N7y1F8iO8qpwK52BXkYi
         e0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GInWLBST1qGU6znwJxlCmt/uE0ekdahoUjtz/trojeU=;
        b=Fp8csCcYcWK0ZaDWp+P+LbfVTxQ8foTmx2LqMa4UrKYczwGFVo3ky0RkIOcp6Emhal
         v32d3YRGFRePnNPBh4DHK6An8g8TCAPctZIHwngqE2ceCubwIG8CsCxE+1coRyGnpIil
         5HXsUfJP1tXbJ99EvkI9sxLti+yHfZNuK2OskZNjnm71/ZpKaOjgWzj5CUbUlDS+DAgQ
         smwzipbM5/V8P3di80aCC5I4M6rlM+mFixROan4Vzx+DBkDb6jrIAiRIpSgxkyFRtupR
         cZgA9CXLsQHTL33BvUHz21H4gS4L+1yn8w37OeXrc3MFnNhS8N8zbo9ZrqXSkv1zqSew
         lMnA==
X-Gm-Message-State: APjAAAVaUSA/gbagpjxBoRcX6ssJYnNXs3oGQY6DWgsLe4fLy/ETvs1s
        /0SD13N82O4Jav3cWJeEuEyDOnOoKnNQjB55kfNFCGRZX8k=
X-Google-Smtp-Source: APXvYqxzLkys3Drar9vIQVP4bGzURmVyo40dhW5cFqXRUkJTgtkNLES+uXr0Ngaen8Wol+wbRgYsu0rUf4xMcArRBXs=
X-Received: by 2002:a9d:784a:: with SMTP id c10mr15011916otm.337.1554642504628;
 Sun, 07 Apr 2019 06:08:24 -0700 (PDT)
MIME-Version: 1.0
From:   Kapil Jain <jkapil.cs@gmail.com>
Date:   Sun, 7 Apr 2019 18:38:13 +0530
Message-ID: <CAMknYEN1x5zDPn4vaZmw3ch-Oy2=NQ=cfF9YmXumcbZGWvTToQ@mail.gmail.com>
Subject: [GSoC][RFC] discussion about stashing with conflicts
To:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

below is my understanding from reading the parts of code as suggested on IRC.

what is the use of ce_stage macro ?
tells about stage of an index entry.
if ce_stage says, stage #0 i.e staging area, then that index entry is
in staging area
and nothing needs to be done.
else a temporary index entry is created and repo_read_index_unmerged()
calls other function and tries to add it to index.
if it fails, it issues an error.

is this correct interpretation ?

1) in repo_read_index_unmerged(), why don't we make the value of
`unmerged` 0, if adding index entry is successful; as the entry is no
longer unmerged ?

2) what is ADD_CACHE_SKIP_DFCHECK ?
i am unsure if i get its meaning, cache.h says that it means "Ok to
skip DF conflict checks"
what are DF conflict checks ? something about diffing to check for
conflicts ? if so why are we skipping it this entry had conflicts in
the past maybe it will create again.

3) what is cache_nr variable in index_state struct ? what is its use ?


Now, about add_index_entry_with_check(), i don't fully understand this
function but concentrating on the part pointed by dscho.
https://github.com/git/git/blob/v2.21.0/read-cache.c#L1284-L1294

    /*
     * Inserting a merged entry ("stage 0") into the index
     * will always replace all non-merged entries..
     */

so this is the part we need to play with for the project
https://git.github.io/SoC-2019-Ideas/#teach-git-stash-to-handle-unmerged-index-entries
try and change this in some-way to not replace those unmerged entries
or store them some place else ?
