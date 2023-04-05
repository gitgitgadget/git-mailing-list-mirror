Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEEFC76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 00:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjDEANo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 20:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjDEANn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 20:13:43 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA174209
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 17:13:42 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o2so32900361plg.4
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 17:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680653622;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RS0iZ3pnCZL6V02UcpuRXtWzwYS+hlTg1T6qxPggO3M=;
        b=mzr0UbMU3slYWJyIvN74ULuNgX5a1JTHb7gN82gI5zc1d+G5kf/LLMlbkx2WGomgoL
         pvqk+fAcL7wY2yUY+8cwKjupM46gZZ+ykZuBiGiy4qO5gERE7ZotZ6V+eFqIdKNX6ogi
         pcOXfZAyPtaIZ23Ge6PRgPYg6715pq/QFXINvIdGDAQwO0QohoddAi62dUfokCDbLbeg
         UMW0QqVqo9FoxxNwdqaSK0tB81fRRRODHYRPDnCFDtey6HNGTca+q1g0QPU6keeHJ+7J
         ONT7sf6lSijNCKge+yNW/TjouAgqMEK2KgmfPOA+P77Mx/vlXg1d/uq2KaxYxu6BGMOu
         VBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680653622;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RS0iZ3pnCZL6V02UcpuRXtWzwYS+hlTg1T6qxPggO3M=;
        b=IaAldVUyV5y5jG9WXhKHklUyKYqihRLwQ6XcpBkX2lsPVcGx9ub7D5pLYz3JR17jyq
         Z+EqSZECPktiFHqd4vjS0lABXAFAhfSXk39fhoLVApCXnIYVKigJ45GYigilhQ8fNLln
         SjqUawN4MlFs6Mf8a2+eKEptdTgQ9VyyRxIXw1bKyn5GO0T8VBLQJzuaSCxrArQeAqyi
         AKyNTHMkXlhiSqwO/LWscrTayeyjxMX2QPHrup7VDhtmkgChUisBOOs/yrFDI+KqjBIh
         0PYdqpDt85652yaxFMGoLP7eqUTMRDWqXm3WVgi/uZTCzAtWy3jRMojauo32N6Zmrj6f
         IqTA==
X-Gm-Message-State: AAQBX9cvphx6lBqU4gB3aI+uaLOmdXNj6YvfGNs0yc68IYFe68u9FQ1A
        8ktYmpxSI7+t1ohrlZSmMjg=
X-Google-Smtp-Source: AKy350az5gCyKk59GKwz+rHo9Cc+S4mfJBmkbhxmuolhnmhK9KLuygkNgzkRgPz1V2IM2ktycRuKJw==
X-Received: by 2002:a17:903:2452:b0:19f:3b86:4710 with SMTP id l18-20020a170903245200b0019f3b864710mr4896532pls.49.1680653621970;
        Tue, 04 Apr 2023 17:13:41 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id jf19-20020a170903269300b001a065d3ea3bsm8871765plb.295.2023.04.04.17.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 17:13:41 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] clone: error specifically with --local and symlinked
 objects
References: <pull.1488.git.git.1680652122547.gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 17:13:41 -0700
In-Reply-To: <pull.1488.git.git.1680652122547.gitgitgadget@gmail.com> (Glen
        Choo via GitGitGadget's message of "Tue, 04 Apr 2023 23:48:42 +0000")
Message-ID: <xmqq7curxk22.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  	iter = dir_iterator_begin(src->buf, DIR_ITERATOR_PEDANTIC);
>  
> -	if (!iter)
> +	if (!iter) {
> +		struct stat st;
> +		if (lstat(src->buf, &st) >= 0 && S_ISLNK(st.st_mode))
> +			die(_("'%s' is a symlink, refusing to clone with --local"),
> +			    src->buf);

If you want to do lstat(2) yourself, the canonical way to check its
success is to see the returned value is 0, not "not negative", but
let's first see how dir_iterator_begin() can fail.  I suspect it may
not necessary to do another lstat(2).  The function returns NULL:

 * if lstat() fails; errno is left from the failed lstat() in this case.

 * if lstat() succeeds, but the path is *not* a directory; errno is
   explicitly set to ENOTDIR.  Unfortunately, if lstat(2) failed
   with ENOTDIR (e.g. dir_iterator_begin() gets called with a path
   whose leading component is not a directory), the caller will also
   see ENOTDIR, but the distinction may not matter in practice.  I
   haven't thought things through.

Assuming that the distinction does not matter, then,

	if (!iter) {
		if (errno == ENOTDIR)
			die(_("'%s' is not a directory, refusing to clone with --local"),
			    src->buf);
		else
			die_errno(_("failed to stat '%s'"), src->buf);
	}

may be sufficient.  But because this is an error codepath, it is not
worth optimizing what happens there, and an extra lstat(2) is not
too bad, if the code gains extra clarity.
