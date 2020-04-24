Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5036CC54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 18:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AC222075A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 18:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nyGMUOyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgDXS5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 14:57:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52328 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbgDXS5A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 14:57:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2967ED26A7;
        Fri, 24 Apr 2020 14:56:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=kaTqzmdlHpIRzpW9Ni1e8hXqwbU=; b=nyGMUOywd/Bn9cz6KS+0
        F3ILnk3hE/kkyJZxqmAsobRqj+ZY1/5yBmtpeXg+Hg59vqvb/cPeX5ARHOAXcONX
        fu3IUgBULK22jg+wt2fm6U+LtNMqgW0abAy2Y2MSKjDXusogPF3G5ZxRll86yg5X
        FXIxVFA2Lns7NeNEVXikSvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=CbrmQwX0N75AJfyHKQqUA7OsWDMwgZ/sZsUSuT3Dyb5jox
        z+uoY6jqZuvltKBe76a4ZgjJIGJdrR/nRKIyIeIWowjuR8mwU8eDW+sfeL3iHrhT
        Tk0tiHR9mMOFd/8c55thaz+23LCTP+3M1VwujcR9TOWsEgAz26/VBI1wZbsqE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 21294D26A6;
        Fri, 24 Apr 2020 14:56:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6A247D26A5;
        Fri, 24 Apr 2020 14:56:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH 0/8] CMake build system for git
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
Date:   Fri, 24 Apr 2020 11:56:53 -0700
Message-ID: <xmqqv9lod85m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DF28514-865D-11EA-97E1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is an attempt to build Git using CMake.

What is your longer-term plan on this one?  Would the ultimate goal
be 

 (1) to maintain both CMake and Makefile and keep them in sync?

 (2) force all the Git developers (not users or binary packagers)
     start using cmake and abandon Makefile, and let CMake generate
     Makefile?

 (3) something else?

Given that bootstrapping CMake typically takes a working "make", by
definition, if you drop Makefile from our shipped source tree, the
audience you can support on minority platforms would be smaller than
what we have.  It is not negotiable that we keep Makefile as a valid
way to build Git, and the Makefile must be tweakable for those on a
minority platforms when things do not go the way they want to (the
tweakability is most needed on minority/exotic platforms).

W ith either (1) or (2) above, I have a feeling that engineering
burden to divert resources to add cmake support (with sustainable
plan to keep "fixable/tweakable" Makefile that is in sync) alone
would already be high enough.  It is unclear the reason why we want
to pay all that cost---to gain what?  Other than to make those who
like CMake feel happier, that is.

I do not want to sound overly negative in my first response, but you
might thank whoever says "no" early before you invest too much time
on this topic, so I'll send the above before even reading these 8
patches.

Thanks for your interest in the project.

