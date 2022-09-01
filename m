Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA50ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 16:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbiIAQaH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 12:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbiIAQaE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 12:30:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F5713E06
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 09:30:02 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mj6so12606194pjb.1
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 09:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=G505GkCnkxnahrKu42s6eix274KH+7hTbsArauvtseA=;
        b=ZJhq2ft2o2cEIxuekYTmLPfOYB+6I6NVUqynwG+T2aq3G404+AhXzHdDtJO2WV4Rhb
         Nd/bdS+TRRQAYuxumjaD+QlB7TbQv5aXFOUlF5/3RKeCmQx5Cadu36qGyWK28+yx6z2h
         8Zqt7O1jAzU2X9u8PooGyeIcMC/si0ptmw8K2Y7ZdprRandgo3N//5kjQ+EymqgFm5Wj
         e1LEPp+zWSgiiYCLnwwb7ENmRY38GxgWkxyP+b+ULgBTnQg4pTuFAW4xyZRwHfnFZsKW
         kKEi41v8brawJQyBOMPFAeqdaI+jXmrllPSlL4fPXU3O+3OpeZGeNKdx/eDgJG51tdN/
         GkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=G505GkCnkxnahrKu42s6eix274KH+7hTbsArauvtseA=;
        b=wcxx6WGd1ocaPhWoFLIYgwnrim9G8FxGhcBfw8mYKbJLH2fUCkvC4YXicEycgVGX2N
         36H/PRSOiZNuBSgddCoK52RaeIiOy0k3sOo8MXwzgfu/EuXqviRoFp1A3W42GBtv69iZ
         e4HuPT6Cfu0xtSFk81tVultYL5AMSYHqH/tZM+7+Ff20+lsqtbFkBL6xtSR9N0v4DqUC
         CYvfI3OlWxrPG3tXqV4CecYbbvdk8m5er71zw6w3ciLnWRBQEd8ODXbHSuvsQI8G0XyO
         Yya70CugU+Ry2PmKgFeMNeVlO6rsIBPDVVBBlJeomEFWhzKVYIDCv7uc48bE3TuSyr4c
         reeg==
X-Gm-Message-State: ACgBeo3qOXqJ54pKx63BU0fZo9quNWjTQkWCXGqRfQD7qcjUt5l/3IjI
        uU+rGYGEWmx8txUOlfiTb4kBbg14elY=
X-Google-Smtp-Source: AA6agR4CRM6WRiDDrxes1vDHiPVQAOEJe/RxQk40Z30jD5AdOKrhePeYAJkozgfYTDr7Nk7QbuFlMw==
X-Received: by 2002:a17:902:760c:b0:172:adc5:fc9 with SMTP id k12-20020a170902760c00b00172adc50fc9mr31620938pll.102.1662049801433;
        Thu, 01 Sep 2022 09:30:01 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 203-20020a6218d4000000b00535d3caa66fsm13348646pfy.197.2022.09.01.09.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 09:30:01 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/3] diff: have submodule_format logic avoid
 additional diff headers
References: <pull.1342.git.1661926908.gitgitgadget@gmail.com>
        <pull.1342.v2.git.1662016087.gitgitgadget@gmail.com>
        <aea0bbc1c6a33d62f6b3313d56664d53df8f620a.1662016087.git.gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 09:30:00 -0700
In-Reply-To: <aea0bbc1c6a33d62f6b3313d56664d53df8f620a.1662016087.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Thu, 01 Sep 2022
        07:08:05 +0000")
Message-ID: <xmqqedwvawhj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:


As there is no guarantee that we'd never add another hack to use a
different kind of "phoney" filepair to diff_queue for another
purpose, either the name of the helper function, or a comment in
front of it, should say something that is sufficient to help readers
understand ...

> +static int diff_filepair_is_phoney(struct diff_filespec *one,
> +				   struct diff_filespec *two)
> +{
> +	return !DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two);
> +}
> ...
> -	if (!DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two)) {
> +	if (diff_filepair_is_phoney(one, two)) {
>  		/*
>  		 * We should only reach this point for pairs from
>  		 * create_filepairs_for_header_only_notifications().  For

... some of what this comment said, i.e. the pair that was added by
create_filepairs_for_header_only_notifications() is what the helper
detects. 

Other than that, the whole series looks good.
