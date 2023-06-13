Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A86DEB64D7
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 19:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjFMTQe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 15:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240618AbjFMTQb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 15:16:31 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FC8C3
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 12:16:30 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b3c578c602so19514275ad.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 12:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686683790; x=1689275790;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LndZOZ3HO8aYx9WtxFfH+mIIUX7xuTxmpfeOeeha5wI=;
        b=FaTcaeVMbv4GqLNRaPNmZTMSPHTvqFGYtQlutw2mY5pdOZEP8/NhUwCd8oXpcbCmoK
         Sknkrx4/XJUEpy7Glgxy9Tk/HE0TqCkh+ApU7r43uPg91kjCGLepjnK8GchaxAjHOs7u
         VPHHiCiwDFHCV4n46tm+6XguVvHoPYvNEkCekXbExStIZtMDnbjdAvBhnpnMYQzySyta
         3H1e+jlJZRPwgdCsu1I1QPaIqmmdGaQLLF3fhY5YIPz/UN0NcyORPWEgj+gBBNFqZQTT
         yDt4by9gPWTNLUGcAnPsa0O4AWgVCr+q3hJoKvsSguRUAN9Pu3flI0s9fmWWhkCtyohq
         G4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686683790; x=1689275790;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LndZOZ3HO8aYx9WtxFfH+mIIUX7xuTxmpfeOeeha5wI=;
        b=MIx/f6jppoFVaOBhcniDRv0mIIvFEMtWdqoq2Motkl1UJvuzkVhlELyyiSlr9ZNbu1
         9UQbthaUR6qi8aoUAKDTG87xIs0KNYlzGmHZLHZAEZECz/zeVcuYjSOkXlQzfoBzWTO5
         fcJeEt8NgUwUu8WXihuBYqBAGP+7CkftpJ+GgEg+8iMMEDGo2MLUCpRK9tJUkdN3Qpr6
         CUaUZOGxtV9k5BQ1sid549DQpLKWwctf9LDwP/LAACWqZ1vfCGnvx/HNzwwYMO64o6tm
         ciBryhuSBhwJtwX1g9S/LwzwljJua6rqjZ0zd6XaEXHEE9tlV9TMGCLoTk2dwAxx9VCW
         ynSw==
X-Gm-Message-State: AC+VfDzP4Y/m+5uXqrxrLK2GmXuFZzETjena26PSjXrDsFGNDGxh8iyn
        AWH62QGBIz/bPHoMq1XStcI=
X-Google-Smtp-Source: ACHHUZ7rp6TvxPRI15gvdTGRFW9u136U8s+qQP2M7Sk11OhVSFcvuED6rPtrm8QaGnbtLHvvqt4lYQ==
X-Received: by 2002:a17:903:110e:b0:1a6:74f6:fa92 with SMTP id n14-20020a170903110e00b001a674f6fa92mr11091417plh.19.1686683789660;
        Tue, 13 Jun 2023 12:16:29 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902b70a00b001afd6647a77sm10639665pls.155.2023.06.13.12.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 12:16:29 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Changed path filter hash fix and version bump
References: <20230613171634.15985-1-jonathantanmy@google.com>
Date:   Tue, 13 Jun 2023 12:16:29 -0700
In-Reply-To: <20230613171634.15985-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 13 Jun 2023 10:16:33 -0700")
Message-ID: <xmqqa5x35g1e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> + - In 'printf' format string, do not use hexadecimals, as they are not
>> +   portable.  Write 
>> +
>> +     CENT=$(printf "\302\242")
>> +
>> +   not
>> +
>> +     CENT=$(printf "\xc2\xa2")
>
> I've checked with "dash" and this applies to any quoted string, not just
> when passed to printf. I'll prepare a patch describing this.

What do you mean by "any quoted string"?

I think built-in 'echo' of dash takes "\302\242" and emits the
cent-sign (but /bin/echo may not), but I do not think it is "any
quoted string".  To wit:

    dash$ echo '\302\242'
    ¢

The echo built into dash shows the cent-sign.  The example does not
let us tell if is the shell (i.e. the 'echo' command sees the
cent-sign in its argv[1]) or if it is the command (i.e. the 'echo'
sees 8-byte string "bs three zero two bs two four two" in its
argv[1], and shows that as the cent-sign), though.

    dash$ /bin/echo '\302\242'
    \302\242

This shows that shell is not doing anything fancy.  /bin/echo gets
the 8-byte string in its argv[1] and emits that as-is.

    dash$ /bin/echo "\302\242"
    \302\242

Again this shows the same; I added this example to demonstrate that
it is _not_ like the shell interprets the backslashed octal strings
depending on how they are quoted.

    dash$ printf "%s\n" '\302\242'
    \302\242
    dash$ printf "%s\n" "\302\242"
    \302\242

And these demonstrates that argv[2] given to printf in these cases
are 8-byte string "bs three zero two bs two four two" and the shell
is not doing anything fancy.

So, I would suggest not saying "any quoted string".  In addition,
even though dash's built-in echo that recognizes "\0num" seems to be
conformant to what POSIX specifies (cf. [*1*]), GNU requires "-e" in
order to do so in both standalone 'echo' binary and one built into
'bash', so we cannot rely on this POSIX behaviour when writing a
portable script.  Hence, I would recommend us to focus on giving a
piece of advice on use of printf in this part of the documentation.


[References]

*1* https://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html
*2* https://www.gnu.org/software/coreutils/manual/html_node/echo-invocation.html
