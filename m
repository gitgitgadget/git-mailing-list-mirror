Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE5AF1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 13:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753031AbeBFNGE (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 08:06:04 -0500
Received: from mail.javad.com ([54.86.164.124]:37200 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752885AbeBFNF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 08:05:59 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 447733E898;
        Tue,  6 Feb 2018 13:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1517922357;
        bh=oS7pdpWcVndHzSDup7A96q1z6/9/Ksx2+dKNZ2HiioM=; l=1690;
        h=Received:From:To:Subject;
        b=U8m4GWk0WQ7KhLTFBWDPZ6dQp5FaR14vB/nvZvi9StM17VR0lQ1eZzjpPEZFE51Xk
         ee0tgoF9p4MrQSfAJPNe7ltm0qiPBnQ7WGFQycTRtFioIk+ZOl8ij6yXSbnyvlJrR8
         3gwDt9wb/+xQrXNhsB9XsRO7WDRzEqEXXRSagqkI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1517922357;
        bh=oS7pdpWcVndHzSDup7A96q1z6/9/Ksx2+dKNZ2HiioM=; l=1690;
        h=Received:From:To:Subject;
        b=U8m4GWk0WQ7KhLTFBWDPZ6dQp5FaR14vB/nvZvi9StM17VR0lQ1eZzjpPEZFE51Xk
         ee0tgoF9p4MrQSfAJPNe7ltm0qiPBnQ7WGFQycTRtFioIk+ZOl8ij6yXSbnyvlJrR8
         3gwDt9wb/+xQrXNhsB9XsRO7WDRzEqEXXRSagqkI=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1ej2wd-0008LX-Ko; Tue, 06 Feb 2018 16:05:55 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: cherry-pick '-m' curiosity
References: <87wozry7z4.fsf@javad.com>
        <xmqqtvuv9po8.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 06 Feb 2018 16:05:55 +0300
In-Reply-To: <xmqqtvuv9po8.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 05 Feb 2018 11:55:51 -0800")
Message-ID: <87y3k6tgi4.fsf@javad.com>
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
>> Isn't it always the case that "mainline" is the first parent, as that's
>> how "git merge" happens to work?
>
> You may not be merging into the "mainline" in the first place.
>
> Imagine forking two topics at the same commit on the mainline, and
> merging these two topics of equal importance together into a single
> bigger topic, before asking the mainline to pull the whole.
>
>     $ git checkout mainline
>     $ git tag fork-point
>     $ git checkout -b frontend-topic fork-point
>     $ work work work
>     $ git checkout -b backend-topic fork-point
>     $ work work work
>     $ git checkout -b combined
>     $ git merge frontend-topic
>     $ git tag merged
>
> The backend-topic may be recorded as the first-parent of the
> resulting merge, but logically the two topics are of equal footing,
> so merge^1..merge and merge^2..merge are both equally interesting.

Point taken, thanks! Now, if I reformulate my original question as:

"Isn't it _usually_ the case that "mainline" is the first parent?"

what is the answer?

For example, in the above case I'd likely rather: 

     $ git checkout -b combined fork-point
     $ git merge --no-ff frontend-topic
     $ git merge --no-ff backend-topic

and still have clear "mainline" on "-m1" for both merges.

I'm asking because those:

"Usually you cannot cherry-pick a merge because you do not know which
side of the merge should be considered the mainline."

in the manual page still feels confusing in the context of typical git
usage (as opposed to the context of abstract DAG operations where it'd
make sense indeed.)

-- Sergey
