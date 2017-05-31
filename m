Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 493E91FD09
	for <e@80x24.org>; Wed, 31 May 2017 18:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbdEaSFU (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 14:05:20 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33497 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbdEaSEz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 14:04:55 -0400
Received: by mail-pg0-f41.google.com with SMTP id u13so1864109pgb.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 11:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9opJiuQSXRNYMECEjsDm7Ws/mtBgdNv2zFuRFSMvmYQ=;
        b=onBMpy5O70K3FWHRsyARRN2JUuUJjTT8af1J1yComtGk+fDFSCE/SJZ9evLOG1fEjh
         d8Z1b/b5qEXLot645f6zdGOrwu1AE/Ki0HRzAwo+eg0hDt6UWO41xMQb8r7gqa1NmKqX
         VgzXJlRF2RB98Y7T/GZuiWZi73BX/eel8vRBYo9KhowdkLj0i4eGTVkayfTR/h6p5HIt
         h5rS8le+u+zJcqblqx/Ws2DNKhVDyOGfifpr+vthEVyWqX5gss2+XlKpg5hTlB2y1faB
         AdPFcS3hVdtSzhOvVlR1r8X38rpaMmo3Udqt2Jvy8XWbuZlbZeQUrJ0YrUwzatWeUqb1
         uMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9opJiuQSXRNYMECEjsDm7Ws/mtBgdNv2zFuRFSMvmYQ=;
        b=AqCQaDoo7UfJebgKl2LnyPy8bMGOb+Kcs/8s7i9fHUMSV+C6H0oAzP8NqR0HVE1c65
         GFPkCxj//sUgJAo4xy4ud1vFXprc/YBSwDN+5fr0jrBxn/gfXJz/3XqKphDzgw8wks7H
         4KsM/iOTjjCHSQGCuw2jkvbA0Ct5mPP7LRRes1+AYrgb5BZIVZhoU+T/bwZgixU+hiTm
         pg9qvcFMGxsGI8ttLRG8CjTZ6dGrOgZlt0ULzP7/LP3jhXvlLgvC6PYDeEvuZ+5ADU6D
         giqwovnlbVhX8+e3dhzvRdhpwHB4nfmtz1dkOxOie+rr5AG9McimGTufibD2yLKJprPw
         aw1g==
X-Gm-Message-State: AODbwcAfQb9lSKcaWcWvouEGdZ/OrE71iS+XdgJupzHkJLak3OFD1BcU
        QI1CW7bTsTLtAiUmCZoXt/TPvpBzs0eX
X-Received: by 10.98.148.2 with SMTP id m2mr31740081pfe.194.1496253894733;
 Wed, 31 May 2017 11:04:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 31 May 2017 11:04:54 -0700 (PDT)
In-Reply-To: <20170530173109.54904-24-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com> <20170530173109.54904-24-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 May 2017 11:04:54 -0700
Message-ID: <CAGZ79kajzJGdN1uu5kni3AB31joP5hdnsWp1NBGkX3Rs-BkPpw@mail.gmail.com>
Subject: Re: [PATCH 23/33] notes-merge: convert merge_from_diffs to struct object_id
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -505,16 +505,17 @@ static int merge_changes(struct notes_merge_options *o,
>  }
>
>  static int merge_from_diffs(struct notes_merge_options *o,
> -                           const unsigned char *base,
> -                           const unsigned char *local,
> -                           const unsigned char *remote, struct notes_tree *t)
> +                           const struct object_id *base,
> +                           const struct object_id *local,
> +                           const struct object_id *remote,
> +                           struct notes_tree *t)
>  {
>         struct notes_merge_pair *changes;
>         int num_changes, conflicts;
>
>         trace_printf("\tmerge_from_diffs(base = %.7s, local = %.7s, "
> -              "remote = %.7s)\n", sha1_to_hex(base), sha1_to_hex(local),
> -              sha1_to_hex(remote));
> +              "remote = %.7s)\n", oid_to_hex(base), oid_to_hex(local),
> +              oid_to_hex(remote));

This part is interesting.

7 used to be the default abbreviation length for sha1s (see
e6c587c733 (abbrev: auto size the default abbreviation, 2016-09-30)
for details) and this may have been a left over from the conversion
to variable length abbreviated hashes. This could be a reminder
we want to fix these, too. (Though not in this series?).

Roughly like

    trace_printf("\tmerge_from_diffs(base = %s, local = %s, remote = %s)\n",
        find_unique_abbrev(base.hash, DEFAULT_ABBREV),
        find_unique_abbrev(local.hash, DEFAULT_ABBREV)
        find_unique_abbrev(remote.hash, DEFAULT_ABBREV));
