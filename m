Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13D01208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 23:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbdHOX1W (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 19:27:22 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:33942 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753141AbdHOX1V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 19:27:21 -0400
Received: by mail-yw0-f174.google.com with SMTP id s143so13495528ywg.1
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 16:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eOrT75msMNg4aiuPqd29x9uWbj/mxmHgzHlbV28Q4Ig=;
        b=BIoeKoocSuv2O1tnFX2/9FSVf7I39uvOPOPp1USS4rY93+9QvYnFxKPaI+WGsq4uIq
         +RhvBFOu4PjB4LWdgTCudxAy9N1QPP4zQIZt3V1k1J2baC6xo32f6y+JSQ/0PlG9qZFg
         aggUdSCW1zb+lHIVHKoZ1siFlpQUEVLuflt8jvN+EWnw9fln9i0s2VYd4AoRynWYbeZS
         lPPp8Usg1Z4QiDyCsnNChOJBgwTZaYJHVb6J5TaLpW4ipDmBpVp/Tq5H50KhlorIU0zb
         bZ6oiHOJvpO7e+hlntHhnOAZqQMO9UbTA/4qzE8VS9K1P7A90DEb9vX538ZEqwIxjyYF
         EdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eOrT75msMNg4aiuPqd29x9uWbj/mxmHgzHlbV28Q4Ig=;
        b=MMMtP1pmbBRDUcDp91cxyyxSXx/buI0fW5H/rXqyCAZZRdHH+QpRHKkC7EEyhUoYto
         uKQYZrLCYWDe5nyQF6Ms0vdNcaqPcacmH4qlrV5RbucBlPkoSUPRcTH4T5D9aYi9+BQv
         Tvuf0TIOej7E0gKmlIEL+sey6WWGS8KXFe2AIw6yRGn2ZerMTuCwjDo5pJWMAxKcLe90
         +cw80mm9ruJfeU0Hof/EffpSWJgqVqEIHlNpqvhavt0VFlUShzaBXaSXAlXQKDlndslU
         LkFBvG1I4OL5RqInWANwwfjJRj2ZGL5/3tK3Q2oOoUb8Hxm1En8zBkaYilqDDoPne8l3
         OxSA==
X-Gm-Message-State: AHYfb5iqWGuyKT5yAX+y3wcIE1T62dYe1sQ7not7izzF3a2Vik25JzI0
        0j5tw2mKjQZhBSbTrMMdPP0nPRq+Lj6gWbY2Iw==
X-Received: by 10.37.183.130 with SMTP id n2mr13384118ybh.353.1502839640856;
 Tue, 15 Aug 2017 16:27:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Tue, 15 Aug 2017 16:27:20 -0700 (PDT)
In-Reply-To: <20170815231414.GF13924@aiede.mtv.corp.google.com>
References: <CAGZ79kZouNBxOKr7X8j6wqebp3Wh3cDqhYR-t_PxaF7AwQ0Wzg@mail.gmail.com>
 <20170815224332.22730-1-sbeller@google.com> <20170815231414.GF13924@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Aug 2017 16:27:20 -0700
Message-ID: <CAGZ79kb2LJ=o0JhL77KY9aYgkQf+M_EuKhOP=UocJERAa4Gfxw@mail.gmail.com>
Subject: Re: [PATCH] push: do not add submodule odb as an alternate when
 recursing on demand
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 4:14 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Stefan Beller wrote:
>
>> Use is_submodule_populated_gently instead, which is simpler and
>> cheaper.
> [...]
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -966,7 +966,9 @@ static int push_submodule(const char *path,
>>                         const struct string_list *push_options,
>>                         int dry_run)
>>  {
>> -     if (add_submodule_odb(path))
>> +     int code;
>> +
>> +     if (!is_submodule_populated_gently(path, &code))
>>               return 1;
>
> Ah, I forgot about this detail.  I don't think it should block this
> patch (so my Reviewed-by still stands), but I wonder why this needs to
> be gentle.  add_submodule_odb is gentle so that is the conservative
> thing to do, but that doesn't mean it is the *right* thing to do.
>
> If this passed NULL instead of &code as the second argument, would
> anything break?

push_submodule, which is called by push_unpushed_submodules
just issues warnings on submodule push error, (which happen all
before the main push,) such that any submodule error does not prevent
the main push.

We could tighten that, but I would suggest another patch for that.

> Could there be a comment explaining what kind of error we are
> expecting and why it is okay to continue when that error is
> encountered without any error handling?

The same as in add_submodule_odb, digging through the
logs. I up to now we did not care about the submodule succeeding
as much, it was just an aid for the main repo push.

>
> Thanks,
> Jonathan
