Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0FB71FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 18:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934347AbcKVSSs (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 13:18:48 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36542 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932355AbcKVSSr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 13:18:47 -0500
Received: by mail-pf0-f172.google.com with SMTP id 189so5253315pfz.3
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 10:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sCMT5gqBmlwLr7Z6YHTQ9RRf6SsgBte5WeIMy6TtagQ=;
        b=OlT+JU6B2Wejgs5g7gZL85vCEwi3B6vW3MreGgKLUg6DV7irxwRKn0khITI/Ae6wl3
         4cwkS+Fm9WlhyKXLeqpEYIcIsD1K4q4vZaUeEZ+PNWgwvhMATwzkQZmbUyL3Dwko9tDi
         iRX4wcWv1Bt2zwZP1YkJRhNfV7d7HTc4FZvNX7NMyFs6Mv0JFNgkYHMKxnusLcJoJ8F1
         nWyxwePb03NAhWILzkvlkF95Bc3mTZP9Q3sHjFJW/4eu+KQcKqYFOY7VIfZO7J6e5nKi
         DTjA/mN0q9ajFFRPOlgcPqJZ/WHOmwTXzOR50P/Dt820hRBrVnzHZFRibzWK9DNqjJBR
         bW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sCMT5gqBmlwLr7Z6YHTQ9RRf6SsgBte5WeIMy6TtagQ=;
        b=RJvcgoQFUjazMly50E2hCyJwwi75TR6OjEF3+n8hwCptMXjWer9K+gRRFmaeP7kh2/
         J6Xf/u8seU2FeH/vW71P7NooNS3nvd69rEFnrbIQIlVhlJXU57J6tb4s9o1HzUnh8GNF
         ud9xNQv/g4a6Vq+koSq/4iiXd8qaOeEksS3od7mV+RCelr+dHnOp1gfiWO0D56mmJp1h
         Ul22SZVMI77xvFjnA64euadjCH3CtsRv+maavyW8OVIUZv+Rfw3ho44UBDJAy5C7YW9t
         8Aa5Mx/e9SY5bSW1b65c9BjKhw/06F1G/4o7FyqrRP9K5LOnsCGTaBoE9Pju8w9801Nw
         Inlw==
X-Gm-Message-State: AKaTC032+eJd74CVUgn7xJvVV9AKI0iWSvgWGyyt1aZsVOF8QDst30zBIHDMUBPv2z8/om1R
X-Received: by 10.98.68.84 with SMTP id r81mr26822188pfa.174.1479838721557;
        Tue, 22 Nov 2016 10:18:41 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:a049:6e3d:16a5:8086])
        by smtp.gmail.com with ESMTPSA id o126sm28830969pga.34.2016.11.22.10.18.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Nov 2016 10:18:40 -0800 (PST)
Date:   Tue, 22 Nov 2016 10:18:39 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 2/2] push: fix --dry-run to not push submodules
Message-ID: <20161122181839.GF149321@google.com>
References: <1479172735-698-1-git-send-email-bmwill@google.com>
 <1479408364-150268-1-git-send-email-bmwill@google.com>
 <1479408364-150268-3-git-send-email-bmwill@google.com>
 <CAGZ79kY1x1HWJFjiyFdMFh8S_Y1F0ecLB5-JPb+nPE0gujfF-A@mail.gmail.com>
 <20161117190255.GK66382@google.com>
 <xmqqk2bvquk1.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk2bvquk1.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/22, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > On 11/17, Stefan Beller wrote:
> >> On Thu, Nov 17, 2016 at 10:46 AM, Brandon Williams <bmwill@google.com> wrote:
> >> 
> >> >                                 sha1_array_clear(&commits);
> >> > -                               die("Failed to push all needed submodules!");
> >> > +                               die ("Failed to push all needed submodules!");
> >> 
> >> huh? Is this a whitespace change?
> >
> > That's odd...I didn't mean to add that lone space.
> 
> Is that the only glitch in this round?  IOW, is the series OK to be
> picked up as long as I treak this out while queuing?

It looks that way.  And I did fix this in my local series.  Let me know
if you would rather I resend the series. Otherwise I think it looks
good.

I do also have a follow on series I'm planning on sending out later to
actually add in a feature which mimics what this bug does (as this
functionality could be desirable in some circumstances) but thought it
best to wait till heiko's and this series were more stable.

-- 
Brandon Williams
