Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAB0520248
	for <e@80x24.org>; Mon,  1 Apr 2019 22:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfDAWbt (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 18:31:49 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32848 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfDAWbt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 18:31:49 -0400
Received: by mail-ed1-f65.google.com with SMTP id q3so9881476edg.0
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 15:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=q48DaaW0t3Wp3YxAByKerh3lvJzyXnWNlwMUCGdkfsQ=;
        b=t39sMz5xNUSZ3nr+9vEpAcc+jcQu06c8Bn1MZFlnDfv+ayEf9NkwEi2ogjo2dyda0D
         rhDQSG1yhuwF+YsbBZFCRmZJrbiefdu/OAeB0delIdgghcJA8tfNVhAOg0WLXVAa/dx6
         zoIq6Mc2JeLS6vy6nhk6KPuUnSDiD3wu7n5yW8AdzK3t9MRSNClSWdHQ/q2uiXFUcWSk
         Inx64D+V09F/tDQBdtgYrjoarKnZq/zX9P+YqEdd+IxXJgqpnXTNY4EvVqb5TA7pCPPM
         puM8sSuU//J7Rdim9xwXtNHffJjHyVh2zUacqJnkvCktzTxC7pQf2SOTrGizA9MlyMwJ
         Bp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=q48DaaW0t3Wp3YxAByKerh3lvJzyXnWNlwMUCGdkfsQ=;
        b=l1npk0sJ95e4ppONZyMlODTYtf1qRld7h/uSG7EKsuymc158mMAj03CY9QYvVJ046N
         zXmfYMmL6gaNgSGURaUBgEQm5cgVHkHs+9tWCppUAa9uiuYhq5+mbhhxaZjy3ERnU1Sh
         thP5kWzhsTrU+cU1lwhv79Jl/8lSfkSZg60ISJDjYliE7/psogtPK2o4TJx82L84JxyK
         bE/B5Ud84oP9r4txtklkIF5CX5NexffKjWGHU1w48Lcz32XNy1XEPRYW/PZiZoD68D01
         I2Fhj9BeQUQpNe0VwywMEFRA9bur1aED/aeTeFfF/ee4p8op1+Jw8+gwZimLud5exPaQ
         vkSg==
X-Gm-Message-State: APjAAAW7kSrInpZYyzjQh6dwGQR8kDv8PSRn02Xsiw1Ph/wl4wxARfyB
        sBra2m5IdQ7WPhIpdSxNX85pd5qQwlWhZSCVUYVmiqoh+pE=
X-Google-Smtp-Source: APXvYqxV5R15g2ZSTE2qT4UdvSlKBHNhrV3f3GWrtPNLiq26Or8FYDxsNfpgldVQ1Z7hkHWg67Wi3tz5lKEpbVKW63c=
X-Received: by 2002:a17:906:6c0d:: with SMTP id j13mr37463157ejr.249.1554157906624;
 Mon, 01 Apr 2019 15:31:46 -0700 (PDT)
MIME-Version: 1.0
From:   Chanseok Oh <chanseok@google.com>
Date:   Mon, 1 Apr 2019 18:31:10 -0400
Message-ID: <CAP5K-1YJN9jt_6yEbLs=ET6M2tRLMMoio65GJMsJy69Y+LCn1g@mail.gmail.com>
Subject: [Bug] git log - reports wrong date and time
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm using the latest version.

    $ git version
    git version 2.21.0.392.gf8f6787159e-goog

WORKS: the following prints out the date and time in my local timezone.

    $ git log '--date=format-local:%Y%m%d %H%M%S %z (%Z)' --format=%cd -n1
    20190401 170250 -0400 (EDT)

WORKS: "TZ=UTC" is respected. It prints time in UTC.

    $ TZ=UTC git log '--date=format-local:%Y%m%d %H%M%S %z (%Z)'
--format=%cd -n1
    20190401 210250 +0000 (UTC)

BROKEN: anything other than UTC reports wrong date.

    $ TZ=KST git log '--date=format-local:%Y%m%d %H%M%S %z (%Z)'
--format=%cd -n1
    20190401 210250 +0000 (KST)

The time is in UTC. Worse, %Z respects TZ=KST, which is in conflict with %z.

The symptom is same with "--date=local". It respects TZ=UTC but
nothing other than TZ=UTC.

Regards,
Chanseok
