Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C94F1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 05:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfJBFlT (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 01:41:19 -0400
Received: from albireo.enyo.de ([37.24.231.21]:42744 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbfJBFlT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 01:41:19 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iFXO1-00053w-FK
        for git@vger.kernel.org; Wed, 02 Oct 2019 05:41:17 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1iFXO1-0002dl-CP
        for git@vger.kernel.org; Wed, 02 Oct 2019 07:41:17 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     git@vger.kernel.org
Subject: Re: git mailinfo with patch parser
References: <87imp77o5k.fsf@mid.deneb.enyo.de>
        <xmqq1rvvhfq2.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 02 Oct 2019 07:41:17 +0200
In-Reply-To: <xmqq1rvvhfq2.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 02 Oct 2019 14:35:33 +0900")
Message-ID: <878sq366wy.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Junio C. Hamano:

>> Is there a way to get the patch data, as parsed by git apply or git
>> am, and dump it back in patch format, without actually applying the
>> patch to a working tree?
>
> So, "the patch data as used by apply" is what you get from mailinfo.
> If it is a patch that applies to what you have in the working tree
> and/or the index is something you can/must ask "git apply".  IOW,
> when "git mailinfo" stored in $GIT_DIR/rebase-apply/patch the
> "remainder" of the message, you could
>
> 	git apply --check [--index] $GIT_DIR/rebase-apply/patch
>
> to see if it is an OK patch.  If it is, then there is no need to
> further "dump it back in patch format"; what you just fed to "apply
> --check" is already in the patch format.

Yes, but that requires a fully patched up Git repository containing
the right blobs.

We know from experience that it is easy for humans to misread patches
and fail to notice that certain patch hunks are actually ignored by
git apply and similar tools.  If there was a way to feed the patch
through the parser and serialize it back, these discrepancies would be
more noticeable, I think.  Any data ignored by git apply/git am would
be missing from the output.
