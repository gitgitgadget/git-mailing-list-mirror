Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB3AC05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 22:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjBAW6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 17:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjBAW6M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 17:58:12 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A7C4FAFF
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 14:58:11 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id mi9so212117pjb.4
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 14:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFx+xApWiUl2FLVWcw1SqOh6Qwh2pOmNL/H7KfFDJKk=;
        b=SEQ/QWuf1RcPa3j093IZR0fXZEIdnkg8FwbdQv4iC3WI6Ap8AWot3q8GwZ2VEYoctY
         aPzgmgq/f44NQ+reVV6cPzqKjkEefyAdKB7FnJp91kJlS5vFga3QSxT/iRse5SyNi1es
         S17u8j2mqJXTIM9Qt1d89op2Ky5jGlIIPpBN2wlMbhcpIY+AGfQPFoRw6eF+empHS8qc
         KqrL0INjziZuy/lI4sPae86O5P5+/ieA4Hh9DAJyi6lUk0van0f3xsb76olK7SKN9i2C
         YQMqN2K5spUOhxLX8OHQ9s1hnCS3iSkvuC1KPpdHHbmpBVRQBmFbveJBHEHmPknVdlR1
         aipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dFx+xApWiUl2FLVWcw1SqOh6Qwh2pOmNL/H7KfFDJKk=;
        b=FkFJuKeyVqcsON7L6QNobQs0yWlk5oCRZeKh4FlvgpbQ2pxEN65ZQ767jS6F7p37UX
         pjthMD7EOxlshLTyVkstyI56zjr7E6od2jNDngzhLxaMDMlTQSTLmEzXh6aPwfsrHR1V
         9oEYO3N6LPXQjORFw0/oxjIPT+z8qL+xMhJmtrixO5qcRXEw9edOx3LrYprGeBhgByq8
         wiDe3irICme+aYLUjKD8K/XKogb0VVZbvELYaMbWTWJligq04e4dJMsth/QnbU29FzQg
         HtgMXYGf4IvzuSsWkNLugsbbwuProNDycZm1mh9owiPnRlnWvI4m/BkrmleKfkJgKU2g
         EPzA==
X-Gm-Message-State: AO0yUKWNmdMskiKltbP3rc3j8uu+1OIkuborXk42+EE/jlcJnDdckUn1
        rHHHVi3o9WJJQGWR1dovpKE=
X-Google-Smtp-Source: AK7set8RIUBLidn5P+Ukl1Y+qxWip+I5jXTBJgAiliL9+wl6w2of3WPOpu7SHh7jek7FDyHNdJgN+A==
X-Received: by 2002:a05:6a20:3b89:b0:be:f077:9dc with SMTP id b9-20020a056a203b8900b000bef07709dcmr4157087pzh.19.1675292290658;
        Wed, 01 Feb 2023 14:58:10 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id z11-20020a056a00240b00b0056bcb102e7bsm11963559pfh.68.2023.02.01.14.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 14:58:10 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Rafael Dulfer <rafael@dulfer.be>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Andrei Rybak <rybak.a.v@gmail.com>,
        Rafael Dulfer <rafael.dulfer@gmail.com>
Subject: Re: [PATCH] rev-list: clarify git-log default date format
References: <20230201155712.86577-1-rafael@dulfer.be>
        <xmqq5ycl1c6h.fsf@gitster.g>
        <230201.864js5q9sv.gmgdl@evledraar.gmail.com>
Date:   Wed, 01 Feb 2023 14:58:09 -0800
In-Reply-To: <230201.864js5q9sv.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 01 Feb 2023 23:28:05 +0100")
Message-ID: <xmqqy1phxabi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> That is
>>
>>     The default format `--date=default` shows a single line with
>>     three-letter day of the week, three-letter month, day-of-month,
>>     hour-minute-second in the "HH:MM:SS" format, followed by 4-digit
>>     year, plus timezone information unless the local time zone is
>>     used (e.g. "Thu Jan 1 00:00:00 1970 +0000").
>>
>> or something like that.
>
> I think that following such a description in prose is still more
> confusing than just showing an example. E.g. we could say:
> 	
> 	Assuming a user in timezone +0200 (Central Europe) values of

Add "on day X at time Y" here, and I'd buy that ;-)

> 	these `--date` argument would produce:
> 	
> 	|---------------+--------------------------------|
> 	| rfc2822       | Thu, 7 Apr 2005 15:13:13 -0700 |
> 	| rfc2822-local | Fri, 8 Apr 2005 00:13:13 +0200 |
> 	| default       | Thu Apr 7 15:13:13 2005 -0700  |
> 	| default-local | Fri Apr 8 00:13:13 2005        |
> 	|---------------+--------------------------------|

