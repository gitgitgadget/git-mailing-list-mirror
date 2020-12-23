Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C913EC433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 21:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F82922473
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 21:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgLWVAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 16:00:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54549 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgLWVAo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 16:00:44 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 37A38118F05;
        Wed, 23 Dec 2020 16:00:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+1tLS2SXNeMhEdfDhLmdxQejiv0=; b=tQcd1W
        29dOo6QC9QoTPptulCxV4KyLabCOxPJFkxpXYPMzKp6jk/597BhHi+n4rCRI1SZn
        qNSvU/bK5PDam9/3hVqor/Qa84tsidTBsbFzZ8fszlp+5Afba6YlhBLrk6XK53kJ
        uEdtcYq8n9dhMPIp61DqQo+CzA/QIIOi8a01Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fri5MnJD4rMrQhPBZ61xgMmLqUDFVMwT
        /UAtOWkvY9hLY4P2C/d9obmWJXDxizrHtOACY+W1p0J20qDCPU25AzyjlKjPprv+
        BtdiRMg0PKLq3k9mdjblm7eDtarKZIrnVy5/xu3cIMySzC1V3j2IkmtzKrzlQx0a
        7gEU7moQIFY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 304CC118F00;
        Wed, 23 Dec 2020 16:00:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3C6C5118EED;
        Wed, 23 Dec 2020 15:59:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2020, #04; Tue, 22)
References: <xmqqo8ilhafa.fsf@gitster.c.googlers.com>
        <X+L14/K8OI1Epa20@tanuki>
Date:   Wed, 23 Dec 2020 12:59:57 -0800
In-Reply-To: <X+L14/K8OI1Epa20@tanuki> (Patrick Steinhardt's message of "Wed,
        23 Dec 2020 08:46:43 +0100")
Message-ID: <xmqqh7oc6xwy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D16C5772-4561-11EB-AD54-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Dec 22, 2020 at 12:07:21PM -0800, Junio C Hamano wrote:
>> * jk/disambiguate-equal-in-config-param (2020-12-09) 3 commits
>>  - config: store "git -c" variables using more robust format
>>  - config: parse more robust format in GIT_CONFIG_PARAMETERS
>>  - quote: make sq_dequote_step() a public function
>>  (this branch uses ps/config-env-pairs.)
>> 
>>  The quoting rules used to pass "git -c var=val" configuration
>>  across processes have been updated in a backward compatible way, so
>>  that the value read from an environment variable can contain an
>>  equal sign when using the "git --config-env var=env" feature.
>> 
>>  We may want to make this just a middle part of the
>>  ps/config-env-pairs topic with a bit of patch shuffling.
>
> Please note that this has already happened with v5 of my patch series
> [1], which I've sent out last week. So you may want to swap out those
> two series and use the combined v5 as it also improves documentation.
>
> [1]: https://public-inbox.org/git/cover.1608104755.git.ps@pks.im/

I'll re-read the series.  I somehow had an impression that it had
these three patches at the end (as Peff originally organized by
posting them on top of all of yours) and placed them on backburner.

Thanks.
