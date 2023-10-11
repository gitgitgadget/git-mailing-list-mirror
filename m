Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01500CDB47E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 21:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjJKVOL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 17:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjJKVOK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 17:14:10 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5C890
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 14:14:09 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf55a81eeaso2361775ad.0
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 14:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697058849; x=1697663649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nBn+wts5MjevDeiqFM3h4RTebNPK1LF1RGl7RAAKZ8=;
        b=biJjbCj0a3R5iNS4Ys5V8QZrVZOxAf9EpYNXs/wjUKAwIumLV7os8c9PZU+r+t6rf4
         kswcx3XrthrTugfghVQ8OWyctDWKHzVAdS3d4AMb3/MQWiXYlt0POkPOyCCrlzKqs7Io
         zk5lNw7oWSXHgK6rFyOgX5KA466MLJ+6iTDk38WZlDLliUhk62OaxLl+lFHhHXnWDYuB
         Qzp2Gz5zbnutfefp+lT8vC/rBxkBHeDfMKw+s4e5J1qLfGvXpQ5bEwYFf67KwY2deCeq
         yC9klcU5rJJqb/u0PtwYQ7yzSaJh6VLaZfJKolXzm2W+T1RJWkJQwtZgClZFL23MNcnr
         o+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697058849; x=1697663649;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nBn+wts5MjevDeiqFM3h4RTebNPK1LF1RGl7RAAKZ8=;
        b=j95cBtzx58x/1flNsg37I6W2u2KsNRlu9OX0tt1oRFDpiwbDPWyT26OprXVv/L1H+U
         InEGc+wGr8swyKsDVZS07pbJWj6WL3+VZ8vxyAL1obd6txVICDSh2kiORpDJGyOw1zxV
         vIwKYTM/6c+ofalqUwTY3TgGU6Ry2jXNpJz+I5z/jhwCBCdTdBpB/CsrfX8xU38We5Jq
         QAHHZt7a8SgbXuG+9RF89Sd8CLh3oWIEuck4VaAR6l+9lQ23pmk3RbRtXZZuMvkUVFiI
         SlL1cwJScweHOthKKabnX8cgQif9QwmnJEmFHvldF7J2g0H8ztMUsOq2ap7NKZ8ICpgd
         /wQA==
X-Gm-Message-State: AOJu0YyDUXNpKz4ihtk7wXNcziO6hJOx5tgsx6XLk0hlF0iowJ+7Wt9/
        hD23HnJMib2I3DrqH38xSGEWHQ==
X-Google-Smtp-Source: AGHT+IFGv/BdJrzXvBvZ1mqAPivUpyCeMGrgxrxWfwcwdWTPbBnO7uma7Rar/p173XknYCa+D3eW+A==
X-Received: by 2002:a17:902:d507:b0:1c8:a68e:7fc with SMTP id b7-20020a170902d50700b001c8a68e07fcmr10822336plg.53.1697058848828;
        Wed, 11 Oct 2023 14:14:08 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:9014:3d3a:f5c5:3ebf])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b001c61073b064sm299488pll.69.2023.10.11.14.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:14:08 -0700 (PDT)
Date:   Wed, 11 Oct 2023 14:14:03 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com, linusa@google.com,
        calvinwan@google.com, gitster@pobox.com, rsbecker@nexbridge.com
Subject: Re: [PATCH v8 1/3] unit tests: Add a project plan document
Message-ID: <ZScQG5QHznMEGzhC@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org,
        phillip.wood123@gmail.com, linusa@google.com, calvinwan@google.com,
        gitster@pobox.com, rsbecker@nexbridge.com
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1696889529.git.steadmon@google.com>
 <81c5148a1267b8f9ce432a950340f0fa16b4d773.1696889530.git.steadmon@google.com>
 <ZSUR+YdzqNTSB0XC@ugly>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSUR+YdzqNTSB0XC@ugly>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023.10.10 10:57, Oswald Buddenhagen wrote:
> On Mon, Oct 09, 2023 at 03:21:20PM -0700, Josh Steadmon wrote:
> > +=== Comparison
> > +
> > +[format="csv",options="header",width="33%"]
> > +|=====
> > +Framework,"<<license,License>>","<<vendorable-or-ubiquitous,Vendorable or ubiquitous>>","<<maintainable-extensible,Maintainable / extensible>>","<<major-platform-support,Major platform support>>","<<tap-support,TAP support>>","<<diagnostic-output,Diagnostic output>>","<<runtime--skippable-tests,Runtime- skippable tests>>","<<parallel-execution,Parallel execution>>","<<mock-support,Mock support>>","<<signal-error-handling,Signal & error handling>>","<<project-kloc,Project KLOC>>","<<adoption,Adoption>>"
> > 
> the redundancy seems unnecessary; asciidoc should automatically use each
> target's section title as the xreflabel.

Hmm, this doesn't seem to work for me. It only renders as
"[anchor-label]".


> > +https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmail.com/[Custom Git impl.],[lime-background]#GPL v2#,[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,[red-background]#False#,[red-background]#False#,[red-background]#False#,1,0
> > +https://github.com/silentbicycle/greatest[Greatest],[lime-background]#ISC#,[lime-background]#True#,[yellow-background]#Partial#,[lime-background]#True#,[yellow-background]#Partial#,[lime-background]#True#,[lime-background]#True#,[red-background]#False#,[red-background]#False#,[red-background]#False#,3,1400
> > +https://github.com/Snaipe/Criterion[Criterion],[lime-background]#MIT#,[red-background]#False#,[yellow-background]#Partial#,[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,[red-background]#False#,[lime-background]#True#,19,1800
> > +https://github.com/rra/c-tap-harness/[C TAP],[lime-background]#Expat#,[lime-background]#True#,[yellow-background]#Partial#,[yellow-background]#Partial#,[lime-background]#True#,[red-background]#False#,[lime-background]#True#,[red-background]#False#,[red-background]#False#,[red-background]#False#,4,33
> > +https://libcheck.github.io/check/[Check],[lime-background]#LGPL v2.1#,[red-background]#False#,[yellow-background]#Partial#,[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,[red-background]#False#,[red-background]#False#,[red-background]#False#,[lime-background]#True#,17,973
> > +|=====
> > +
> i find this totally unreadable in its raw form.
> consider user-defined document-attributes for specific cell contents.
> externalizing the urls would probably help as well (i'm not sure how to do
> that best).

Ah yeah, user-defined attributes definitely cleans this up quite a bit.
Thanks for the tip!
