Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4498620188
	for <e@80x24.org>; Mon,  8 May 2017 00:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751094AbdEHAqt (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 20:46:49 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33005 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbdEHAqt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 20:46:49 -0400
Received: by mail-pg0-f42.google.com with SMTP id u187so18043072pgb.0
        for <git@vger.kernel.org>; Sun, 07 May 2017 17:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rXeB0/Q4brzCTST82A4Zi97HPGo4YPUgnBUXif7QncE=;
        b=D3+iuao+Wgrlwo2TZlU0KWp9oRwrKyksFkKR3ACmCtiK7SNjM4l1AnDtkr+68C+LpK
         FWziC55tP89zDuKUzMIwU2KRNvBYQ6Ea11LUG1AWcgJl6V92gUoLBG7BwIkfsCPk5E6y
         nq1J4T6726i4k62tYh0jAUOOvtOol9Ezjy+AKOplV9dPjXVdYV9Fz0vOdpsron6LFfsy
         yT6zbvpPb18aGRFMyuSrhonWBrdau9xZknv/YWuPk3PkDFh2HrD/lxv3Uour9kPX3MFG
         4lp2hwGndAXJodQ+ESj6FxIE9gyyqSXDKnUhCW8+tA72l6/f7eAAN0lY33p68hCY2E9l
         9GkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rXeB0/Q4brzCTST82A4Zi97HPGo4YPUgnBUXif7QncE=;
        b=d2xirXNIMinxQFt/Z+n8UOdeUBwQQjajwux/K4K+H19dl6ku5c/GAOr/+5fG7HV3MV
         3cjC36+zkWr4Ll6rp3KSW4t36eenVPou8I1fVqbk276JnhMiw5v2oDHM8WmISHPOG5Er
         +B9CDB0yZBn1p/jbdnV5Kir+IyDBYOmhNn7mZjY9Bo01MqpaeX+MZs0uaS8QEJCTHlGm
         ppXx+Zn1gmZ8Pgz+OWlDsX3ye3G5r3p6tDuqisPbOikLlu++4caqa7FOKGRafWZqFn2I
         O3c/WVbNyNdo7ndlr5fu9hqjcrxQRjxYw9A/MG4SXqypERBPEmbxDBaaIvDkrmR7v+Iq
         t3Uw==
X-Gm-Message-State: AN3rC/7uwixgpt7y2sfNigDNztw1SWoLys2IvycNDjttNIsMnKo0sT83
        60PdYqccyN4F7g==
X-Received: by 10.99.164.26 with SMTP id c26mr15859533pgf.89.1494204408360;
        Sun, 07 May 2017 17:46:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3011:642f:81a0:efbd])
        by smtp.gmail.com with ESMTPSA id e207sm19553464pfh.121.2017.05.07.17.46.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 17:46:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [RESEND PATCH] diff: recurse into nested submodules for inline diff
References: <20170504214355.14179-1-sbeller@google.com>
        <CA+P7+xqMNiHGi=NVjTHCmnkk3u2BVC5Kfs6p6S3m+LwZr6vkaQ@mail.gmail.com>
Date:   Mon, 08 May 2017 09:46:46 +0900
In-Reply-To: <CA+P7+xqMNiHGi=NVjTHCmnkk3u2BVC5Kfs6p6S3m+LwZr6vkaQ@mail.gmail.com>
        (Jacob Keller's message of "Fri, 5 May 2017 18:24:42 -0700")
Message-ID: <xmqqfuggcgzt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Thu, May 4, 2017 at 2:43 PM, Stefan Beller <sbeller@google.com> wrote:
>> When fd47ae6a5b (diff: teach diff to display submodule difference with an
>> inline diff, 2016-08-31) was introduced, we did not think of recursing
>> into nested submodules.
>>
>> When showing the inline diff for submodules, automatically recurse
>> into nested submodules as well with inline submodule diffs.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>> This is a resend of
>> https://public-inbox.org/git/20170331231733.11123-3-sbeller@google.com/
>>
>> In the cover letter of that patch, I said I would want to redo the tests with
>> scrubbed output. However given the widespread use of unscrubbed output,
>> I think this is fine as-is to include.
>>
>> Thanks,
>> Stefan
>
> Fix looks obviously correct to me. I would like to change the tests to
> not use the unscrubbed output, but that's a problem for a separate
> patch.

OK.

Thanks, both.
