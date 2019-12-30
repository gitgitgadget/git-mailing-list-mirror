Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE36C2D0C3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 19:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4CE206CB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 19:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qodlnvG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfL3T7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:59:18 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:42488 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfL3T7S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 14:59:18 -0500
Received: by mail-pf1-f169.google.com with SMTP id 4so18712578pfz.9
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 11:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cu9KqnyNuJhfNCjAxtwfiO/Qdox3tddvOjDSQcXRLd0=;
        b=qodlnvG5HUxqprip1aJsslM3axeRDY49IttOpF2EdKc2MX57wjqbps9SDfZHEeycUL
         +qHcLx4tvcMoN6k5Ul2GE8bM+sVzAir2VOsXg0/TtCj+Uq7PNQZn/epeAdQYJgmhwdhL
         sPbcdbDmquuV58F9Njn0Ko/vmYK8lUBYblmXpAYCcxlcdPlLchJmdQDHjxjIqGtD/Qu0
         gNKrGdgM0eYaW48qYpUAJSMRs5TEMWh691ZeWEo44bt6J7AB82CZn/f/kovNnBc7ChqV
         vYl0IuFK/irQKk+CAfRB2Z955adPEUosqTLigPtGkfEOGqLpZuNGxBzD6YS6y9s1HUfM
         PJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cu9KqnyNuJhfNCjAxtwfiO/Qdox3tddvOjDSQcXRLd0=;
        b=QzA3vHtRLqUou44GMeaYOCupIutrw/dDR6/PwNQPkW8a80tfFN2wo6PJsbxH+60X0g
         BnhnCvMo3hKhMPv95ZyadVZAavg+p0iZlI9igIP4SAJ9JJKv3uwvqUBagFdgEXebnDox
         9hBsCx0J1V2/DRSTm/Ny99AlJ0aCF9nLtHLgBoFRQR+B9FZafVaHLBwbsUqA/ffuIxNF
         g/xNJFXngoUX2ubA0+OVvjpb9QvTUrbTtCRRMt3PEBa53H/qwbtisvYfkKf4lUthPEKD
         hNT1lvGEggrYQH1fBLVZ2uOCiIKCJcgO9OknsPmbb0gSg1Nd+x1haPeOyBralLlZIfQn
         GJKA==
X-Gm-Message-State: APjAAAWHUcVGYB9hd3Z/i6zlI5A7tyn2un4lfMtfY5I5P++KnBq+9/VR
        rhwsIRbuVOaE+S0TGw6pi4c=
X-Google-Smtp-Source: APXvYqxeek9t9om1I7rTUHdYBN74GN4t+W3HLEHUTiOgQ97dCK0EjYnTuI4LiE6X5E5Fh+SG2X95AQ==
X-Received: by 2002:aa7:8191:: with SMTP id g17mr74625106pfi.25.1577735957346;
        Mon, 30 Dec 2019 11:59:17 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id c68sm54016340pfc.156.2019.12.30.11.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 11:59:17 -0800 (PST)
Date:   Mon, 30 Dec 2019 11:59:15 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Gal Paikin <paiking@google.com>
Cc:     git@vger.kernel.org, ajp@google.com,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Nasser Grainawi <nasser@codeaurora.org>
Subject: Re: Updating the commit message for reverts
Message-ID: <20191230195915.GE57251@google.com>
References: <CAEsQYpNtgMgwjVSOYB9vn-YPvKyKPZ2yZ3NigAVe3PztTN4v8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEsQYpNtgMgwjVSOYB9vn-YPvKyKPZ2yZ3NigAVe3PztTN4v8w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(not cc-ing the Gerrit list after all, since only members can post)
Hi Gal,

Gal Paikin wrote:

> I work on the Gerrit team and I would like to change the default
> behavior for suggested commit messages for Reverts.

Thanks for writing.  I like it when tools behave consistently with one
another, so I'm glad you brought it up here.

> Currently, if the user is trying a change called '"Revert "change X"',
> the suggested commit message would be 'Revert "Revert "Change X""'
> which is silly, since sometimes users want to revert the same change
> many times.

For context, [1] is where this was discussed previously on the Gerrit
mailing list.  Do you have more context?  For example, have there been
reports from users requesting this kind of change?

For a bit of precedent, the Chromium project has some custom logic[2]
that rewrites a revert of a revert to "Reland".  I kind of like that,
since it makes the intention behind the revert-of-revert a little
clearer.

If both reverts are clean, then the typical use case I can think of is
that a prerequisite was missing, hence the revert; after all the
prerequisites were in place, it was then safe to roll forward, hence
the reland.  I would hope that the full commit messages for these
revert commits would provide this context since without that kind of
communication from the people involved, a reader is lost.

> The suggestion is to change the behavior to "Revert^N" instead of
> multiple Reverts one after another.

This would be replacing one kind of jargon with another, so it's not
clear to me that it would improve matters.

With Revert / Reland, we can forget the N altogether:

 1. 'Do some great thing'
 2. 'Revert "Do some great thing"'
 3. 'Reland "Do some great thing"'
 4. 'Revert "Do some great thing"'
 5. (etc)

For the reader of the shortlog, it's not too important how long the
edit war has gone.  The single word makes it clear what the commit
is going to do.

In the full commit message, I would hope that people put in some
explanation of the story so far to explain why they have gone
back-and-forth all these times.

Thanks and hope that helps,
Jonathan

[1] https://groups.google.com/d/msg/repo-discuss/edl43LcyEKE/f9Q65kOcBgAJ
[2] https://chromium-review.googlesource.com/c/infra/gerrit-plugins/chromium-behavior/+/757684
