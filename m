Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1483F20756
	for <e@80x24.org>; Mon,  9 Jan 2017 09:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934455AbdAIJqu (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 04:46:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56286 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934442AbdAIJqt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 04:46:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AFCE5A3CF;
        Mon,  9 Jan 2017 04:46:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=80WpEZ1blansyUZyrd2H5tJ//HI=; b=uAJyGn
        2HqdKifn2y4upqCAp522xnNlXHMsX1QRtXwCcaaIEggtTM0XVvsSbAnPiwtTFe8l
        NE1HSGe2pgXGetgNv8UTE9nQDK0qjfgBCeOqZglpqcfI5xRRO9A9QIOD2+xEqTIm
        UOpD78V6OO2oTK75bH0noFBaSv7xMHL0t1laI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nx/kItQIkqSuNCjqQehslbkQiXRfA9mt
        pB+ctme4gDUmIjisfFlO8zOLF3N5tIbg/lMHYUZEph4ADB84iDYAYh+Awr+Tmead
        5vQO+Li2b2PnjkTnFU1o0A6O86RLbfJLl7gzvIGi8DC5UNFfXI8Wc7CASaMKne27
        GvVL0bLw63A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 232C85A3CE;
        Mon,  9 Jan 2017 04:46:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 75B4F5A3CB;
        Mon,  9 Jan 2017 04:46:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Subject: Re: [PATCH v4 4/4] t7800: run both builtin and scripted difftool, for now
References: <cover.1480019834.git.johannes.schindelin@gmx.de>
        <cover.1483373635.git.johannes.schindelin@gmx.de>
        <0ae4a950a4cd2c8c4f05a6b46c60f127611580cf.1483373635.git.johannes.schindelin@gmx.de>
        <xmqqtw99ypvq.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701090850340.3469@virtualbox>
Date:   Mon, 09 Jan 2017 01:46:45 -0800
In-Reply-To: <alpine.DEB.2.20.1701090850340.3469@virtualbox> (Johannes
        Schindelin's message of "Mon, 9 Jan 2017 08:56:29 +0100 (CET)")
Message-ID: <xmqqbmvgy396.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 899027A0-D650-11E6-B851-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> And the most important point is that we do all of this only during a
> hopefully brief period in time that is mostly spent on reviewing the code
> and finding serious bugs and fixing them.

You seem to misunderstand the purpose of the code review.  

We indeed spot bugs while reviewing patches, especially ones from
less experienced folks, but that is the least important part of the
review.  In general, we review for:

 - Design.  Is the feature make sense?  Is it too narrow?  Are there
   better ways?  Does it fit well with the rest of the system?

 - Explanation.  Is the purpose of the change in the bigger picture
   explained well enough to allow future people to answer this
   question: "We now have an additional requirement to the feature.
   If the original author knew about that when this was first
   introduced, would s/he consider that our design for this
   additional thing consistent with the original design?  Should we
   design our enhancement in a different way?"

 - Maintainability.  Does the implementation avoid reinventing data
   structures and helper functions that already exist to interact
   with elements in the system?  Would a future change to some
   elements in the system that are touched by the implementation
   require changes to both existing code _and_ reinvented ones the
   patch introduced?

 - Correctness.  Does the implementation actually reflect the design
   and the way the design was explained?

For the "difftool in C" topic, the first two are mostly irrelevant
as the goal of the topic is to first replicate what already exists
faithfully (even in a bug-to-bug compatible way).  The issues in
correctness is something your daily use before submission would
have caught, use of 'next' users as testers will help, and also
caught by running test suite (again, before submission).  

I honestly do not expect glaring errors in the code from experienced
contributors remaining when their patches are polished enough to be
submit to the list.
