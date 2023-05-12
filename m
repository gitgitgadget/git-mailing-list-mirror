Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABACC77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 19:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbjELTmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 15:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238467AbjELTmW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 15:42:22 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7544A6EBD
        for <git@vger.kernel.org>; Fri, 12 May 2023 12:42:11 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-52c30fa5271so5459213a12.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 12:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683920531; x=1686512531;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMNcJxn9Ujcl4akqw4RjoJtIddo/JUqeJnoYxoRYsok=;
        b=YNof9Kw3udmuBkf+I7D1k38pKi/sgHlGFfVWxg7MgGlXd1X8AyeL/NsCfSWNAp347l
         0LoUg3QDaw1jHa0WNMCttd9ok0VUKONLDT4oq7SJYN9Ni+qAeUiv8xQ0prng7KyoJtAT
         jH+eiC3jH4jA5IDjRJHOrF6ex8GkXkTmcVL997H3yXIFarezAbeekNXA+a8lVGkxdpmB
         uY8CoO/ezVQtYSVWH1VNDDUwerTnJaRYmLg4mSv3lOW3VTmPB37P1EYIdoB32tOJUcMp
         UMJlr0uy7vTI0pg+b0VyD29DNQpmhC4jtep7ojfCY8Di7Tm2BZlpm0SSye//re0GEk+R
         HFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683920531; x=1686512531;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JMNcJxn9Ujcl4akqw4RjoJtIddo/JUqeJnoYxoRYsok=;
        b=WeHS8OhbvkPhP9Jf/t33knAC9XywhCuyjdd9C1NyrEBN+U4pFrVw8a9pCt2mzqBuIC
         zfp60FFgSOsQLmvSMQN5nLAbHy3InStECbQwKc9BE/5FRfrPjKkokPHe9R/gFlISY/AN
         chPrz8UMA2YKDrt6pjmlrmUodxbl/zCZI8jvlxPgO72cTBCDvrfjHDcVgu/6mRXfe6XK
         gMY2EJBk/9C58N5KuZSrYmq6fia5obrpIz93fbO8LQwCGrQBKSJMD/W97keezYWqbi3M
         IgXjd690SUc71au32aUv3KFSZri5CRfhkHl0g64qWfc28Sz3l/Ln4d7ADO+eVWjb2Dqw
         1fhQ==
X-Gm-Message-State: AC+VfDwllZ6wfwJuv8bhagcT/7LLGKcJzIHf6KBNyFieU3tJyAsigVDF
        Ed9M+fKABRfuV+yOY+WeaS4=
X-Google-Smtp-Source: ACHHUZ6aU1AoexzRG4WfctNJ4Hb48WRyWiw5U+wPH8s2j1VZJxuG3bOwzHAkqkErr9G82UQeA6a/gw==
X-Received: by 2002:a17:903:248:b0:1aa:e631:9f7f with SMTP id j8-20020a170903024800b001aae6319f7fmr29621029plh.41.1683920530843;
        Fri, 12 May 2023 12:42:10 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id io20-20020a17090312d400b001ab0a30c895sm8282726plb.202.2023.05.12.12.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 12:42:10 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        derrickstolee@github.com
Subject: Re: Changed path filter hash differs from murmur3 if char is signed
References: <20230512173330.1072880-1-jonathantanmy@google.com>
Date:   Fri, 12 May 2023 12:42:10 -0700
In-Reply-To: <20230512173330.1072880-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 12 May 2023 10:33:29 -0700")
Message-ID: <xmqqbkippca5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Yes - if the bloom filter contained junk data (in our example, created
> using a different hash function on filenames that have characters that
> exceed 0x7f), the bloom filter would report "no, this commit does not
> contain a change in such-and-such path" and then we would skip the
> commit, even if the commit did have a change in that path.

Just to help my understanding (read: I am not suggesting this as one
of the holes to exploit to help a smooth transition), does the above
mean that, as long as the path we are asking about does not have a
byte with the high-bit set, we would be OK, even if the Bloom filter
were constructed with a bad function and there were other paths that
had such a byte?

> I don't have statistics on this, but if the majority of repos have
> only <=0x7f filenames (which seems reasonable to me), this might save
> sufficient work that we can proceed with bumping the version number and
> ignoring old data.
>
>> Better yet, we should be able to reuse existing Bloom filter data for
>> paths that have all characters <=0xff, and only recompute them where

"ff" -> "7f" I presume?

>> necessary. That makes much more sense than the previous paragraph.
