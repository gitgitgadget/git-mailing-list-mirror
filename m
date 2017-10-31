Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 222B220281
	for <e@80x24.org>; Tue, 31 Oct 2017 04:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbdJaElO (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 00:41:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58323 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751119AbdJaElN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 00:41:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 031B8AA6F7;
        Tue, 31 Oct 2017 00:41:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fc9IKV+nrTPHyPl0Ij6X32flDLY=; b=abvioU
        3P3mOhHwbi6XYtCQdlbQ1eOSu4WZLBZwly79JKZp2x13gfftuPj53NJ4qd38jRCQ
        TCBue4idqSELh3hNntvtJrGELvmiUXjsFkyAfD4XVi/6XLPJS9P+NJ4/0XXEq5Hn
        /+Mi9OiItQl4hspaT8sY269c4DmTuaF4K+HIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dgyO/0bc9x1Anpb7QgFssARrP1IZ8NGU
        3AzLl9k4erC3IK5MIE8HIpXsveprDQ1mF8L/Gk85lQLXBBukeYkATfSh96u3Q4r3
        nhkDh23xiiEk6srivvNB+OFAQ+nj684O7HjarDYc7eoiafzNnP1fhheHchSGXJdm
        MeHOjQe5i8Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EEBDDAA6F6;
        Tue, 31 Oct 2017 00:41:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 65FCBAA6F5;
        Tue, 31 Oct 2017 00:41:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v2 2/4] diff: convert flags to be stored in bitfields
References: <20171027222853.180981-1-bmwill@google.com>
        <20171030194646.27473-1-bmwill@google.com>
        <20171030194646.27473-3-bmwill@google.com>
Date:   Tue, 31 Oct 2017 13:41:11 +0900
In-Reply-To: <20171030194646.27473-3-bmwill@google.com> (Brandon Williams's
        message of "Mon, 30 Oct 2017 12:46:44 -0700")
Message-ID: <xmqq8tfs2al4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8DF0480-BDF5-11E7-A95D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> +	if (flags)
> +		rev.diffopt.flags = diff_flags_or(&rev.diffopt.flags, flags);

If we are avoiding from passing a struct (even if it is a small one)
by value, then returning a struct as value defeats the point of the
exercise, I would think.  If that will be the calling cconvention,
making diff_flags_or(&a, &b) to update &a by or'ing bits in &b would
be more natural.

Having said that, as I said in a separate message, as long as we
have this _or() thing, no sane person would add anything but
bitfields to the structure which will guarantee that it will stay to
be small set of flags and nothing else---so I personally am fine
with pass by value (which in turn makes it OK to return as a value,
too).

Other than that, this step looked reasonable to me.

Thanks.
