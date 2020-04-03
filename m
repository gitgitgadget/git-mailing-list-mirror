Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24B4C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 10:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BBE206F5
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 10:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Muh7Pn+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgDCKJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:09:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43368 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDCKJf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 06:09:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id f206so3255529pfa.10
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 03:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=G9lGhgcUxAcaCy4vPL5GYkav2xlbIcjdK5VJayrfjI0=;
        b=Muh7Pn+xrGeomrdyTXkdv5rNOboiUKTwzwkJudwziqnpbbRp4DC9gYF6ve/hmqpZ+H
         gFCSZemclzNgR8aj85zVazMkf3btCP6OII/Qh63iDM69+NtTrSIsfbuBPVkZS501EISg
         ir5kUgEwBC6dKNXeX5B3FivyBagiZGcxpjqq32dJbV9KNGtPhtaouRpQu6P4mULQoJx5
         Cf1IoYPoGEHA5Z0lw19dPlhbv1XVfvZkP/TkxekKAf4iqTnbzPs9d2IrrMjBQ9ULksQC
         i0hkiOd7m8HEWU3+H1oGoLI3jWg9u+/W/C12jrSzREmAmh6ffoE3REBi1HKbmxMF9mUE
         XulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=G9lGhgcUxAcaCy4vPL5GYkav2xlbIcjdK5VJayrfjI0=;
        b=P/Ndbbi3GGnsktwdCGAUL29SWKxaFPMZieQw18pgd02C1KTm87ghEZ1AaHCCfLICiZ
         z6B3A0gNT3oeZ3QvKnn21Lk92yBcK48EL/0g/xYBEdPXW7QzInLOPoPAKvw/eR8SLJR1
         QTyGN9XxSCRwzlOhdreJa0B0DW17KD8Zv+As4WTGbTftr47DvSBX3jOzqr2N5z3SZWp/
         gMIGEj0gUeqDUXAWGmo3IE6rQupcPMv49vlGjNVAEgxgceE704KCDk6voSAR5m3EQwa8
         kzoVmVzP0xR8oxkfGmtuMnslqI8mz9P9lsqiSFRU/MVtDzLXGklzFSFDbCdQ1tvis6+a
         4izg==
X-Gm-Message-State: AGi0PuaO64tCylye5twUyctlpM/R0g3KLl69bIOg+9kl2g/r4L07tGrq
        7zsRR7jTi/gRQdPdCoVK9Rc=
X-Google-Smtp-Source: APiQypIZ8mC4c6InsWqeI7IDoFkydLkTNbn5umE1jwALJLuqYBina0TNLzvlec8H4/g/Ithhn3YkUg==
X-Received: by 2002:a63:8048:: with SMTP id j69mr7641217pgd.410.1585908574734;
        Fri, 03 Apr 2020 03:09:34 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id u186sm5469565pfu.205.2020.04.03.03.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 03:09:33 -0700 (PDT)
Date:   Fri, 3 Apr 2020 17:09:31 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/6] ci/lib-docker: preserve required environment
 variables
Message-ID: <20200403100931.GA32101@danh.dev>
References: <cover.1585474409.git.congdanhqx@gmail.com>
 <cover.1585832270.git.congdanhqx@gmail.com>
 <b7b079f559a17b6d6cef037afd6ce023df8f90b0.1585832270.git.congdanhqx@gmail.com>
 <20200403082254.GJ2224@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200403082254.GJ2224@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-03 10:22:54+0200, SZEDER Gábor <szeder.dev@gmail.com> wrote:
> On Thu, Apr 02, 2020 at 08:04:01PM +0700, Đoàn Trần Công Danh wrote:
> > We're using "su -m" to preserve environment variables in the shell run
> > by "su". But, that options will be ignored while "-l" (aka "--login") is
> > specified.
> 
> This is not true.  See any previous runs of the 32 bit Linux job,
> which worked as expected, because none of these environment variables
> were cleared.

Different su have different behavior when combine "-m" and "-l"

util-linux's su has this as far as 60541961f, (docs: improve grammar,
wording and formatting of su man page, 2013-10-12)

       -m, -p, --preserve-environment
              Preserve the entire environment, i.e., it does not set HOME,
              SHELL, USER nor LOGNAME.  This option is ignored if the option
              --login is specified.

https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tree/login-utils/su.1#n120

Ubuntu (our Linux32 builder), ships su by shadow-utils:

	Note that the default behavior for the environment is the following:
		The $HOME, $SHELL, $USER, $LOGNAME, $PATH,
		and $IFS environment variables are reset.

		If --login is not used, the environment is copied,
		except for the variables above.

		If --login is used, the $TERM, $COLORTERM, $DISPLAY, and
		$XAUTHORITY environment variables are copied if they were set.

There're no mentions of other variables, I _think_ our Linux32 works
by accident.

Alpine ships su from busybox, this su ignores "-m" if "-l" is set.

-- 
Danh
