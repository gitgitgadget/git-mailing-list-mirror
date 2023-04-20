Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BA6C77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 17:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjDTRbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 13:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjDTRbD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 13:31:03 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2521BE57
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 10:31:02 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b46186c03so1635237b3a.3
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 10:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682011861; x=1684603861;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMOiMSk1tFNkVCmrt7CEkwzChv+BlrAlOQiEk4pw9Fk=;
        b=Jq/KLASxBPHfzZiucOReCLQFyiHEHDeFk790Etp4StRD8xQaTzXiZIV7lJ+wVXwCE4
         N1i/aPeZaScb/6Kep5qUK5TXV04uwIlILUhoG/PNJQgnBJZr+KjS8WNgCH6XHUlzxo4o
         OJIHxvN1JAr69uGI8Mj3WheEvATfK0bgBgHPcKrVGYjVUDLaUU8CCcAzyG51D1r5+jzh
         uWdo5LcGgrM12eWC66QRSyz1hNUsGvDiQSg7lyezYB0BrjYPIerZRJO68jq9d8atzXYR
         9T2F+80BWwVU9imWZYc+WaiXgg86pUS1eXXL+RJu1kOoiaROxcWJkT4YVMESWK5NrQ0q
         SKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682011861; x=1684603861;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aMOiMSk1tFNkVCmrt7CEkwzChv+BlrAlOQiEk4pw9Fk=;
        b=QMKaN7Fsi2jMfoCCK5TjbHCUk/yW3QYtMypmQwwOhIC51BtCciC2c9pf9X2gYHyRT/
         X4RaCu9uf0mDOk/NbjOnvlRNae34QeF7lIYXi8bbQ3NSPCHExl7A+VGhXjxFRM3v5Q+T
         jQb8U+3qmeat0PpEyOGfd3FR9i48v8XV9qVxoLvvzxQnik3ipI1hvBA0ImyOweq+W8eB
         hVIC86iCuq3nttCjtrI7rdTkT8kGYxIhc9UZ0lEhnsyMhtnR+FibKk68tH+Mo77EtfGO
         j2nEtqe8hK7LD6G9G+OOgEbmgsgal1/4I94Ryrjx9wL9cHTEZ914bJxRz6evgo7Tj9Rp
         6cwg==
X-Gm-Message-State: AAQBX9eQu61cnfivNDXqfgTrrR4W3pwN2EmEvL81NjJHnxG0h7X44SJh
        +76AHkvAvUaIgLeCaRCUPAc=
X-Google-Smtp-Source: AKy350ZJc4atYCQ0n/sgx4Ke/ZzLdCF5z82TQI/UHEX097KTLY4SO3p8ZZnPU/ErZscF6px5xgk1tA==
X-Received: by 2002:a05:6a20:748a:b0:ee:bd92:4b3b with SMTP id p10-20020a056a20748a00b000eebd924b3bmr3065665pzd.19.1682011861475;
        Thu, 20 Apr 2023 10:31:01 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090abd9600b002340d317f3esm1404705pjr.52.2023.04.20.10.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 10:31:01 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 09/10] builtin/gc.c: make `gc.cruftPacks` enabled by
 default
References: <cover.1681764848.git.me@ttaylorr.com>
        <cover.1681850424.git.me@ttaylorr.com>
        <b6784ddfe2906f7c04b3050bd9ba63a884ddb047.1681850424.git.me@ttaylorr.com>
        <xmqqh6tb7bsa.fsf@gitster.g> <ZEF1MSwtSl7KdjMi@nand.local>
Date:   Thu, 20 Apr 2023 10:31:00 -0700
In-Reply-To: <ZEF1MSwtSl7KdjMi@nand.local> (Taylor Blau's message of "Thu, 20
        Apr 2023 13:24:01 -0400")
Message-ID: <xmqq5y9q1mwb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> Being listed here is a definite sign that a feature behind a
>> configuration variable is considered experimental.  Do we have (and
>> if not, do we want to establish) a procedure to mark and announce a
>> feature that used to be experimental no longer is?  If it is enough
>> to mention it in the release notes, then I can take care of it, of
>> course.
>
> I am not aware of such a procedure. But personally I think it would be
> fine to mention it in the release notes for the next release.

OK.  I updated the entry for the topic in the draft "What's cooking"
report to read:

    * tb/enable-cruft-packs-by-default (2023-04-18) 10 commits
     - ...

     When "gc" needs to retain unreachable objects, packing them into
     cruft packs (instead of exploding them into loose object files) has
     been offered as a more efficient option for some time.  Now the use
     of cruft packs has been made the default and no longer considered
     an experimental feature.

     Will merge to 'next'.
     source: <cover.1681850424.git.me@ttaylorr.com>

and the per-topic description text is usually what is copied
verbatim to the release notes, so even if I forget, the procedure
will remember it for us ;-)

Thanks.
