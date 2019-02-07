Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5171C1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 02:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfBGCsA (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 21:48:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37089 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfBGCr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 21:47:59 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so5009937wmd.2
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 18:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eLzvy9WRk4olPm9YY8PTe3cvCNgy0MUdoCRLMkXRbEQ=;
        b=T59Iri5S2TrFq7HXpJUWUH/o+oBnXl+Xvtbf9jYO0s3fMrpjl6EaykpLfcTcMLXLAr
         ib79/Q+C4Qf9CkgwxOipBZw9MzdAoAxysJy3EyQcXRq8OTvnNvUjt3HFItpare1yTcp+
         ABn+HPA+4BQ+vX3yCuAchH6oYh7xA8xg0iQssMc93rIOjfn42H324Mwdujrg4t8IiRTt
         ZrOiNuHx0wumAWbTYi8vj3rE1ZUcevU8g8WIu8qsAWTcu8umHf40Hh4XvELlyFnY8WQH
         wUkwvnfZl9abP0h35k+QnG861duffHdwhwLlNMRL78+2jR9AetlLoHumE3vRD/a3odNb
         5Y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=eLzvy9WRk4olPm9YY8PTe3cvCNgy0MUdoCRLMkXRbEQ=;
        b=qLrLqIU9/6qrnavcH9vZfZWip/J38I9PbMVGGFFI949/gIEk+fuH9Y4gGnjsmTPx9n
         8tahvwyI8k9gAt2QcZrisIkHx7JpJhV1yEEY4pSJz7fX7LVW3a4Z0WbSX16DrSjp/rqA
         QmwxiBMOkNp9sRFdk9Q5lsKk7/kfxlxQpl5HDdJtssYMiiEVqLhSV3WMLNd4wZpLVxi1
         eyxNAO2czgVI0UuHY6w7wKoDF/guTplwz/+JQlMucb0lTD4K/A9QxObCyAU+DDmDbIBW
         RRnJmbVjG0g72k4mbth0ZEN0q5nzchTqMTU2+OaRiSFygi+YVoz6gHDpV9jHMVox1k/G
         jGfw==
X-Gm-Message-State: AHQUAuY9F9cPx0S/b6cJzjShxMj3FqKSdu0bXPlxuGCdHd54560DqTq/
        mDRaUj7O7pbnAfRBHRQtKqY=
X-Google-Smtp-Source: AHgI3IZyr5rZYJJS0dfjlIfNgIi7KxwiykY6i6pi9SqqUATmBbGaVIEInJRZtMPNj1XzWrPvSpuRnQ==
X-Received: by 2002:a1c:7e56:: with SMTP id z83mr5728453wmc.100.1549507677558;
        Wed, 06 Feb 2019 18:47:57 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b14sm29250173wrx.36.2019.02.06.18.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 18:47:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2] fetch-pack: clear alternate shallow when complete
References: <20190204000650.686175-1-sandals@crustytoothpaste.net>
        <20190206235937.201663-1-sandals@crustytoothpaste.net>
        <CACsJy8Ae0ZZjh8+f+TwbfJ-V9SzrHpDFyfjwScwKJj+kc7FDTQ@mail.gmail.com>
Date:   Wed, 06 Feb 2019 18:47:55 -0800
In-Reply-To: <CACsJy8Ae0ZZjh8+f+TwbfJ-V9SzrHpDFyfjwScwKJj+kc7FDTQ@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 7 Feb 2019 09:32:21 +0700")
Message-ID: <xmqq4l9gs49w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Feb 7, 2019 at 7:00 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>>
>> When we write an alternate shallow file in update_shallow, we write it
>> into the lock file. The string stored in alternate_shallow_file is
>> copied from the lock file path, but it is freed the moment that the lock
>> file is closed, since we call strbuf_release to free that path.
>>
>> This used to work, since we did not invoke git index-pack more than
>> once. However, we now do, and starting with bd0b42aed3 (fetch-pack: do
>> not take shallow lock unnecessarily - 2019-01-10), we no longer reset
>> this value unconditionally; consequently, we reuse the freed memory.
>> Ensure we reset the value to NULL to avoid using freed memory. git
>> index-pack will read the repository's shallow file, which will have been
>> updated with the correct information.
>
> The patch looks good to me.

Thanks, all.
