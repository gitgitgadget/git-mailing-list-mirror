Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9223C20958
	for <e@80x24.org>; Sat,  1 Apr 2017 19:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbdDAT0d (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 15:26:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54121 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751804AbdDAT0c (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 15:26:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D70426BF0F;
        Sat,  1 Apr 2017 15:26:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x8xRW3PRZD4r1mIPhg/9E3C1O2w=; b=UaFcyS
        PgbyOeDLCfBaxUSJ5cCm59wxn4KHkh4wAH+7XiFkmsuk6J9l8ho7g6pd8vj5+bUz
        HOas8vAArMvQwon4D9+Y6Zt5aRfIchMoo/Uz4skTLPWvtPKGIuqJNOcHar9riIn6
        DOdI/RoZBOC8e5t8WfVLPKrcGXIx4w2NWBDXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jQgEWFYisZk+QK+g1DZ8+bRvDRRlVKd5
        CYCPFexKJl+vd4l5FwHL7pOPEuz7zrCi5CtL64S5kU2Wq/s5Cpc8S1w1tRAWfEk7
        EFA/6cjVfEiohObbOFrQ9LoEGyUI50bZJxfAeAb7g3Wt8aI4BNlCpjGrR25fJnwr
        Hi491F7ZeR4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D01056BF0E;
        Sat,  1 Apr 2017 15:26:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1F0846BF0D;
        Sat,  1 Apr 2017 15:26:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation: make 3-way merge warning more generic
References: <20170401133124.10479-1-sandals@crustytoothpaste.net>
Date:   Sat, 01 Apr 2017 12:26:29 -0700
In-Reply-To: <20170401133124.10479-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 1 Apr 2017 13:31:24 +0000")
Message-ID: <xmqqpogwszdm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C198A70-1711-11E7-BD80-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>  With the strategies that use 3-way merge (including the default, 'recursive'),
> -if a change is made on both branches, but later reverted on one of the
> -branches, that change will be present in the merged result; some people find
> -this behavior confusing.  It occurs because only the heads and the merge base
> -are considered when performing a merge, not the individual commits.  The merge
> -algorithm therefore considers the reverted change as no change at all, and
> -substitutes the changed version instead.
> +only the heads and the merge base are considered when performing a merge, not
> +the individual commits.  This means that if a change is made on both branches,
> +but later reverted on one of the branches, that change will be present in the
> +merged result; some people find this behavior confusing.  The merge algorithm
> +considers the reverted change as no change at all, and substitutes the changed
> +version instead.

I agree that it makes sense to say 3-way merge considers only three
points upfront.  

I do not think "this means" is helpful to the readers, though.  Drop
"This means that" and instead rewrite the remainder of the paragraph
after "present in the merged result", perhaps?

	If a change is made on both branches but later reverted on
	one of the branches, the net effect the branch that reverted
	the change has to the project is nothing, while the net
	effect of the other branch is to make that change.  The
	3-way merge, i.e. "if one branch did something while the
	other branch didn't do that something, merge result is to do
	that something", rule keeps the change in the merge result.

We do not need to say "some people find this confusing" buried in a
long paragraph, which would not even serve the purpose of attracting
readers' eyes by shouting "THIS MAY BE DIFFICULT, PAY ATTENTION".
The last sentence in the original (and your version) only repeats
the same thing without saying what the real 3-way merge rule is, and
I think a rewrite like the above that makes it more explicit is
easier to understand.


