Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DBCC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 23:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E9323730
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 23:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbgLPXme (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 18:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgLPXme (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 18:42:34 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68DFC061794
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 15:41:53 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id q25so25215090otn.10
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 15:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=wbU6F2RRG9xc82Us3rbYSoAzjnzl8kxC6eVIG9ipgyc=;
        b=TCNNPJ3S4iHxj9y1LEpgMXpKV1gcb1gTEN91L7s1NJYMjFr0yJhd2L/DlyLMX7aEL5
         Dj/kGh/YtNsP9Q0J5n53eBFsHOgzMvhnxCI8MyCYxvr79quB2coMuMQ1LvYtuAUAmO9i
         c7PIedP9Iuxxv7l35T4r9rydcipcQ1uymx1EvBnXrgoXaoasmNXXpmDVZKXY4svxuHDc
         087OMOOKC/4vnvcBhMSf8GUAANpak6zyxNpydkFfPE9G3o7rVhym0PXTFU6JrAMnWHpm
         wU3HMysAJVyXSRYAuICkh56pTBluhCgLPuvtHCuB0SdwfPV6dt42qlhUxrci2sBJqHXD
         ocEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=wbU6F2RRG9xc82Us3rbYSoAzjnzl8kxC6eVIG9ipgyc=;
        b=DM1dwKkSXvBsUfqPI/t0X4ERxDLNB+2SX/sYhr3M/pLuFp1YBl5c4Khh/c8M+sYy4F
         5ZXx+r+KLaJlGWsbSNkacnTGcOje3lKo9xZmMCnfbTIYdmD8vFUPRx3iGDw5hqV0PrHR
         yodhHlLvgjTaZ2xmWABh8KUh/26MGl1TBbzw/4QUjUGWtwL08DWfIycSennJvazI6f4b
         M5nJ72l6fHuNSiuU4doJ9n2Ci3/8w3brY60gQseV0l8cbyUgtgy6glQcoHbU1IxGnDqF
         ZjjM3yBqOa5R1n76QmYBtEchI+0kiqOQoPM7UI4z2JgYVHjh1bAlJIRFYbieFoLw58qV
         qCqw==
X-Gm-Message-State: AOAM533lvJ2EPu/NdcGtCZJJqJrPnoLhtDSd3POjmEvhMndtwz9mwYSO
        HYkiR71HYKXDm6z5W0MTye4=
X-Google-Smtp-Source: ABdhPJwS68B94hXfdX3JjUQREPR8bwZ1Y+CcH5oEdZuTLT9TAQTr5LUe7AsY1tAOR+fuZZqVsdTYpA==
X-Received: by 2002:a9d:372:: with SMTP id 105mr23398087otv.118.1608162113320;
        Wed, 16 Dec 2020 15:41:53 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id b25sm908241ooe.18.2020.12.16.15.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 15:41:52 -0800 (PST)
Date:   Wed, 16 Dec 2020 17:41:51 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Seth House <seth@eseth.com>
Message-ID: <5fda9b3f4979c_973f2083@natae.notmuch>
In-Reply-To: <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
References: <20201216174345.28146-1-felipe.contreras@gmail.com>
 <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > It doesn't make sense to display already-resolved conflicts in the
> > different views of all mergetools.
> >
> > We already have the best version in MERGED, with annotations that can
> > be used to extract a pruned version of LOCAL and REMOTE. If we are using
> > the diff3 conflict-style, we can even extract BASE.
> >
> > Let's use these annotations instead of using the original files before
> > the conflict resolution.
> >
> > TODO: There may be a better way to extract these files that doesn't rely
> > on the user's conflict-style configuration.
> >
> > See Seth House's blog post [1] for the idea and the rationale.
> >
> > [1] https://www.eseth.org/2020/mergetools.html
> >
> > Cc: Seth House <seth@eseth.com>
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> 
> Hmph, I got what Seth showed, but I do not quite see how the ideas
> in the post relate to what this patch does.  The patch just avoids
> grabbing the contents of each stage out to a file for three stages
> using "git checkout-index" and instead does the same by munging the
> diff3 output, which ought to have the same information at least for
> text files, using "sed", or is there something I am not seeing?

It's not quite the same information.

Take the following script that uses Seth's example:

----------------------------------------
cat > BASE <<EOF
A

"Beware the Jabberwock, my son!
The jaws that bite, the claws that catch!
Beware the Jub jub bird, and shun
The frumious bandersnatch!"
EOF

cat > LOCAL <<EOF
B

"Beware the Jabberwock, my son!
The jaws that bite, the claws that catch!
Beware the Jub jub bird, and shun
The frumious bandersnatch!"
EOF

cat > REMOTE <<EOF
C

"Beware the Jabberwock, my son!
The jaws that bite, the claws that catch!
Beware the Jubjub bird, and shun
The frumious Bandersnatch!"
EOF

git merge-file "$@" --diff3 -p LOCAL BASE REMOTE
----------------------------------------

Notice how git is smart enough to resolve the conflicts of the second
paragraph, so the user doesn't have to do anything.

LOCAL is the equivalent of "git checkout-index --stage 2", but that
doesn't have the resolved conflict.

We could call "git merge-file --ours" and overwrite $LOCAL; that way the
user is not presented with any diff for the second paragraph. The same
with --theirs and $REMOTE, but there's no "git merge-file --base".


The implementation details of the proposed patch are not relevant at
this point; it was just to show an example of what Seth's diffconflicts
vim plugin does.

Cheers.

-- 
Felipe Contreras
