Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE71C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 17:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D3D820775
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 17:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snoWz60U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgD0Ra5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgD0Ra5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 13:30:57 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BEEC0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 10:30:57 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d3so1738322pgj.6
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 10:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ytC5q6B8HJdZLlhiFmTlE1tgp2NPYRkT+U14qWhiv3c=;
        b=snoWz60US2XYB0A69eze3DikAZHR/JtogHpi7vKYneKD39o/tc2YclsHeo0D1f7SZL
         TSR99aPQBAkZ4nb9RtsMqWyMxgis4RWoZZZ9TQdh4XcpHvrGDgUJCkbJ9l7NKGee30OW
         7ONPVXNp51s22G9q11XfYcl/IHUsOxzSuYyrMmYHn6LV5J/AL4usR/J1V7zZ3D+azqsA
         j/OqEbtEDM3n27DDrkV4nSwbRdMjz76qGOzKMIG4aAZ/6bnG/AFynFJnbwjRmzwnosOG
         fUlBK5GKRYpg+/+Qcpc0fnzIFvfWwosVHI/mtk1xPpCj49GzwalxkiqOXcbklD6LHNO3
         +A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ytC5q6B8HJdZLlhiFmTlE1tgp2NPYRkT+U14qWhiv3c=;
        b=AEbM/gI4vGHbgOaETvJHzx0lvOWyiuRZtjPQSg1nHC33wduOZkRsKsbv6N2rmMZ+BP
         f3ge7bLFPYiErX78ifXo0ef3owfSdL/47HvIeExFiNfSAZKbZynqDfz49VClxqD/+KLb
         RRr2+jxCH6ziC3evvC5Utpaa818xhXekuYQujz5MOmQzQqE/g0viN+hy19JHzH2v9ovz
         vpXjFLagn9aTRnQI33iTsTH1D5oN7mhOoqI6sKSZ8o25duYJuDsSaDvS4Mfd6w9H5LgB
         iEU4L4dkpgkBX+CLe8eoRXSXRuo/6bUcZeArv39AniSpkP6clMrFXd3ZYF11r31zv1xi
         WL/w==
X-Gm-Message-State: AGi0PubVclJUAl7f1iAYP1zqUZzrlyh2b3c+jw092UBfi2HFH9n8nLyC
        y1BKJG8ZbaxXzJVHEypJ4VGkpdOq1nBkeA==
X-Google-Smtp-Source: APiQypKjgVc1c4cp1POd95BGn73wuqEl3MsYUaT4acnE8pJU4HiCdUorqMvAmaurqAktfWxaUXjBug==
X-Received: by 2002:a62:6dc3:: with SMTP id i186mr23871625pfc.273.1588008656450;
        Mon, 27 Apr 2020 10:30:56 -0700 (PDT)
Received: from konoha ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id g27sm11282783pgn.52.2020.04.27.10.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 10:30:55 -0700 (PDT)
Date:   Mon, 27 Apr 2020 23:00:49 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH v3 2/4] gitfaq: changing the remote of a repository
Message-ID: <20200427173049.GA6714@konoha>
References: <20200421131223.29337-1-shouryashukla.oo@gmail.com>
 <20200421131223.29337-3-shouryashukla.oo@gmail.com>
 <xmqq368wobqu.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq368wobqu.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/04 12:54, Junio C Hamano wrote:
> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
> 
> > Add issue in 'Common Issues' section which addresses the problem of
> > changing the remote of a repository, covering various cases in which
> > one might want to change the remote and the ways to do the same.
> >
> > Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> > ---
> >  Documentation/gitfaq.txt | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> 
> Again, I think this belongs to Documentation/git-remote.txt; unlike
> the ".gitignore" one, however, the existing description is heavily
> concentrated on "what happens when X is set to Y?" and does not
> answer "why would I want to set X to Y in the first place?" very
> much.  And the text below you have is a good thing to teach anybody
> who learns "git-remote".  
> 
> So how about clarifying the existing page, perhaps its DISCUSSION
> section (which currently talks only about "how to add a remote, and
> configure" without discussing "why would I want to add a remote, set
> a URL and/or a pushURL to it") with what you have, and trim the
> description here in the FAQ file to the minimum and refer to the
> page instead?

Yep, it seems reasonable. So a good strategy would be to append the
'DISCUSSION' section with what I have added in the FAQ and quoting a
couple of lines from the documentation, providing the solution and
giving a further reference to the Documentation right?

	A remote is an identifier for a location to which Git pushes
	your changes as well as fetches any new changes from (if any).

	To change the remote of your repository, you may want to
	execute:
		git remote set-url <name> <newurl>

Something along the above lines? I think that a generic user will mostly
find this as a solution to their problem instead of using the '--push'
option to specify a different push URL.
