Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40722C2BA2B
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 23:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D2820857
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 23:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgDPXGG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 19:06:06 -0400
Received: from nef2.ens.fr ([129.199.96.40]:32981 "EHLO nef.ens.fr"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbgDPXGF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 19:06:05 -0400
X-ENS-nef-client: 129.199.129.80
Received: from phare.normalesup.org (phare.normalesup.org [129.199.129.80])
          by nef.ens.fr (8.14.4/1.01.28121999) with ESMTP id 03GN5t1F031090
          ; Fri, 17 Apr 2020 01:05:55 +0200
Received: by phare.normalesup.org (Postfix, from userid 1317)
        id 1344AE0633; Fri, 17 Apr 2020 01:05:55 +0200 (CEST)
Date:   Fri, 17 Apr 2020 01:05:54 +0200
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2020, #01; Wed, 15)
Message-ID: <20200416230554.bhk2yfycjwjpxggy@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Fri, 17 Apr 2020 01:01:38 +0200
References: <xmqqr1wo4alb.fsf@gitster.c.googlers.com>
 <20200416211208.xqnnrkvcl2jw3ejr@doriath>
 <20200416213009.GA1721147@coredump.intra.peff.net>
 <xmqqh7xjxeew.fsf@gitster.c.googlers.com>
 <20200416224708.zr4dlrz4hpaqsz2s@doriath>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200416224708.zr4dlrz4hpaqsz2s@doriath>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3 (nef.ens.fr [129.199.96.32]); Fri, 17 Apr 2020 01:05:55 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Damien Robert, Fri 17 Apr 2020 at 00:47:11 (+0200) :
> The triangular workflow patch is not quite correct in the sense that it
> does not handle (yet) all cases

Here were the two reasons for the RFC of this patch e3165570dfca690ea1a71518799153f6350777ae

- in is_workflow_triangular I compute the fetch and push remote. But the push
remote is computed again in branch_get_remote_ref. So we redo an already
done computation.

- Also in
struct remote *fetch_remote = remote_get(remote_for_branch(branch, NULL));
I don't check the value of *explicit.

This means that I get the fallback of 'origin' if no remote is specified.
So if I set a pushRemote="foobar" but no remote, then remote.c will
consider we are in a triangular workflow but git push will not.
