Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 050141FAFB
	for <e@80x24.org>; Thu, 30 Mar 2017 09:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932274AbdC3JZN (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 05:25:13 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:35924 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932189AbdC3JZM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 05:25:12 -0400
Received: by mail-oi0-f54.google.com with SMTP id r203so25145547oib.3
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 02:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BdZcRMVTJOUB03PKazwEcPF2lXX7BweYdd4m1WC+TFk=;
        b=FbGCJqEC+u5q40TsvNPHQZUz3/XheoZfIJApYy7oauVxyBrbuLflbtwp7GaRRqK8UW
         P3P/sD5dQneQjIzhKVWcS6SkyZQeGDPfhpg+086lZvLSYJZlnyYmTqIc483gSdtaYJN9
         xujBjJAoowEFTJRfAoMB5M2iElFubZhaInlMIUunINrS6Gvbspat5nGBQ6b7d6ELYutQ
         g9PN5zXrM8OnwGVnkJ7DCeS0H/UVIPND7H0swIMeRKZIIWGNCpXPhQHmfiWur42yGg/g
         sPQl9gZT/UrtDYBICGk3RCwRxf7hZK4i68UmEmAjdE+XqL98lfSU1Y/erHBfJrqxsdHf
         Yopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BdZcRMVTJOUB03PKazwEcPF2lXX7BweYdd4m1WC+TFk=;
        b=I1QpIBdEcBLSqvYEWhg9rnW4tEyqPw7zkFHJIGi9CCJvdXTIJqGuvF/W4FmWEXuwhB
         nfQJfmX7Upy+kHRBpRLVTSlOyrmaXpc8kixrBFLQcnqAuoJfALqU4hDUn0TQygIzoLw9
         K8u1SXB8Wvn7yrEo/1gZBH06ZCurfFSLqdV3RApwnGQEdZd+cGBkko0QNdehwC9LS2nc
         xVDzz1mJ9nt+lzu64YBZ8IqJQgTJi8j7BWRAIIVEIBSQ4uDq0RGj0/brqqZy5gxbRUJM
         oc06BAgPqdpgNtxe/vsodzgdsRpwKIMFmU/tLEnqcNDrCfOVX5tEAjNtz1z0VRx+494O
         tvag==
X-Gm-Message-State: AFeK/H2G+aVQyjK9gakmcfbEnQygZ4RBzYLM4sE4IvQGQ+8RoQuOjoodzOWjIXdOsdwy7LgphSC4ZGvQLeBlYw==
X-Received: by 10.157.46.145 with SMTP id w17mr2859788ota.225.1490865911082;
 Thu, 30 Mar 2017 02:25:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Thu, 30 Mar 2017 02:24:40 -0700 (PDT)
In-Reply-To: <20170329175614.uecvtvmzoj2wfle3@sigill.intra.peff.net>
References: <20170329080820.8084-1-chriscool@tuxfamily.org>
 <xmqqfuhwau6r.fsf@gitster.mtv.corp.google.com> <20170329175614.uecvtvmzoj2wfle3@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 30 Mar 2017 16:24:40 +0700
Message-ID: <CACsJy8BR9=Ju_7tSmZEH+UDqWG3Ud1KXY-m6r_jHb-aQUoUMAg@mail.gmail.com>
Subject: Re: [PATCH] read-cache: avoid git_path() race in freshen_shared_index()
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2017 at 12:56 AM, Jeff King <peff@peff.net> wrote:
> But in the end it doesn't really matter. I think code like:
>
>   const char *filename = git_path(...);
>
> or
>
>   nontrivial_function(git_path(...));
>
> is an anti-pattern. It _might_ be safe, but it's really hard to tell
> without following the complete lifetime of the return value. I've been
> tempted to suggest we should abolish git_path() entirely. But it's so
> darn useful for things like unlink(git_path(...)), or other direct
> system calls.

Yeah. I thought we killed most of those (was it your patches?).

I had a quick look at "git grep -w git_path" again. The ones in
builtin/am.c, builtin/grep.c and submodule.c look very much like that
anti-pattern. The one in read_index_from() probably should be replaced
with git_pathdup() as well. Sorry no patches (I'm very slow these
days).
-- 
Duy
