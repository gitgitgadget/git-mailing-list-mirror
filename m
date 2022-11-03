Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4FCC433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 09:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiKCJUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 05:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiKCJTd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 05:19:33 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F97FDEAD
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 02:19:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i21so1995393edj.10
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 02:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bGGVeAqrvVW3F0QXdzjmyzfQessbg4sk2+n8qxsAeC8=;
        b=p/epdl08MbSysl1VlFmXwyEuKWb28J/qa13HbsRWt+GvMSL2XLDOdeJ4/Lx8hItTM9
         T0YTugSxGabTZI8F9AapLWtf9aiN+961ZKdb7Q5uv9GQ2X83QW0leoBgTllYolc5D4Zh
         dKgA/mUDzzgit5GnfwshD6pMkNKLEWdYJXYRXfem8+uyoybFnqmX0lgeJ780x0LhH/hE
         px5uke+BSzUhJbdQATfKqtaYs5l/593J6GK6YJL2y6KBfmg5gKkZBmJv7ngVudvMPzK1
         D2oF1neMKIzJRYHQfGhjkpyvNeF9wbOL73CPghhsH38r4WR0O22Gv86/+WLo8oiQL9AI
         1LMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGGVeAqrvVW3F0QXdzjmyzfQessbg4sk2+n8qxsAeC8=;
        b=NvmX2NfJMc1p3LWG8Waj3HmuxYPPdByQ6UvrPSXovB24Jga+1eZz4BcKf57Gfh2C8x
         kZobe9T0DHDvuQGj6GnDYlWpdA6FC1TdHZsbUH2re4FtIFNGcXl6ckqZn++qtBog8/9C
         ll40SfWPqzBA1oDN3KmybZVUTru5NJfQMmEBwL9IcrLpoSeZc9UDIAp+jREiC1ZGFD6n
         +CP7nCtcgN68ybjnuPJ/18lUHfr/dhOH3nxjZtRDto6RPX3jGgTIEar1zggRtP7DGzKB
         fwWSmzbUI30N7DKedYd9LWRSMqNU5A96OmbN1mho9QWAOEHQ+FsXGMOTK0rOf6gEFtXy
         tXPw==
X-Gm-Message-State: ACrzQf3+6vLSWlbG6wUuG1Dr+qqsJVwlSzff+RD+XZQV0zmtIJicFOLW
        RHCOfakOhDCUgx0kYx2s3Ik=
X-Google-Smtp-Source: AMsMyM6UhCMmVQSSR02PhSTkzOyoUA7zwduDjZ88kesuff6EOo396zcMdcKy1KZz7gga5pypaf0RMw==
X-Received: by 2002:a05:6402:51d0:b0:462:847f:212b with SMTP id r16-20020a05640251d000b00462847f212bmr28855691edd.397.1667467152784;
        Thu, 03 Nov 2022 02:19:12 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id kx17-20020a170907775100b0078d793e7927sm267488ejc.4.2022.11.03.02.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 02:19:11 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqWNS-00CLZn-2X;
        Thu, 03 Nov 2022 10:19:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC/PoC 5/5] docbundle: provide the git-log History
 Simplification example
Date:   Thu, 03 Nov 2022 10:17:58 +0100
References: <20221102224843.2104-1-philipoakley@iee.email>
 <20221102224843.2104-6-philipoakley@iee.email>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221102224843.2104-6-philipoakley@iee.email>
Message-ID: <221103.86r0yk1jld.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 02 2022, Philip Oakley wrote:

> +note () {
> +	git tag "$1"
> +}

Aren't you just...

> +test_expect_success setup '
> +	# get the structure set out, then the file contents
> +	echo "asdf" >foo &&
> +	echo "quux" >quux &&
> +	git add foo quux &&
> +	test_tick && git commit -m "I: Initial commit" &&
> +	note I &&

...re-inventing "test_commit" here (including the "echo")?
