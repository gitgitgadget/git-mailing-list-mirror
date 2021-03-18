Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9ABC433DB
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 22:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E0964E81
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 22:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhCRW3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 18:29:20 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:55139 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhCRW3M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 18:29:12 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Mar 2021 18:29:12 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616106551; h=Content-Type: Content-Transfer-Encoding:
 MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Cc:
 To: From: Sender; bh=yfad7xQw9c7grobyWEembo8B6TFky6lgIC8QQr+6yVo=; b=uSiFBZPyf3KcwF4ON53GxWc0kbIJiZLRUToCuboKr7GYPP9X3aVNaJ68mtsiwV16y8rKAsTF
 BRBaqTv3OXaImAARlxFOl8eQPyHxtLb4LF2JivCqD60G80Ubz81fIvML+rwFITxnPJHIFvmJ
 Vcj3dPobxKQM777JvXP3vnirieU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyJjNzk3NCIsICJnaXRAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6053d30521031618f6b1565b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Mar 2021 22:24:05
 GMT
Sender: mfick=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E9C3EC43461; Thu, 18 Mar 2021 22:24:04 +0000 (UTC)
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 57B43C433C6;
        Thu, 18 Mar 2021 22:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 57B43C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mfick@codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Distinguishing FF vs non-FF updates in the reflog?
Date:   Thu, 18 Mar 2021 16:24:03 -0600
Message-ID: <4400050.5IlZNYTcJN@mfick-lnx>
User-Agent: KMail/5.2.3 (Linux/4.4.0-203-generic; KDE/5.36.0; x86_64; ; )
In-Reply-To: <CAFQ2z_MavgAGDyJzc9-+j6zTDODP7hCdPHtB5dyx-reLMSLX3Q@mail.gmail.com>
References: <CAFQ2z_MefCwiWdhs0buJv5Zok+nsgaOvUCcsSnfm_PP0WozZKA@mail.gmail.com> <5359503.g8GvsOHjsp@mfick-lnx> <CAFQ2z_MavgAGDyJzc9-+j6zTDODP7hCdPHtB5dyx-reLMSLX3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, March 18, 2021 9:58:56 AM MDT Han-Wen Nienhuys wrote:
> On Wed, Mar 17, 2021 at 10:22 PM Martin Fick <mfick@codeaurora.org> wrote:
> > On Wednesday, March 17, 2021 9:06:06 PM MDT Han-Wen Nienhuys wrote:
> > > I'm working on some extensions to Gerrit for which it would be very
> > > beneficial if we could tell from the reflog if an update is a
> > > fast-forward or not: if we find a SHA1 in the reflog, and see there
> > > were only FF updates since, we can be sure that the SHA1 is reachable
> > > from the branch, without having to open packfiles and decode commits.
> > 
> > I don't think this would be reliable.
> > 
> > 1) Not all updates make it to the reflogs
> > 2) Reflogs can be edited or mucked with
> > 3) On NFS reflogs can outright be wrong even when used properly as their
> > are caching issues. We specifically have seen entries that appear to be
> > FFs that were not.
> 
> Can you tell a little more about 3) ? SInce we don't annotate non-FF
> vs FF today, what does "appear to be FFs" mean?

To be honest I don't recall for sure, but I will describe what I think has 
happened. I think that we have seen a server(A) update a branch from
C1 to C2A, and then later another server(B) update the same branch from C1 to 
C2B. Obviously the move from C2A to C2B is not a FF, but that move is not what 
is recorded. Each of those updates was a FF when viewed as separate entries, 
but if you look at both lines you can see that the second entry does not start 
where the first one left off. This would be detectable, it would appear as if 
there was a missed entry that did a rewind from C2A to C1, but that rewind 
presumably actually came in as part of the second update from server (B)  as 
it had a cached version of the branch and believed it still pointed to C1 when 
it made its update,

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

