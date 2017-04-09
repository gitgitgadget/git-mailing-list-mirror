Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A2B820966
	for <e@80x24.org>; Sun,  9 Apr 2017 08:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751922AbdDIIip (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 04:38:45 -0400
Received: from dd28836.kasserver.com ([85.13.147.76]:41292 "EHLO
        dd28836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbdDIIin (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 04:38:43 -0400
Received: from [192.168.42.152] (dslb-178-000-062-147.178.000.pools.vodafone-ip.de [178.0.62.147])
        by dd28836.kasserver.com (Postfix) with ESMTPSA id 9133330122E;
        Sun,  9 Apr 2017 10:38:41 +0200 (CEST)
To:     jacob.keller@gmail.com (Jacob Keller), peff@peff.net (Jeff King)
Cc:     avarab@gmail.com (=?ISO-8859-1?Q?=C6var_Arnfj=F6r=3F_Bjarmason?=),
        matt@mattmccutchen.net (Matt McCutchen),
        git@vger.kernel.org (git), gitster@pobox.com (Junio C Hamano)
In-Reply-To: <CA+P7+xqfHDVKpVKVYbB-4kjb9ja+u4GVMwkTFrj0f0n_OXZfvQ@mail.gmail.com>
Subject: Re: Tools that do an automatic fetch defeat "git push --force-with-lease"
From:   lists@haller-berlin.de (Stefan Haller)
Date:   Sun, 9 Apr 2017 10:38:41 +0200
Message-ID: <1n47l28.1xcy707zz3evtM%lists@haller-berlin.de>
User-Agent: MacSOUP/2.8.6b1 (Mac OS 10.12.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> wrote:

> What if we added a separate command something like:
> 
> git create-lease
> 
> which you're expected to run at the start of a rewind-y operation and
> it creates a tag (or some other ref like a tag but in a different
> namespace) which is used by force-with-lease?

The problem with this is that it doesn't help to use "git create-lease"
right before you start your rewind-y operation, because by that time you
may already have fetched. You'd have to use "git create-lease" right
after you pull or push. But at the time I pull I don't know yet whether
I will later want to rewrite the branch, so to be sure I have to do this
every time I pull or push, and then I'd prefer git to do it for me.

> However, I think using origin/master works fine as long as you don't auto-fetch.
>
> If you're doing it right, you can handle origin/master updates by
> checking that your rewind-y stuff is correct for the new origin/master
> RIGHT before you push.

I'm not sure I understand what you mean by "checking that your rewind-y
stuff is correct for the new origin/master"; does that mean manually
inspecting origin/master to convince youself that you are not
overwriting something new? If so, I don't think this is acceptable. It
is probably ok to work this way if the other party only pushed commits
on top; it's reasonable to expect that you will recognize new commits as
ones that you haven't seen before. But what if the other party has
rewritten the branch and squashed improvements into commits in the
middle of it? The head commit will then look the same as before, and the
only way to tell whether you are overwriting something new is by
comparing the old and new hashes. So then we're back at having to
remember what the old hash was.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
