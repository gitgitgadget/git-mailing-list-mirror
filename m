Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115B9C433DF
	for <git@archiver.kernel.org>; Tue, 26 May 2020 16:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E88FC20849
	for <git@archiver.kernel.org>; Tue, 26 May 2020 16:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgEZQ52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 12:57:28 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:38642 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbgEZQ51 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 12:57:27 -0400
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
        by smtp5-g21.free.fr (Postfix) with ESMTP id 756305FF20;
        Tue, 26 May 2020 18:56:56 +0200 (CEST)
Date:   Tue, 26 May 2020 18:56:56 +0200 (CEST)
From:   ydirson@free.fr
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Message-ID: <253380167.1036247407.1590512216359.JavaMail.root@zimbra39-e7>
In-Reply-To: <xmqqd06qoec9.fsf@gitster.c.googlers.com>
Subject: Re: [BUG] diff algorithm selection issue
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [91.170.159.152]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> > When the config has diff.algorithm=patience set, "git diff
> > --minimal" seems to
> > be ignored, and does not give the same output as "git diff
> > --diff-algorithm=minimal",
> > but really the same as "git diff --diff-algorithm=patience".
> 
> As I wrote, that is absolutely the intended behaviour.
> 
> When patience and other algorithm learns how to trade cycles off
> with output size, --minimal may make a difference, but unlike
> "--diff-algorithm=minimal" that forces Myers algorithm, the
> "--minimal" option should not change the underlying algorithm.

OK, so then the problem is just in the doc, where --diff-algorithm=minimal
should rather be documented as something like:

 The basic greedy "myers" diff algorithm, spending extra time to make
 sure the smallest possible diff is produced (equivalent to
 `--diff-algorithm=myers --minimal`).

Or is it rather intended to be `--diff-algorithm=default --minimal`,
whatever the default may be in the future ?


As for the other flags, --patience and --histogram should probably
documented as backward-compatibility aliases for --diff-algorithm=, right ?


I'll send a formal patch if all of this sounds good.


And as a last point, there would be the problem shown by patience diff
on the commit referenced in my original post - If patience is still
considered for promotion to default some day, I guess we wouldn't want
it to make such a bad choice.

Best regards,
-- 
Yann
