Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A67AC433EF
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 22:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A6D61057
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 22:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240043AbhIBWcd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 18:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbhIBWcc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 18:32:32 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1301C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 15:31:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id t19so7891254ejr.8
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 15:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=xeQkq4X2bEtEnzLNvT3Hn3Tj5JId+9WItTlZXkitwH8=;
        b=OtfrVc8VjwkPf0Sp8V2gyAGcVGjWJX86lcInDmJrw9PTft8Pn+t2Ycu2CknQk290Bp
         D22YPGHf4cCX/otlm5e+51lx+BGEquk6f7OlphS5eauk5GL4NzDS3bM+/0sNhvc/NRgq
         lr8+/vzcAE0IIa8LRN+2DHViwogx4s4Pnf92sH+BQaWfOPGRxU1+kLv6uoO3Zhg0HSlO
         NjomCFl6ma8JLdJZQaFSuDbStedXvlZBS8VAQHqPcSIPF1Dbts3m4KmNmNAVVVm/ACAH
         wTcAMjvLyreMaHz7o4zN/WTLOghIUNVKhJ48ZVzrDFV8rCkAQaclQe/SBrsQxxZpxDQu
         r2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=xeQkq4X2bEtEnzLNvT3Hn3Tj5JId+9WItTlZXkitwH8=;
        b=tSwl12lExsDs4Ej6WK3G4IXPAY8Iu6fclucOVHhreYoRF8t0O9lZBB9IW+8YAaP/P+
         v8755P3+T/AWaSW//JIl1nWfmjAYy72uYGx6CXTt2qPjNQCgGV2ksoD/RwCZ2WLlJkc3
         XOxXbaOImrvxJlpK00J6AyInNroURSmd6iIwnFu8iwa6sbNkJrPw8KXdgZui1j00isof
         VH9FcYJXC7QM2BOa7WaB7CFnwCyE42ZiwURwC7zev895Qp2ij2sSEvP2JURjLJDvOjZ/
         o3ajhJ1BFDwG5M3RCg3TP45kI9HVbYZv3p56RG5TAjeMJVa03KuYybm45uoCl5x+gE3Q
         Npsg==
X-Gm-Message-State: AOAM531JLjgtkgLp0vrVStRvZfs8+8tgMzu14ZfvCoJ1vB7w7mfvJACh
        SnSKOqbmGEAArab27MwTkjg=
X-Google-Smtp-Source: ABdhPJwpUXrNqkdZfaJdcwhaUWuTeyXG2ec++EvupR6j6aa9EqnzNurCnvLZc/6tmRgEJ9x79QW72w==
X-Received: by 2002:a17:906:5a66:: with SMTP id my38mr546490ejc.36.1630621892263;
        Thu, 02 Sep 2021 15:31:32 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bj21sm1803457ejb.42.2021.09.02.15.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 15:31:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH 0/9] remove dead shell code
Date:   Fri, 03 Sep 2021 00:17:08 +0200
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
 <xmqq5yvik8bc.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqq5yvik8bc.fsf@gitster.g>
Message-ID: <874kb2a9tp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 02 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Remove dead shell code in git-sh-setup, inspired by parallel
>> discussion on another topic (but the two don't conflict):
>> https://lore.kernel.org/git/87lf4f9gre.fsf@evledraar.gmail.com/
>>
>> The last two patches were picked from a dropped series of mine
>> submitted earlier this year, it was dropped because of other more
>> complex patches that I haven't included here:
>> https://lore.kernel.org/git/20210311001447.28254-1-avarab@gmail.com/
>>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (9):
>>   git-sh-setup: remove unused set_reflog_action() function
>>   git-sh-setup: remove unused git_editor() function
>>   git-sh-setup: remove unused git_pager() function
>>   git-sh-setup: remove unused sane_egrep() function
>>   git-sh-setup: remove unused require_work_tree_exists() function
>>   git-sh-setup: move create_virtual_base() to mergetools/p4merge
>>   git-sh-setup: move peel_committish() function to git-subtree.sh
>>   git-bisect: remove unused SHA-1 $x40 shell variable
>>   test-lib: remove unused $_x40 and $_z40 variables
>
> Was "unused" above decided based solely on the presence of in-tree
> users?  If that is the case, I do not think we want to take these
> sh-setup changes.

I should have remembered to reference the earlier discussion, but I
think we had this exact discussion around a year ago when I submitted
patches to remove git-parse-remote.sh, and decided this direction was
OK.

See a89a2fbfccd (parse-remote: remove this now-unused library,
2020-11-14) and the thread starting at
<20201111173738.GB9902@coredump.intra.peff.net>:
https://lore.kernel.org/git/20201111173738.GB9902@coredump.intra.peff.net/

You'll know better what you meant, but I interpreted the docs you added
for git-sh-setup in 850844e28f7 (Documentation/git-sh-setup.txt:
programmer's docs, 2007-01-17) as a guide for in-tree porcelain scripts.

As noted in my recently sent <87lf4f9gre.fsf@evledraar.gmail.com>
(https://lore.kernel.org/git/87lf4f9gre.fsf@evledraar.gmail.com/) the
eventual goal I have in mind here is to get rid of git-sh-i18n.sh.

If we're set on maintaining these shell libraries indefinitely even
after in-tree users have gone away that pretty much means we can't do
that, which would be unfortunate. We continue paying for quite a bit of
technical debt to extend certain parts of core C git functionality to
*.sh and *.perl.
