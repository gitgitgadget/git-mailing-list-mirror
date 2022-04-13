Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6740C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 05:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiDMFmw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 01:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiDMFmk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 01:42:40 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B7F205F9
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 22:40:20 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso1012351pjh.3
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 22:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bYVeFuxQZdCx1TDrlb/8P+DH7E9if5Te+PeZDfHiZb4=;
        b=k8gIuImaImce7zEI368BLZdc1KqujExtydz9feOoM3zmDcdgpkah2yrug45w0IWFf5
         kEXYAo7kS9/LYMremrIPvNeZ8RGDTwZCh7gHmEFUY3QDJIeEmKeAqGHlUoezIcbECjSR
         RQRs3jPSnQ0b1c/38Q/+rSzX4Q+8P3oVnAgikERHRsMlkejDla/KZIL5CfGTU6YTcXn7
         kUUALgkeg8dUK9OL7bCWylii1ZryZN6y6PwGXdzYGgNkVAPLEbQcE5E1IUAkI8GDEN2M
         MxFq+hMMQAp6KYTtlmNjJJHKV9e9QaU+t7D+sHG219p1i8WR8TVJ9vDBg1V4oqqyw35e
         wXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bYVeFuxQZdCx1TDrlb/8P+DH7E9if5Te+PeZDfHiZb4=;
        b=bYEMLVPgAkBF+RyeaGETMwPRK6pUj2VHrvfasXp6i4VMWE0TFehDyZIk+UqkQ8R2aM
         3XJQX5yq9yxWanzBaT0YWJwyoOYRAITq0TaIyZ1Av/upmzLCBvWzfVuqWhKclPYaJjWJ
         LwWpddIJHsS/l2MJDHNZfJLssr8yuFgd+KmS447Kg7KMUEQ8pRmUZizLR6Tq2MaJl3/g
         Y8ZXkRBcqZ1lWKA9rNqzeHVglyDtirfBP+FqEtsN9W7TX15w0jXL3h7CQO5AxzIHOUBc
         TYiA/PJJ4D7Xh3mO9LcPHhdxJNLxvF9RQ4tNrZ7BnTCBf2xWsv7BdCYoRbZ2dszEY3zk
         u5wQ==
X-Gm-Message-State: AOAM531Qvv8JuR9JoVQvZqQ0Ktf+8DZInzr7p/ONeJIkTFe9mCmsRp/U
        2JJ9itwOqfEbU7g0z1XMslI=
X-Google-Smtp-Source: ABdhPJxRZN8PocNBZQX7snE7cCfGEy14hMmgN2ovXANT0myNK93yJUOYKHeQ9IqmF/nEdzthGxh3aQ==
X-Received: by 2002:a17:90a:6781:b0:1cb:11f0:9c51 with SMTP id o1-20020a17090a678100b001cb11f09c51mr8851795pjj.243.1649828419499;
        Tue, 12 Apr 2022 22:40:19 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:1f54:1578:a9b9:677d])
        by smtp.gmail.com with ESMTPSA id gt14-20020a17090af2ce00b001c701e0a129sm1391484pjb.38.2022.04.12.22.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 22:40:19 -0700 (PDT)
Date:   Tue, 12 Apr 2022 22:40:17 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     rsbecker@nexbridge.com,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        jurgen_gjoncari@icloud.com, git@vger.kernel.org
Subject: Re: Make commit messages optional
Message-ID: <YlZiQemrAuryF0vv@google.com>
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
 <YlC3devsgmv17PnQ@camp.crustytoothpaste.net>
 <00ca01d84ba0$dd7ee0c0$987ca240$@nexbridge.com>
 <20220409113244.GX163591@kunlun.suse.cz>
 <CAPMMpoi50j7MzrsokQAcBWBgj8qGPN=j68PuEsppv629Oh7GHg@mail.gmail.com>
 <013101d84ceb$afaa51b0$0efef510$@nexbridge.com>
 <013201d84cee$3e8d88a0$bba899e0$@nexbridge.com>
 <CAPMMpohnwTTwTEjr9u29O_qVJtQNuG29G3Ta+-rXz-De8zvMCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPMMpohnwTTwTEjr9u29O_qVJtQNuG29G3Ta+-rXz-De8zvMCQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Tao Klerks wrote:
> On Sun, Apr 10, 2022 at 5:18 PM <rsbecker@nexbridge.com> wrote:

>> And I still don't get why the --allow-empty-message is not
>> sufficient to meet your use case. git supports what is being
>> requested already, not that it is allowed where I am. Are we
>> talking about setting --allow-empty-message as the default? That is
>> a major behavioural change. You could create a git command alias to
>> always specify this option. So what is the point of this?
>>
>
> My proposal is that it absolutely is enough, functionally - but the
> abundance of "we should change something" concerns in this thread and
> elsewhere suggest, to me, that it might not be sufficiently
> discoverable; hence the "advice" proposal.

Thanks for this point.  I find it to be a very reasonable one.  I'd be
happy to review a patch adding an advice item when people use options
like '-m ""'.

Sincerely,
Jonathan
