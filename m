Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B99522027C
	for <e@80x24.org>; Tue, 30 May 2017 15:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751305AbdE3PGQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 11:06:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751248AbdE3PGO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 11:06:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3263F3B708;
        Tue, 30 May 2017 15:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 3263F3B708
Authentication-Results: ext-mx06.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx06.extmail.prod.ext.phx2.redhat.com; spf=pass smtp.mailfrom=lersek@redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com 3263F3B708
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-87.phx2.redhat.com [10.3.116.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06B7219EF3;
        Tue, 30 May 2017 15:06:12 +0000 (UTC)
Subject: Re: FORMAT_PATCH_NAME_MAX increase
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <99ac8ee7-67b5-5ae7-51cf-6be38de6217f@redhat.com>
 <CACBZZX5U=U1bpiFuuxH2t8ZWnmQQAjWm1ji8XYq_6-SJPGL1sw@mail.gmail.com>
 <c2453701-979b-ebc7-dcc3-483a27d4c157@redhat.com>
 <85970ab4-e9c8-c6b6-11d3-faafd3ed0708@redhat.com>
 <CACBZZX4-T50q_eVWwJuBzoC6ocuG+v14Tm8wfK8h7FB_cMQzdQ@mail.gmail.com>
 <xmqqfufmbh4f.fsf@gitster.mtv.corp.google.com>
 <CACBZZX7x7s-RfQMZjHuq=fbGtOeQzYin_Owqx7dK3v7dudh8zA@mail.gmail.com>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <36557854-907f-9bb0-2059-c97328e1ca41@redhat.com>
Date:   Tue, 30 May 2017 17:06:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CACBZZX7x7s-RfQMZjHuq=fbGtOeQzYin_Owqx7dK3v7dudh8zA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 30 May 2017 15:06:14 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/30/17 16:35, Ævar Arnfjörð Bjarmason wrote:
> On Tue, May 30, 2017 at 3:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>>
>>> Just curious do you know about https://github.com/trast/tbdiff ? If
>>> not it might have a high overlap with what you're doing.

Thank you for the suggestion, it does exactly what I need. It solves the
Assignment Problem a whole lot better than my current, crude script.

https://en.wikipedia.org/wiki/Assignment_problem
https://en.wikipedia.org/wiki/Hungarian_algorithm

(Mildly amusing, to me anyway: I happen to be Hungarian.)

The output of git-tbdiff is not exactly the way I like it (I like to
review interdiffs colorized, and fed to $PAGER individually), but I can
easily do that on top of the "--no-patches" output.

>> Yes, that is a very good suggestion.  You'd need to be able to
>> actually apply the patches but the way I often do a review is very
>> similar to (actually, I'd say it is identical workflow) Laszlo's,
>> and it goes like this:
>>
>>     $ git checkout topic ;# previous round
>>     $ git checkout master... ;# check out the fork point of previous one
>>     $ git am mbox ;# apply the updated one
>>     $ git tbdiff ..@{-1} @{-1}..
> 
> I wonder if this tool seemingly everyone on-list uses should just be
> integrated into git.git.
> 
> I only learned about it <2 weeks ago and it's been great. The diff
> output was a bit nonsensical in some cases because it uses python's
> diff engine instead of git's.

Yes, I'd probably plug in git's diff engine (the patience algorithm at
that).

> 
> Would you mind patches to just integrate it to git in python as-is,
> then we could slowly convert it to C as we're doing with everything
> else.

That would be wonderful. My preference would be to use core git features
for solving the problem; as a second preference, it would be great if
git-tbdiff were packaged & shipped by GNU/Linux distros.

Thomas (I see you are on To:/Cc: now -- I meant to CC you, snarfing your
email from the git.git history :) ), are you aware of any distros
already packaging git-tbdiff?

Still the best would be if git provided this feature out of the box;
incremental review of rerolled series appears a common activity for any
serious reviewer / subsystem co-maintainer.

Thanks!
Laszlo
