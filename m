Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04A451F454
	for <e@80x24.org>; Mon, 11 Nov 2019 19:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKKTvW (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 14:51:22 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:34163 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKKTvV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 14:51:21 -0500
Received: by mail-lf1-f45.google.com with SMTP id y186so5029237lfa.1
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 11:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=myitcv.io; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=WYbarlJeJA6gRjMNRIQlF8rvO4/MDDlNIvvI8CMmI/U=;
        b=fTjSByNeLqNaj/jd4HUFSrpDiysOn77T2xw4AtAvbz0Xxg+0GyIRSgSg4qZmUMMkCf
         jygsqTtdY0Vc1YBQhuEOHd4SwlDo6p/DiD7u0eXFckXP/71x40DhkaHsrQ0idlUhd56a
         J4vuqIdwNGTt84NjwLiQNinvtw0yDaioBmj6wrda9X2Udc/AOpASPJoKU+DkBvAaWhAg
         2oc3d4rOqEXKhsoFQOj9nWcpvqwzaKuy1ffoEA0ELxluUeQqzzs/EQTLLbyfJk0svi9/
         TKqIDZTReMCPDRq12lg109Lb4pHr4QyOvXCFEw/15DnA3z3yySFlTiUR4WndWPxQ7Nou
         I4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WYbarlJeJA6gRjMNRIQlF8rvO4/MDDlNIvvI8CMmI/U=;
        b=uTiPwqmClG791UkumNX1kSEjFoJM/5YbzTmznPY1vQVghfdGyFQdvH6Q3HlLXSQJQQ
         5GgDzZ1wBu4u4784a4dzD6SUPS2NgXtrGj0RRbCiVx6IlxGe2wafedGRAs4ty51Bg1h/
         K6RDPKjLKH+tXjQd7mGObhhnjz3lZ/YSMpy+kYoVX1DL6s4dsSe9cnLsMwefrz2uvO9z
         NTIdGqPxV5c1A/JYdGJm5vRBLYXsAo1dg9GzTpySjE2KqupsgBMbOoBmKpofTs433bYW
         STNE16coRa4xcO2B+wq5ILN6Y6lzyXB7o0zkVk66Q7SA31crqa7z2buhZOInFj1s9Wa8
         p04A==
X-Gm-Message-State: APjAAAWe0MIxUMhcfZefjMyXdycgH0dNOafGonUV2hc+hzaEA5iErEDo
        kmW0qix1iFiK3q0PRwroXf7PoOfisjysYPlnZasJuJl7IS9LaQ==
X-Google-Smtp-Source: APXvYqz78tSh2eoY1m0MtYlb3Iaw5zLrj2oUfTzdfPQjp1xksk7wpw7+G+gAErKsaSEKkWjpRiEoGjplxh1Vcgfs1D4=
X-Received: by 2002:a19:848a:: with SMTP id g132mr8499870lfd.62.1573501879364;
 Mon, 11 Nov 2019 11:51:19 -0800 (PST)
MIME-Version: 1.0
From:   Paul Jolly <paul@myitcv.io>
Date:   Mon, 11 Nov 2019 19:51:08 +0000
Message-ID: <CACoUkn6D0cUmN1RbcpfERcOJsbGLdwj6oDeF2oRADV+rX2artQ@mail.gmail.com>
Subject: Bug in bash completion for git rebase --onto
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

The bash completion for git rebase --onto seems to have been broken by
commit 2b9bd488ae09dc89f02be7d73f3710ee2ea7325c

Previously (v2.23.0), hitting tab after

    git rebase --on

gives:

    git rebase --onto

(note trailing space) hitting tab again offers a list of potential
refs onto which to rebase.

As of 2b9bd488ae09dc89f02be7d73f3710ee2ea7325c, hitting tab after:

    git rebase --on

gives:

    git rebase --onto=

but then hitting tab again offers the current directory contents as
candidates, i.e. not git ref candidates as they should be.

Note the adding of a trailing '=' is, I think, more correct/robust
than the trailing space so I don't disagree with that change. It's
just the failure to offer git ref candidates that is the problem.

Thanks,


Paul
