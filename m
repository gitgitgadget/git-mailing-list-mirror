Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61389C433E1
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 23:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 082DB206E3
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 23:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sDT0bzTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgGXXE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 19:04:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60355 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgGXXE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 19:04:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9191C761EE;
        Fri, 24 Jul 2020 19:04:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5+tRZp1WNnGuX6egP9yEolw9x98=; b=sDT0bz
        TdHv+6s4QJDF+5xiOJbpszkybROUSfuUVj6qjvZ63XGgQOkqRsIaTNWcrpa3jior
        MRRVoqKQPMVcgvdxe4walqJwUDleCH9+kr+GDqBSroRyk8pXwAgtcJOAz5LycqLF
        FcNvxRkFW2B3YvOnDIazWy1Jl4o/+uQiYPKDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=idK8YwE2LFKb+iaX7X3P3JyB6TVwxe/I
        7hOi8E01vYR8Frg88yQCOrNtXQ7FMb3nCm2WtZ2l//tMTv0v/Av3Nb0tpxKlttYU
        LtTGf49nw2j5cStlGsbyGNgQYCVcXBkIYbB4DjycT4ovvfvKNPsVOC9lqfNt2qUc
        ScHBEkaQTo4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 885AB761ED;
        Fri, 24 Jul 2020 19:04:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1AC73761EB;
        Fri, 24 Jul 2020 19:04:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        "B. Stebler" <bono.stebler@gmail.com>, git@vger.kernel.org
Subject: Re: Improving merge of tricky conflicts
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
        <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org>
        <874kpzmhis.fsf@osv.gnss.ru> <xmqqwo2v45hq.fsf@gitster.c.googlers.com>
        <87tuxzl00h.fsf@osv.gnss.ru>
        <20200723182648.GC3975154@coredump.intra.peff.net>
        <87blk6yrlc.fsf@osv.gnss.ru> <xmqqimedq5c8.fsf@gitster.c.googlers.com>
        <874kpxwghu.fsf@osv.gnss.ru> <xmqq7duslkp0.fsf@gitster.c.googlers.com>
        <87tuxwimvm.fsf@osv.gnss.ru>
Date:   Fri, 24 Jul 2020 16:04:25 -0700
In-Reply-To: <87tuxwimvm.fsf@osv.gnss.ru> (Sergey Organov's message of "Sat,
        25 Jul 2020 01:11:57 +0300")
Message-ID: <xmqqft9gjz0m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 053B59F4-CE02-11EA-8018-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Anyway, my primary point was that I still might wish to do exactly reset
> and start from scratch, and then I miss --conflict option, that in turn
> makes its existence less than 100% less sense than configuration
> variable, my estimation being about 80%.

As with other uses of "update working tree files from elsewhere" use
of "checkout", "--merge/--conflict=<style>" checkout does take
pathspec to specify what paths are to be updated.  Nothing stops you
to give "." (everything under the sun) pathspec there, so I do not
really see the point of insisting "I want to start and redo from
scratch".  

Unless the reason is "because that is the way I am used to", that
is.  Surely, we can start and redo from scratch any operation, not
limited to merges, by removing the entire repository and cloning it
again from scratch.  I am trying to give our users tools to help
them not get into that habit and instead always make forward
progress without discarding work that has already been done.

