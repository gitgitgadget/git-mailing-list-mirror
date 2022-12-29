Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55F0C4332F
	for <git@archiver.kernel.org>; Thu, 29 Dec 2022 07:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiL2HdE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 02:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiL2HdB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 02:33:01 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61A8208
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 23:33:00 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so22191294pjj.2
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 23:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcXgNsybyplpV5y63td1bvJ4aoot6mcH9ToZnw8fZQI=;
        b=cNge+mHNGrrBSxJaPR65NFolzyH4QCbAQAbtdzXMKNsYYQYfLZnO2k83IMj8xKwo/S
         pMzKTO832tKDYRDn/GKzumr93sfldPFF1XBSwmHj0F7oWJFgLMXb1CXNTEXfy3LyavqP
         EK0EfWpeILFWS2pI1qE/qkOD+G4JG9zP6a+t/LM9vKESKbYN211k09/+culkVk0TcEsg
         ku4pjNzGIeoonwuI78BIkGvfBMMyHAuX9n465mGngLlGTNbCEuqM7JJNK6Yz0cTZKMmK
         hoboPXK4STtZlb0bkl0kbHCjRd5j6RVHZohWGPGaqqfnEO6v1cDVr65cY+NWUFdY0aUO
         plNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcXgNsybyplpV5y63td1bvJ4aoot6mcH9ToZnw8fZQI=;
        b=B89+LgP14RwUkNiK7w8RX1/YZEMthus+hM4otjvL8zwoMhDcHeVuVbnAld7k3sH/YF
         l01K5GvgPPn+oQ1RPnZbKTGKPi2Qb3FHVOjgUhQszQ8fLe1bxAodS1o4Mj5JNJn/eVBD
         BiuNnT0icdJP9Wk/7vwYlSoTw1YDsCn7SXJRb2VBowZ0iVGY1tco/ITkKQYdppTLyr2i
         C21pzZgPqqosumsbONPVYUek+xcJOTDOfZdLtwziJRHRc8cppmgjBpT7UYY1fYb4D4P1
         K5CqJPrlpmwGlGJQcryAJXQS9k6DUunjVZERGvcr7jLWv2m0HqwR7ye3lbyO6iOx8wgO
         DqMA==
X-Gm-Message-State: AFqh2kp9FDxRAa22VnrF6y74jrqtOwsr2M0QtM1pi5up6cD4JmSSz3sS
        QlQMFo0xPDx9sQ9CbhzL4Xx7V/CBlCdppg==
X-Google-Smtp-Source: AMrXdXtVYXeJZAEJMBC6cB5G1nVWdWlENjd/anYsAqy4EmSfak7CbrfLtwqJK8rpB8ozBS7+QccMkQ==
X-Received: by 2002:a05:6a20:8ed6:b0:af:953a:12b2 with SMTP id m22-20020a056a208ed600b000af953a12b2mr28088028pzk.43.1672299179943;
        Wed, 28 Dec 2022 23:32:59 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y5-20020a63ce05000000b00478f0aa945csm10560692pgf.7.2022.12.28.23.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 23:32:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 12/20] http-backend.c: fix cmd_main() memory leak,
 refactor reg{exec,free}()
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
        <patch-12.20-9be5b0c7836-20221228T175512Z-avarab@gmail.com>
        <5ca7b3ce-dda9-270a-6439-bd897cd5df28@web.de>
Date:   Thu, 29 Dec 2022 16:32:59 +0900
Message-ID: <xmqqpmc2mzpw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>> diff --git a/http-backend.c b/http-backend.c
>> index 6eb3b2fe51c..9bb63c458b1 100644
>> --- a/http-backend.c
>> +++ b/http-backend.c
>> @@ -759,10 +759,14 @@ int cmd_main(int argc, const char **argv)
>>  		struct service_cmd *c = &services[i];
>>  		regex_t re;
>>  		regmatch_t out[1];
>> +		int ret;
>>
>>  		if (regcomp(&re, c->pattern, REG_EXTENDED))
>>  			die("Bogus regex in service table: %s", c->pattern);
>> -		if (!regexec(&re, dir, 1, out, 0)) {
>> +		ret = regexec(&re, dir, 1, out, 0);
>> +		regfree(&re);
>> +
>> +		if (!ret) {
>>  			size_t n;
>>
>
> ... i.e. right here.  But only after copying the offsets out of "out"!

"only after..."?  Do out[i].rm_eo and out[i].rm_so become invalid
after calling regfree() on the regex out[] was taken against?  I do
not think so, and am confused by the comment.  After all, if we can
free only after copying the offsets out of "out", the posted patch
in question is already wrong ;-)

> Anyway, the ret approach taken here is fine.

Yup.

> "dir" is still leaking, by the way.  Probably worth a separate patch.

Good eyes.  But I'd actually say UNLEAK() is fine for that one.

Thanks.

