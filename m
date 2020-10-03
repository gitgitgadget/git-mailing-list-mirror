Return-Path: <SRS0=BObu=DK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491ADC4363D
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 04:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D55F120738
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 04:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="saC7CESg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgJCEme (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Oct 2020 00:42:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64084 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJCEme (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Oct 2020 00:42:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B4FF6EE8BF;
        Sat,  3 Oct 2020 00:42:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GnP1MIam+RMtILV/fOXr6cVtjTM=; b=saC7CE
        SgB4Z/CR5jYwFBg8l6NsLGp5ywDgzEi+0kH4jprDYXTSGzIRW+dOZLzawuuLFDU0
        H+qtvIJCqTmv7he+LGDzVEp4TjTDV3Qbjmrow4/qKGCBhKKUDKzvF7ErWMYJgprG
        vnvydcKaOcZnxjr2O9TgVil7iF0JOLYRMuG/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LZeJTlmisVS4DsxIFZR9twocfBLcjE/j
        OsSrzSTMjc5m0+uUHMs2MxxyBFDpZzoMYeoOnJJpBzSo6+Qgw6bzKkhHSKLgZbkz
        NJYpb1ToqAbOPAj/Qga2AkBLxxHNLlNZy9KjN29API18tZr+n0O43bNGCYAy4ThH
        BaoMFixgsIA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AD39FEE8BE;
        Sat,  3 Oct 2020 00:42:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D6DA8EE8BC;
        Sat,  3 Oct 2020 00:42:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shengfa Lin <shengfa@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, nathaniel@google.com,
        rsbecker@nexbridge.com, santiago@nyu.edu
Subject: Re: [RFC PATCH 0/1] adding user.hideTimezone for setting UTC timezone
References: <xmqq8sco8era.fsf@gitster.c.googlers.com>
        <20201003035050.151766-1-shengfa@google.com>
Date:   Fri, 02 Oct 2020 21:42:27 -0700
In-Reply-To: <20201003035050.151766-1-shengfa@google.com> (Shengfa Lin's
        message of "Sat, 3 Oct 2020 03:50:50 +0000")
Message-ID: <xmqq4knb9az0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D79F1644-0532-11EB-B443-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shengfa Lin <shengfa@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> If we have a setting of "core.recordTimeZone", do we need to make it
>>> as a command option as Junio suggested earlier?
>>
>> Usually we add command line option --[no-]record-time-zone first
>> without configuration option when introducing a new features like
>> this one.  Once the feature proves useful, we'd add a matching
>> configuration variable for convenience, but leave the command line
>> option (negative form in this case) so that a configured per-user
>> default can be overridden as needed.
>
> Any recommendation as to where to add this command line option?
> Should the option be added separately in "git merge", "git rebase",
> "git commit", "git pull" and other places as OPT_BOOL?

I think that would be most end-user friendly.

> Or could it be added directly to handle_options in git.c?
> If added to git.c, it will only be added it once.

That would be easier for lazy developers, but not as end-user
friendly as giving it to individual commands, I would think.

> Then an environment variable(such as GIT_RECORD_TIME_ZONE) can be added
> to save the option and datestamp in date.c can set offset accordingly.

We prefer not to use new environment variable unless there is a
clear advantage.  Consider GIT_DIR etc. that were added early in
Git's history as historical mistakes.
