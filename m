Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98F84208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 18:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbdHOSaR (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 14:30:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61877 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751949AbdHOSaR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 14:30:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ADCEBA4E55;
        Tue, 15 Aug 2017 14:30:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IiFKbSVcbJtga+4aahjE4S5Ui9o=; b=o/tj7D
        uKMfPLpuS4T0sFQZf4Z2IMOy6Vt27bt1i0lmZ5kp2NvhM43ngWKd78GLh/Xaagf9
        oCzoXyLvvFp37CPQbQyzX4itAAQSYAWYwj/B5Uq2AwSXY8ygJABKc2dwiUfCMa8U
        olG98TbfLufswyi6Pbi0rubGb7WmyjGj7kYjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EqQ/jBTOwsn1c0i21i5NzqVKGopYwfwM
        yeL2BQ6R/0TGUEhbnUjsXsddFOemFXd5rhCi5ZHIb3PFkm+RQwAbdw1XJnma/6+q
        4VzepWj57f70af1XxsP/0R6eMYuJjH6E175yZGQ/cWxvYf99NuObFnnp9A7yo0Uv
        iUZj/ggzcwY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A6A59A4E53;
        Tue, 15 Aug 2017 14:30:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B09AA4E52;
        Tue, 15 Aug 2017 14:30:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 5/5] commit: rewrite read_graft_line
References: <cover.1502796628.git.patryk.obara@gmail.com>
        <cover.1502796628.git.patryk.obara@gmail.com>
        <ee8edaf08864d5983ff1a5150077d29a4ee17796.1502796628.git.patryk.obara@gmail.com>
Date:   Tue, 15 Aug 2017 11:30:14 -0700
In-Reply-To: <ee8edaf08864d5983ff1a5150077d29a4ee17796.1502796628.git.patryk.obara@gmail.com>
        (Patryk Obara's message of "Tue, 15 Aug 2017 13:49:06 +0200")
Message-ID: <xmqqo9rgr8eh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C893329C-81E7-11E7-809D-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patryk Obara <patryk.obara@gmail.com> writes:

> The previous implementation of read_graft_line used calculations based
> on GIT_SHA1_RAWSZ and GIT_SHA1_HEXSZ to determine the number of commit
> ids in a single graft line.  New implementation does not depend on these
> constants, so it adapts to any object_id buffer size.

I am not sure if this is a good approach.  Just like in 2/5 you can
use the MAX thing instead of 20, instead of having each graft entry
allocate a separate oid_array.oid[].

Is this because you expect more than one _kind_ of hashes are used
at the same time?

