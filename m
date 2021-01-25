Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BDBC433E0
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B77B227BF
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732510AbhAYXFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 18:05:50 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59060 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732590AbhAYXEv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 18:04:51 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4364D10AA52;
        Mon, 25 Jan 2021 18:04:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SWQNEL2jEoYvxgGFMJIyNvcnWB8=; b=lZn+IA
        8kQtyCFna2+9gRsazV9grQ6i0G6UPPjio5JvqOP86tYD4ib2LI2HHKwypzD9d9g9
        dBfm/Cw3q5yzhZ5TT9+evAM0kUXfPWB6l7Iey1Qy3QlVp19LAQR/4zDSVeoKPOLA
        Lu+RNIvX+XlXJM9mZsL1JWT6xcEwofkmgHtkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rP4Xb7WBBC+hXFu6qKjSiuyNGdDXPYJq
        +76+3Kfodhd/2GjR1UEoGe+iVJItb5xlrpyUP6HbTbv2unjeBNL1sFlvtH+lFm9C
        mWPRjFsjg6fjY17OXG/m2dWNhweAgX7dZDPALeNvRyTCodaSvUnPruqOgaHCzzY+
        5tS3MNLurBI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3AD0610AA50;
        Mon, 25 Jan 2021 18:04:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6E0FE10AA4C;
        Mon, 25 Jan 2021 18:04:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicholas Guriev <nicholas@guriev.su>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/4] difftool-helper: conciliate difftool.tabbed and
 difftool.prompt settings
References: <20210118210003.3071205-1-nicholas@guriev.su>
        <20210125212132.894458-1-nicholas@guriev.su>
        <20210125212132.894458-3-nicholas@guriev.su>
Date:   Mon, 25 Jan 2021 15:04:01 -0800
In-Reply-To: <20210125212132.894458-3-nicholas@guriev.su> (Nicholas Guriev's
        message of "Tue, 26 Jan 2021 00:21:30 +0300")
Message-ID: <xmqqa6swy5y6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E258982-5F61-11EB-8382-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicholas Guriev <nicholas@guriev.su> writes:

> The commit combines paths of compared files into a separate temporary
> file and prints them before launch the tool on last invocation of the
> helper. All temporary files will be removed before exiting after that.
> At least, we try. But it may happen the files remain in case of a bug
> or a random SIGKILL.
>
> Signed-off-by: Nicholas Guriev <nicholas@guriev.su>
> ---

Isn't the introduction of prompt_before_launch etc. would be a
welcome change before step [v3 1/4]?  If it makes a pure improvement
of the existing code without adding any new/additional feature like
the "tabbed" stuff, it would be better be discussed before anything
else in the series.

Then the new "tabbed" stuff can take advantage of the cleaned up
code with the new helpers---the patch that introduces the feature
will become more concise and easier to follow, I would think.

If I am reading the patches right, [v3 1&2/4] goes the other way
around: "let's add a new feature first in an ad-hoc way.  ah, it
seems that the code added for the new feature can be simplified if
we tweak a few things, and while we are doing so, we can adjust old
feature to use the same simplification again".

Regarding what [v3 1/4] does (which if we follow thru the above
suggestion would become [v4 2/4]), I am not sure that we want to add
'if tabbed mode, do this, otherwise do that' to run_diff_cmd.  It
would become awkward to keep piling such a change on top in the
function in the longer run.  I am wondering if each mergetool can
override run_diff_cmd as a whole, when it is dot-sourced to set up
itself.  The logic you added inside is_difftool_tabbed in [v3 1/4]
would probably need to be made available to the dot-sourced backends
so that they can just call something without reimplementing the same
logic, but by doing so, diff_combo_supported would become unneeded.
Tools that do not support the "combo" mode just do not have to do
anything.

But such a change would become easier to review if we do restructure
like this [v3 2/4] does earlier in the series _before_ a new feature
gets introduced.

Thanks.
