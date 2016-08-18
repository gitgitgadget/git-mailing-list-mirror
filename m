Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAFB6203E2
	for <e@80x24.org>; Fri, 19 Aug 2016 01:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754648AbcHSBFT (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:05:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61486 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754027AbcHSBFR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:05:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E6CA536345;
        Thu, 18 Aug 2016 16:49:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Nq0/mz+BzomvIQDx+cCOgxfFqeI=; b=DiZCSj
        chCDjqHbEmV9spm3+t0wBptrOOwLFg9jjY9ImVJpZpdwUEhfJSiuUrkLdvmCM5eh
        1/WBhujsHJgWmL6RSt7N5n+u9jx0TD1GiRpV1pw7YK1ZFBsGQfr+XTMflqkeAxsB
        /R7hPA8pdVZzgEMlRpLOhZTHgo/irntPBmYLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AAGKfwck4swTQSidkHmP2O+Z5RiaBRpY
        oFrDSAVofRB7xPIbKyANY5JIdHxB0s+80Iq5kjuEhFg/rVR3VGMEnNcIs0ZTOwrL
        YHDNPJXuVLgNAOtueFRq7sjNbM5DOTSCOCYBXfGThmtJ39h8FwLREncKd8IEYT5L
        bfw68Mpp8Y8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DEED936344;
        Thu, 18 Aug 2016 16:49:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6A4EC36343;
        Thu, 18 Aug 2016 16:49:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v7 6/7] submodule: refactor show_submodule_summary with helper function
References: <20160818005131.31600-1-jacob.e.keller@intel.com>
        <20160818005131.31600-7-jacob.e.keller@intel.com>
        <CAGZ79kaFfrVwe+JXVJBBZVPn=mTv7F1db8T1ZzXEaMtZKoupQA@mail.gmail.com>
        <CA+P7+xrNzc-+KBdu20QpEcCJ_udYUUk=qQyDi26YoOyCwrPXiQ@mail.gmail.com>
        <CAGZ79kZp+fhB-APx+zSAyYYiLq0pinDZOS1s33a7OjckJOi5=A@mail.gmail.com>
        <CA+P7+xqQ-iaax3rtZbsGb6D4vBbwP7d63Qq4D2_z71V0Z4YCeg@mail.gmail.com>
Date:   Thu, 18 Aug 2016 13:49:25 -0700
In-Reply-To: <CA+P7+xqQ-iaax3rtZbsGb6D4vBbwP7d63Qq4D2_z71V0Z4YCeg@mail.gmail.com>
        (Jacob Keller's message of "Thu, 18 Aug 2016 13:44:09 -0700")
Message-ID: <xmqqbn0p6bvu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 417C8B66-6585-11E6-8A8F-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

>>>> If we were to change those, we could discuss if we want to go with
>>>> full sentences
>>>> all the time:
>>>>
>>>>     submodule is new
>>>>     submodule is deleted
>>>>     submodule is not initialized
>>>
>>> I agree, I'll make a new patch that does this as a cleanup prior to
>>> this re-work.
>> ...
> Sorry for being unclear myself, too. I'm keeping it as "not
> initialized" and updating the description of the patch that changed it
> from "not checked out" to "not initialized"

Whether it is done inside or outside the scope of this series, the
other two "is new"/"is deleted" updates look very sensible ones to
make in the longer run.  I'd further suggest to unify "commits not
present" and "revision walker failed" into one error class.  From
the end user's point of view, they aren't very different.
