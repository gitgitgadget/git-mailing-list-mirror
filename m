Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27707C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 13:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E7F20752
	for <git@archiver.kernel.org>; Wed,  6 May 2020 13:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7fRsbIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgEFNrD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 09:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728740AbgEFNrC (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 09:47:02 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8593C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 06:47:02 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 7so2499587pjo.0
        for <git@vger.kernel.org>; Wed, 06 May 2020 06:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ikF97UxdvDGHlNsoEUZi6IK0PbChNzeyBQ5sAj2qSoo=;
        b=U7fRsbIUqGl5V1zUKiBM/csyPnwKb4riIAv0b6LgNqPvCh7f5HLnD+3uivr714mLQS
         Iwxdcg6rqqqGNL7maGxGlqrb0xYt7bM+KJ7xRCVP909E+iWuAbAPUDLgbBEWHF4qjvfj
         fJXBEI8gEUTHAf4bbbOWrS566mcH9uFyn2Mo6cWzTbfwZW8V0XooPo09deQrVKxIKjNK
         MTaBlzJgRFY6C8AQgcXk563jZy+zq0laGledZd2wgXt2U4YuaofYqrUHxlS3G/hBBKIM
         II791vR+zv3dBY2EJU9HcJ5y1A8/9cnVVwk/hpfIgijq/A+YReIgktCPy+LWNuwZTogd
         Yvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ikF97UxdvDGHlNsoEUZi6IK0PbChNzeyBQ5sAj2qSoo=;
        b=l/jQEcPCLg1JuMTxA4xkGkJ9wLx6ohNYQk+yzsGEpxtXVDYS2tuQ2XW77zxnl/J07J
         0WztXKoDAmmDZmpLB1KlEjRdGWGF+LfyaMyKmtPajTlQMu1+1czgaDL0/Ogi+6PWCHPt
         M8qnwFnqB2vx6fUIHdW9dItBVSwRpkP6NEMIoDeqmEPYfmlTBkXvAsqZzRSTP2D7M1a1
         kggibDLNaCJxTnVKPTEXNoQ8m6wUzoufDantXoVbu0GRtnhNgBNJelQvLyeslF/FCa+x
         wJ3YCGmHyROLCs9scKfPjhfxVDV9R6892m7apmq87ntvsHHTUfkzpO91gLXwxtlTzWBo
         DUDA==
X-Gm-Message-State: AGi0PuZURYQZrIPm+ZbRgfH78s8BMRaayrmuxCBtC9YBki2jU7KndHH/
        PE3lfciJ+JC1qCUU3ghXr+4=
X-Google-Smtp-Source: APiQypKX+d/2jZO7qgIG0M+W1XICXN2u8Jqid0ycKiWxltdyAB4hmGXA3Mzcsc5Ra99W4e9J1rTO1Q==
X-Received: by 2002:a17:90a:db91:: with SMTP id h17mr9001471pjv.7.1588772822167;
        Wed, 06 May 2020 06:47:02 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id 185sm1966884pfv.9.2020.05.06.06.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 06:47:01 -0700 (PDT)
Date:   Wed, 6 May 2020 06:46:59 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Danh Doan <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 10/12] tests: when run in Bash, annotate test failures
 with file name/line number
Message-ID: <20200506134659.GA75901@Carlos-MBP>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
 <cover.1586538752.git.congdanhqx@gmail.com>
 <ce0038598704e03becc65731a71abf596bdfbe98.1586538752.git.congdanhqx@gmail.com>
 <20200504174636.GG86805@Carlos-MBP>
 <20200504232511.GB29599@danh.dev>
 <xmqqlfm7cj7s.fsf@gitster.c.googlers.com>
 <20200506073045.GA52959@Carlos-MBP>
 <nycvar.QRO.7.76.6.2005061447010.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2005061447010.56@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 06, 2020 at 02:54:38PM +0200, Johannes Schindelin wrote:
> On Wed, 6 May 2020, Carlo Marcelo Arenas Belón wrote:
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 1b221951a8..a8f8e4106b 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -676,15 +676,9 @@ die () {
> >  }
> >
> >  file_lineno () {
> > -	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" && test -n "$BASH" || return 0
> > -	local i
> > -	for i in ${!BASH_SOURCE[*]}
> > -	do
> > -		case $i,"${BASH_SOURCE[$i]##*/}" in
> > -		0,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:$LINENO: ${1+$1: }"; return;;
> > -		*,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:${BASH_LINENO[$(($i-1))]}: ${1+$1: }"; return;;
> > -		esac
> > -	done
> > +	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" || return 0
> > +
> > +	echo "$0:$LINENO: ${1+$1: }"
> 
> That suppresses the error all right.
> 
> Unfortunately, it completely breaks the feature. At that point, `$LINENO`
> is either unset (e.g. in `dash`) or it contains the number of the line
> _containing the `echo`. That is totally useless information at this point,
> we want the line number of the caller.

that seems like a bug in dash, which NetBSD sh doesn't have, as LINENO
wouldn't be unset.

> Try this, for example:
> 
> ```
> #!/bin/sh
> 
> file_lineno () {
> 	echo "$0:$LINENO: hello"
> }
> 
> file_lineno
> ```
> 
> When you run this, it will print `4`. What we want is `7`.

so you need instead :

```
#!/bin/sh

file_lineno () {
	echo "$0:$1: hello"
}

file_lineno $LINENO
```

> Even worse, as `$0` does _not_ contain `test-lib.sh` at this point, the
> printed information is totally bogus.

not sure I understand what you mean here, at least when runnning with bash
the original code shows $0 correctly as t????.sh when I tried to force a
failure to test.

Carlo
