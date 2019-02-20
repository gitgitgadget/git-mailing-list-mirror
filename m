Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6C731F453
	for <e@80x24.org>; Wed, 20 Feb 2019 11:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfBTLAh (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 06:00:37 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:42664 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfBTLAh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 06:00:37 -0500
Received: from [192.168.2.201] ([92.22.15.194])
        by smtp.talktalk.net with SMTP
        id wPc9gBBUFN402wPcAgoiXv; Wed, 20 Feb 2019 11:00:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1550660435;
        bh=8jFYypsvDdJoscGsrEHPLuImrfeauA6wDTt6fgjpIss=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CxyqAXjjCQe3/F+EErVI84Q/dNcZkAN74jC44939GXKp7E21F0GHQTrnph9KBpwJm
         Jqw65McLR9gRm+7rHpuKSAnXLsKk332u8pYJ9oNEbEHWuxAtUcVM6TWmD4uKxz9Jlx
         D8dpEm9inYtA75OKLUl1UCclfkXc4ZjluD1zd9Bc=
X-Originating-IP: [92.22.15.194]
X-Spam: 0
X-OAuthority: v=2.3 cv=afAfYigt c=1 sm=1 tr=0 a=SbQTfhO/oL0pg4h8lvBCaA==:117
 a=SbQTfhO/oL0pg4h8lvBCaA==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=5rxgeBVgAAAA:8 a=nN7BH9HXAAAA:8 a=W73Ni84s455WlsvDntMA:9 a=QEXdDO2ut3YA:10
 a=PwKx63F5tFurRwaNxrlG:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 5/8] git-rebase, sequencer: extend --quiet option for
 the interactive machinery
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Pratik Karki <predatoramigo@gmail.com>
References: <20181122044841.20993-1-newren@gmail.com>
 <20181211161139.31686-1-newren@gmail.com>
 <20181211161139.31686-6-newren@gmail.com>
 <nycvar.QRO.7.76.6.1901211709090.41@tvgsbejvaqbjf.bet>
 <CABPp-BFrgjW-c8NKGYKs1VaH--Oc8yUu0enQMSp1pQVUwBOBwA@mail.gmail.com>
 <xmqqy37ce8ad.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <63822309-1c58-a4a2-fa2b-d694bd9b8663@talktalk.net>
Date:   Wed, 20 Feb 2019 11:00:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqy37ce8ad.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFMOjwt1DhuidrpFN2sZUr6xvH1BMJVpnBd7LweWhISVO/18DyHcsq+sLFSzz80EkwtLiN63VW7YHYYG57LVdgvp1kibd74OAcgP+d9B48HO7svDsJvy
 D8SwAeC6HiQLIXz7reXfAy8UXuzYmpKz6UEVn5DOPDPGbcdyueApkFF8qUisyz4aFUIDgaPyo5j8q0+vHOjirKDWQ1SpucsYlaqUvwt4JTU/IBQdl+Qm8DOh
 py1UfUXajFNtvEPWs/GP2q5ttL+UJkuiiMo1sysynMNePdJCnfvPTZegXNUnmdk3p7gpM5na3A47GZLMGtwD4w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/01/2019 20:39, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
>> Also, I have a fuzzy memory of discussing a very similar case with
>> some rebase-oriented option and its on-disk representation, where the
>> concern was more about users upgrading git versions during an
>> incomplete rebase rather than power users looking at internal file
>> contents.  And I think either Phillip or Junio made some statement
>> about considering these internal details and that they felt the worry
>> about upgrade mid-rebase was overly worrying.  But I can't find the
>> emails right now, and it's been so long (at least half a year) that I
>> might be imagining things.
> 
> I do recall saying that mid-rebase upgrade is probably not worth
> getting worried about.
> 

In light of yesterday's bug report [1] about those other changes I'm
more concerned about this change. We were worrying about whether or not
to worry about a mid-rebase upgrade but it seems people can have two
different versions of git installed - one bundled with something like
tig and another they use on the command line. If they start a rebase
with a version containing this patch and try to continue it with a
version that does not then the older version will fail with a complaint
about a missing quiet file. The other way round they'll potentially get
the wrong quiet setting which isn't such a problem. It's probably a bit
late in the release cycle now to change this? But we could flag it up in
the release notes and bear it in mind when making changes in the future.

Best Wishes

Phillip


[1]
https://public-inbox.org/git/d7acf780-522d-84e6-68b8-d8d35a305588@talktalk.net/T/#maa521f788bd61f9b65d52c14430a88bf077e6752
