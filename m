Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C929C4320A
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 18:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67CD460F3A
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 18:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbhH3SRV convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 30 Aug 2021 14:17:21 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:41494 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbhH3SRP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 14:17:15 -0400
Received: by mail-ed1-f49.google.com with SMTP id eb14so13749313edb.8
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 11:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pbFNqlWIkgtovbdc8dRbSqbDCxAyeHYI5s+hPGvjcag=;
        b=lZ1xQpCoLtPcZ4BCSKi96zI2vXFmtu8o2e261QAPVlEeSHy98ZZo4/F85cvRhJeb0v
         6/9Sj7GI+Ry24YV9t33ymNfW7q04u2D98NPb3p5MyqwY2CdpTY28P4/0oy2fOftQ6SCA
         MYT4Kx+F+JeIaP3xggI0HRq/rNWN8GwO7ymm1ppWSPIjhCcdOAALmfCBaIpEwqao9EDv
         0CUm40gR9jRD4arZVPJDVgRot+DXT87KXNsJ2rmBG6mZmFm67ajkGzsJKMm6Mw2jCE0Q
         rUnlOZFCFossM22gpxAnX91Z4O0N25Y/Fg4oAZRrGmtlXUG4bipVyOXsXQpFLPnev9KI
         J/jw==
X-Gm-Message-State: AOAM533k1GF3BhhW172IwdqGzVIDu64GP3IYBZqIPJJTIure0E0I+d7i
        6LjgGiJK8fmuxmEfTf4cavRrf/syNa7S4jto4gY=
X-Google-Smtp-Source: ABdhPJxiUsF8Ksuc4PCOTJACg6uNHgYEhphF9iIVUq3pbutGtatNWIxnAoWCXIdnUUSuXe8mVzkGEnYzT+LFWWTghCc=
X-Received: by 2002:aa7:da56:: with SMTP id w22mr25243145eds.89.1630347380062;
 Mon, 30 Aug 2021 11:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210830072118.91921-1-sunshine@sunshineco.com>
 <20210830072118.91921-2-sunshine@sunshineco.com> <xmqq4kb66er7.fsf@gitster.g>
In-Reply-To: <xmqq4kb66er7.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Aug 2021 14:16:09 -0400
Message-ID: <CAPig+cRqMjaujwfwzrqNyxaMN9y4r7RP2W6kOcP-kKcnvrjYxQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] t3301: tolerate minor notes-related presentation changes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 1:09 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > These tests care about whether intended notes-related functionality
> > occurred and that `git log` presents the notes in the expected fashion
> > (or, in some cases, that `git log` suppresses the notes). However, the
> > tests hard-code the precise indentation of notes by the default `git
> > log` output, which makes them somewhat brittle since they won't be able
> > to tolerate even minor changes to the presentation. Make the tests a bit
> > more robust by ignoring indentation.
>
> Isn't this losing too much information?  If we lose all, or gain
> random number of, leading whitespaces, the test won't notice.

That was the idea. The precise amount of indentation -- whether four
spaces or one TAB or whatever -- seems pretty much immaterial in the
wide view [1], and it is not inconceivable that the exact amount of
indentation might change in the future, thus this future-proofs the
tests against minor indentation changes.

However, as mentioned in my response to Ævar, I wavered quite a bit on
whether or not to make this change since, although the justification
of "future-proofing" the tests isn't exactly hand-wavy, we don't need
the change either. It may be a case of YAGNI. So, as I also mentioned
in that response, I don't mind at all dropping this patch and going
with Ævar's version.

[1]: mechanical extraction aside...
