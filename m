Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38E3220984
	for <e@80x24.org>; Tue, 13 Sep 2016 23:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758882AbcIMXCg (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 19:02:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54290 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758095AbcIMXCf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 19:02:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77D4F3C5D8;
        Tue, 13 Sep 2016 19:02:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F2rYaBDOs9tjFInDnKgDSWj1EEs=; b=Oey6ww
        nDj5iQRbZa+ZNHKL0hJJ6enIeXkGeFUhNCm9CgMkJyRFKkGEZJzSQOwGpg6ghFKD
        JS1TbKHb/RM3qo4eM+Pcllx0R5lvwGDRfdaQ1uKWOkgWeOYIlThbxie5afUmNOyP
        M4l9UUgSpuQrsQG8OZ4IeHuTUfy8ZNbvRbuP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wQJLsWTNVD3bc0Idl+jRd5Ni33EBx0C8
        6tzBHp7f7DIECL0keHoAa5ZxsowDhW+IvWNAjEYoOCpZX4ravDcecdesMFlAVOEx
        9Bazu6CFpOzFJ6gAP9cQdlFps35CaL+ZFBv7tW8/+Ltz2umnXfJS1ZVZtGhhxJCk
        TGU1GPUy4HM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6FA1B3C5D4;
        Tue, 13 Sep 2016 19:02:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CFA923C5D2;
        Tue, 13 Sep 2016 19:02:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     peff@peff.net, chriscool@tuxfamily.org, git@vger.kernel.org
Subject: Re: [RFC/PATCH 10/17] submodule.c: convert show_submodule_summary to use emit_line_fmt
References: <20160913044613.1037-1-sbeller@google.com>
        <20160913044613.1037-11-sbeller@google.com>
Date:   Tue, 13 Sep 2016 16:02:31 -0700
In-Reply-To: <20160913044613.1037-11-sbeller@google.com> (Stefan Beller's
        message of "Mon, 12 Sep 2016 21:46:06 -0700")
Message-ID: <xmqqpoo7tnco.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27DE52F8-7A06-11E6-B694-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> In a later patch, I want to propose an option to detect&color
> moved lines in a diff, which cannot be done in a one-pass over
> the diff. Instead we need to go over the whole diff twice,
> because we cannot detect the first line of the two corresponding
> lines (+ and -) that got moved.
>
> So to prepare the diff machinery for two pass algorithms
> (i.e. buffer it all up and then operate on the result),
> move all emissions to places, such that the only emitting
> function is emit_line_0.
>
> This prepares the code for submodules to go through the
> emit_line_0 function.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

I wonder how this interacts with the jk/diff-submodule-diff-inline
topic by Jacob that has graduated recently to 'master'.  IIRC, it
just lets a separate "git diff" instance that is spawned in the
submodule directory emit its findings to the output of the driving
"git diff" in the superproject.

