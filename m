Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBD2C77B78
	for <git@archiver.kernel.org>; Tue,  2 May 2023 19:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjEBTBC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 15:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjEBTBB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 15:01:01 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741B410C6
        for <git@vger.kernel.org>; Tue,  2 May 2023 12:01:00 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-54c905139deso1019315eaf.2
        for <git@vger.kernel.org>; Tue, 02 May 2023 12:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683054060; x=1685646060;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alKJA61zsVMf5pixNiFYZhDNX/E9XXPf/AC4GyC+7c0=;
        b=LqYjNLQor7GObL56df2ibS5PXxanJhdTYp2g7s8tNKrm0NcCcd5tKwALpx5paANdqm
         zerqKvWuBPAqbNI17ns2Xx5aODoLECOgPzwSK1sA1anDH8l62QErhnGz/9nk1J/1uHT0
         hEp6VpvOWB4d5rcGrpTkQ6VGhlaZbCiax3u6Gjzl769GxhAnbqBHN6O1kHsvcJUl3Fse
         Hy5Q1EEYmEa2HoNy5v+UMY/2NRIZHQ1tpKTzPNGDO2fWq66N1iUV27EG3t1aP4YRa0oc
         tNi/MTfT2KniLHLRImf52FQyVLKuB8VVs/cvzWz5PAlyvgOA3ksyAqpWJwwmUxYdTHBt
         MQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683054060; x=1685646060;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=alKJA61zsVMf5pixNiFYZhDNX/E9XXPf/AC4GyC+7c0=;
        b=P0MgynEQ4LH6DUAjyAzuQpW9O2XnMNAopQ73lk6w3nqrtnad4p9mQJ+IyMZowSRsql
         9miVtUheOca4LtF9uSiM3tHx14sZ5gucKjFmjOn+douTw2ibqJLZmpJzBSPmRFeR1ZpJ
         wrXZpjWkqHvsM30hg+EpjSfp9EJUJ+tRWBGIv/ab+9tOM3RV/yCEeqskj3lHImf6kE7W
         alO+d8XWap11k5vR24pKr6+VLdpWW4PWTVx652QMGeVfNtSiUcxGoNqRiYXPyGAESZF6
         vSIHVdkig/hcg7+CV3LHmaR+cAhnecjemGtByXy0jLELrSgKq9/dzrKE/kFYax6eYWPw
         vJuQ==
X-Gm-Message-State: AC+VfDz95pcgsNRMKrLENsClpIL15XV125CO0a4VXRi7FikpdTSdtHTk
        ptheFZAGCHIbgqdwBfozlHpp18vNRuU=
X-Google-Smtp-Source: ACHHUZ7NBoYK4aVUtv2GatJSOcWzSrtoQnuBRpZ0trP89wU2zVVO7Yr1urN81zf/BLK9Al5/osVuDQ==
X-Received: by 2002:a4a:d0a5:0:b0:545:bd13:18cc with SMTP id t5-20020a4ad0a5000000b00545bd1318ccmr8265918oor.8.1683054059763;
        Tue, 02 May 2023 12:00:59 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id d3-20020a4aba83000000b0053b88b03e24sm1368907oop.18.2023.05.02.12.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 12:00:59 -0700 (PDT)
Date:   Tue, 02 May 2023 13:00:58 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Message-ID: <64515dea5c566_1ba2d29487@chronos.notmuch>
In-Reply-To: <20230427083253.GA1478679@coredump.intra.peff.net>
References: <20230323162234.995405-1-oswald.buddenhagen@gmx.de>
 <ZEopHDNl69ZBcpps@ugly>
 <20230427083253.GA1478679@coredump.intra.peff.net>
Subject: Re: [PATCH] strbuf_stripspace(): rename skip_comments arg to
 strip_comments
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> I'll quote liberally from the original below:
> 
> On Thu, Mar 23, 2023 at 05:22:34PM +0100, Oswald Buddenhagen wrote:
> 
> > That makes its function much clearer and more consistent with the
> > context.
> > 
> > Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> > ---
> >  strbuf.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/strbuf.c b/strbuf.c
> > index 1c57ac6574..49e8beaa4c 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -1118,10 +1118,10 @@ static size_t cleanup(char *line, size_t len)
> >   *
> >   * If last line does not have a newline at the end, one is added.
> >   *
> > - * Enable skip_comments to skip every line starting with comment
> > + * Enable strip_comments to strip every line starting with a comment
> >   * character.
> >   */
> > -void strbuf_stripspace(struct strbuf *sb, int skip_comments)
> > +void strbuf_stripspace(struct strbuf *sb, int strip_comments)
> 
> I don't have a strong opinion either way. The original name was just
> copied from stripspace()'s similar parameter, which came from 9690c118fa
> (Fix git-stripspace to process correctly long lines and spaces.,
> 2007-06-25). I don't think it carries any particular significance,
> though I find either name easy enough to understand.

To me strip_comments makes more sense, because it implies an active
action, skip_comments implies nothing will be done on them.

-- 
Felipe Contreras
