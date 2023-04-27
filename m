Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6160FC77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 03:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242842AbjD0DrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 23:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjD0DrT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 23:47:19 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A140C1
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 20:47:18 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b5ce4f069so9642082b3a.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 20:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682567238; x=1685159238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btHGNf8P6IAKskzXL2CV+LULuE4zysGH7wEi2XTMYL8=;
        b=PC5++cJz0a6h2yfUDw0poCsgfDrswMPpVq4rwM2SHglykINFBdk+NOb0u28VRKXAiM
         S1eO6JaAMsFLeeOLAz+bS/TBHlumdh262YTM7GnGVOtUPwQ35x5cqS3OCHyprH2xSrtH
         25w1RAqEymO3qxXJcWT4+3AuV+fpKbcEE1KRGTwgo8iWs5J86tNbmgPzhDxUrvzmRZ3/
         /FIoktDNXYk2E/ab/BsfKsc66f9rIwGdlgeEIo0gWMyDzC5z/hfFKuWfqPXRbDzYHsa9
         hzin+pH7J5W23t/D+BxUnpYfGak6dZS/ZyLUriSlnIpI2e/fdrf4laHXD4yDTGlbklC2
         rxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682567238; x=1685159238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btHGNf8P6IAKskzXL2CV+LULuE4zysGH7wEi2XTMYL8=;
        b=hAlhgxzCXRQNURl+TQNc046t+tZLYbfml9Ko/sWxhU+1UXBRtZ2e6Fty7jkNEQ8RQW
         l19OUcB/Qnf6pEPb6xEXSTmsLgZbEKBpEppBFRN+gqsvml0LnYw00N2hS3D/IOZj3+5i
         63CSdVJErOK7X3M7EyxLWwRDByTAk4hGHddF7PGnudYwwWZ0BJ7PLGBxTAdwVMHakujq
         l85juugyEiG6rOYyYHFDcKSnkVBxVNFWSRWlrZecl6k1DTLgl8gewMAvfI6C7b3y6Pf3
         kwzaQdYalbmZ8eXe0rs+OHquJV+KYuoVv5/bCTLRtEaXu94ZWpO6BmQzFvuB+B346El2
         aVTg==
X-Gm-Message-State: AC+VfDxcuXiDwNiBFaKnRnKhXVpbTJHhCec/vh4+HYzg6sLBLnrnTIdm
        WNmiD6TcOBcbsL96jM/Al2E=
X-Google-Smtp-Source: ACHHUZ5H+PDtdZKChbVDEbU5iQwgFmNcOOeRMCKU/mXhjXlbEceunXQA8Zh2lXPzKnm304SZypTdog==
X-Received: by 2002:a05:6a00:10c2:b0:634:970e:ca09 with SMTP id d2-20020a056a0010c200b00634970eca09mr350347pfu.30.1682567237700;
        Wed, 26 Apr 2023 20:47:17 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.58])
        by smtp.gmail.com with ESMTPSA id f25-20020aa782d9000000b0063a1e7d7439sm12036091pfn.69.2023.04.26.20.47.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Apr 2023 20:47:16 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v8 3/6] t3321: add test cases about the notes stripspace behavior
Date:   Thu, 27 Apr 2023 11:47:11 +0800
Message-ID: <20230427034711.27680-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.0.358.ged3339c3
In-Reply-To: <xmqqjzy03p4w.fsf@gitster.g>
References: <xmqqjzy03p4w.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> ---
>>  t/t3321-notes-stripspace.sh | 291 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 291 insertions(+)
>>  create mode 100755 t/t3321-notes-stripspace.sh
>
>Looks quite thorough.

I'm not sure if I've covered everything, but I've tried to addi
some basic test cases to give us a chance to add on top of that later.

>> diff --git a/t/t3321-notes-stripspace.sh b/t/t3321-notes-stripspace.sh
>> new file mode 100755
>> index 00000000..7c26b184
>> --- /dev/null
>> +++ b/t/t3321-notes-stripspace.sh
>> @@ -0,0 +1,291 @@
>> +#!/bin/sh
>> +#
>> +# Copyright (c) 2007 Teng Long
>
>It's 2023 now.

Will fix.

>> +test_expect_success 'add note by editor' '
>> +	test_when_finished "git notes remove" &&
>> +	cat >expect <<-EOF &&
>> +		first-line
>> +
>> +		second-line
>> +	EOF
>> ...
>> +test_expect_success 'append note by specifying multiple "-m"' '
>> +	test_when_finished "git notes remove" &&
>> +	cat >expect <<-EOF &&
>> +	first-line
>> +
>> +	second-line
>> +	EOF
>
>Inconsistent indentation confuses readers if the author meant
>something unexplained by the difference between the two.  Stick to
>one style (I personally prefer the "indent to the same level as the
>starting 'cat' and ending 'EOF'" but it is OK to pick the other one,
>as long as it is consistent within a single test script).

I will follow as your prefer format, thanks.

>> +	cat >note-file <<-EOF &&
>> +		${LF}
>> +		first-line
>> +		${MULTI_LF}
>> +		second-line
>> +		${LF}
>> +	EOF
>
>This is a bit misleading, as there are TWO blank lines before the
>"first-line" (one from the here text itself, the other is from
>${LF}).  
>
>I do not think it matters too much, because the point of stripspace
>is to remove any number of leading or trailing blank lines, and
>squash one or more blank lines elsewhere into one, so having two
>blank lines at the beginning or at the end of the file is just as
>good an example as having a single blank line.  I am mentioning it
>primarily because I had to spend some time thinking about ways to
>make it less misleading.

Yes, a little bit, I don't found a more clealy so far. It works for
now but I'm willing to optimize if there's a better way.

Thanks.
