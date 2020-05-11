Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E14AC54E4A
	for <git@archiver.kernel.org>; Mon, 11 May 2020 21:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A162206D6
	for <git@archiver.kernel.org>; Mon, 11 May 2020 21:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SA3CBUUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgEKVWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 17:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725895AbgEKVWN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 17:22:13 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26E6C061A0C
        for <git@vger.kernel.org>; Mon, 11 May 2020 14:22:11 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s69so187413pjb.4
        for <git@vger.kernel.org>; Mon, 11 May 2020 14:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6JXtu2azWbsZIRt6uRWLfn7AX2sNb4NqmsNGKAVH2us=;
        b=SA3CBUUR8ymFJPPxx1C8ti3AlMxifJwgLlkPoSzbbmMBigElBEVsAXdOA5oox62RYi
         x1MYNCUf2KTzeZWOlKdB7MdPKCawz95V4CoF8Ijr3llLupm5giXmEczZRdvIWwhmYl3C
         VrMmlKJPIyPzK0iylsBWRJ+XJvwapzP+AboBslG1FqoBbyWXXzElAMtWveMVeJoX1S2V
         lQbRSJ1bD5flDpHW9ojSaXf9X4PtV4ILhRe7K68WL2KsQnGF8L4p9oZHL6QCgXe2SAOW
         gliNE3mmkZW1FhChPWLowya35cnfi7kMELIvf4xEsXnvckIA/oR37mvyAltcNcOJ7wkr
         hHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6JXtu2azWbsZIRt6uRWLfn7AX2sNb4NqmsNGKAVH2us=;
        b=ioqu/37X9Vxn/AfXxUefjMyJVmmE1AKJ8nhrzd6D0uV2jc66xR9yY5QDrBrv8o6Fvt
         1MmRmjEM6rN82/jNN0LFs3yeU68QJzUP7p8w3tDJa2VkJkFtGaO1dTeQg3yzaIyXIFl1
         tAy1Pr3Up99jzUv55z8UeRYXkun1I/MBquoC2HF3+a4xW3aBhm9AyHhGzNK1wrCHe7lo
         mvoBujniHQWOmSqw44lyTOE0rDceVwMzrV6J5jYnC5Xi++AykZX7TZ/riWmLsrUGisSz
         6pTeDjGWPyyZ9vrFzsOR3hSq6DbSOuErj78FtBZQGuqOK5rD3BgLeOk010Cyg0VUTtYU
         B2lw==
X-Gm-Message-State: AGi0PubXiU+SWzuatpayr/vPQ/MxlTVSKRcocU6e08Pe+/YcjwHQsu4Z
        sw+TSKnB6Xa0avc9udvFXbkkQw==
X-Google-Smtp-Source: APiQypLQIWAPMeeF2jxV6HsG49XI1qPjavrRiLu9yal/EwIMpFH/cdMmo9G1ILVwzTJH6SpL486tXg==
X-Received: by 2002:a17:902:a401:: with SMTP id p1mr13739606plq.223.1589232130867;
        Mon, 11 May 2020 14:22:10 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id gm3sm10843485pjb.49.2020.05.11.14.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 14:22:10 -0700 (PDT)
Date:   Mon, 11 May 2020 14:22:05 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4] bugreport: collect list of populated hooks
Message-ID: <20200511212205.GI77802@google.com>
References: <20200430012425.209122-1-emilyshaffer@google.com>
 <20200508005357.223058-1-emilyshaffer@google.com>
 <20200508013405.GA2111@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200508013405.GA2111@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 08, 2020 at 08:34:05AM +0700, Đoàn Trần Công Danh wrote:
> 
> On 2020-05-07 17:53:57-0700, Emily Shaffer <emilyshaffer@google.com> wrote:
> > +test_expect_success 'indicates populated hooks' '
> > +	test_when_finished rm git-bugreport-hooks.txt &&
> > +	test_when_finished rm -fr .git/hooks &&
> > +	rm -fr .git/hooks &&
> > +	mkdir .git/hooks &&
> > +	for hook in applypatch-msg prepare-commit-msg.sample
> > +	do
> > +		write_script ".git/hooks/$hook" <<-\EOF || return 1
> > +		echo "hook $hook exists"
> > +		EOF
> > +	done &&
> > +	git bugreport -s hooks &&
> > +	grep applypatch-msg git-bugreport-hooks.txt &&
> > +	! grep prepare-commit-msg git-bugreport-hooks.txt
> 
> Hi Emily,
> 
> I think this is a bit more correct test.
> ---------8<----------
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Use an exact match to check for populated hooks
> 
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
>  t/t0091-bugreport.sh | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
> index 9450cc02e3..789e8f1ac7 100755
> --- a/t/t0091-bugreport.sh
> +++ b/t/t0091-bugreport.sh
> @@ -67,8 +67,13 @@ test_expect_success 'indicates populated hooks' '
>  		EOF
>  	done &&
>  	git bugreport -s hooks &&
> -	grep applypatch-msg git-bugreport-hooks.txt &&
> -	! grep prepare-commit-msg git-bugreport-hooks.txt
> +	cat <<-\EOF >expected &&
> +	applypatch-msg
> +
> +	EOF
> +	awk -F "]\\n" -v RS="[" "/applypatch-msg/{print \$2}" \
> +		git-bugreport-hooks.txt >actual &&

If I understand correctly, you are saying "look for a line like [...]
which is followed by a line that says 'applypatch-msg'" - that is,
making sure that you don't see some false positive should
"applypatch-msg" exist in the rest of the bugreport.

Could we compromise and grep for "^applypatch-msg$", e.g. "there is a
line calling out applypatch-msg in some way that isn't in the context of
the report template"?

- Even though regex magic is used, ^$ are beginner regex that many
  people can understand easily.
- Using grep for a single line means we are not allergic to header
  format changes later on

It doesn't search for false positives, true, but I found your awk
suggestion hard to understand - my impression is that awk is less
commonly understood, even among Git contributors.

In sed, it's a little bit more readable:

  cat <<-\EOF >expected &&
  [Enabled Hooks]
  applypatch-msg

  EOF

  sed -n '/\[Enabled Hooks\]/, /^$/ p' git-bugreport-hooks.txt >actual
  test_cmp expected actual

But, I don't like this because it relies on the name of the header, and
the newline spacing between sections - and would be nontrivial to change
if we decided to underline headers instead, or add a newline between a
header and its contents. So I think it may be overkill.

Thanks for your suggestion, though.

 - Emily
