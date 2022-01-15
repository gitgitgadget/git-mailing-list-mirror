Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EAEC433F5
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 00:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiAOAg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 19:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiAOAg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 19:36:58 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD89C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 16:36:57 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w16so39868471edc.11
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 16:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=94mfi9XAE/BbqZL6X1gwBrCmVgDijgLW2r4wrP/NZ5A=;
        b=GbknNYcQqY1SE4O4OZZISXNPMeURgZDqCNkRP1zdLqfJPyWMCrfJCVYv7Z4Ph0Z6Mb
         WW1JviqpP7uESltW3YH55r0lcqI5Xs1S75lGs8mqLVg+CQOYANdMGEyMQRZjVIAnjQ1L
         KP3e6ynnDYgEbp4MARaPSu1/3Pe/GKqQPu9jPCerIqz4FRbc9xHDK1Qw5Tkh4u1Jt/VD
         Xc2/ugDnL4LDTCCXjDYp8YZEjzfl2HFvykyIKr+7k4agJ93LN2V5+uIBJWut/fU7DCqR
         5O8+uaLxnMy/ngrCZC0mHIvRDCaWgI1acxrqAxqAsbsiev3tirkagGWM/c/MRL10gGjM
         0mNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=94mfi9XAE/BbqZL6X1gwBrCmVgDijgLW2r4wrP/NZ5A=;
        b=oWEDbPEceycY9ueO1k5bsoCub1YeICwOrvMud6BduCCWVOKBYO65hdCQO/sR1ZU+mW
         WcZbbLlGzdYiooi9J913jjkSlh0ERcL7KSQlYiBG5kf0k3JgbbOyD9SNx+TCCPdg8wnV
         BW35TxcLJpBzsUkifUpse9WP+GeSf6+pCEVV7lEiwpFgxE7/cP4MylWrcN8F5ZijfOLe
         Qr28V6Bap8BS2UgL9QSW2Srb8pW66722OdzuqtKwvoY7T0tlEultXggzAMsGhS8tAk9J
         RGIrpaGGNp1q0wZ2Zbfq0PKsp7u+jmHET82F1gG3igYmdPBeYLqAEZiLlsqDJjOuYdo+
         6cUA==
X-Gm-Message-State: AOAM530CngK3A38gUn9ab11bzu83cr5y1N+vX2nkd+C/oabLfNStXAyZ
        r8IQjdpwLVu6blalcwdiZ84=
X-Google-Smtp-Source: ABdhPJwKnn+EwLLpr0xjOkCoXFL9WMizWlwW0HDMvNHZrFm5KT7dQnuMAV4kbaKLMRk+Outy/G838w==
X-Received: by 2002:a50:a6d1:: with SMTP id f17mr7412338edc.28.1642207016446;
        Fri, 14 Jan 2022 16:36:56 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id di5sm2183922ejc.45.2022.01.14.16.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 16:36:55 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n8X3v-001Hzm-8s;
        Sat, 15 Jan 2022 01:36:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH v1 0/1] ls-remote: inconsistency from the order of
 args and opts
Date:   Sat, 15 Jan 2022 01:34:28 +0100
References: <cover.1642129840.git.dyroneteng@gmail.com>
 <xmqqfspqeun5.fsf@gitster.g> <220114.867db2rs0n.gmgdl@evledraar.gmail.com>
 <xmqqbl0eaw2e.fsf@gitster.g> <220114.86y23iqbbk.gmgdl@evledraar.gmail.com>
 <xmqqo84e9e9g.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqo84e9e9g.fsf@gitster.g>
Message-ID: <220115.86lezhrg0o.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 14 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>>> But when GNU came around its option parser was generally happy to acce=
pt
>>>> options and args in either order. E.g. these both work with GNU
>>>> coreutils, but the latter will fail on FreeBSD and various other
>>>> capital-U UNIX-es:
>>>>
>>>>     touch foo; rm -v foo
>>>>     touch foo; rm foo -v
>>
>> This is only an approximate list, but:
>
> Don't waste your time on this, and instead spend on something more
> useful.  What I gave wrt gitcli.txt in an earlier message is final.

Whatever we do with git-ls-remote (which I don't really care all that
much about) gitcli should really be documenting how our tooling behaves.

Which is what I was mainly pointing out upthread, that your summary of
options before other types of args omitted that many utilities support
the reverse. Or perhaps you were only describing an asthetic choice
(which I don't think is worth debating). I'm just talking about what the
ground truth is.

What do you think about something like this to clear this up?:

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 92e4ba6a2fa..b1387c4fe68 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -19,6 +19,13 @@ Many commands take revisions (most often "commits", but =
sometimes
 "tree-ish", depending on the context and command) and paths as their
 arguments.  Here are the rules:
=20
+ * Options are (almost) universally accpted before other types of
+   arguments, e.g. `git cat-file -t HEAD` or `git push --dry-run
+   origin`, but in the case of those commands a GNU-style `git
+   cat-file HEAD -t` and `git push origin --dry-run` would work just
+   as well. The reverse is often not true, many commands do not accept
+   options after non-option arguments.
+
  * Revisions come first and then paths.
    E.g. in `git diff v1.0 v2.0 arch/x86 include/asm-x86`,
    `v1.0` and `v2.0` are revisions and `arch/x86` and `include/asm-x86`
