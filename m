Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07EA91F404
	for <e@80x24.org>; Fri, 24 Aug 2018 15:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbeHXTcy (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 15:32:54 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41178 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeHXTcx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 15:32:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id l26-v6so7048948lfc.8
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pwg8OCh4VdscMDCyM6cHwtdIsVaI0Vc+dbV1+d15dBk=;
        b=c9/ye1E3pOIdrBgJmTfnPKkg1C3nOk6pr688AeUi8G0tNby1m50ASLji6khjY10EjB
         q/7Sv7fRatME099X/6rtrhvkyJxg2NzL683X0O/OVvw73KFg4OaXvxGMMnW1NjXwwe4V
         NPS4558cgWPjyDIXLrTpbV7ioqPiP0HQz682cg9N2dUGkWOCmGGf9QN2V01YymhKE03K
         vWE47PWqelrh1RvjI6FCS/As6Kexg3PM1SnLbilJ84XiDF6H+EKvq9Dh3j2Oxg8ojGRY
         rgmituQaB/DcCqsYXs1KDtphTJbVEWlIrsQrCHN8XU4ymih2zXfwbizICM+J5hHCaRW6
         mLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pwg8OCh4VdscMDCyM6cHwtdIsVaI0Vc+dbV1+d15dBk=;
        b=QQl0ImYzOYHOwWmhOmn+d5BftY2lYQV6GrBRf6x9GLN9OndJi3cPzIoP9y93QMhdBB
         j+0uB4KUhziCbhfxPzdq5a+9nxaCAQGmxaJnRiNRYyqMfx3cD1dLNFmM+pjQ19rJLG0t
         F0GSBQtq/3O6o5bR3QS/cZyFVz85M0T6X5sDtvwH0UMEPveNMEVAz91NrAU4MHTDoDyG
         tdT9AOoQyEK8qtyG4Fd+c2IeeHsBISqsnAIvgmF3ZFTmPGapmDmfGCcFJ4wsgXiQUl5E
         0/vhQj5UzbZljew5k71hcdLOW/OQl+hFBphu44acwkyuru59u0VOKOTsfZOTmz52lQi1
         BQCQ==
X-Gm-Message-State: APzg51CRUlH1P1VXyQTSe+RTgQGe31CkH7aEJbMw1QtGKqfSJ4i6Y4LZ
        ph24mNf3rFHHsfG4YaIhR/c=
X-Google-Smtp-Source: ANB0VdbMg9Gs5lhX5LowDYDXNGfP0A7u0KSNHYGCoglV1KNDoZ0JxVH0qo1g8OQ8RAd5XdEscqukOQ==
X-Received: by 2002:a19:6d12:: with SMTP id i18-v6mr1816567lfc.40.1535126257376;
        Fri, 24 Aug 2018 08:57:37 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id y65-v6sm1381428lfa.97.2018.08.24.08.57.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 08:57:36 -0700 (PDT)
Date:   Fri, 24 Aug 2018 17:57:34 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1] read-cache: speed up index load through
 parallelization
Message-ID: <20180824155734.GA6170@duynguyen.home>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <xmqqin41hs8x.fsf@gitster-ct.c.googlers.com>
 <4c70ea50-5b43-8696-3c46-cf3d658a0ef8@gmail.com>
 <CACsJy8CUPGUhR3girstdqD6YVxOQ6_xE+gacT98KXgqOSPz0dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8CUPGUhR3girstdqD6YVxOQ6_xE+gacT98KXgqOSPz0dw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 24, 2018 at 05:37:20PM +0200, Duy Nguyen wrote:
> Since we're cutting corners to speed things up, could you try
> something like this?
> 
> I notice that reading v4 is significantly slower than v2 and
> apparently strlen() (at least from glibc) is much cleverer and at
> least gives me a few percentage time saving.
> 
> diff --git a/read-cache.c b/read-cache.c
> index 7b1354d759..d10cccaed0 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1755,8 +1755,7 @@ static unsigned long expand_name_field(struct
> strbuf *name, const char *cp_)
>         if (name->len < len)
>                 die("malformed name field in the index");
>         strbuf_remove(name, name->len - len, len);
> -       for (ep = cp; *ep; ep++)
> -               ; /* find the end */
> +       ep = cp + strlen(cp);
>         strbuf_add(name, cp, ep - cp);
>         return (const char *)ep + 1 - cp_;
>  }

No try this instead. It's half way back to v2 numbers for me (tested
with "test-tool read-cache 100" on webkit.git). For the record, v4 is
about 30% slower than v2 in my tests.

We could probably do better too. Instead of preparing the string in a
separate buffer (previous_name_buf), we could just assemble it directly
to the newly allocated "ce".

-- 8< --
diff --git a/read-cache.c b/read-cache.c
index 7b1354d759..237f60a76c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1754,9 +1754,8 @@ static unsigned long expand_name_field(struct strbuf *name, const char *cp_)
 
 	if (name->len < len)
 		die("malformed name field in the index");
-	strbuf_remove(name, name->len - len, len);
-	for (ep = cp; *ep; ep++)
-		; /* find the end */
+	strbuf_setlen(name, name->len - len);
+	ep = cp + strlen(cp);
 	strbuf_add(name, cp, ep - cp);
 	return (const char *)ep + 1 - cp_;
 }
-- 8< --
