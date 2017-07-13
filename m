Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EADDE202DD
	for <e@80x24.org>; Thu, 13 Jul 2017 00:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbdGMAJN (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 20:09:13 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36188 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbdGMAJM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 20:09:12 -0400
Received: by mail-pg0-f54.google.com with SMTP id u62so20462014pgb.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 17:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8GHOQG6VvsDeGwZ2TkITJvuVshwW7cte3LomuR5rD08=;
        b=AsGDukc/kOO6fMx9YDNlsnz9/M7wu5NKnRpNR7kH257FJHJZ57Z67vFiguh0/rHb6K
         1tYS/ZQTN/XOMo1hncFfPAgEGKTkqwRwxk+0D4/EgBNK21GQtluHQhJ+rtMN0tCqSVa1
         XdY7oTBtF7Fhvm7zTfcwcjblaW8gHPLxlh4dpzNHBvYvbgiccNe07McLLmg7KZlORhgE
         gjlsGARYKCv1HY5oIrFPagTwWLXfhohLjIHuWRdUBebRiu1hjjZCNkVwStCchNI3eV0L
         PJfivJHHVTkjInsF488AFg+0XgLO9qoSSN00JlmpbC2FGlngjjPPruiGUHN2SOMavzTd
         iMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8GHOQG6VvsDeGwZ2TkITJvuVshwW7cte3LomuR5rD08=;
        b=LyyB4uGLwiRSR0XbfYim8DjOkuogJHwxCSx6pZWdGWWuCRhalwH0Yd2Icz2zT7Ci1+
         X+KYdiiFLBt9zNaAD3Ld73x/wEGIt+DzrPNtV4+Za2EvHLtKRhBOwTRmvkBOZC3WTe4e
         sd3LGCahoR0RQHmoHPIQajSBg2y5gsnO3KA164O3CZbPsetr0IIcU/JfYvXcsNEqLmuF
         U8XZfZzYj+kM07rYcLTAjB+gss1JS7rr7Uomyv2qcQUoYoBW5OfYMeQpfBcez2Bqzyri
         2n3EnGd5TyUZWy07Z/GzfdIyLmDip9jCTZHzNnejHvFPj9sdaYmqfNJrJ6jS9QGS7742
         yonQ==
X-Gm-Message-State: AIVw112y4qnH18TILBfyffN5Z3gUnNVEXcggOJ9YoVf6Qfpob8TRgFKu
        IL22B2q0zOK2U5epkiw0yGdyK1KEiJki
X-Received: by 10.99.96.141 with SMTP id u135mr6343463pgb.129.1499904546986;
 Wed, 12 Jul 2017 17:09:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.129.65 with HTTP; Wed, 12 Jul 2017 17:09:06 -0700 (PDT)
In-Reply-To: <20170713000117.GJ93855@aiede.mtv.corp.google.com>
References: <20170712234504.15811-1-sbeller@google.com> <20170713000117.GJ93855@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Jul 2017 17:09:06 -0700
Message-ID: <CAGZ79kZMVXR_S7z=uFohOYXAJrpj=hRFn=w--EWiEEvxF3KCkw@mail.gmail.com>
Subject: Re: [PATCH] submodule: use cheaper check for submodule pushes
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 12, 2017 at 5:01 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

> These footnotes don't answer the question that I really have: why did
> this use add_submodule_odb in the first place?

oh, I forgot to put that down: presumably add_submodule_odb was
used because it was available back then? Note the dates!

> E.g. did the ref iteration code require access to the object store
> previously and stop requiring it later?

No. See [1], it was overkill since the beginning of time.

>> -     if (add_submodule_odb(path))
>> +     int code;
>> +
>> +     if (!is_submodule_populated_gently(path, &code))
>
> Should this examine the code to distinguish between hard errors
> (e.g. "Error reading .git") and a missing repository?

add_submodule_odb does neither, so I think this is best kept without
additional checks.

Thanks!
