Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6841C6FD18
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 22:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDSWA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 18:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjDSWAy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 18:00:54 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBEA46A9
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 15:00:50 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-51f597c97c5so221307a12.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 15:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681941650; x=1684533650;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1lazOpFpZ5RuJorW1wCHHJRuHc1FO1oEiMB3kAgVg8=;
        b=SptPjTzoua0RNubA3HcbHTi+4SaCslqsyDRtGVqUuSsvKV+u276jom0xHPDOQz0K3/
         WtJTpItT4VEeGz6pD5VmhXARByxX7IQLZ+UAUmXcnujzIBoVUc/eTy2QslO7Ju9/fAiT
         mYd6uH24jR2LtgSnDteosQ1QWw2VN2FmUGnJ74qD04H1tMNZQFKyekR4N4rRQbyqW9CK
         PcbE6/s8fQzrwGXfq7ktr7ZTlw+uG8qYhaei/hcbg5Ap+9IR4FAE0/+j9nAYM0sqHJIL
         bFFmTAKNBiBdzjJuegV2lADb3WTf+qMu3Ooi8w4UhEn7q0rut1/Ku6fxiuyHxZ0k++Lz
         vZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681941650; x=1684533650;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u1lazOpFpZ5RuJorW1wCHHJRuHc1FO1oEiMB3kAgVg8=;
        b=l0LMJ2u9xckqGv+hwgRMr0FCMu0Ke7anlgcYWNY/7wqF94dzVD0W11RgKDoeyObb4h
         sewDIB7cHMzjtRIH04aNdSlw7w/Itk097G7960Y5umGZa+SSNQEv2Ek6euqvngOeFQOW
         DWr2t/W6Ynrdl+RtomNFYP81M/EwVA79aZF+Bg2YiGh75YRmFd43xkJlWshIAyYAZiKW
         0ILN3tPT5kVUbSUO/uolqNi3bnucvpg1RF3RWbw15KDz7hUNRlvyrWdZinFNK5QnUHkX
         kG0uWg5+P6Md5Rvzki5O3bSg3g47RhvYrwY/LgpxXbAJmUqDNDVVLVtrWbN1FxFMTMee
         UHiA==
X-Gm-Message-State: AAQBX9c3oyY/0s4QjFx3bVnoD+pbs3oNG4bdrNd68rMrvTkXSoq8kD4A
        sGZz05dmbEVNRCf0IOisJX8=
X-Google-Smtp-Source: AKy350ZlzBXhvyUzCn+dkMwEqLOtZ17WqdCSBGSGS4TAuGTVSnSbdOet3eHDS4i7JSDy8UXa2V/QLQ==
X-Received: by 2002:a17:90a:5312:b0:246:9374:febb with SMTP id x18-20020a17090a531200b002469374febbmr4344586pjh.19.1681941649568;
        Wed, 19 Apr 2023 15:00:49 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id r5-20020a1709028bc500b0019fcece6847sm2514751plo.227.2023.04.19.15.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 15:00:48 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 01/10] pack-write.c: plug a leak in
 stage_tmp_packfiles()
References: <cover.1681764848.git.me@ttaylorr.com>
        <cover.1681850424.git.me@ttaylorr.com>
        <c477b754e7ddde0d6e696cfd4027ad88c18aeff3.1681850424.git.me@ttaylorr.com>
Date:   Wed, 19 Apr 2023 15:00:48 -0700
In-Reply-To: <c477b754e7ddde0d6e696cfd4027ad88c18aeff3.1681850424.git.me@ttaylorr.com>
        (Taylor Blau's message of "Tue, 18 Apr 2023 16:40:32 -0400")
Message-ID: <xmqqpm7z7crz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> The function `stage_tmp_packfiles()` generates a filename to use for
> staging the contents of what will become the pack's ".mtimes" file.
>
> The name is generated in `write_mtimes_file()` and the result is
> returned back to `stage_tmp_packfiles()` which uses it to rename the
> temporary file into place via `rename_tmp_packfiles()`.
>
> `write_mtimes_file()` returns a `const char *`, indicating that callers
> are not expected to free its result (similar to, e.g., `oid_to_hex()`).
> But callers are expected to free its result, so this return type is
> incorrect.

Indeed the string that holds the name of the file returned by
write_mtimes_file() is leaking.  Does the same logic apply to the
returned filename from write_rev_file() and stored in rev_tmp_name
that is not freed in stage_tmp_packfiles() in another topic?

> @@ -544,7 +544,7 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
>  			 char **idx_tmp_name)
>  {
>  	const char *rev_tmp_name = NULL;
> -	const char *mtimes_tmp_name = NULL;
> +	char *mtimes_tmp_name = NULL;
>  
>  	if (adjust_shared_perm(pack_tmp_name))
>  		die_errno("unable to make temporary pack file readable");
> @@ -568,6 +568,8 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
>  		rename_tmp_packfile(name_buffer, rev_tmp_name, "rev");
>  	if (mtimes_tmp_name)
>  		rename_tmp_packfile(name_buffer, mtimes_tmp_name, "mtimes");
> +
> +	free(mtimes_tmp_name);
>  }
>  
>  void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought)
