Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5702FC76195
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 16:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjC0Q3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 12:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjC0Q3R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 12:29:17 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B1D1BF8
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 09:29:16 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so9489761pjb.0
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 09:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679934555;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aesAQ1fiN+Bv/JF+gJST6EepZuh1cC2M1PXPOdScWt8=;
        b=Ianq4s9WJS5e1T7czI6KLSU9fGEz8BAwFN22tcxrELErG4oIgazaiFH8qxCMS/6Yim
         py/FG02uIy4ZJxcRYBqOUgcjUwe2cqKSODsFL097yhpcB+EPZy3+KYoBfpy8t84Fe6rI
         c78LjCJI7QX5AhfPsaWX9WCY0XwefV0XsE9P91BT3K1BkiJEaKu0tddt1+WYrrh3Kofm
         RTHlS5mjT+9WOVAhcnxUDMRJZpOI2b3jCiXieg/sGId6qnQm60mxfH9IfvhFnBvqD2kq
         QbSobCDAmxLoA87Y947Ndl8YSEGAdIkShydLlaFShNaJSkhCUtfuF/tTKR6grQGZwT7Z
         WFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679934555;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aesAQ1fiN+Bv/JF+gJST6EepZuh1cC2M1PXPOdScWt8=;
        b=bowppMXuqGz2SinfXmSxP6jwqs6m9P0hXUQrqCJhUwDy63idibuercR/+u4a8W5ziG
         yX469tHkE1ICjVLb1zT65T7mjoSYydtQ6jEFNnzjIe9FHmbxHfG7CGO1JB1SmF03PD0a
         PLRE0tjQbDdVbktkmeXZOpQjvo9mbzyVb6D2BSPnNiDNZ/TkVPVXQ4McjJ4MMSkJHJAB
         m9TENL8lTXpQe7i+73F/Na2EH1fY1vsQCx72stNfH99Im5coNv6BFophK39SZh6Elj6C
         jUjLJKPxrv996JYV3G5ZLZcaUaveyHJszLGQ2aQY+mvjvC55+5iOuPnMt7WaMiHAaaEJ
         dP+w==
X-Gm-Message-State: AAQBX9e1MO7b0oullphJ/jKXKwyXHM2PFXz7QUAEzva4r27Jcj4ISnIq
        0AvgLmDq1vfosSuRWUTvzcU=
X-Google-Smtp-Source: AKy350Y2Fxi9IC+UoCynGzsj57ww/I1RG8laRIn6tApNdPuYPT290rkWdapZRQGS1BIOvedrshRB4w==
X-Received: by 2002:a17:90a:4c:b0:237:f018:6433 with SMTP id 12-20020a17090a004c00b00237f0186433mr14423169pjb.27.1679934555603;
        Mon, 27 Mar 2023 09:29:15 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902c1cd00b0019f2328bef8sm19437647plc.34.2023.03.27.09.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 09:29:15 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Mario Grgic <mario_grgic@hotmail.com>,
        demerphq <demerphq@gmail.com>, git@vger.kernel.org
Subject: Re: git bug: Perl compatible regular expressions do not work as
 expected
References: <MW4PR20MB5517583CBEEF34B1E87CCF1290859@MW4PR20MB5517.namprd20.prod.outlook.com>
        <CANgJU+Vn8ZLGcAYbuDeNkv6T5YdX6t20BqGQDPB0VL_TzoGSWg@mail.gmail.com>
        <MW4PR20MB5517888E63C13099E284B97590859@MW4PR20MB5517.namprd20.prod.outlook.com>
        <eba23dc4-c036-fd1b-a1f0-028e8fff602b@web.de>
Date:   Mon, 27 Mar 2023 09:29:14 -0700
In-Reply-To: <eba23dc4-c036-fd1b-a1f0-028e8fff602b@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 25 Mar 2023 19:09:35 +0100")
Message-ID: <xmqqh6u6cg4l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 25.03.23 um 14:09 schrieb Mario Grgic:
>> The lowercase -p is to print the output in patch format. You can rewrite the command line as
>>
>>  git log --all --patch --perl-regexp -G '\bmain\b’
>>
>> I still get no output in any git version after 2.38.4
>
> -G doesn't support Perl regular expressions.  --perl-regexp only affects
> --grep, --grep-reflog, --author, and --committer.  Neither POSIX basic
> nor extended regular expressions support \b as word boundary.  GNU regex
> and our compat/regex/ do, as extensions.  macOS regex supports it if the
> flag REG_ENHANCED is given to regcomp(3).

Good summary to unconfuse speculations in the thread.

> So perhaps this is rather a feature request to support Perl regular
> expressions for -G (and probably -S as well).  

Perhaps.  I used to be a "it would be wonderful if pcre were usable
everywhere" dreamer, but after seeing our share of bugs caused by
use of pcre, I am not a huge proponent anymore.  I do not object to
such an enhancement at all, as long as it is done cleanly and in
such a way that it is clear pcre cannot be used by accident when the
user does not ask for it.

> Or to enable REG_ENHANCED
> for them, at least, like 54463d32ef (use enhanced basic regular
> expressions on macOS, 2023-01-08) did to get alternations for git grep
> on macOS.

This one sounds like a reasonable thing, which may not have huge
unintended fallout, to do.  I am a bit surprised that we have to
cover each individual callsite of regcomp(3), though.  Doesn't the
54463d32ef fix use "#define regcomp git_regcomp" to cover everybody?



