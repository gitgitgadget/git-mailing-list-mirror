Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFE4F1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 23:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbdAYXEK (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 18:04:10 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:33592 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbdAYXEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 18:04:09 -0500
Received: by mail-io0-f176.google.com with SMTP id v96so26194750ioi.0
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 15:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=po5+I1EqI+OgLtzRB8bzSmsC6UxIcA5bRJG2Sg5+MJE=;
        b=OHb7E05maYgaEDJw4iPATzOifn2V7hcEkj1uQ05IIUxTcFc2DB+VFNh1cDiFT1H+zX
         Z3VZ5wuqb6ZGAtTxXp1WuvURqOy0giRkybAtcfzH74PQFyA/RwWcuyC4HDE5AyGrm/0B
         N+/hclpCUhsmvngLyTV+u2uxDus4HGV75chXd/LiOQbqW22VjcZ+n5aN7Lb4nPs1OVM7
         rYEDXh+0NYjultHgiH320g0lFoqYUEIsoUxW0Iignn1yHibMhobjr69BCps+G/dLcwvE
         8T9/A8AAz/hMcOnps4c6b8lQNVAeNvRlzcPkSuqw7bUXxzjJ0m1yCne01ZIFdrDVSBEN
         KSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=po5+I1EqI+OgLtzRB8bzSmsC6UxIcA5bRJG2Sg5+MJE=;
        b=NtSsas1DmXtBQcuPyyR/jtID8jKPu0j2sysZ/Sw/POOVAESVzNVzZ5WUlZ3Xvq4jdZ
         tu/G1Ev4mwJNmpWQcPydTJLjIrw18fonzprTFCvki796Ey3+xtevFTjBg+6KZhntNUf0
         2KcYdhIYAwW1mZo5mF/OI36zeN0ntUzc95TIzosDK7bpnUApX33OPztnoANkkH780LdW
         ex1xJ4kpLozJW2lXe2mrKRRwAdJBNwn71fjx9x8lUE2dX9odEinEfEDTgJSQOdc2YX13
         jK1ulv/2O56cl1PGG9xiqm0w5yuLTPSt/UwbiirJwdLKH9RfLSUJxEFgDSpF0D6F1JHW
         4+lg==
X-Gm-Message-State: AIkVDXI63Y/ops8dmm//cihwsP9S0V4F0YtvGFHtfn0ox1J7fYZ46NcmOF6Cg7dA4NBRfx4BYwuLYZKhAlwT/jIi
X-Received: by 10.107.16.14 with SMTP id y14mr263050ioi.164.1485385448841;
 Wed, 25 Jan 2017 15:04:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 25 Jan 2017 15:04:08 -0800 (PST)
In-Reply-To: <20170125004610.GC58021@google.com>
References: <20170124221948.GB58021@google.com> <20170124235651.18749-1-sbeller@google.com>
 <20170124235651.18749-4-sbeller@google.com> <20170125004610.GC58021@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 25 Jan 2017 15:04:08 -0800
Message-ID: <CAGZ79kaSQ8YE2S2MuaaOo9HeyHL7A66Ug9aO_j7F=o2e5RO6iQ@mail.gmail.com>
Subject: Re: [PATCHv2 3/3] submodule absorbing: fix worktree/gitdir pointers
 recursively for non-moves
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 24, 2017 at 4:46 PM, Brandon Williams <bmwill@google.com> wrote:
> On 01/24, Stefan Beller wrote:
>> +             connect_work_tree_and_git_dir(path, real_new_git_dir);
>
> Memory leak with 'real_new_git_dir'

yup. :(


> The scope of 'real_sub_git_dir' and 'real_common_git_dir' variable can
> be narrowed.  Move their declaration here and free it prior to exiting
> the else block.

ok.

> 'v' isn't ever used, just use starts_with() and get rid of 'v'

makes sense.

>
>> +                     relocate_single_git_dir_into_superproject(prefix, path);
>> +     }
>>
>
> There's a label 'out' at the end of the function which can be removed as
> there is no 'goto' statement using it.

We do use it in

    if (err_code == READ_GITFILE_ERR_STAT_FAILED)
        goto out; /* unpopulated as expected */

I took your proposed SQUASH and removed the goto, see the followup email.
