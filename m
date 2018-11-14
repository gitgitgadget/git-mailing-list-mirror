Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A94631F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 14:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733170AbeKOBDZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 20:03:25 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58160 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731585AbeKOBDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 20:03:25 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B89242CF88;
        Wed, 14 Nov 2018 09:59:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fgmQIm29g9BYH00tfMFE6jWhm30=; b=wenbdo
        5/iS6mPczGNZjTqdhRMe3QZFLLbLUSxYx5udDZJKmBKYZzbPya3OnbgE7MF4oEfX
        wNbJhxJ8f+0jGpSM0OjCeJgCMne8HYujqPNESBQ2Cf5vbCnkzowNeuy+CPFwlc2X
        okr2TXH7kwKHq9gXqcau9TPGrywYd2DwHRHe0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m+aFmRG55gjTi58lO/52+N/eoZGzO965
        oec/U4X3qtPglmVK5ap5iVMAoOQKjL246xhz1ggmUeF+QUilZxrNnGyZLPf1bsqi
        OR8y6sPW1sCd5HpsgG2ZXF6HzjfgSdkEswGaOra1bYVS1XQuSgP/hoUazu2b45VB
        7HfCfSKSZ5U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B1E892CF87;
        Wed, 14 Nov 2018 09:59:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BF6BE2CF85;
        Wed, 14 Nov 2018 09:59:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/5] tests: respect GIT_TEST_INSTALLED when initializing repositories
References: <pull.73.git.gitgitgadget@gmail.com>
        <948b3dc146fe353fbab6057c1376fa0e787a444f.1542030510.git.gitgitgadget@gmail.com>
        <xmqqin10p8aq.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1811141413170.39@tvgsbejvaqbjf.bet>
Date:   Wed, 14 Nov 2018 23:59:43 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1811141413170.39@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 14 Nov 2018 14:16:37 +0100 (STD)")
Message-ID: <xmqqa7mbn1r4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ECB8296E-E81D-11E8-9049-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It would make sense, but we don't know how to get that information, do we?
> ...
> And changing the code *now* to let us query Git where it thinks its
> templates should be won't work, as this patch is about using the installed
> Git (at whatever pre-compiled version that might be).

It won't work, but we can add something like "git var templatedir"
to help those who want to further improve the test-installed mode
next year, preparing for better future by sowing seeds now.

In the meantime, using the same temlate dir as before is probably
the best we can do.  Two and a half tangential thoughts are:

 - But then, we need to make sure $GIT_BUILD_DIR/templates/blt/
   is populated, if we do rely on them (i.e. we probably want to
   make sure we have built).

 - Yet, once installed, the contents of the templatedir can be
   arbitrarily munged by the end user, so anything that depends on
   what is in the template won't work as a reliable test piece.

 - Among what's in templates/blt/, we explicitly disable hooks at
   the beginning of the test repository creation to ensure no hooks
   interfere what we test by default, but we will get affected by
   what is in info/excludes.  The contents of freshly-built one is
   empty, so it is unlikely that this will cause problems, but if we
   use installed templates, we cannot control what's in there,
   letting the tests get affected to random things the end-user
   happens to have.

So after all, if we were to change anything, it might make better
sense not to install anything from any templatedir.

But of course, that is orthogonal to the test-install mode.  If we
want to make the test more robust by emptying the templates, we
should do that also for the test-freshly-baked mode, too.
