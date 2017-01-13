Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B7E820756
	for <e@80x24.org>; Fri, 13 Jan 2017 18:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751086AbdAMS17 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 13:27:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51894 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751033AbdAMS15 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 13:27:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF2445CCFE;
        Fri, 13 Jan 2017 13:27:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eK4bGqfX16KPojqSfIyb/pmFJzk=; b=g6vHcj
        wdMErbDq88mOFBl80TOXqVFXFClKsZHa/x7mKHY1F++yNbzJtoq1b6aTJUs2MH+D
        qtfFPNyj+NnjH87EEFgPRjEyZNTp8a/FwfLBt8Q9eCS6AO05Wzx55ij69Os8bBZc
        8sw2UlSs6qyHH8ybbcodeC5Hs6xRxZLwwEyjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bGZBBk4N2GxtOZ6AHXnUPtdOHELZ95R9
        dli3BFa+2jZtvDmchrc1975W1gtwskJbtbHmOaW73s50YlKwfuq3c5+Mx8MpQjX0
        1Au2rtIXTIPNZFsWcL89oO5IEh77GVaSU9hdyTPuoW0lcPcvKuobxmVBSEn9Dbwy
        ixOC/KzUwE4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D61225CCFD;
        Fri, 13 Jan 2017 13:27:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2C81A5CCFC;
        Fri, 13 Jan 2017 13:27:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Pat Pannuto <pat.pannuto@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] Use 'env' to find perl instead of fixed path
References: <20170112055140.29877-1-pat.pannuto@gmail.com>
        <20170112055140.29877-3-pat.pannuto@gmail.com>
        <6fe462dd-929a-671b-a210-36ee38e99115@kdbg.org>
        <CAAnLKaGbf9-GAF19+61=7_RfCOBM0=Ounwf8KkL1jS6HX3pOag@mail.gmail.com>
        <alpine.DEB.2.20.1701121118170.3469@virtualbox>
        <xmqqbmvcj9le.fsf@gitster.mtv.corp.google.com>
        <CAAnLKaGvz4Wzs36gMSdoYCg+tzx6KFCe59FNnk5zNQ-L58ww1g@mail.gmail.com>
        <20170113024842.GA20572@starla>
Date:   Fri, 13 Jan 2017 10:27:54 -0800
In-Reply-To: <20170113024842.GA20572@starla> (Eric Wong's message of "Fri, 13
        Jan 2017 02:48:42 +0000")
Message-ID: <xmqq4m12izmd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00D8D508-D9BE-11E6-942D-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Pat Pannuto <pat.pannuto@gmail.com> wrote:
>> You may still want the 1/2 patch in this series, just to make things
>> internally consistent with "-w" vs "use warnings;" inside git's perl
>> scripts.
>
> No, that is a step back.  "-w" affects the entire process, so it
> spots more potential problems.  The "warnings" pragma is scoped
> to the enclosing block, so it won't span across files.

OK, so with "-w", we do not have to write "use warnings" in each of
our files to get them checked.  It is handy when we ship our own
libs (e.g. Git.pm) that are used by our programs.

If something we write outselves trigger a false-positive, we can
work it around with "no warnings;" in the smallest block that
encloses the offending code in the worst case, or just rephrase it
in a way that won't trigger a false-positive.

If something we _use_ from a third-party is not warnings-clean,
there is no easy way to squelch them if we use "-w", which is a
potential downside, isn't it?  I do not know how serious a problem
it is in practice.  I suspect that the core package we use from perl
distribution are supposed to be warnings-clean, but we use a handful
of things from outside the core and I do not know what state they
are in.
