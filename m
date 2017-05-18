Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B072B201A7
	for <e@80x24.org>; Thu, 18 May 2017 04:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754365AbdERE5s (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 00:57:48 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33841 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752978AbdERE5s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 00:57:48 -0400
Received: by mail-pg0-f68.google.com with SMTP id u187so4457588pgb.1
        for <git@vger.kernel.org>; Wed, 17 May 2017 21:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=emX//EAJG/nljS4SjJZTzDr/WVXaKtQMJru2iGCxUpI=;
        b=hFEP6Qluq9uM97ABxp2PFDo3wU2bS7mb74QsN+aBaH2pfj1e9p5DQ1Y20n0eHSE5zY
         +HgBbow2t/mifBc74VCFrjbJWSPsR1V9yD1UNMR+zvtcekAjWWds7nMlIbZpSMU6ACDe
         aAyoVfU094Oqtuns3aN+pdshl+HxLJPB8P2jWCiriSbvS9pgzaxe1f/oNrKTW2y+xNYC
         KsGAjim+wpc2koS5a8SscGCTwAKmhR+zG6Z3B/4bqqk4/s3o6vtkm0Hv9etxeRVTsUWe
         Fo843y6kesQab4VKz2lgx5cdIx7/bEL0jvn/gneq0OHrtFQDJzWEHpXREpyxxhMRaw8g
         OIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=emX//EAJG/nljS4SjJZTzDr/WVXaKtQMJru2iGCxUpI=;
        b=pWVB71yW3vYDl1QIZ9z4iXtDzw+t2LC5Kk5JJEmxdXKklnmgvbyWyfmK1zJYN1wwOW
         zoS+9mxBWXbx2k3dwwKDMNBk+xkjPxtgqH+DaynL1naqrGTGcJMze0M4U4Z17p2mEOSi
         ZP91MmpVM2dSuo82qplpFw10Pt6RbisqKJdnaQ6vGG4X7lLxhCoR3hTe7F3qYYNQ9Ymr
         HtlT5uBjWQenxvpV/jtABJEY3iuNxJSyv/wzXp46LHAMbcvP6Ovru+7ePbH86RcmSd4Q
         n/U0Zx9d5en4PlR4H6j9tHnZk6lTguv4w9ukTy4nRRxji8P/8GtrGwtmG62oPkAJKuYi
         CreA==
X-Gm-Message-State: AODbwcACyLcdNxG/uxxLLb8KYk9yh4Zkrp+sCHI9h/XQyr+x5f8FwOFA
        98zRAX6QtFlfNg==
X-Received: by 10.98.6.132 with SMTP id 126mr2351169pfg.197.1495083467364;
        Wed, 17 May 2017 21:57:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f155:f4fa:305b:79e3])
        by smtp.gmail.com with ESMTPSA id r73sm7350120pfk.114.2017.05.17.21.57.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 21:57:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 19/23] read_packed_refs(): report unexpected fopen() failures
References: <cover.1495014840.git.mhagger@alum.mit.edu>
        <5d13d0f0e0a63430a9bf2889e9a9e911382170de.1495014840.git.mhagger@alum.mit.edu>
        <20170517132839.fx6oebgqt5t65tia@sigill.intra.peff.net>
Date:   Thu, 18 May 2017 13:57:45 +0900
In-Reply-To: <20170517132839.fx6oebgqt5t65tia@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 17 May 2017 09:28:39 -0400")
Message-ID: <xmqqwp9eu5h2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, May 17, 2017 at 02:05:42PM +0200, Michael Haggerty wrote:
>
>> The old code ignored any errors encountered when trying to fopen the
>> "packed-refs" file, treating all such failures as if the file didn't
>> exist. But it could be that there is some other error opening the
>> file (e.g., permissions problems), and we don't want to silently
>> ignore such problems. So report any failures that are not due to
>> ENOENT.
>
> I think there are may be other "OK" errno values here, like ENOTDIR.
> That's probably pretty unlikely in practice, though, as we're opening a
> file at the root of the $GIT_DIR here (so somebody would had to have
> racily changed our paths). It's probably fine to just err on the side of
> safety.
>
>> +	if (!f) {
>> +		if (errno == ENOENT) {
>> +			/*
>> +			 * This is OK; it just means that no
>> +			 * "packed-refs" file has been written yet,
>> +			 * which is equivalent to it being empty.
>> +			 */
>> +			return packed_refs;
>> +		} else {
>> +			die("couldn't read %s: %s",
>> +			    packed_refs_file, strerror(errno));
>> +		}
>
> I think this could be die_errno().

I wonder what the endgame shape of this code should be, when it and
nd/fopen-errors topic both graduate.  We cannot use fopen_or_warn(),
as we not just want to warn but want to die, e.g.

	f = fopen(...);
	if (!f) {
        	if (warn_on_fopen_errors(...))
                	die_erno(...);
		return packed_refs;
	}

