Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885FBC433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 13:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343620AbiDGNRc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 09:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343605AbiDGNRa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 09:17:30 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13E91BBE19
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 06:15:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a6so10891231ejk.0
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 06:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=yTQvRmfh/FeY066IcoBX5NPNeoEa5q1NWLreWmzUErU=;
        b=ANkhhYeYDZkjInhoxijUvJC5wEdaQ/1Rv7m+/tGH3MpiBk2FqhWj4ES9YxY4MVvmox
         KqVl6jtuMP/FNV9+4s1IVZ49JsmFKNNCmQXl3ZnPTnQfnoPrnoS+TIk956ZQd6ZhR7r1
         pnQDxnL9XYAVMnilVq5xoPFuyo9MM2EIX+25EYT+mozplGJLyashrrleHvngFy0BHXN1
         sOupl7abiXsBW5WlTF2KjGSwEZjRIBWzxMml7D8wl0MsOhQHqQud6LQaTdVCh3D+K86N
         YA8wBExkBT9eb8aKp+MwhJ8+WmxFua/Ndsa8GzC6p9BEQ/gxINjhwa4QbkBuR1G6M3O1
         uCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=yTQvRmfh/FeY066IcoBX5NPNeoEa5q1NWLreWmzUErU=;
        b=6Obm/nU46e/Q1DsyVYWJTzER+aGJcK7cNkS+bOjtC8obl9Mcqqrn3lrIVALOa/tEzt
         yUweK+npx9WJSvBRRAc+Mkj0KBwmrx3YIfZ9CcwmdlUNV6wunY1wy48OOQTg71vjd2IV
         rfVy83art+YErrX15jw/S94dCTH7RSo9JIB+3w/7DA2+8gzSRELkakvJzwJnfQZn75cB
         dkPcXEo62bLB+hDrayoKVesHjb8v30xlu9MOYhISVSHXWSRHe+b/Qe/Q3wRRtnGTfPRV
         kS9uf9S1U4OLOlUSxym5trRA6K4aIHLQ0H6et8HjvnAMs6fmbXlrHyZELgSyX0s/N5ls
         1o5g==
X-Gm-Message-State: AOAM531ojd7HnrcBpCZyoktkvpdhXBm1SX+fgk40ZRTsJXEPaNHteRYv
        BBCgiiVg1gBsa5ttNcPV5qzzbQZ2uCU=
X-Google-Smtp-Source: ABdhPJxh7VMStINtNf6FGIA1awORJCBRrVhQOeluWDXLJNSk8BGUtg5iP50Vm+XsZG55fu9BhHK16A==
X-Received: by 2002:a17:906:19c6:b0:6ce:98a4:5ee6 with SMTP id h6-20020a17090619c600b006ce98a45ee6mr12996596ejd.567.1649337325940;
        Thu, 07 Apr 2022 06:15:25 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709063e4e00b006e73392e592sm5706240eji.209.2022.04.07.06.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 06:15:24 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ncRyu-000zC5-Bg;
        Thu, 07 Apr 2022 15:15:24 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fsck: detect bare repos in trees and warn
Date:   Thu, 07 Apr 2022 15:12:24 +0200
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20220406232231.47714-1-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220406232231.47714-1-chooglen@google.com>
Message-ID: <220407.86pmltc9w3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 06 2022, Glen Choo wrote:

> @@ -602,6 +605,12 @@ static int fsck_tree(const struct object_id *tree_oid,
>  		has_dotdot |= !strcmp(name, "..");
>  		has_dotgit |= is_hfs_dotgit(name) || is_ntfs_dotgit(name);
>  		has_zero_pad |= *(char *)desc.buffer == '0';
> +		has_head |= !strcasecmp(name, "HEAD")
> +			&& (S_ISLNK(mode) || S_ISREG(mode));
> +		has_refs_entry |= !strcasecmp(name, "refs")
> +			&& (S_ISLNK(mode) || S_ISDIR(mode));
> +		has_objects_entry |= !strcasecmp(name, "objects")
> +			&& (S_ISLNK(mode) || S_ISDIR(mode));

Doesn't this code need to use is_hfs_dot_str() instead of strcasecmp()
like the other similar checks?

> @@ -336,6 +336,10 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
>   *  - either a HEAD symlink or a HEAD file that is formatted as
>   *    a proper "ref:", or a regular file HEAD that has a properly
>   *    formatted sha1 object name.
> + *
> + * fsck.c checks for bare repositories in trees using similar rules, but a
> + * duplicated implementation. If these are changed, the correspnding code in
> + * fsck.c should change too.
>   */

Probably took much hassle to factor these so it can be re-used. Typo:
correspnding.

> +		test_i18ngrep "warning.*tree $bad_tree: embeddedBareRepo: contains bare repository" out

s/test_i18ngrep/grep/
