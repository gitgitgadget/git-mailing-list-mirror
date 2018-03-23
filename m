Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A98231F404
	for <e@80x24.org>; Fri, 23 Mar 2018 20:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751930AbeCWUU0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 16:20:26 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38092 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeCWUUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 16:20:25 -0400
Received: by mail-wm0-f51.google.com with SMTP id l16so5666139wmh.3
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 13:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/sIi2J5rzm/zdvc/KqYMQq8XIbp6+NswBFhvqLrJOLo=;
        b=mntgW/6eHZhexwjDrgTE3Jb3uavgFoQS9H538Kvr1MHvv/BToAzlIfVR0P+TPqC8DM
         QseAVgvPjW7+XPJuopBWotlNhNoOL5TDYE1iOwHT77gex7IIpRKTAlnXDEAZ8lHv4PCo
         NLZPgG3bwggTrChHHMZkvGB0qRn2HkMlzALKkgvcuEPdyoFW5/+TLpLspEMfhUJOJYOd
         EM0wT5T7jxqaFCY+C/6ZEs4ZwW9B+uzvaDleKhVUItzcLWJwl4GEJrVoFe51IcHjRJ2b
         aDEakY+2niCUiMagZX4JuIkfE2gMa9qu6e1SIrIb3YtIOypYijgg49rrBHOLUsxgiaLN
         FQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/sIi2J5rzm/zdvc/KqYMQq8XIbp6+NswBFhvqLrJOLo=;
        b=UaDMxk3pP+a3ZLNEAOqBtGEvkqbH2A4qGu6J5m9BIPeawNnGwl3XTm6zkYprpxc9Cy
         znlkJRltNwHKJRL4ElcloMR85c5Ytde+PBql0/Op/hlDA1YwisVmza9ky3WG2Z2yzjRD
         viSFDLth4r35MZkZTK0ytxmWn7LdGhUxEi4i6P2lZaLDFculn+wOUhzCoRV2TjBpPmDE
         sLUWRcxeayckj9d+T7/b7njT6HspLvksCfuYYsGJcxHFJlX708c3rPGn2/iwr0ZFe+ey
         va3YTlWqVf0CieH9j8i3uF0IP/fG+lOYJESWT379Cm2aqH/hS+LMrSavjwSJ5Lla2ZBo
         iL1w==
X-Gm-Message-State: AElRT7H3t3tq/DTG9xY2G0wvYSmPbjUsVBSP5DBXtsevGN12jVfbhR6f
        cPl0bzzagET4xCYRIY1lAxg=
X-Google-Smtp-Source: AG47ELtaOuGi3EI8dlB4LU6weJdix8b2H7m0rJGe8++fd0FRxXv1gw9D8I8Aw53fdAp6XHckA1HPEg==
X-Received: by 10.28.193.13 with SMTP id r13mr8765053wmf.38.1521836423912;
        Fri, 23 Mar 2018 13:20:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n62sm8846071wmf.13.2018.03.23.13.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 13:20:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yuki Kokubun <orga.chem.job@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] filter-branch: fix errors caused by refs that cannot be used with ^0
References: <5ab46520.0352650a.cc02b.a177@mx.google.com>
        <20180323050913.5188-1-orga.chem.job@gmail.com>
Date:   Fri, 23 Mar 2018 13:20:22 -0700
In-Reply-To: <20180323050913.5188-1-orga.chem.job@gmail.com> (Yuki Kokubun's
        message of "Fri, 23 Mar 2018 05:09:13 +0000")
Message-ID: <xmqqvadmilx5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yuki Kokubun <orga.chem.job@gmail.com> writes:

> "git filter-branch -- --all" print unwanted error messages when refs that
> cannot be used with ^0 exist.

It is not incorrect per-se, but if I were writing this, I'd say
"... when refs that point at objects that are not committish" or
something like that, as that is much closer to people (both end
users and Git developers) than the "^0" implementation detail.

> Such refs can be created by "git replace" with
> trees or blobs. Also, "git tag" with trees or blobs can create such refs.

Taking two paragraphs above together, you wrote an excellent
description of the problem to be solved (i.e. what would be seen by
users and under what condition the symptom would trigger).  If there
is a single obvious solution that would trivially follow from the
problem description, it is perfectly fine to stop here.  Otherwise,
it would help to describe how it is solved next.  Something as brief
like

	Filter these problematic refs out early, and warn that these
	refs are left unwritten while doing so.

would suffice in this case, I think.  We _could_ insert

	before they are seen by the logic to see which refs have
	been modified and which have been left intact (which is
	where the unwanted error messages come from),

between "early," and "and warn", if we wanted to.

> ---
>  git-filter-branch.sh     | 14 ++++++++++++--
>  t/t7003-filter-branch.sh | 14 ++++++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)

The diff looks good.  

Please sign-off your patch (cf. Documentation/SubmittingPatches).

Thanks.
