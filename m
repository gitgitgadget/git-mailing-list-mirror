Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C40CC7E0B3
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0D9247F8
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x6aJJKJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfLMSrq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:47:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62769 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbfLMSrq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 13:47:46 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C52F82308C;
        Fri, 13 Dec 2019 13:47:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RFml0ieNjL9T/Ce2FyJf66I9lko=; b=x6aJJK
        JUbwk+pO1m5bmCZQ761WXIH38ngWQ91U1gbje3+BXk5AN1PSTfTdqliK0HlRZH4f
        oxEnj9Wc8v2ecSPa0i6tmCjQkZjYZTZ301eAgO8+CfcZtMSfRI+0BOy8bJor9qK6
        qFD/dXHtipu+IIpA52h4ucTQjUoePPiUc+Jis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AtXwH7vJiwW+JKMian3wvXAdHxSm4fGU
        vkx6xWxB0PKg/a242atQyewO80kpHcOjW2TkmPOZZHcO7B5IHTMDcWe4jyP9s1rX
        uUW2+ZTtfdLbqu59sBPoWe95Dlu1Puxu722YNPhD2IpYXP+BBSf9gm7FPqB3u0hn
        VR2dO3dUo80=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BCDEE2308B;
        Fri, 13 Dec 2019 13:47:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 305A92308A;
        Fri, 13 Dec 2019 13:47:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: how to add a (history-laden) subdirectory into a repo?
References: <alpine.LFD.2.21.1912130447510.5127@localhost.localdomain>
Date:   Fri, 13 Dec 2019 10:47:42 -0800
In-Reply-To: <alpine.LFD.2.21.1912130447510.5127@localhost.localdomain>
        (Robert P. J. Day's message of "Fri, 13 Dec 2019 05:00:33 -0500
        (EST)")
Message-ID: <xmqqblsckqpd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0BD9FEB6-1DD9-11EA-A119-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>   I have a xilinx petalinux (vendor) repo that i started from scratch,
> with a certain amount of history that I would like to hang onto --
> assume the top-level structure (as created by the petalinux-create
> tool) is:
>
>   board_name/
>     dir1/
>     dir2/
>     ... etc etc ...
>
> and so on, and so on. that is the structure of my current repo,
> totally isolated from other content.
>
>   Now, at this client site, they're using petalinux, but their
> existing repository buried the petalinux project content inside a
> larger build infrastructure that involves docker and other tools, so
> the client's single repo has the structure:
>
>   client_repo/
>     blah1/
>     blah2/
>       woof1/
>       woof2/
>       board_name/      <---- subdir content in client repo
>         dir1/
>         dir2/
>         ... etc etc ...
>
> ...
>   I'd like to add my PL repo into that structure -- as you can see,
> all my commits will be relative to the dir structure "board_name/",
> while the corresponding content in the client repo will be relative to
> "client_repo/blah2/woof2/board_name/".

I think that pretending your history were all touching paths with
client_repo/brah2/ prefixed to them so that the shape of the working
tree resembles with each other is the easiest part of the problem.
You could filter-branch or filter-repo your history or even create a
fast-export stream and munge paths in it before running fast-import
on the result.

A much bigger issue is what you want to record as the result of such
a merge.  Your client repository may have their own changes they
want to keep, and your repository (with paths appropriately munged
to match) would also have your changes you want to keep.  Obviously
there won't be any common ancestor between these two histories, as
they evolved independently without being aware of the other.

"git merge --allow-unrelated-histories" would give you a chance to
record the result of such a merge, but you'd need to sort the
conflict out to match your customer needs.

