Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F4AF1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 17:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754072AbcHWRZk (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 13:25:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58019 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753912AbcHWRZj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 13:25:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5A3835DC0;
        Tue, 23 Aug 2016 13:25:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gzrl/hlpbiT3TNgJVAbS21XbhYA=; b=PFypv5
        0Xwor2I+U2YUdJzUFsZTRvdX2vULmLCxdwPxP0N0yUUqgb4NN28ttyjsdaox3lSG
        VLAbcOr+1N7h+O5IM7l3Qs7JegZhBv2+6Rxrdy40iEWQ3JZqzyo5MIwMAQRoZK4w
        Dr0d/lwQuExTvwYBqKZMHU9X7RlNVvZYqFSLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o/cRxUufTobMWQGy7SpQ1kGDP2qgvAfM
        srquLrnjWPvSqSUpHzNCklMbNM1QkWsrhyYSSHxmjG+evwlN1tsBSzBv0zdfYt6Q
        TPZDcq/Mo2DOY23Q01DtCNINc7RpHU2TDnuBcGqtAP2KfCAqjxY5pdxXQ6GtowvH
        /UiFR054tHg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E94F35DBF;
        Tue, 23 Aug 2016 13:25:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E84A35DBE;
        Tue, 23 Aug 2016 13:25:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v10 0/9] submodule inline diff format
References: <20160822234344.22797-1-jacob.e.keller@intel.com>
        <CAGZ79kbKibe2RpQ9QWN1naY07feZLKbhc+dts3BD-4+y-pUOVw@mail.gmail.com>
Date:   Tue, 23 Aug 2016 10:25:35 -0700
In-Reply-To: <CAGZ79kbKibe2RpQ9QWN1naY07feZLKbhc+dts3BD-4+y-pUOVw@mail.gmail.com>
        (Stefan Beller's message of "Mon, 22 Aug 2016 18:00:56 -0700")
Message-ID: <xmqqlgznwg6o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B1FA5C0-6956-11E6-85F8-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Mon, Aug 22, 2016 at 4:43 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> A few suggestions from Stefan in regards to falling back to
>> .git/modules/<path> being a bad idea. I've chosen I think to avoid using
>> die() as we just stick with the current path if we can't find its name.
>
> Which makes the existing bug more subtle :(
>
>> I think this should be safe since we already do this today.
>
> It's a bug today already. Thanks for spotting!
>
>> The new flow
>> only changes if we are able to lookup the submodule, so I don't think
>> it's worth adding a die() call.
>
> Well this series improves the buggy-ness as it is only buggy when the name
> is not found, and we fall back on the path.

I am not so sure about that.  If there is an existing place that is
buggy, shouldn't we fix that, instead of spreading the same bug
(assuming that it is a bug in the first place, which I do not have a
strong opinion on, at least not yet)?

Can there be .git/modules/<foo>/ repository that is pointed at an
in-tree .git file when there is no "name" defined?  I thought we
errored out in module_name helper function in git-submodule.sh when
we need a name and only have path (I just checked in the maint-2.6
track); did we break it recently? submodule--helper.c::module_name()
seems to error out when submodule_from_path() fails to find one and
will segfault if it does not have name, so it is not likely.


