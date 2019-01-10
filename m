Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 449171F803
	for <e@80x24.org>; Thu, 10 Jan 2019 20:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbfAJUnN (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 15:43:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44484 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729743AbfAJUnN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 15:43:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so12875620wrt.11
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 12:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VcUhjEbwYw59aKLheqWcc9SYBPHAbIYVcI+Ym734YDs=;
        b=pu+A1QG6So/sAgywUqAQ8lo/Cal0xfG9Mcolf4fKJDtxb1+NZUWhPysD6ItrQCWt5M
         gavRDsbu6Tf5UdvfMK0tKiJbRrp30RnbMSKVKNFHfbjrhwh9duJKuzVXRF3AxLnHIeJV
         n8FvQHoEzmqoAiyrVxNrYm9fG1oPz4MfS0lZ6UpHT1ZmsATCtyCEHiu5bHD/BaNmqazA
         e68vUgfVTdQ99rKW0dQtMnuxwRcvUbgT24dnTAfUOzrOrxFFG9EWgDmlcqun2O6z09kL
         IRONKtfb9bC598SdwTbQ0cVMHM+PriZwaZ6cGq8tpkSpGgWt5KzjcKx9i5TStrIvmbhN
         sN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VcUhjEbwYw59aKLheqWcc9SYBPHAbIYVcI+Ym734YDs=;
        b=K0p6hRyPql3Ku7vBmFkR/0vkrSIZAa0aGwgC9axmS/UsctFIR8ox5aDogNrkhMZiag
         0fqdqasNCDX/5AUvuVaphsBiVlhQGCfHItmQuPQpPG906Q/GYa93m/+lgYUNQJNQuLNf
         PEsa1AoN8aY/YqUowPWmSo7dOCaa4yrfkuOr240vzMFXwY0LtyWEWbo8a9PPP59u4Naw
         yDdvFxrqbZtR4zIbLICQsDJaxUvOH7itNoZd+TiUohY/AT/EsWpdc5QBzIviqY+P7Xuy
         upyQBtT9kBz7nhbWTVw8AusMGuFWTd26ulaeuMgfGikeRjMSgnVdLIPKAswNeetJvfgH
         /HvQ==
X-Gm-Message-State: AJcUukfxC/GnIPEms8XtQwFSTToXzdDxcri7He7HPzSD9ovvz4/cxjCY
        qvoezeEa4UpRhid2leUqT+JSMb26
X-Google-Smtp-Source: ALg8bN4US/nkOKVzyA69XCy+8jDetiy7jq/TaLykCDQjyEdfcWlyrYppjoJCZf8Md0XwHsPYt0qH9Q==
X-Received: by 2002:a5d:454f:: with SMTP id p15mr11421252wrr.39.1547152990767;
        Thu, 10 Jan 2019 12:43:10 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a8sm118510wme.23.2019.01.10.12.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 12:43:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH] upload-pack: teach deepen-relative in protocol v2
References: <20181218212435.201641-1-jonathantanmy@google.com>
        <20190109193510.GE54613@google.com>
        <xmqqa7k82wnr.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 10 Jan 2019 12:43:08 -0800
In-Reply-To: <xmqqa7k82wnr.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 10 Jan 2019 10:30:00 -0800")
Message-ID: <xmqqr2dk1bxf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Josh Steadmon <steadmon@google.com> writes:
>
>> Looks good to me.
>> Reviewed-by: Josh Steadmon <steadmon@google.com>
>
> Thanks, both.

This, when applied on top of ecbdaf08991, seems to break t5702.30,
at least for me.

Tip of 'pu' in today's push-out will be broken as it has this patch
merged.

Can somebody take a look?


expecting success:
        rm -rf server client trace &&

        test_create_repo server &&
        test_commit -C server one &&
        test_commit -C server two &&
        test_commit -C server three &&
        git clone --depth 1 "file://$(pwd)/server" client &&
        test_commit -C server four &&

        # Sanity check that only "three" is downloaded
        git -C client log --pretty=tformat:%s master >actual &&
        echo three >expected &&
        test_cmp expected actual &&

        GIT_TRACE_PACKET="$(pwd)/trace" git -C client -c protocol.version=2 \
                fetch --deepen=1 origin &&
        # Ensure that protocol v2 is used
        grep "fetch< version 2" trace &&

        git -C client log --pretty=tformat:%s origin/master >actual &&
        cat >expected <<-\EOF &&
        four
        three
        two
        EOF
        test_cmp expected actual

Initialized empty Git repository in /home/gitster/w/git.git/t/trash directory.t5702-protocol-v2/server/.git/
[master (root-commit) 1581e3e] one
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 one.t
[master 5680d21] two
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 two.t
[master 94705d7] three
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 three.t
Cloning into 'client'...
remote: Enumerating objects: 5, done.
remote: Counting objects: 100% (5/5), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 5 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (5/5), done.
[master 0b417c7] four
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 four.t
remote: Enumerating objects: 6, done.
remote: Counting objects: 100% (6/6), done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 5 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (5/5), done.
From file:///home/gitster/w/git.git/t/trash directory.t5702-protocol-v2/server
   94705d7..0b417c7  master     -> origin/master
 * [new tag]         four       -> four
fatal: shallow file has changed since we read it
not ok 30 - deepen-relative
