Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28FD91F404
	for <e@80x24.org>; Mon, 22 Jan 2018 19:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750925AbeAVTqj (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 14:46:39 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37615 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750892AbeAVTqi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 14:46:38 -0500
Received: by mail-qt0-f194.google.com with SMTP id d54so23924508qtd.4
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 11:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=PZAI7ZrBKerl7wSJE65MjMVlLK0Z/h4CU0KXq+UqZUU=;
        b=YzIhebZCqTHkgO5cN1CGCcg9/nsFt5185WNlMgcdi5SELFk2B+I29pWhHUTReOwmKG
         mi/UwmrIFyWq336SoTkR9r5tfI4++pcysIG9Qo2mWKkXmYHNmyq8hx6s6eztVmQvhQfT
         nzKRt1p+wRB5H/xYxKs5bN/WTvPIIh5pgfIV1IrhX35ro1/EP8mxgH/zekcv2jaN2pj4
         ikxAtRG0FHsJzyu46NmgH6RP2yvZVBkv5XFGXsruktHagj0i4MaNSY/sy6HLjY2adNKj
         CNdRIMjMlHWWTYf2VKKWFlWqWwnFXaq2rODvEHYoeIL+VvRFAlwyj6URpVvD8IZZAHTT
         Ztfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=PZAI7ZrBKerl7wSJE65MjMVlLK0Z/h4CU0KXq+UqZUU=;
        b=jGOXH1hxC0DVmpKP5Qbu9YbU3az2pfYyjSPbQvs/xv/ApGhmr/5faUiW5EI53I3+VM
         lHZhCqBWUKam0KikgqOdMUd5R2iKlytTi1dfnkKwclWQXjvx0q2ku8vyFseIVQG3gdt2
         ZE8DBAqVRsWJUTP5xbN0R8DA79SH941FKf4Y3GwJbyevZol/71Sx+5xmnHzs9crsHv1n
         WAJdNba0akGSOkLER9omM0cF//JBhSD1o9P3Ftc1+CtvqyQvBXUAhZd2ht/OpNhd1VKA
         NpSC0PaDvgPSPmOas6t3arcQJjsp3ToP96yOA5JdaqETZMWG3Cs79K7wf8Sivx6MtotG
         DdUA==
X-Gm-Message-State: AKwxytcM0M1mUHKKlSrRCJ0Gc0jhc+Kb9BWL63eXspvH+ej1I2g+yQUv
        Oap2TIadt8L/NmVxKWmzD64RjIvVzR3qDLUZOV8=
X-Google-Smtp-Source: AH8x226x7yh3ejJLIVZZBrFCxgc1yEx1AeJKHd3XuYZdHd7+YFcbCFmHeMLpIKquSK0j9oCXMB6PmI68q9A2wdUy5hA=
X-Received: by 10.200.25.9 with SMTP id t9mr12721626qtj.75.1516650397462; Mon,
 22 Jan 2018 11:46:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Mon, 22 Jan 2018 11:46:37 -0800 (PST)
In-Reply-To: <20180122182717.21539-1-szeder.dev@gmail.com>
References: <CACsJy8BBXQ9KErfiuf2ty_4szE2fiHLDiKvMig1LbSefzf-o7w@mail.gmail.com>
 <20180122182717.21539-1-szeder.dev@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 22 Jan 2018 14:46:37 -0500
X-Google-Sender-Auth: 4aneXC-nllKS6oSb4L33Q4KOYBY
Message-ID: <CAPig+cQnVfFcN_kH-pQmjJWa_3SeEb4_vdL7-nDCO-tV-U7Pvg@mail.gmail.com>
Subject: Re: [PATCH 3/3] read-cache: don't write index twice if we can't write
 shared index
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 1:27 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> Subject: [PATCH] travis-ci: include the trash directories of failed tests=
 in
>  the trace log
>
> The trash directory of a failed test might contain valuable
> information about the cause of the failure, but we have no access to
> the trash directories of Travis CI build jobs.  The only feedback we
> get from there is the trace log, so...
>
> Modify 'ci/print-test-failures.sh' to create a tar.gz archive of the
> test directory of each failed test and encode it with base64, so the
> result is a block of ASCII text that can be safely included in the
> trace log, along with a hint about how to restore it.  Furthermore,
> run tests with '--immediate' to faithfully preserve the failed state.
>
> A few of our tests create a sizeable trash directory, so limit the
> size of each included base64-encoded block, let's say, to 1MB.
>
> Note:
>
>   - The logs of Linux build jobs coming from Travis CI have mostly
>     CRLF line endings, which makes 'base64 -d' from 'coreutils'
>     complain about "invalid input"; it has to be converted to LF
>     first.  'openssl base64 -d' can grok it just fine, even without
>     conversion.
>
>   - The logs of OSX build jobs have CRCRLF line endings.  However, the
>     'base64' util of OSX doesn't wrap its output at 76 columns, i.e.
>     prints one single albeit very long line.  This means that while

Perhaps you could pipe the 'base64' output through 'fold' or 'fmt'?

>     'base64' from 'coreutils' still complains, by the time it gets to
>     the invalid input it already decoded everything and produced a
>     valid .tar.gz.  OTOH, 'openssl base64 -d' doesn't grok it, but
>     exits without any error message or even an error code, even after
>     converting to CRLF or LF line endings.
>
>     Go figure.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
