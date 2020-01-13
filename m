Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58734C33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 23:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326FE20678
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 23:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgAMXef (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 18:34:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33429 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgAMXee (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 18:34:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so10428143wrq.0
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 15:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Cr0/znUEs18224WlKSv08w9wsMI8Q4nH1EdaZdm3JHM=;
        b=kQTwUwtu8DDrGnuzxa8yVl26qAbJSw0ucRNCPo1Hc/AeModBcfgtBvqxN9Weifvm6G
         iOyqFKd6W7z7QlO5Hy1GteiSpNqLDXwYjc4LT+O6VqaOzkckr3nCljyqpazjb5YlM3+0
         KNH6H3HK92kZ38Biwf5OAdGXv+Gv+Vy7wV3U/MLucqZAG8TeFS8ISlhlN3lKqO/GE9yE
         ft4xxv04mE0MVz2Uo9YLjHfk6iZPNz09YqYfm0YaP+9qVG4UlsPc9puH4zhyqIm6Qttr
         IE/Odxrkq8K8Q8DE4tZNkG8s8revuS0Kw/2Tswd9/+Zq2rBuS/saU81zaWjceTLPxqaC
         viuQ==
X-Gm-Message-State: APjAAAWGcQBAL72I1PAYBnySdseqSnpyOW/OdZHnQfFFWr6GQ1pDOaj+
        i4uRLcE9PVh9VrK+yTsqZ8pHyYx/vZwfW5rDt2w=
X-Google-Smtp-Source: APXvYqw/ZRtpbO+e0ppmq0a9bJgFEe3lpFMxeIhCN5qKRI46O/akvB4QJlWhmc3lVAnGSLaO2MBtFhnHLfoZ7gGqkDw=
X-Received: by 2002:adf:b193:: with SMTP id q19mr21349105wra.78.1578958472843;
 Mon, 13 Jan 2020 15:34:32 -0800 (PST)
MIME-Version: 1.0
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
 <CAPig+cReDPs8D1L3+Z4sMn__JuU-Ezs+fOSF00=_tNxa0DotFQ@mail.gmail.com> <20200113231705.GU6570@camp.crustytoothpaste.net>
In-Reply-To: <20200113231705.GU6570@camp.crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Jan 2020 18:34:21 -0500
Message-ID: <CAPig+cTUKc1+L2XOjToCNmip3h1C33-ZhCWMkujptScYy0OeGw@mail.gmail.com>
Subject: Re: [PATCH 00/24] SHA-256 test fixes, part 8
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 13, 2020 at 6:17 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On 2020-01-13 at 13:41:44, Eric Sunshine wrote:
> > The test itself is fine, but it is one of those unfortunate cases of
> > checking for absence of something (which is a wide net). As explained
> > by the commit message[1] of the patch which added the test, the
> > collision occurred only between short OID's. The patch[2] which fixed
> > the problem did so by avoiding short OID's in the scripted
> > implementation of `git rebase -i` (and also flipped the test from
> > `text_expect_failure` to `test_expect_success`).
> >
> > The test, as currently implemented, is very much specific to SHA-1
> > since the FAKE_COMMIT_MESSAGE="collide2 ac4f2ee" it uses only produces
> > a collision with short OID's when SHA-1 is the hashing function, so
> > the prerequisite is correct and serves as documentation (even if it
> > doesn't affect the outcome of the test). Removing that prerequisite
> > should only be done if the test is updated with a different
> > FAKE_COMMIT_MESSAGE which causes a short OID collision when SHA-256 is
> > used.
>
> I'll take another look.  When I looked at the output, it looked like
> they didn't collide anymore even under SHA-1, but perhaps I instrumented
> the test wrong and therefore got the wrong result.  Thanks for double
> checking.

They might not collide anymore if the length of a short OID has
increased since the test was written[1] (even with the "fix" patch[2]
reverted) since, to fail, the test only needed the common prefix of
the OID's to collide, where the common prefix was the length of the
short OID. So, it's possible that the test doesn't do anything anymore
if the short OID length is now longer. (This might suggest that
dropping the test would be a path forward.)

[1]: 66ae9a57b8 (t3404: rebase -i: demonstrate short SHA-1 collision,
2013-08-23)
[2]: 75c6976655 (rebase -i: fix short SHA-1 collision, 2013-08-23)
