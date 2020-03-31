Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FC2C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 00:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B4020771
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 00:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgCaAAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 20:00:35 -0400
Received: from mx.sdf.org ([205.166.94.20]:57005 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbgCaAAf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 20:00:35 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02V00KiI025915
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Tue, 31 Mar 2020 00:00:20 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02V00KI4010913;
        Tue, 31 Mar 2020 00:00:20 GMT
Date:   Tue, 31 Mar 2020 00:00:18 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Philip Oakley <philipoakley@iee.email>, lkml@sdf.org
Subject: Re: Feature request: rebase -i inside of rebase -i
Message-ID: <20200331000018.GD9199@SDF.ORG>
References: <20200320223015.GA19579@SDF.ORG>
 <xmqq36a2bpxz.fsf@gitster.c.googlers.com>
 <20200320233528.GB19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003211135380.46@tvgsbejvaqbjf.bet>
 <20200321175612.GC19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003252008490.46@tvgsbejvaqbjf.bet>
 <20200326001821.GB8865@SDF.ORG>
 <nycvar.QRO.7.76.6.2003281510260.46@tvgsbejvaqbjf.bet>
 <20200328163024.GA26885@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328163024.GA26885@SDF.ORG>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thinking about Philip Oakley's suggestion, it dawned on me that
we can *already* do a nested rebase manually, and having a less
manual alias for the procedure would be reasonable.

Suppose the last four commits are O-A-B-C, and whether they were created 
by this rebase or existed before is irrelevant.

If I want to rebase --nested -i O, then I --edit-todo and
prepend the following four lines:
reset O
pick A
pick B
pick C

If a nested rebase command does just that, I think it would cover my
use case.  If it adds a comment saying "nested rebase ends here",
it's easy to cancel the nested rebase if there was a mistake.

A slightly fancier thing a nestrd rebase could do is see if any of the 
newly created picks are also used in merges that were already in the todo 
list.  In that case, follow the pick by a label command and update the 
later merge to refer to the label.
