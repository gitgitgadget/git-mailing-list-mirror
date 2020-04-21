Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFB8C54FC9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 08:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A98E22098B
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 08:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMXoPki0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgDUIi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUIi1 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 04:38:27 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD0EC061A0F
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 01:38:27 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g6so6440759pgs.9
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 01:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WYOOvMlpHespKeLiG0XNh25U9modOcLjAD/oaRKq0S0=;
        b=fMXoPki0IU8TvokM6lD5EKl7sFrEtIrxVt1OXZ0BkbmV0+4IJLFXuUjBj3exzX7YpW
         HGg14AWJCbuJ5IVFwiX52VoZ0sqJ6AJlwFMM8hntJU42mXwMqX87TQvjs3XJBtPnhSL/
         xaNdhYdWVOdGlLa18uuAOnDTbAGmA33Oe5S6xVu7F15RIMrL9wVYArwD2U6Jk2b4OY5c
         1Vgr9QW1OoIxvq6ocfKJvVYiE8E+6WcNlZ4MbvoW+mpOZQyyAUHDfUB6Wpum4FiCEmlX
         wRoaTNGlfwYEYx2mrLn14hoHKp/M9ElZ7+dT7JhLRmJVBzrh9g6wS3HGZ3p60k7UicNi
         S8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WYOOvMlpHespKeLiG0XNh25U9modOcLjAD/oaRKq0S0=;
        b=PWqeoyG69vuT3xLUybZfn4uNT98YtlpQfk1xqF+PbuH2tLdwB5BIEaGhOsShHzAWts
         SsuxVO/hcpzvy44HsutkgE9KOUj2xgeSRazrIoQbB6/w1j/FKc2hFaNDCjdvfU1471NZ
         qZtsBcR6aHZ6iMnL7sT/+dlh+kYL0u8uU94GddfujozG1/u7GwCnC5i1roBnTrqkTuYo
         DwCogu1z7h31AQKXzwJYS3fgW5n0mrKnx5DhDsaSLfEMjBqDxj3Ya4OLSf/qlV14osa8
         qMLy7uQVtD3eoz9GL9Ho+ysi9OjkFx+FOd+ue4f13VJZ+s/N95MMVh1fo+3RGO/Evtqq
         cU6g==
X-Gm-Message-State: AGi0PuYjNcfdI07w1sRlUUixHKsokrzeOHfgfW6UCr32CUIktQnJNm1+
        9gVw6kCCtuiBbD+DfiOy3wEiiPM4y1U=
X-Google-Smtp-Source: APiQypJiJsnYY9s/J5Q1UomN292KknwMwfemsZZHhcMhEDsGtLrhisFSxsnw32nSmrmmKtzZ58S4xQ==
X-Received: by 2002:a62:864d:: with SMTP id x74mr20590501pfd.158.1587458306540;
        Tue, 21 Apr 2020 01:38:26 -0700 (PDT)
Received: from konoha ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id 185sm1834731pfv.9.2020.04.21.01.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 01:38:25 -0700 (PDT)
Date:   Tue, 21 Apr 2020 14:08:20 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] gitfaq: append the 'Common Issues' section
Message-ID: <20200421083820.GB11800@konoha>
References: <20200413140918.4778-1-shouryashukla.oo@gmail.com>
 <20200413140918.4778-2-shouryashukla.oo@gmail.com>
 <xmqqsggxpseq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsggxpseq.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/04 05:57, Junio C Hamano wrote:
> Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> >+ 		2. One might want to have two different remotes for
> >+ 		fetching and pushing; this generally happens in case
> >+ 		of triangular workflows.  In this case, it is
> >+ 		advisable to create a separate remote just for
> >+ 		fetching/pushing.
> 
> Yes, by definition, triangular is about fetching from somebody else
> and publishing to your own place for others to fetch, so you'd need
> two remotes, as you are not talking with a single repository.
> 
> But I find your phrasing quite confusing.

I understand. My words turn out to be very ambiguous sometimes. I meant
creating a separate remote for fetch and separate one for push.
Apologies for the confusion.

> "advisable to have two remotes, one for fetching and the other for
> pushing" would probably be a lot more correct.
> 
> And I can understand why you did not write so, and instead ended up
> with your version.  In order to reach the goal of having two (one
> for push and one for fetch), you would "create a separate remote" as
> you are likely to already have one for one direction (in other
> words, you didn't want to say "advisable to create two remotes").
> 
> You wrote "create a separate remote just for fetching/pushing" and
> made the direction of the new one vague, because you do not know if
> that existing one is for fetching or pushing,
> 
> But I suspect that all of the above would not be as clear to those
> who need their questions answered as to somebody like me who knows
> what you want to say already.  And you do not want to explain things
> in a way that only is understood by experts.  How about rephrasing
> the above more like so?
> 
> 	2. One may want to fetch from one repository and push to
> 	anther repository---this is often called a "triangular"
> 	workflow.  As you'd probably have one remote that you use
> 	for fetching already created when you cloned the project,
> 	you would want to create a separate remote to record the URL
> 	you push to.

Yep. I will add this. This reads out much better.

> >+ But, another way can be to change
> >+ 		the push url using the `--push` option in the `git
> >+ 		set-url` command.
> 
> Do not recommend this when you describe a triangular workflow; it is
> confusing to readers.  Keeping separate fetch and push URLs for a
> single remote is not triangular.  

I thought it would be OK to describe a maybe *unorthodox* way to do
this. I will remove it in the next version.

> Describe it separately as a different use case, e.g.
> 
> 	3. You may want to push to a repository over a network
> 	protocol different from the one you use to fetch from the
> 	repository.  Perhaps you want unauthenticated https:// URL
> 	for fetching from, and use ssh:// URL when you push to, the
> 	same remote.  In such a case, ...

That sounds quite better. I will incorporate this.
Thank you so much for such a detailed review! :)

Regards,
Shourya Shukla
