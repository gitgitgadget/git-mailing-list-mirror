Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67996C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 00:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiKUAQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 19:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKUAQH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 19:16:07 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B589186D4
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 16:16:06 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id x13so1723634ilp.8
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 16:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FDRFXGzjkf6KuClVzLgzW8KXZnW+lZfA5s1XSc7L03o=;
        b=uVyzgPVE0o86cEIj0PvuDWYYA5oEZqRPvhdPM762KmyOSX4OE+Bfy9/cX+k6GyRHJe
         fOVP3weEdaumLu3pOIKmMteDM0Jf/DWS+AlbQJpDe9jA7DcpGECYS8jXNQnGJfc+moI/
         LuLnkMrPJ2DHS3irlXse2cLcYlSO6XNFp//bubKdYPxnnMo9Y28RE41rMxAmp6FWFmib
         Un51No+RR6Jy+1HHChjy3PtUU9tiHoUXA4ciA1VDDnL/rI2kjWy7DrD8cJJBn+qkoyUb
         zC8TQFn8dOm4K9gYSAidbirVp2Q2ZJnngYKSkYC5jDXScxlkzelZfeL4Y+2bfD65cdIB
         YHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDRFXGzjkf6KuClVzLgzW8KXZnW+lZfA5s1XSc7L03o=;
        b=MTyv6Ep17Z+cA+LozuuZJUMBIyTWsLvAHjtU/azvkgbI6Jx1nta1YWNr6QVYcAyapm
         y5YpN+qDu79WEYz8QqfycoxTW7HsD5gpMe1RzvxQ+lsiqpAX3LPb0k6nemvR2q5bEazc
         XsdwG0nqYhB8OXomvHe2Ba5jbMLHREOQmh06GPdKh+Z4fiUsScRUpJdC/5aLUpF5q+GH
         ZMSnPt206Dt7EK+U4kvMJyAwJLTlPf8nEu1BbPDYWVhnlfVx5MVadKh9QdN5oMjr6MQa
         +5UX9sOOMKLlAfrepC6AFclJv7BSKsRhUpW8xX5rCg3R3dROAPheJISjh5kPHmjGmP39
         xgOA==
X-Gm-Message-State: ANoB5plLO7irBZ9gEI1M9/h5K9pfCBGBXkVEBqC0CK1UC5k1Lfi6A5MM
        EaFiTkUnL92b/g0gWrFn7X77EA==
X-Google-Smtp-Source: AA0mqf5/NiM/8oy/Kof3xE7cCsfMAa1TQTQYexIf2+G9l8uHxL14i7pbLHkOvaNyZfac+2pzO+6iFg==
X-Received: by 2002:a92:cc46:0:b0:302:3cda:9f12 with SMTP id t6-20020a92cc46000000b003023cda9f12mr105322ilq.57.1668989765799;
        Sun, 20 Nov 2022 16:16:05 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w6-20020a022a06000000b00375966aa90esm3353348jaw.161.2022.11.20.16.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 16:16:05 -0800 (PST)
Date:   Sun, 20 Nov 2022 19:16:03 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2022, #04; Fri, 18)
Message-ID: <Y3rDQ3x44BUmmGHV@nand.local>
References: <Y3g95OYdwzq2OP3z@nand.local>
 <xmqq35ad181e.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq35ad181e.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2022 at 09:10:53AM +0900, Junio C Hamano wrote:
> Another question.
>
> Quite a many topics are marked as "Will cook in 'next'".  After we
> go into the pre-release feature freeze period, most topics in 'next'
> are marked as such, and are expected to stay there until the final,
> but as we are yet to tag -rc0, I am a bit puzzled.
>
> Are there concrete exit criteria for them?  Or are they, at this
> very close to -rc0, already judged to be a bit premature for the
> upcoming release so I can safely keep them in 'next' until the
> final?

Anything merged on 2022-11-14 or 2022-11-15 is ready to go to 'master',
in my opinion. I held off on integrating them into 'master' on the 18th
since they hadn't been in 'next' for that long. Though I think all of
those topics are pretty low risk anyway. So I would recommend merging
down all of those into 'master' before cutting -rc0 next week.

These are the topics I'd feel comfortable merging down before the
release candidate:

 + pw/rebase-no-reflog-action                                   11-09/11-14    #2
 + pw/strict-label-lookups                                      11-10/11-14    #2
 + dd/bisect-helper-subcommand                                  11-11/11-14    #3
 + js/remove-stale-scalar-repos                                 11-11/11-14    #2
 + ab/coccicheck-incremental                                    11-11/11-14   #14
 + kz/merge-tree-merge-base                                     11-12/11-14    #2
 + ab/t7610-timeout                                             11-15/11-15    #2
 + dd/git-bisect-builtin                                        11-15/11-15   #13
 + rp/maintenance-qol                                           11-15/11-15    #4

I also feel comfortable with these (below), but they are newer topics
than above. I would like to see at least ps/receive-use-only-advertised
in this release, since it saw the most comprehensive review of any of
these.

 + mh/gitcredentials-generate                                   11-14/11-18    #1
 + jt/submodule-on-demand                                       11-14/11-18    #1
 + ps/receive-use-only-advertised                               11-17/11-18    #7
 + jk/parse-object-type-mismatch                                11-18/11-18    #2

These ones I am not as sure about, though Ævar (cc'd) will probably try
and tell you they're ready to go ;-).

 + ab/cmake-nix-and-ci                                          11-04/11-08   #14
 + ab/submodule-helper-prep-only                                11-08/11-08    #9

Thanks,
Taylor
