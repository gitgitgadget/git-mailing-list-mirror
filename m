Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 661AA20A40
	for <e@80x24.org>; Sun,  3 Dec 2017 05:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbdLCFjZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 00:39:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53121 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750757AbdLCFjY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 00:39:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BEE7AB6590;
        Sun,  3 Dec 2017 00:39:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/tahyMdIBFVmOn0hTagFx4FMjGA=; b=Ddkt5D
        7SmblMExabZ/CzwZJB3siIbtDL1Zwl2UVS3WmyO/yMPE5LZMCfE4LyT2ucTV4CNy
        fzzLzGdIgUQnzuiBeSHwUdtFyLkbDAL2whkWShHVXFPRrWecXPTDgaQKhfn6jas8
        pIRVS6XZv9R5fPXpn0Q9qAq9DjyfHNknAnHGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kB/9PGLy9/p9VGR9JsP1sE4VhDzTcExG
        bTY7R6UT2tBIXEz76Po3zxvb/YybWiY3D0A7iPCQ5ZVcIXeBq6bM7NwFlua7ZzpO
        l12zvHQ/R/TPiuSDrXvgETjaz4wwMXoWAzAFbCBeHTpEKIz4EecI3PtbtTXznxUp
        cVTtYjtKkf8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7B06B658F;
        Sun,  3 Dec 2017 00:39:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 34312B658E;
        Sun,  3 Dec 2017 00:39:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Knittl-Frank <knittl89@googlemail.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "git describe" documentation and behavior mismatch
References: <CACx-yZ10GiDT=dDeF1EUtM_K4nGd414SDfxLRqGWyXt0ub02Gg@mail.gmail.com>
        <CACx-yZ1dJuUj5mD6WE8yqZCPMK8q-yaJ0GKUSppZ7uDkqvJ5UA@mail.gmail.com>
Date:   Sat, 02 Dec 2017 21:39:21 -0800
In-Reply-To: <CACx-yZ1dJuUj5mD6WE8yqZCPMK8q-yaJ0GKUSppZ7uDkqvJ5UA@mail.gmail.com>
        (Daniel Knittl-Frank's message of "Thu, 30 Nov 2017 20:26:26 +0100")
Message-ID: <xmqqefocjrp2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 512D953E-D7EC-11E7-BA61-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Knittl-Frank <knittl89@googlemail.com> writes:

> An interesting fact (and intentional behavior?) is that describing a
> commit with only a lightweight tag will properly display the tags/
> prefix. I assume this is because the annotated tags only store the
> tagname without any ref namespace, which is then picked up by git
> describe and displayed.

I suspect that "see if the name recorded in the tag object matches
the name of the ref that stores the tag after refs/tags/" code *is*
not just verifying what it claims to (which may be good) but also
unintentionally affecting the output (i.e. "--all" promises that the
prefix tags/ should be shown).  Perhaps the code needs to be fixed
if that is the case.


