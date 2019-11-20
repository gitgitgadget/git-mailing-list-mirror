Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75C2C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 23:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B740820857
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 23:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhT39zHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKTXke (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 18:40:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33090 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfKTXke (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 18:40:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id t26so2373519wmi.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 15:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Xem3CWzce+CFUTLeT3g5eoHMYqSI1fBfwLJJ3hpCkjQ=;
        b=UhT39zHuu81gzgf3OcMX6naG28rGqYh1qTj7PgIAdLr7dSpl1ldNOqOpfDZSZ8pShx
         wefNSRxrMJW0h4wpEIF5XSPwGEkOTaox4sHr8i3d+sA8+MCLanCnJsa9oBZT+8TkyrNR
         1fN4CY8bBUzY1KpFWgTaDXX9q8vqiW50VhzA2nkDDJlkGCCZlXFnEP57A6+Qiet17kHR
         ORrpdaUOzpsWccWPGH9ZFVVhPMJjtdDrE8T1HGoWgrkRL2WXcuuSW87m6lF/v2wMWB/l
         IejrBkmEjyJE5iA+sI/Hn2WhFT7ND7Vkjk7eMjwh+GVr5SXbwCBeRNQAK04yNcJXVedg
         Tqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Xem3CWzce+CFUTLeT3g5eoHMYqSI1fBfwLJJ3hpCkjQ=;
        b=agnNW+jgr6Dk/1ZV6kYUnCw1iYv1h5Y110OwJUN2ZwoLwLKGHBf4auuuexJFlPWdmY
         c7hkA8KcYLgajt5QxX9190GnLWsmBycwCWgwamKmy0cg555qfkFzTLWJ9pU5y+hA9nzo
         8vf4EJ79a3heiUhhWfqXVjq/ZFScjaZtaGGp5vJ6exSp5yoEoi5JNL5qCgp7avbPldHl
         XYXZ2Z5GXJXuITe9EwP9Sn09uspcO+dRRzP3CsHkAR70NJcOJMxRwnpumtgNDyOg0HHF
         YGQYCM/tDWFjpCoGuCbw/stzNnUsJ7zIw6q6cQ+nT0+RdWfN7XkE8Oagm94P98VNuY9M
         iqOg==
X-Gm-Message-State: APjAAAVjSsCMiQK4OFQ1ajXG88KUZtPZj+wxATIWsD9jW/ejZAdtle+9
        bm1R/QGP44J3ZI6Ev4IXvh4=
X-Google-Smtp-Source: APXvYqwlpqbN0YPeRrXOIhiv2YTBNI3nLzIOFHhLUB0HqxHkVTgCZQKgU2s2IiUUXLxML6CbGsI4Pw==
X-Received: by 2002:a05:600c:28c:: with SMTP id 12mr6306300wmk.25.1574293230971;
        Wed, 20 Nov 2019 15:40:30 -0800 (PST)
Received: from szeder.dev (x4d0c5363.dyn.telefonica.de. [77.12.83.99])
        by smtp.gmail.com with ESMTPSA id d11sm1042767wrn.28.2019.11.20.15.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 15:40:30 -0800 (PST)
Date:   Thu, 21 Nov 2019 00:40:27 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] MyFirstContribution: add avenues for getting help
Message-ID: <20191120234027.GP23183@szeder.dev>
References: <20191115230637.76877-1-emilyshaffer@google.com>
 <xmqqv9rk4j1y.fsf@gitster-ct.c.googlers.com>
 <20191118214519.GH22855@google.com>
 <20191119184919.GM23183@szeder.dev>
 <nycvar.QRO.7.76.6.1911192227280.15956@tvgsbejvaqbjf.bet>
 <20191119214101.GN23183@szeder.dev>
 <nycvar.QRO.7.76.6.1911201222490.15956@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1911201222490.15956@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 20, 2019 at 12:41:56PM +0100, Johannes Schindelin wrote:
> Hi Gábor,
> 
> On Tue, 19 Nov 2019, SZEDER Gábor wrote:
> 
> > On Tue, Nov 19, 2019 at 10:29:43PM +0100, Johannes Schindelin wrote:
> > >
> > > On Tue, 19 Nov 2019, SZEDER Gábor wrote:
> > >
> > > > On Mon, Nov 18, 2019 at 01:45:19PM -0800, Emily Shaffer wrote:
> > > >
> > > > > I don't mind the idea of pushing folks to ask on the mentoring list
> > > > > first. It's pretty well attended already - just now I count 16 list
> > > > > members, a pretty significant majority of which are project veterans.
> > > > > I have no problem suggesting newbies ask their questions, which others
> > > > > probably had and solved before them, in a space separate from the main
> > > > > mailing list.
> > > > >
> > > > > Of course if you want to encourage newbies to ask in any of these
> > > > > three venues, weighted equally, I can change the language. But
> > > > > suggesting the main list as a last resort was intentional.
> > > >
> > > > git@vger is the ultimate source of all wisdom :) and it is openly
> > > > accessible for anyone for writing,
> > >
> > > ... except people with an @outlook.com address (all of their emails will
> > > bounce) and people who do not know how to suppress HTML in their emails
> > > (which I believe constitutes the vast majority)...

My interpretation of the above paragraph was that the "(which I
believe constitutes the vast majority)" part refers only to the
"people who do not know how to suppress HTML in their emails", but not
to the aforementioned "people with an @outlook.com address" (who had
their own subsentence in parentheses).

And with that statement in itself I completely agree: I would expect
that that "vast majority", i.e. the number of people who don't know
how to suppress HTML in their emails is in the billions, though I have
no data on that.

> > And I believe that that "vast majority" will never try to contribute
> > to Git, and thus doesn't matter.

I could have worded this more carefully, e.g. along the lines of:

  I believe that the vast majority of people will never contribute to
  Git anyway, therefore trying to give more weight to your argument
  with that "vast majority" doesn't make it any stronger.

> Yes, this is a tautology, because by that very expectation you make that
> happen. It's kind of a perfect example of a self-fulfilling prophecy.

Call it as you wish, I think it's simply inconceivable that the vast
majority of people will contribute to Git.


[Snipping the parts that appear to stem from the misunderstanding that
I tried to clarify above, in the hope that we can focus on the more
important point, which is:]


> > > > reading, and searching.

I would like to emphasize these last words of the sentence that was
cut in two so unfortunately, because I'm afraid that they didn't get
the attention they deserve although they are of fundamental
importance.

If someone reaches out to us with a problem, and we can provide a
solution, then it's best to have that solution openly accessible for
the benefit of everyone else.  IMO this far outweighs any issues with
HTML-formatted emails or @outlook.com email addresses, and on its own
justifies putting git@vger first.  That way even those who stop
reading at the first email address will choose what's most beneficial
for the greater good.  If someone for some reason still prefers
otherwise and/or due to some technical limitation can't post to
git@vger, then they could still consider the other two venues.

> > > > Therefore these three venues cannot be weighted
> > > > equally, but git@vger should be the explicitly preferred venue.  Only if
> > > > the newbie has some other preferences should the other two be
> > > > considered; e.g. if more interactive, chatty communication is preferred,
> > > > then try #git-devel.
