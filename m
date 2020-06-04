Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBE0C433DF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 19:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEED8206E6
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 19:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="AZuPkEPf";
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="uTwamZXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgFDTcn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 15:32:43 -0400
Received: from ns3309586.ip-5-135-160.eu ([5.135.160.121]:36926 "EHLO
        mail.spkdev.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgFDTcm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 15:32:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.spkdev.net (Postfix) with ESMTP id 14F8F40246;
        Thu,  4 Jun 2020 19:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1591299160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f/3wAAVsKWj9t+TJpsckHp/uO9Qdy7MYApPyqa4q3rU=;
        b=AZuPkEPfFy1kOryY+HNOFt7KsNJBZ6YogAsKX7U9K4NE2A9bgXWdZGEeidM71P84L6sF34
        7B4OTz1c9dQJS9jykuo03uMHV4zKnKdB1fwI70zmEBFwSzwWI4BcCBTNMnynDoyEJrt84H
        n8dehKODQohXR37YNkD0KrmYg6prUbg=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.spkdev.net (Postfix) with ESMTPSA id 9E1F23FDDF;
        Thu,  4 Jun 2020 19:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1591299159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f/3wAAVsKWj9t+TJpsckHp/uO9Qdy7MYApPyqa4q3rU=;
        b=uTwamZXtn2Ujv1Kv+RoFK3A+O1pkYM/4aMuU2H2aaVi4Rn2rjl6OKAjG0O4vZucqMctGh1
        h3icoriNkJV59rzAA8/fznD1qq/6xD2eYoJT056+Ol6hc4n7LtTMKlY+LM8qJYFkE0LBSA
        8+97KfWTwUS/oS4HX1uZzj935BFN46E=
Date:   Thu, 4 Jun 2020 21:32:38 +0200
From:   Laurent Arnoud <laurent@spkdev.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] format-patch: generate valid patch with diff.noprefix
 config
Message-ID: <20200604193238.GA1911544@spk-laptop>
References: <20200602204924.GA1853335@spk-laptop>
 <xmqqpnahrx2y.fsf@gitster.c.googlers.com>
 <xmqqeeqxrufz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeeqxrufz.fsf@gitster.c.googlers.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 02, 2020 at 03:09:36PM -0700, Junio C Hamano wrote:
> Having said all that, we seem to be letting more configurations for
> the diff.* family to affect the format-patch command.  The latest
> addition was "diff.relative"---together with the "diff.noprefix"
> that triggered this thread, some users may feel that it is a bug to
> allow these configuration variables to affect the output from the
> "log -p", "show", and "format-patch" commands.  
> 
> It *might* make sense to introduce log.diff.* configuration
> variables so that when they are set, they are used by
> log/show/format-patch instead of diff.* counterparts, or something
> along those lines.  I dunno.

I don't know if its a bug but I founded strange that I needed to use an alias
"git -c diff.noprefix=false format-patch" to generate a patch that I can apply
directly with "git am". I didn't know the -p option but to send a patch to a
mailinglist it should have the prefix I guess ?
I can try to implement this option if you think it can get merged

-- 
Laurent
