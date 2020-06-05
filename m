Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59E4C433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 17:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8A32075B
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 17:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=forgerock.com header.i=@forgerock.com header.b="hRxTecwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgFERQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 13:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgFERQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 13:16:09 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BC2C08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 10:16:09 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ne5so442441pjb.5
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 10:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forgerock.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1hUIeuceH8ydsp5m8V9gcnmAh0csn7KtCKlzKc2R8Z8=;
        b=hRxTecwqc/RYAQe/2oMqxTu0HFXQ7vPYBYdCbNwyuPxp7wc1OTDywJESJIYyCmX5mL
         BQ68u6s4AxRZavMPpyrOEQi4hAAAefV5l5pKia4/AlU1cKxSmHaLv6Izw63vBUc7az0+
         gVzmpkTWvtPG41qKx8Hr4kDqUQjXU0156zjgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1hUIeuceH8ydsp5m8V9gcnmAh0csn7KtCKlzKc2R8Z8=;
        b=BDFKSbRf9+GxydGNnXgsf/py5rMte2FC5zWMlN1L3UKp4LexkCjiTjZ9ep1xNFS75l
         QWcPGHf7VIk88OrgFvnuwTdxyePRdLyksE91VqWDsDm7aZzYeLrhlzkRw5SFraOocRb/
         QJj9Teq9Li8lH4AsedAJWJUU5HgVCuTVzTI5BMgZJWMp8v0LQHETQceP8emN12fsLUIy
         kKa+bskzF3lKTTsr6rNuY2blvchr1LAk8CKrIE9oArzCn5di3fJUSGHjt3g0P4zeZdje
         ThDZUniZ4Xl5LfOWQRLBkB9GBUOtmpzNlG61iuAWa6B3JzNuIypUQCfV7f03eFquygZo
         FAVQ==
X-Gm-Message-State: AOAM533/FcB5b0b4ux0bezFY6afL1GMaMRacNEzA0rNQrWkA/9vOmT+Q
        U7sEhQz0J36OUCPAZwRB4zULOQ==
X-Google-Smtp-Source: ABdhPJxfhU0VFlo84JjtnqQJ9tLf1Z8Dx27Mw0XrsEd+7d2OY61JboNhZpMzngwKKUOPuZH8DfVoWg==
X-Received: by 2002:a17:902:9885:: with SMTP id s5mr10364040plp.204.1591377368891;
        Fri, 05 Jun 2020 10:16:08 -0700 (PDT)
Received: from localhost ([75.164.48.18])
        by smtp.gmail.com with ESMTPSA id i14sm8604398pju.24.2020.06.05.10.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 10:16:08 -0700 (PDT)
Date:   Fri, 5 Jun 2020 10:16:07 -0700
From:   Max Resnick <max.resnick@forgerock.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: name-ref on annotated-tags is null terminated, but lightweight
 tags arent
Message-ID: <20200605171607.rducvc4xretxacn5@forgemax.local>
References: <20200605165109.jr6mjl6xz7upofdy@forgemax.local>
 <xmqqa71ho34p.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa71ho34p.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thanks Junio for the quick response.

> Presumably the long hexadecimal are supposed to be on the same line 
> as the "name-rev" command itself?                                   

Yes, sorry I didn't see that the formatting was broken before I sent.

> The suffix "^0" (which has nothing to do 
> with null-termination) means "I do not mean the tag object itself, 
> but the object that is pointed by it".                             

Ok, thanks. I need to unpack that a bit more. I tried to dig around in
the man to see if there was indication if that's what was expected but
didn't find anything at less for name-rev.



On 20/06/05 10:04AM, Junio C Hamano wrote:
> Max Resnick <max.resnick@forgerock.com> writes:
> 
> > What did you do before the bug happened? (Steps to reproduce your issue)
> > I was using name-rev to resolve a commits tag name. Annotated tags seem
> > to have a null termination and lightweight tags dont.
> 
> > ❯ git name-rev --tag --name-only
> > 38bdebc9107cab4ab3718d0581632702e74d9209
> > annotated-tag^0
> >
> > /tmp/null-termination-issue on  master
> > ❯ git name-rev --tag --name-only
> > a340894d3ee655ae6c336a85b42d2215d52609e3
> > lightweight-tag
> 
> Presumably the long hexadecimal are supposed to be on the same line
> as the "name-rev" command itself?
> 
> There is nothing broken in the above output.  The anotated tag
> (annotated-tag in your example) is an object that merely points at
> another object (in which case, the object whose name is 38bdebc9,
> which I guess would be a commit) and it itself has an object name
> different from 38bdebc9.  The suffix "^0" (which has nothing to do
> with null-termination) means "I do not mean the tag object itself,
> but the object that is pointed by it".
> 
> On the other hand, your lightweight-tag is directly pointing at the
> object a340894d, so saying "lightweight-tag" is sufficient, as there
> is no extra layer of indirection (i.e. a tag object) involved.
> 
> Hope it helps.
