Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90407C3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 16:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672482073D
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 16:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4aOvFpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbgCCQQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:16:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34358 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729961AbgCCQQL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 11:16:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id z15so5131983wrl.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 08:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=E8Cmz/iXDQY10XCN5jht2VjKskR4owwYc5eYvo1/ujw=;
        b=G4aOvFpA9uQQiboJU4R7fBE9wqXcCkuP0wDly+Gr1iiUmVnkU3O65OYqld/uDQWvvX
         ppSB6KFLg675WTgTC8WhqCbUzNRGbnOjqJbLKnniXjwtzi8kyfmGVNJa9YncEWhnPjzx
         Cp6TCTlsdwAobYMEwu8S4bNrY1I+VNyWuvbYOGMQ+zMh+OxK7ay3x1UPZ6iH9ctFYeB5
         7ztvsV+Wr6KARP4SVMQPxpNJVWVd6zX8uk7MQANBVvLR603d4FHow6gnkcR2WTeKbIGz
         lflXt5qi/cBJx9M9fNACkjEGCamE8luj+UYCr1ZHZ3rd58Y3yLG1/+hhIUspcPC35/5P
         H7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=E8Cmz/iXDQY10XCN5jht2VjKskR4owwYc5eYvo1/ujw=;
        b=QV6qm4gu6zPgEj0dT+FNksixJS9ulNSWAQ4LCPr8bOb0mcH+ZWgm1PDxTz3jKsAUlP
         usWTXxNGay9N6smk/VrzDfhZIBoGaUH9tB3JB0LlsUN2TtUWj1mnSEhcXsMhzpQbJHyk
         1CP2ipB4qNd9kVG8v9AHNV1U48qSHed5pFvkScJ1n3BzrCBqePwno7ITj1j1SSpxJsGX
         SGTbt+MmdmvDua48Cv3LUlCi4YiCpfqMfsXc+1JzeQ9dhqEgVul/HzL9KCuo/dqbzVvs
         InXqoMlyi3/KW8Wlm7rmiTm7JfP7pIlahu6jFll7Dh+CAigmmmnmvq1UbJU5B9rim22y
         0tdg==
X-Gm-Message-State: ANhLgQ1DB1TQSyQC3VNY2CJgQEKWv6EFR6cxLYctSVPiq5p3TX9rWODd
        qNW+pYMLGjZVhg7fV+MDjCFovQoSSbw=
X-Google-Smtp-Source: ADFU+vuS/XhFHgJY5Be+uD+m8J7tYCgAT0us5ZncbFGh6BSnImtCk+xCQ4alLFsMGhHUMYnJna7Dew==
X-Received: by 2002:a5d:534f:: with SMTP id t15mr5868491wrv.190.1583252169055;
        Tue, 03 Mar 2020 08:16:09 -0800 (PST)
Received: from feanor (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id 25sm144403wmg.30.2020.03.03.08.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 08:16:08 -0800 (PST)
Date:   Tue, 3 Mar 2020 17:16:06 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] remote.c: fix handling of push:remote_ref
Message-ID: <20200303161606.xe5iof6hz2nubc7t@feanor>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Tue, 03 Mar 2020 17:13:49 +0100
References: <20200228172455.1734888-1-damien.olivier.robert+git@gmail.com>
 <20200228182349.GA1408759@coredump.intra.peff.net>
 <20200301220531.iuokzzdb5gruslrn@doriath>
 <20200302133217.GA1176622@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200302133217.GA1176622@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Jeff King, Mon 02 Mar 2020 at 08:32:17 (-0500) :
> > I think you looked at the RR_REMOTE_NAME (ref-filter.c:1455), here the
> > situation is handled by RR_REMOTE_REF, where explicit is not used at all.
> > So we could remove it.
> 
> We do look at it, but it's pointless to do so:

Oh sorry, I don't know how I missed this line while I saw it above.
> 
>   $ git grep -hn -C4 remote_ref_for_branch origin:ref-filter.c
>   1461-	} else if (atom->u.remote_ref.option == RR_REMOTE_REF) {
>   1462-		int explicit;
>   1463-		const char *merge;
>   1464-
>   1465:		merge = remote_ref_for_branch(branch, atom->u.remote_ref.push,
>   1466-					      &explicit);
>   1467-		*s = xstrdup(explicit ? merge : "");
>   1468-	} else
>   1469-		BUG("unhandled RR_* enum");
> 
> I think we probably ought to do this as a preparatory patch in your
> series.

I wonder about the case of RR_REMOTE_NAME to.
We always have explicit=1, except if we fallback all the way to 'origin',
via pushremote_for_branch and then remote_for_branch. But 'origin' even
through it is implicit, is still the name of the remote we fetch/push to by
default. So should not %(push), %(upstream) still show origin in this case?
