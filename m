Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 077451F453
	for <e@80x24.org>; Sun,  4 Nov 2018 01:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbeKDKWt convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 4 Nov 2018 05:22:49 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46630 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeKDKWt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 05:22:49 -0500
Received: by mail-qk1-f195.google.com with SMTP id q1so9167452qkf.13
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 18:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HIO23ZysLDrI5rw7pXTgs02IGbJSYfLOTfAbKri4PMw=;
        b=NW7JDq4zQZhadFlTsoLa2IiTOZJ56Ks+CSZ8LmpL8ilW8eflWTPEI7SnFH6rlkcuSe
         vfwkyh5ZLT3RFfIGUVM2XmtTUpqeLLJHss0OAiHmnV/3LxWPPxn386QVT4Lcca1FtbYJ
         ntILgiLGK/k9XnDH/vLFzUuhfkJ0oqp59VmAOSckSErVcEOEaQ4pU3husFsQqpcfI51q
         d5EQs1Jf3MwM0LanpWaqOS6Q5wMtsESeVoss5ql25QyEPADkwHO5uGQRArbV3qP//bOF
         HAFajE6H0tfBseQJXMxHrVl/0ElbDP6FF928JX5tbCdI74R7LXLO0mnqe7JNYw823/g/
         s5hg==
X-Gm-Message-State: AGRZ1gK+pJ0cALdAGgxje9eUrd88A2OJQjq70F3un6KeNgG9srtCRBBg
        xwWZXpO7U7S6dwZey7G6a2LhLUdXWkqnVm+7P8k=
X-Google-Smtp-Source: AJdET5ePZWtOKSLvnVMaEBgFKDXyisFkYqP2AQIZ6cK3chsJPZQk/Ztd1ytI9KWvz8WcksfpnOjxnEuPEkusMV91+zU=
X-Received: by 2002:ac8:2a97:: with SMTP id b23-v6mr16512218qta.110.1541293787670;
 Sat, 03 Nov 2018 18:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <87efkkdwcv.fsf@evledraar.gmail.com> <20181102223743.4331-2-avarab@gmail.com>
In-Reply-To: <20181102223743.4331-2-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Nov 2018 21:09:36 -0400
Message-ID: <CAPig+cRpCu6y+_GXNSHX=h+VxTEq+7rxLiw-jcjXzOf9X4Dqkw@mail.gmail.com>
Subject: Re: [RFC/PATCH 1/5] Makefile: move long inline shell loops in
 "install" into helper
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Dan Jacques <dnj@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, stanhu@gmail.com,
        richardc@unixbeard.net, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'sb/filenames-with-dashes'On Fri, Nov 2, 2018 at 6:38 PM Ævar Arnfjörð
Bjarmason <avarab@gmail.com> wrote:
> Move a 37 line for-loop mess out of "install" and into a helper
> script. This started out fairly innocent but over the years has grown
> into a hard-to-maintain monster, and my recent ad874608d8 ("Makefile:
> optionally symlink libexec/git-core binaries to bin/git", 2018-03-13)
> certainly didn't help.
>
> The shell code is ported pretty much as-is (with getopts added), it'll
> be fixed & prettified in subsequent commits.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  install_programs | 89 ++++++++++++++++++++++++++++++++++++++++++++++++

Pure nitpick: Earlier this year, Stefan made an effort[1] to eradicate
filenames with underscores and replace them with hyphenated filenames.
Perhaps name this "install-programs", instead.

[1]: sb/filenames-with-dashes

> diff --git a/install_programs b/install_programs
> @@ -0,0 +1,89 @@
> +while test $# != 0
> +do
> +       case "$1" in
> +       --X=*)
> +               X="${1#--X=}"
> +               ;;
> +       --RM=*)
> +               RM="${1#--RM=}"
> +               ;;
> +       --bindir=*)
> +               bindir="${1#--bindir=}"
> +               ;;

Is the intention that the user might have X, RM, 'bindir', etc.
already in the environment, and the switches in this script merely
override those values? Or is the intention that X, RM, 'bindir, etc.
should all start out unset? If the latter, perhaps start the script
with an initialization block which clears all these variables first:

    X=
    RM=
    bindir=
    ...
