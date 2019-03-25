Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6777920248
	for <e@80x24.org>; Mon, 25 Mar 2019 06:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbfCYGnN (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 02:43:13 -0400
Received: from mail.javad.com ([54.86.164.124]:54327 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729631AbfCYGnN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 02:43:13 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 450003E9F6;
        Mon, 25 Mar 2019 06:43:11 +0000 (UTC)
Authentication-Results: mail.javad.com;
        dkim=pass (1024-bit key; unprotected) header.d=javad.com header.i=@javad.com header.b=Dfzura+w;
        dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1553496191;
        bh=fmOv+pVRz/gsATYOSYDiSJ+xMMbWIuRMoRlbKzfSEDQ=; l=1602;
        h=Received:From:To:Subject;
        b=Dfzura+wEPL3ZcjSbnYSBdS7duxnSVanZ09mllwRhhHIouLsfAz4k3T9NQ/U+kFez
         eqYyWqNRZc9iMe7jEWy7sLNG1UzaS75F9GgCqxVp45wjKG3Q/enmHmW5Qcxfo8zkV4
         qMsp6eLCpI6SzaLExY2CCi8cjrHGETz2NZjwmXCA=
Authentication-Results: ip-172-31-2-110;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (ip-172-31-2-110: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1h8JK9-0000TA-Fb; Mon, 25 Mar 2019 09:43:09 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] cherry-pick: do not error on non-merge commits when '-m 1' is specified
References: <87efh0pdln.fsf@javad.com>
        <xmqqsh5gt9sm.fsf@gitster-ct.c.googlers.com>
        <8736nj2jcl.fsf@javad.com>
        <xmqqbm26xtum.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 25 Mar 2019 09:43:09 +0300
In-Reply-To: <xmqqbm26xtum.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 20 Mar 2019 09:38:57 +0900")
Message-ID: <87h8bra1z6.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> I think that "first-parent is special" is the way to go indeed for
>> porcelain, as it does make many thing easier and more convenient[*].
>
> Perhaps.  However ...
>
>> [*] One example that immediately comes to mind is "git log -p" for a
>> merge commit. I doesn't currently (as of v2.10) show the first-parent
>> diff, for whatever reason. "git log -p -m --first-parent" is needed to
>> get the answer to most "obvious" question: what (merge) commit did to my
>> mainline? "git show" has its own issues.
>
> ... this is very much deliberate and will remain so.

> A single ball of wax "diff M^ M" for a merge commit is not always
> what you would want, especially while viewing "git log -p" (without
> "--first-parent").

OK, point taken. Then it's an issue of suppressing (presumably huge)
parts of output for merge commits by default, and is only vaguely
relevant to the "first parent is special" trend that I intended to
discuss. So, let's leave in peace the "git log -p" for now, and let me
try it from different angle.

How about changing "git show -p M" to output "diff -p M^ M" rather than
"diff-tree --cc M" for merge commits? It's really surprising specifying
-p has no visible effect.

Also, is current output of "git log -m", being extremely confusing,
suitable for anything? Maybe consider to change it to output diff with
respect to the first parent only? Though it's then a pity "-m" lacks
argument here, similar to what it has in cherry-pick.

-- Sergey
