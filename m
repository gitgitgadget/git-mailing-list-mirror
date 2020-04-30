Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93616C83000
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 01:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD312082E
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 01:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWuc3ZOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgD3BAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 21:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726279AbgD3BAa (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 21:00:30 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A7FC035494
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 18:00:27 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id v63so2025291pfb.10
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 18:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QDhZLIKBRo+Tjhb7U693lNPJqFLQuaXaAtTqlTDzjjM=;
        b=HWuc3ZOERhpL3T3JybQ0eoyDInoMOnNDMkuSGZiED6SRh5wP/6AE1xtVFje/3AKxpw
         RcFOV163JrVOuoRZIOEJAUr2qX1iPkL99hNe5wdx5F3QOe0w7a+Ll7xoJ2NayNVVw+VV
         3VN7B88cBCFRsqjUAeiV1b7vaDxRbNAG7qAThLrn1OaJexdpBbXUi08Mw6M/SuW9a8Nk
         wcAKM9QMg937QIsq8RpNC9Ss2uQzQyIZpYtRCR2jFECYykt/7N/86bSzCfCpCp0Zy1oa
         oGeOIZ0PPk7I10EYlTpiWBjYSW04QU5FwB1iFpamPEDH0DAMXOW+Py7oB+jupRCsb5WK
         wpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QDhZLIKBRo+Tjhb7U693lNPJqFLQuaXaAtTqlTDzjjM=;
        b=bpdplluKkNDng1UXPkOE1zy/l8wyuSQt83y5UT1nio+zJeCBDVq73f9jlUdgD10QFi
         h8bjeg741/6MUUATN2T4vSqIyWGdYidsz1s2XtSZ57o89r8JajTRSrNDteIDrr+l5CNI
         DS+unzFw2we1V+D5l9smGU8o8pPZJ6KhtaOHsPbmy57qRqby/2XvebYHgt405NoL0H8C
         kTe0aYMgk49NKuh1HM0TtMHU9R+i8wgFaDoZG6LDEuOLiM/DidJ6MLle7ktQJIR/UBk6
         xyaFbDWaiB2YALzOqL+V6KKFhMqBy463Lpirw+K3MgIFZFiQm0dortyWkUV5DASNpvLE
         gJlg==
X-Gm-Message-State: AGi0PuYSgGCoE+OzYUzRbttFvM4CGtBKGS++fcDq64m+57/3WpboREYP
        8DdZMr4DloowJknYnhhxaaPrm9S8
X-Google-Smtp-Source: APiQypL5enFzv6nobTDcT+NJwh40Tc3r1iH089biDvXOuXDqEhLmsRl9T7X2aFE0YqTxk64E7LbgJQ==
X-Received: by 2002:aa7:9491:: with SMTP id z17mr923534pfk.264.1588208426965;
        Wed, 29 Apr 2020 18:00:26 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id a99sm346708pje.35.2020.04.29.18.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 18:00:26 -0700 (PDT)
Date:   Wed, 29 Apr 2020 18:00:24 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net, jrnieder@gmail.com
Subject: Re: [PATCH v6] credential-store: warn instead of fatal for bogus
 lines from store
Message-ID: <20200430010024.GC33264@Carlos-MBP>
References: <20200429203546.56753-1-carenas@gmail.com>
 <20200429232322.68038-1-carenas@gmail.com>
 <xmqqlfmdua5o.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlfmdua5o.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 04:47:31PM -0700, Junio C Hamano wrote:
> > instead of doing a hard check for credentials, do a soft one and
> > warn the user so any invalid entries could be corrected.
> 
> instead -> instead

;)

> I do not think dropping "view or" is justifiable.  There is no need
> to invite the risk of opening with the intention to only view and
> then end up saving a modification.  In other words, do not encourage
> use of an *editor* in any way.
> 
> > +An unparseable or otherwise invalid line is ignored, and a warning
> > +message points out the problematic line number and file it appears in.
> 
> OK.  You didn't want to tell them they can remove the problematic
> line as a whole with their editor?

someone said "do not encourage use of an *editor* in any way" just a few
lines before ;)

> > +	test_config credential.helper store &&
> > +	git credential fill <<-\EOF >stdout 2>stderr &&
> > +	protocol=https
> > +	host=example.com
> > +	EOF
> > +	test_cmp expect-stdout stdout &&
> > +	test_i18ngrep "ignoring invalid credential" stderr &&
> > +	test_line_count = 3 stderr
> 
> The "ignoring invalid credential" message could be translated into
> two or more lines, but I think that is worrying too much about
> theoretical possibility, so checking line count would probably be
> sufficient.

yes, and specially considering that if I even ended up adding a -c
option to test_i18ngrep as I intended originally we will still the
same issue.

what is the preferred way to do something like this, or is it better
to add a check for each line formatting issue this is handling?

Carlo
