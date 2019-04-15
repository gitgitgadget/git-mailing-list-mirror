Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13C6820374
	for <e@80x24.org>; Mon, 15 Apr 2019 06:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfDOG2Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 02:28:25 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:60068 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfDOG2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 02:28:25 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 44jJTz2bc1z5tlG;
        Mon, 15 Apr 2019 08:28:23 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 8005B2AA9;
        Mon, 15 Apr 2019 08:28:22 +0200 (CEST)
Subject: Re: [RFC PATCH 3/4] range-diff: add section header instead of diff
 header
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20190411220532.GG32487@hank.intra.tgummerer.com>
 <20190414210933.20875-1-t.gummerer@gmail.com>
 <20190414210933.20875-4-t.gummerer@gmail.com>
 <CAPig+cTJyYLGAfHM_PrZd9DDaZBcVUetcWFcANGCYPvaMh2qxA@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <46e31ffc-60f6-1aef-5159-6796b7f13294@kdbg.org>
Date:   Mon, 15 Apr 2019 08:28:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cTJyYLGAfHM_PrZd9DDaZBcVUetcWFcANGCYPvaMh2qxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.04.19 um 01:29 schrieb Eric Sunshine:
> On Sun, Apr 14, 2019 at 5:10 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> +                               strbuf_remove(&line, 0, 4);
>> +                       if (!strcmp(filename_a.buf, "/dev/null")) {
>> +                               strbuf_addstr(&buf, "new file ");
>> +                               strbuf_addbuf(&buf, &line);
>> +                       } else if (!strcmp(line.buf, "/dev/null")) {
>> +                               strbuf_addstr(&buf, "removed file ");
>> +                               strbuf_addbuf(&buf, &line);
>> +                       } else if (strbuf_cmp(&filename_a, &line)) {
>> +                               strbuf_addstr(&buf, "renamed file ");
>> +                               strbuf_addbuf(&buf, &filename_a);
>> +                               strbuf_addstr(&buf, " -> ");
>> +                               strbuf_addbuf(&buf, &line);
>> +                       } else {
>> +                               strbuf_addstr(&buf, "modified file ");
>> +                               strbuf_addbuf(&buf, &line);
>> +                       }
> 
> All of these disposition strings end with "file", which seems
> redundant. Short and sweet "new", "removed", "renamed", "modified"
> provide just as much useful information.
> 
> Also, should these strings be localizable? Alternately, rather than
> using prose to describe the disposition, perhaps do so symbolically
> (thus universally), say with "+", "-", "->", "*" (or ""),
> respectively?
When the strings are translated, it would be preferable to not do this
sentence lego at all and have format strings that are filled with the
values.

Then the noise word "file" is probably not that bad, in particular, when
translators tend to not add words that they don't see in the original.
For example, German translations of "new %s" I anticipate "neues %s",
"%s (neu)", "neu %s", all of which are awkward, but translations of "new
file %s" lends itself naturally to "neue Datei %s", which is fine.

-- Hannes
