Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50739C2D0A3
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 19:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0275A2231B
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 19:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mcl31AUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbgKPT0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 14:26:43 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53799 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729819AbgKPT0m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 14:26:42 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EBCE6F47E6;
        Mon, 16 Nov 2020 14:26:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GOPcahheaKbxc/M/K/rdaDtYzic=; b=Mcl31A
        UzpZyeAKMhs2nsiTX/2e0iYoybsmvWYcCRxyHxhJYEf+WYJ0/P2+FjCFlKlLB2DA
        oZVEroXgGToIRI2K1Cr16EV1d3mK+AH0qCXtXfaK+94NvTLeO7zlcLTwBO9ikPYu
        j9vFX17pL8J3J8WSWJacuoQNl3+glibyIpR9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yNYmjCDNVFFW9clpi+4vdAtDwHoESg8J
        gdx3SKa5nJQnnSTNEk3letquxikTHOIAkRn/yw5ufzmDPTVj2yMglle/qR8wf9ks
        bOCOnwvFFfCeCbxQzC4T16brzxHnmtDr6CC89j+xA990O5MlEBgt/47qnQoAizMH
        3HeWLtte78Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E43DDF47E5;
        Mon, 16 Nov 2020 14:26:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 33548F47E4;
        Mon, 16 Nov 2020 14:26:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ryan Zoeller <rtzoeller@rtzoeller.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Specify resume point with git difftool?
References: <gOXOaoqn-E9A2ob7ykWEcDc7ZxmSwAjcP5CCFKfr5ejCOWZQ1lfAUZcbgYT9AyQCcDgJvCrnrtziXiels-Hxol3xlkGTVHk24SvAdaSUtKQ=@rtzoeller.com>
Date:   Mon, 16 Nov 2020 11:26:36 -0800
In-Reply-To: <gOXOaoqn-E9A2ob7ykWEcDc7ZxmSwAjcP5CCFKfr5ejCOWZQ1lfAUZcbgYT9AyQCcDgJvCrnrtziXiels-Hxol3xlkGTVHk24SvAdaSUtKQ=@rtzoeller.com>
        (Ryan Zoeller's message of "Mon, 16 Nov 2020 16:45:02 +0000")
Message-ID: <xmqq36199k7n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5A94448-2841-11EB-B2AD-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ryan Zoeller <rtzoeller@rtzoeller.com> writes:

> Is there a way to tell git "resume the difftool process at file n"?
> The difftool prompt counts which file I'm on ("Viewing (10/20):
> 'filename'"), so it seems like I ought to be able to jump ahead by
> specifying a starting index (or range to view).

There is no such support in the code.

diff.c::run_external_diff() maitains and increments the counters
used to show the prompt in the form of a pair of environment
variables, GIT_DIFF_PATH_TOTAL and GIT_DIFF_PATH_COUNTER, and they
are used in git-difftool--helper::launch_merge_tool() when asking
you if you want to run the difftool backend on that 10th file out of
the 20 files.

Right now, you can only say Yes or No to that prompt, but it
shouldn't be too hard to add another choice to the response to the
prompt, saying "skip to 15th file", for example, and record that
"15" in a temporary file in $GIT_DIR/ and exit without running the
difftool backend on the 10th file, so that later invocation of the
git-difftool-helper script can skip without prompting you until it
is the turn for 15th file.

The launch_merge_tool() function needs to be modified in the
following way to do so:

 - At the beginning, see if $GIT_DIR/difftool-skip-to file exists.

   - If exists, read its contents.

   - See if the value is larger than $GIT_DIFF_PATH_COUNTER.  If so,
     just 'return' without doing anything else.

   - Remove that file (we are at the 15th path and done skipping).

 - Update the "Viewing .../ Launch?" prompt and offer another choice
   "Skip to?".

 - Update the if/then/fi statement that processes the answer to the
   prompt (right now, it takes n as a sign to skip the file).  When
   the user says "skip to 15th", create $GIT_DIR/difftool-skip-to
   file and record "15" in it and 'return'.

#leftoverbits.





     

