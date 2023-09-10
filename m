Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90282EE49A4
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 18:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjIJSHh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Sep 2023 14:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjIJSHg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2023 14:07:36 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF41E188
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 11:07:30 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:44122)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qfOqH-008nYS-Ph; Sun, 10 Sep 2023 12:07:29 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:47908 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qfOqG-003OMB-Df; Sun, 10 Sep 2023 12:07:29 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
        <20230908231049.2035003-1-ebiederm@xmission.com>
        <ZP3Rr8Ei0sG0lg0R@tapette.crustytoothpaste.net>
Date:   Sun, 10 Sep 2023 13:07:21 -0500
In-Reply-To: <ZP3Rr8Ei0sG0lg0R@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 10 Sep 2023 14:24:47 +0000")
Message-ID: <87zg1tgaw6.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qfOqG-003OMB-Df;;;mid=<87zg1tgaw6.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+sO4RIOB4jhC8Shy0E2cptNq4ZxZzWZdU=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 01/32] doc hash-file-transition: A map file for mapping
 between sha1 and sha256
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2023-09-08 at 23:10:18, Eric W. Biederman wrote:
>> The v3 pack index file as documented has a lot of complexity making it
>> difficult to implement correctly.  I worked with bryan's preliminary
>> implementation and it took several passes to get the bugs out.
>> 
>> The complexity also requires multiple table look-ups to find all of
>> the information that is needed to translate from one kind of oid to
>> another.  Which can't be good for cache locality.
>> 
>> Even worse coming up with a new index file version requires making
>> changes that have the potentialy to break anything that uses the index
>> of a pack file.
>> 
>> Instead of continuing to deal with the chance of braking things
>> besides the oid mapping functionality, the additional complexity in
>> the file format, and worry if the performance would be reasonable I
>> stripped down the problem to it's fundamental complexity and came up
>> with a file format that is exactly about mapping one kind of oid to
>> another, and only supports two kinds of oids.
>
> I think this is a fine approach, and as I'm sure you noticed from my
> series, it's a lot more robust than trying to implement pack v3.  I'd be
> fine with going with this approach instead of pack v3.

I think I got your pack v3 working but it was at a minimum a serious
distraction.

I worry a little bit that this might leave some performance on the
table, with something like a 256 way jump table like we have in the
index file.

Still I figure we can start simple and when we start optimizing and
profiling we can revisit the format if it shows up as a performance
issue.

Eric

