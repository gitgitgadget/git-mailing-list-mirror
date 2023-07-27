Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CDDC001DC
	for <git@archiver.kernel.org>; Thu, 27 Jul 2023 17:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjG0Rqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 13:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjG0Rqc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 13:46:32 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC09A30E8
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 10:46:31 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b9defb366eso1008658a34.2
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 10:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690479991; x=1691084791;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wULA9EQ9lOjrQhNmc6/lWBECnJRsYInV0fixLJ4Ba4Y=;
        b=HdeYChmc+TdlDLrlMu8r84jdkbspUBIyxeaFNCM07Owd6uP+wz4wMtOx6Sb3qi+Zfs
         /w77ZrG8aieGxFTikZiBT7JadfSV3mc8zgd3zxv9WgACVBcIocgUL5+pyIQnrG9T1SMm
         0S66qOt2Q6dk5X9EtOcIsXMprHtgqR6aFiSRFcPHpphvmL9OeHFgg9k0LIoXJjnDXPK1
         HiQVF/IdP02Eu6bEyhe5moPgCovatpRqNmbs31muoun6H4XdkSsNvsEN0DauUv96bPvA
         if5VJWuYiu4UkuthOqkwUaTavqLEMdU8yPzdftQZCN4xoWZ4ry4aGdla1WCk0Vz9g6O3
         j67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690479991; x=1691084791;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wULA9EQ9lOjrQhNmc6/lWBECnJRsYInV0fixLJ4Ba4Y=;
        b=QQ6Xk9tpGGaLDYXp4Y365HeW6wUDbr/mgOi2t8UqNmX6at9Ktr3+Kk5XSd0n/cfQ2V
         KNlwlqrzKHeDIr1O7M12Pvx8p3ZmvesAcEnwWBrgoY/rZ2y9rgRJr6XeyXFpbLEWupyh
         WeVayhqoqxW8ekF576Q2i9m876SOLPsh1ONwXu4PUu4O7jH4Aw3QrJkUfEY7G8f3M86u
         XbIaQOQflO0h0j8afbJ0ZL8hEN8gr9J0zyhXULphQ8GaQjijfI/cwBOg5DvkXVjGlDud
         w5LlyXoM3w74WiBbEXFAftZcl7oPOJd/gAIQc3ODgIvWd2DcLga9lMediemxYAyBx6vx
         mQeg==
X-Gm-Message-State: ABy/qLaipWStVuZl7T8IfvVo27ryKvaehzsl+3NOTPvkT92m42Rqz5Kw
        dDIWlsXYsbyBWpT53aoEAFHNZxdHA+ezttb7daUqsw==
X-Google-Smtp-Source: APBJJlG+fczgsUQh0DU6HFn4zv4vBxc+huwFMKVWwFva2ABZcs/jt9UaRLdI26za47oCMVapE2CI5g==
X-Received: by 2002:a05:6358:5284:b0:134:e301:2c21 with SMTP id g4-20020a056358528400b00134e3012c21mr217857rwa.15.1690479990979;
        Thu, 27 Jul 2023 10:46:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b33-20020a25aea1000000b00d05bb67965dsm406611ybj.8.2023.07.27.10.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 10:46:29 -0700 (PDT)
Date:   Thu, 27 Jul 2023 13:46:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu <adlternative@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [QUESTION] how to diff one blob with nothing
Message-ID: <ZMKtcaN7xYaTtkcI@nand.local>
References: <CAOLTT8TVGna+C9nYy9nj3h5bT7AdAT0SKtUM3YVz6h=KZhGHHg@mail.gmail.com>
 <xmqqo7k7c1yw.fsf@gitster.g>
 <CAOLTT8R84Zrtpd=j6o2V=Y_uD54XAS5EA7NWHsdfL+XCkD5cqA@mail.gmail.com>
 <xmqqila6cz0n.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqila6cz0n.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 26, 2023 at 11:23:52AM -0700, Junio C Hamano wrote:
> ZheNing Hu <adlternative@gmail.com> writes:
>
> >> If you haven't created one, of course it would fail.  It should help
> >> to do
> >>
> >>     $ git hash-object -w --stdin </dev/null
> >>
> >> before running
> >>
> >>     $ git diff 00750edc e69de29bb
> >>
> >
> > This is a viable solution, but it's a bit ugly since a read-only "diff"
> > requires ”write“ an empty blob.
>
> If you do not even have an empty blob, you have no business
> comparing some other blobs you have with it, do you?
>
> If you do not have a file with a single line "hello, world\n" (that
> hashes to 4b5fa63702dd96796042e92787f464e28f09f17d if written in a
> blob), then you cannot do "git diff 4b5fa637" with anything and
> expect it to work.  It is the same thing.
>
> Besides, if you _know_ you want to compare a blob X to emptyness,
> you are better of doing "git cat-file blob X" in the first place.

Yeah, exactly. In 346245a1bb6 (hard-code the empty tree object,
2008-02-13), the rationale was partly that having the empty tree object
is useful for showing some diffs, such as for the initial commit.

But I can't think of a similar argument for the empty blob. Like Junio
said, if you're purposefully diff-ing against the empty blob, wouldn't
you simply want the entire contents anyway? If that's the case, cat-file
seems like a much more appropriate tool.

Thanks,
Taylor
