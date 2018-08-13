Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 487EE1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 23:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbeHNBxs (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 21:53:48 -0400
Received: from mout.web.de ([212.227.17.12]:53311 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730203AbeHNBxs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 21:53:48 -0400
Received: from [192.168.178.36] ([91.20.56.63]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LgpJ4-1gC5GK1Ixi-00oCJW; Tue, 14
 Aug 2018 01:09:18 +0200
Subject: Re: [PATCH 2/2] fsck: use oidset for skiplist
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
 <54a5367f-f832-402c-f51b-3225c92b41ad@web.de>
 <xmqqmutq5cpo.fsf@gitster-ct.c.googlers.com>
 <49564417-fac3-ede2-7fd1-e3a5a03e4cfe@web.de>
 <xmqqd0um3rhx.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <fc24f963-1bca-a638-e292-71044057dabb@web.de>
Date:   Tue, 14 Aug 2018 01:09:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0um3rhx.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:us0ktLHLTlGAQq0riNVvj7J96RHWjVLw1a34jEBzffPWwllvNq9
 jNmISAYQA/BDY5USEbMSEQAxTeDH1QN+fsr16TlzcSdzEOOM2JS39Jc0jkqwb0uv4r4er5Q
 k+BgYJxAjf5ddGXPXgpI6AtdsEpUk6wZBzUTIRLFXJ9rMmgNJ5Xd/LWoNMz8hsyDs1tnLUp
 v1zVv1o4QpYpORj83dbTA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qqmFRTZDRaY=:Fx0iG81Xx4w4G+Q68Xrjv1
 /mvYZXXDPkiIzx2SuXIL+bpGIvQh0z9PBonwFM078E7DOEIFt2jzTRYC7pYRakIBXdvVxdDAe
 zcyAXT1q10qNa18yVIez//mIrQaQucJCK0LPzkb3N+/5lh0W/toNAC7Mtw81WMZYYc2cVr2jT
 obNVhvZq7/SQM6V90xZ+0LZmHob5BPHdKOugpreEuA+2BcqfWanZf8ryOPuabTH5ahWvRZBQ9
 vlpKXKiE7dahpQ4k+ZJ45VIZBCmV6dp+8AJeOwVLRG/7lkv42dwtdRzFx/xTRPjGB8tTbQGCh
 sUgWuPXkshm94d7WQV4bxus6UpNH8YCvO+TXklJeBlS6Jyzi0r4hyU2aTKIXL8ena7wkDdce6
 8zp6f23nqnmIbvjlyMqJGc9nRHooGJdMIN/BNL8PvmJaxs5tmSvMjBsIiyhKMApSw8xp6QJ8c
 g300ybM+AxU5OtJqfAWJ3+/7CT+QYKVAURhS6n8cgue82T+Dm4eTt3WNVbVsRU9dgipkI3cZr
 T2atnWlGRTNIKcCpIv7J1BT4IBgG4bTdd1/ZU0YSGkxJRvOxvAC5AuOZDQOF1IVvyiGO/PMBl
 S6hc70F7hwRZ2TR5OCTv6oKN86UG5AjRu6uwz5wDAFchLrFK1H7UFi868kIU18IYabKL4AfBO
 AtPLanIzVUao4VsariE2lMQ/32+oM4dlSFK5GMqRsjPpA2SDpBmJTFjkcVvqRhZKhOe+X/n/9
 +PWQZZ5W2Hz+W10AsBdkdVdGX7qq530JADYV2zaLHk1uVKy2pGXEMJIWq8oRZtZ/Y4lQzlwK5
 d8Uu2or
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.08.2018 um 23:07 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> the mailing list [1], nor on the web interface [2].  The latter shows
>> extra spaces on the context lines of the first hunk, though, which I
>> can't see anywhere else.  All the lines look fine in the citation of
>> Ramsay's reply [3].  So I don't know where these extra spaces are
>> coming from. :-/
> 
> Hmph, interesting.
> 
> https://public-inbox.org/git/54a5367f-f832-402c-f51b-3225c92b41ad@web.de/raw
> 
> has "Content-Type: text/plain; charset=utf-8; format=flowed".  That
> page's rendition is more faithful to the bare text.

That explains it: Thunderbird 60 disables most older Add-ons, among them
Toggle Word Wrap, which used to turn off format=flowed for me.  I did
that now using the config settings mailnews.send_plaintext_flowed and
mailnews.display.disable_format_flowed_support.

> The funky " -" one I showed was what Gnus/Emacs came up with as the
> result of its best effort to make the format=flawed into something
> closer to "text", I think X-<.  

Sorry. :(

> In any case, I do not think format=flowed can be reverted reliably
> (or can it be?  If so we should teach mailinfo to repair them).

RFC3676 gives me a headache, perhaps I should go to bed.  If we can
assume that lines don't have trailing spaces originally then we should
be able to reconstruct their contents, no?  "A generating agent SHOULD:
[...] Trim spaces before user-inserted hard line breaks.", i.e. lines
with trailing spaces are doomed to truncation without hope for repair.

René
