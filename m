Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2247C433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 17:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A86C020801
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 17:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPA0da2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgFLRDH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgFLRDF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 13:03:05 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35390C03E96F
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 10:03:05 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id j13so5708750vsn.3
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 10:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=02W3gc24vd2nuhYd8I/311v5X1THZA5btd25+k5YVlg=;
        b=EPA0da2oqt6905sZZEkzfJep1hCQRRQPATj5DdJXUhzTf3VuoK6N7qU/6qAQugnLYT
         qJOsfvY+ogNHFGY4Xv+V6+NSV83Qzhq7gWuyF/qJoxSkw4NL5hkPad9vsr1/zbRnzjoQ
         3o7Eq0afGTiOuO3JDe8FLHhtBG9TM7EdoCBbbiwdFAUQV48kMciq0UndBM94v6phTot2
         xUVwscUkhQb1IYWzGvp0v1n7LDmTJI3wtFPb/IpB8Cu9zWAyYjyQD/nfh3orLsoUVJYZ
         Zb8LfiARLPIE2kvC0FXBH039W5xwqPDbFJqEq+KY1EExbBp5zSERaBbJqC4dGJTRvmbD
         KQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=02W3gc24vd2nuhYd8I/311v5X1THZA5btd25+k5YVlg=;
        b=g72pn8EFNRJ/nor3LynHVMMc1rNyAUyG+XMGNfArHkMweCRcLw9M18l6j03G0nhy9r
         tAOlRurYwYxouOLNGFm1j3u9RFWATYYJnQd7D+tsHVQvpMipODopHGFcxgq5YB5RvN/r
         mLca8R115HlhjT7BcwlZqm/qtPeuhdSVZqnOdg9No9AI/2zwPn9tLQqPqfLeXHKL8p0S
         2YFlLSrYK7qw7xoyMEdziUwGbKO1WunrsYdhVHcQpV4TktmWsdnpgfLEOyxFGi4X6GvB
         mpb6NLKsyiZVkQPbNmbke3EBaSNBvbfGfs7oXq9vwKGhtikYZ97l6ehyUqSVer2bc7J+
         +lnA==
X-Gm-Message-State: AOAM532lI/ASGvzFJoxu1F9+xdXktYBylS23EaB438v56iOaWb4RyX2B
        dbrJtcn3nUpMWI13hdQGtAI=
X-Google-Smtp-Source: ABdhPJyl632Py+IBl3DJvQT8KLEIofqPI6QLZ7Hw13787kgWM0bvALEaUZmn/4jKq7/EcAUyIjP8IA==
X-Received: by 2002:a67:eacd:: with SMTP id s13mr10645748vso.171.1591981384175;
        Fri, 12 Jun 2020 10:03:04 -0700 (PDT)
Received: from localhost (25.173.196.35.bc.googleusercontent.com. [35.196.173.25])
        by smtp.gmail.com with ESMTPSA id h190sm1041655vka.53.2020.06.12.10.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 10:03:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Ed Avis <ed.avis@qmaw.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git log --name-only improvement: show old file name in rename
References: <BL0PR11MB3460BEB60550854661B5178B9D800@BL0PR11MB3460.namprd11.prod.outlook.com>
        <xmqqsgf1i46l.fsf@gitster.c.googlers.com>
        <25ca66fb-82bc-7278-90e9-5e1999593068@iee.email>
Date:   Fri, 12 Jun 2020 10:03:02 -0700
In-Reply-To: <25ca66fb-82bc-7278-90e9-5e1999593068@iee.email> (Philip Oakley's
        message of "Fri, 12 Jun 2020 15:18:49 +0100")
Message-ID: <xmqqh7vg2p4p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> @Ed
> On 12/06/2020 00:16, Junio C Hamano wrote:
>> Ed Avis <ed.avis@qmaw.com> writes:
>>
>>> The git-log manual page says
>>>
>>>        --name-only
>>>            Show only names of changed files.
>>>
>>> But when a file has been renamed, only the new name is printed, not the 
>>> old.  I think it would be more useful and more correct to print both 
>>> names. 
> Was this a concern that the manual did not clarify which name (old or
> new) was being reported?

Good point.  

I am not Ed so I cannot give an answer to that question, but if we
do not document what name is listed in the output, we definitely
should.

Thanks.
