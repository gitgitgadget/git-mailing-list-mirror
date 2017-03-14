Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D219D20951
	for <e@80x24.org>; Tue, 14 Mar 2017 23:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbdCNXD4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 19:03:56 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35974 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbdCNXDz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 19:03:55 -0400
Received: by mail-pg0-f45.google.com with SMTP id g2so332012pge.3
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 16:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VxhFQpirrXrjNtxPEvXpubmc2P5gM77rffuRsgWG3dk=;
        b=SvV3+D/+slrqxhqefmIhrOMJi75kRZjikDeIABaWwTrj7rPRO4oZmnAxidWlYbePqE
         Y/qlaLTfOEp/VGS5HaP1ZlVOnkEe1VE7h8YUXLf8I2EJkCKhoiy8SYu8aNa2PuHWllq1
         kT2G1eV7WmECQf/FMVvoYkjfollU/i6BdqDb9xPZ6lNjYFaWKVIf6PTNazZ7aF0QxobV
         UI9Ft0FOyCVhF3m1TjlAvVddZFWLY3bqvzp/Yxw6op2YjKtA6o4CEY/knIyl1foNH2VE
         yZt+DZeLeShPA/+wr3pgvYCGonaduJ9YQus/w4kYl3to5hc53+JQvvmCdf+QmnuirwJL
         83ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VxhFQpirrXrjNtxPEvXpubmc2P5gM77rffuRsgWG3dk=;
        b=oKDxP3wMGOZreKZmIbBRsb/kKQ5HEzBjNZK9wdiPDunb0Nh4To6jeJr1/EidvQ+hBr
         MzwS0i0hfVo31GsjZR3sM0oAgw7dgWCc8phUHi71z3NnTCSJeEYQhw5W61XJtv2vCOnK
         dZTyOR5Zi116ZyyCOgqx3zUAmlXGI9AtOGs4pw10yJ3jvRde5lS3IlldcHQYvZIcKss8
         6hbBQukWuetXdXn2MjHFkko0qI6YEweSEs9t7zhGEZcpTSVUpP3k3CgbCiY90Wk5wceC
         6im/lQN5vG8yVCiXpBLYVjxsvPYop9YxLxp6pqQOmbwhI8xD+TsioY2tpI2uWAg1sMNg
         A7Hw==
X-Gm-Message-State: AFeK/H29aXpDnGsH+0TpugVguOSvW8Kyf6vllc4YLJC+FsrE3YG2lQp+X2vif85kA83yZxQJ+wTKjdgMxM+Z6f9w
X-Received: by 10.98.112.134 with SMTP id l128mr162100pfc.81.1489532634097;
 Tue, 14 Mar 2017 16:03:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Tue, 14 Mar 2017 16:03:53 -0700 (PDT)
In-Reply-To: <20170314221100.24856-4-bmwill@google.com>
References: <20170224235100.52627-1-bmwill@google.com> <20170314221100.24856-1-bmwill@google.com>
 <20170314221100.24856-4-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Mar 2017 16:03:53 -0700
Message-ID: <CAGZ79kY0d45SB8JHWO6jo+WTQQLsZ2jMSVEeeKPjWG7FkJTryA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] grep: fix bug when recursing with relative pathspec
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 14, 2017 at 3:10 PM, Brandon Williams <bmwill@google.com> wrote:
> This patch fixes the bug by passing the 'prefix' to the child process.
> Now each child process that works on a submodule has two points of
> reference to the superproject: (1) the 'super_prefix' which is the path
> from the root of the superproject down to root of the submodule and (2)
> the 'prefix' which is the path from the root of the superproject down to
> the directory where the user invoked the git command.

Would the information of this paragraph also be well suited in the
documentation?

(1) clarifies what the super prefix is.
(2) maybe the docs or this commit message should talk about
  how the prefix is relayed, i.e. it doesn't set 'prefix' in the child,
  but it reads GIT_TOPLEVEL_PREFIX_ENVIRONMENT and
  acts on that as (2) ?
