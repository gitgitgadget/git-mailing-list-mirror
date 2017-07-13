Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04A2B20365
	for <e@80x24.org>; Thu, 13 Jul 2017 20:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753183AbdGMUt1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 16:49:27 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35559 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753205AbdGMUt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 16:49:26 -0400
Received: by mail-pf0-f193.google.com with SMTP id q85so8413720pfq.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 13:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h02AAjjlYYBco5+c9nfxcLYf3ZfF2R5zfYqG/y8U8EE=;
        b=ppL69Bf/A8PZBg8gCYp3YwCpfZo9MlDPXSgiIqIaxUBaLCD4VChQKBRAAoMeVVufuE
         aHORbSLlJxlKwMAmtsV8du9yhOXy69pz/oWpdrsWXU2tQ+WlcoApSxeOSmmQKBH7+kHN
         VZTe4qiocGRm1Lb+ou7flYruSyFVNHq/sqsrg/WjdkMvQC/s8ClgDjqSXpEv8TSC8uD9
         ttrw9CkzijKuEpBYMDYWe/TgOd8LTInu6YOiVttbVtt4L/+Crd+91xbeZ0tJ5sO67aW/
         4g+IuxR2uNFcN+9QYYuc25ynpeOcO9mT2ulQYHfyMl45R30ytRNsSU6if4G2Txq3yi5r
         UmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h02AAjjlYYBco5+c9nfxcLYf3ZfF2R5zfYqG/y8U8EE=;
        b=KdZGoU8XqmUGA0AcXgFkZ4aSs0v7x5yELZymHuZWlw6hGCaFWrbe3x56vrihE4pdrm
         1HJLFtkOlA1ippAhpmbKsW8xfem7XtwsW0a/606uU1rcK5HQVSLIyoKeSgFVRt0el6u9
         t531aPqHkiGCEWTEF8nlZoevccXUHaKio/B3su8ZOJKrsqQge8tvwebwe7qS8io8By+e
         hKd+AqC8YsdNkLzAlrIuoX+u+M0Csulcw+TSkKM7QUf52G0FNqaq16/SaMAVSPEHNowD
         8AgluVxCtuGirSJpkOsiYQzkR19fmdbp4df8Ld59Tztk61ZJvni6vxMAZ2rWCo29GU6M
         OUzA==
X-Gm-Message-State: AIVw112abreQZukxCwRtsD1AjXMZFZ5qcS+m7skXHYFCZBgpOgPRZ/gq
        0rT4MyIH85PxCQ==
X-Received: by 10.99.163.26 with SMTP id s26mr11245211pge.232.1499978965300;
        Thu, 13 Jul 2017 13:49:25 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5f:87d5:d3a8:6694])
        by smtp.gmail.com with ESMTPSA id g79sm14004420pfg.121.2017.07.13.13.49.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 13:49:24 -0700 (PDT)
Date:   Thu, 13 Jul 2017 13:48:54 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] submodule: use cheaper check for submodule pushes
Message-ID: <20170713204854.GA158114@aiede.mtv.corp.google.com>
References: <20170712234504.15811-1-sbeller@google.com>
 <20170713000117.GJ93855@aiede.mtv.corp.google.com>
 <xmqq60exyx5k.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaHX-YCMv01T-QE=mYeymjTnwrpg9-bsOrCjg3NWEunDA@mail.gmail.com>
 <xmqqa848xjxr.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYtRbHvfC6d=+eEXCceJam4wwo9XqvY752c_pg6kq90DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYtRbHvfC6d=+eEXCceJam4wwo9XqvY752c_pg6kq90DA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> Yes we are safe, because the function itself only spawns a child process
> (not using any of the objects).
>
> It's only caller push_unpushed_submodules also doesn't rely on objects
> loaded after calling push_submodule.
>
> The caller of push_unpushed_submodules (transport.c, transport_push)
> also doesn't need submodule objects loaded.

Thanks for looking into it.  This is what the commit message should
say to help reviewers or people trying to understand it later.  The
footnotes don't help and are distracting, except that it makes sense
to point out the original GSoC patch to say the alternate submodule
odb wasn't needed even then.

E.g.:

 Subject: push: do not add submodule odb as an alternate when recursing on demand

 "git push --recurse-submodules=on-demand" adds each submodule as an
 alternate with add_submodule_odb before checking whether the
 submodule has anything to push and pushing it if so.

 However, it never accesses any objects from the submodule.  In the
 parent process it uses the submodule's ref database to see if there
 is anything to push.  The actual push (which does rely on objects)
 occurs in a child process.

 The same was try when this call was originally added in
 v1.7.11-rc0~111^2 (push: teach --recurse-submodules the on-demand
 option, 2012-03-29).  Most likely it was added by analogy with
 fetch --recurse-submodules=on-demand, which did use the submodule's
 object database.

 Use is_submodule_populated_gently instead, which is simpler and
 cheaper.

[...]
> On Thu, Jul 13, 2017 at 11:37 AM, Junio C Hamano <gitster@pobox.com> wrote:

>> My hunch (and hope) is that we are probably safe, but that is a lot
>> weaker than "yes this is a good change we want to apply".
>
> Given the above (I went through the code), all I can do is repeating
> "yes this is a good change we want to apply".

With such a commit message change, this seems like a reasonable change
in principle (though I haven't looked carefully to verify it).

My one doubt is the is_submodule_populated_gently.  Why are we using
that instead of simpler is_submodule_populated?  The names and API
comments don't explain.

Thanks for your patient explanations,
Jonathan
