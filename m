Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AA7C33CA9
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 02:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0D9214AF
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 02:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kx7c/1G7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgANCwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 21:52:38 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:32805 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgANCwh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 21:52:37 -0500
Received: by mail-pl1-f171.google.com with SMTP id ay11so4632295plb.0
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 18:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WSETGpuknowOrNpULzXf5KRkK3Dt+OJVL3JNHsD4O8Y=;
        b=Kx7c/1G750INDMst9lcxnLnIYMZuR5gQpiR8/6PZO54ozY0OG+b5gHjdgeiGWLelPV
         jxeApDJosd8s4WRbNMgF7Tb++OH4HD+QG+B9KXr030UjIdhccORt8TuaisWa2kuRXPBw
         sFxs3KXhSkXsCtfP7eAg6wTlEqY9cgZ3vi/NNkSzaxMzPk3+3RsEpTaHdhd6Uewewgr+
         V27TO34gNjjOXTXVvDQQWqtWT2OKWRaAMwVfW7D1d9Y/7AV2C0DzFZPtGbDzfR7XL5eq
         OIQo1mBz0qPH5Oe/OA9zQ7wXJQfh6qsQmJF7mdzSoofUB43qlxXKVy4MnFOf93I9Xc4Z
         wZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WSETGpuknowOrNpULzXf5KRkK3Dt+OJVL3JNHsD4O8Y=;
        b=Fx4Wuup8tpv4UnkPjAdJFwliNNRjuPcUGG57oCxULapyIzz0otT8LWpxB81pdop4bu
         JgAgG2IiUh/fpo3g0dAcxjT4TDzS0UZ34TPYTQTZ3e03fQuGannvgJyRwXzUn5lBG8UL
         +mKrpUYWlTyPzZgq2F3Y/OHglrzfHrZ4BufzW8wNku40R5QwDfj9KKXFjGIxQtoqZyjn
         +P8tO5ZqEcq/l4y383XAkfKKCuP1eYqPgoC3GJdjXj0RcSgxUS6Pi4TrbxtOiDV5LjZo
         hmz/c8xbTmjbhZWFmWGSuptazaVB1mLFR9+BHy+aEJV2g3qlkS/cMShzb5DA96IEVPf5
         rfRQ==
X-Gm-Message-State: APjAAAVy7BpEh+5/jTDAuUdg9a8MC92RRxw9mLzUl2N7XJj+oGddHJA/
        v7vVQGA77nCWoXBVuuiGo4s=
X-Google-Smtp-Source: APXvYqzbpwkmX4naJqwfGVdGCKos3PiCKSTwls2Nc0l5ya1q4f2BapfPRKarvkQ+uN04tFftAPRbhA==
X-Received: by 2002:a17:902:426:: with SMTP id 35mr17363649ple.302.1578970356135;
        Mon, 13 Jan 2020 18:52:36 -0800 (PST)
Received: from google.com (240.242.82.34.bc.googleusercontent.com. [34.82.242.240])
        by smtp.gmail.com with ESMTPSA id o184sm14717817pgo.62.2020.01.13.18.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 18:52:35 -0800 (PST)
Date:   Tue, 14 Jan 2020 02:52:34 +0000
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Cristian =?utf-8?B?VMOicsWfb2FnxIM=?= 
        <cristian.tarsoaga@gmail.com>
Cc:     git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>
Subject: Re: no documentation for - git subtree
Message-ID: <20200114025234.GB24302@google.com>
References: <CAA07yUgTW9-ba_Hynoj16sX4892FUhLxSy_fPwyc6p4aHb4fzA@mail.gmail.com>
 <CAA07yUhYMM8MkC0rdE5OGStjycgQbp8bnk1VTBhZEgRLFHz2ew@mail.gmail.com>
 <CAA07yUiCvVc_GhyWwXpvOmSuJroSHTspAqVNgHPCNpv=4+=SyQ@mail.gmail.com>
 <CAA07yUjg0q0r7PvALU4h4ZMicHySnhXL+ryXQAy_GYYZhvac2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA07yUjg0q0r7PvALU4h4ZMicHySnhXL+ryXQAy_GYYZhvac2A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(cc-ing the git-subtree maintainer)
Hi Cristian,

Cristian Târşoagă wrote:

> I just noticed that https://git-scm.com/doc
> shows no documentation for the git subtree command.
>
> 1. Is this the right place to report this problem?
> 2. Is it missing or am I wrong?
> 3. How can that be fixed?

You're in the right place.

"git subtree" is not a standard command in Git itself, but is
contributed software in its contrib/ directory.  Its manual should be
readable on any machine that has git subtree installed, using "git
help subtree".  If you have HTML documentation installed (e.g. on
Debian, if you have the git-doc package installed), then you can use
"git help -w subtree" to view it.

Thanks and hope that helps,
Jonathan
