Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2410B207BC
	for <e@80x24.org>; Wed, 19 Apr 2017 05:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760060AbdDSFcQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 01:32:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53744 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1760057AbdDSFcN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 01:32:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CFF5985368;
        Wed, 19 Apr 2017 01:32:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=1TXqiAk2W+joJLDqf1HOssQPA
        WQ=; b=CsU0C7WC4SFPaqRrRl3mGso6bTVDi6pqUgzUB7IQGEGjpkZAcYJqyoLNS
        we/lUTNoHwwDBbBrUBAxqa2MgaweGr0VTjtnLE8hO+fSQpQ8hRsaoPyWQOtmB1HR
        Gvw0oKo+Ag+ped+nmG/Av5kKMTxyG4boTubGcrVnPQNgBoUh00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=hhv+AfA2CYP1LaOOQX/
        kLqblAw9s0Qtp9sBZU1BEOupAq+HI+0iYITxVp411LqRgDP48VvfMIeFQ6DBSsXh
        qdlSza0ITwH6BPUHtcVCjrgXl2MMHPUNvCwgh+/xyXYTRWOdYqoMFpOsiGD88N6l
        oNXrAa8ZITIhUAM4/nWDRB2U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C85AA85367;
        Wed, 19 Apr 2017 01:32:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 39F4285366;
        Wed, 19 Apr 2017 01:32:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] clone: add a --no-tags option to clone without tags
References: <CACBZZX584QwjphGfEgTn2V9P0yVkYSxfE1_Gp96bno8186SDyA@mail.gmail.com>
        <20170418191553.15464-1-avarab@gmail.com>
        <xmqq60i1dvnk.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 18 Apr 2017 22:32:09 -0700
Message-ID: <xmqq1ssparom.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8983D94A-24C1-11E7-8330-C260AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Add a --no-tags option to "git clone" to clone without tags. Currently
>> there's no easy way to clone a repository and end up with just a
>> "master" branch via --single-branch, or track all branches and no
>> tags. Now --no-tags can be added to "git clone" with or without
>> --single-branch to clone a repository without tags.
>
> Makes sense.
>
>> +--no-tags::
>> +	Don't clone any tags, and set `remote.origin.tagOpt=3D--no-tags`
>> +	in the config, ensuring that future `git pull` and `git fetch`
>> +	operations won't fetch any tags.
>
> OK.  Not just we ignore tags during the initial cloning, we set
> things up so that we do not _follow_ tags in subsequent fetches.

I somewhat doubt the utility of this change.  "--single-branch"
already refrains from grabbing all the tags, and the tags it grabs
when "clone" runs and also in subsequent "fetch" are only the ones
relevant to that branch.  When a user is fetching say 'maint', it is
very likely that the user wants tags that are reachable from the tip
of 'maint' (if only to make the tip of that branch describable),
even though the user would not care about the tags on the other
branches that are ahead of 'maint'.

It is not that much code, and carrying it is not that much burden,
but I am reasonably sure that I won't use it myself.



