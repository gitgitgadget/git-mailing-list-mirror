Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32C7D2022A
	for <e@80x24.org>; Tue,  8 Nov 2016 21:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752823AbcKHVhn (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 16:37:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54023 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752084AbcKHVhl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 16:37:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B73C54DFCB;
        Tue,  8 Nov 2016 16:37:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0GsV3QUpZ+BHorgrofM4r3BGf/I=; b=aFNKoq
        zCx+s9niVRrzkGgvj+tWTYoSEmroTiPcez9RTm1C+Exor8nteyPLfH9SDMrOQwaY
        d6G+cQYhoueeF9eIQcC5NkqjKIYSxNkbdy0u17l7EltzFaAA/VbCnbgbk2GAesGl
        vhB1tqYUA0U3XM3raj1ztK90EYWEvdzMrkWf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QnLfQtDmTMUdWtXFIiE56zkcbqep9Lpt
        DJI0c5A+0dhKKTByMeGPEt6c7nSiNZnkgf+qh09/ph0bpr9CGg7XxbeB0ZKGPyud
        m+vwWxlvsgM1gC7GZAgUImj+1xAz3Dyf7/F9DLyAs9mCV4DfstxtLumDh/AyWLYF
        gyYjHs00Gl8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AFA5B4DFCA;
        Tue,  8 Nov 2016 16:37:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 356194DFC9;
        Tue,  8 Nov 2016 16:37:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Markus Hitter <mah@jump-ing.de>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 0/3] gitk: memory consumption improvements
References: <de7cd593-0c10-4e93-1681-7e123504f5d5@jump-ing.de>
Date:   Tue, 08 Nov 2016 13:37:38 -0800
In-Reply-To: <de7cd593-0c10-4e93-1681-7e123504f5d5@jump-ing.de> (Markus
        Hitter's message of "Mon, 7 Nov 2016 19:54:28 +0100")
Message-ID: <xmqqtwbhbql9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 925DE1AE-A5FB-11E6-8EE3-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Markus Hitter <mah@jump-ing.de> writes:

> List, Paul,
>
> after searching for a while on why Gitk sometimes consumes
> exorbitant amounts of memory I found a pair of minor issues and
> also a big one: the text widget comes with an unlimited undo
> manager, which is turned on be default. Considering that each line
> is inserted seperately, this piles up a huuuge undo stack ... for
> a read-only text widget. Simply turning off this undo manager
> saves about 95% of memory when viewing large commits (with tens of
> thousands of diff lines).

You made me laugh crazy hard while in a waiting room in a clinic
yesterday with the cover letter; people around gave me a strange
look but I couldn't help.

This is a single liner with the largest gain in the history of this
project.  Very well spotted.

Are all semi-modern Tcl/Tk in service have this -undo thing so that
we can pass unconditionally to the text widget like the patch does?

If we had to do this conditionally, that robs the fun of "just
adding 8 bytes to the source to reduce 1+GB memory consumption", but
even if we had to go conditional, this is a great find.

Well done.
