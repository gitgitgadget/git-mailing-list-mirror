Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823AFC433DF
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 00:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2CD22253
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 00:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHH/QYk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgJIAZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 20:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgJIAZo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 20:25:44 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B21C0613D2
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 17:25:44 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id i2so5717997pgh.7
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 17:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MkTq08PrxdxMqQ0jStJXKedXyHKWKyendMSXVSi16k0=;
        b=hHH/QYk0FC9QTWKhhbTE8toEoI4TMGu7lGGN0Vi/j4gZZOXSwfIDKAhJ7YIlrZAVuo
         zcOFqRPBFml4WYAfOjd5JoGnKArtdx28iXJ+3Ttj/J5dZF557BIhfy2e3Kqae7yylr6E
         YxFYUzDgCTLeZ+m4PUW5kRgl9tdn/Ev2C1U8TPXZf2Vk5OBD6fSbu1/OuCLq9YJaxWbg
         lz4paK4htejxUln/Fk4rIgb6eTTmLIEItwRsB+1ATVAQyLmcpqzDx5ePU/uR4hRFNWnT
         WCVbzqfxvs+Doth1ZiY1B9AHWdi3y18LWO5cDa19tmCJvSJW9Uf3aZTFNvMsxx9jqnbz
         WflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MkTq08PrxdxMqQ0jStJXKedXyHKWKyendMSXVSi16k0=;
        b=Ht3jo94nc6O/vIWJO+bImbDJH7i7CWb0bbUdKrwJyCH4u826nxTLP9RvbagDuhF6JK
         ipDjb4X7zR6sMXzvhdSgNF1tXXjh+Tr2K4Dtk5Q+ufqxV1MaQtIt0/tzdFJXKrrDpYqZ
         8inREmK0IOiRTQvdZtnqxFDfh5n4sYg2lt0/YrYEValbQoTlh+nrRF60fJ6UubOMFevx
         smqdKrHEFGzkN1ywLg9/bichzw7PFBJFMBA7zvK3/a8hJRJlOR1/04D9TCXZVEQ9f7Nd
         0fz5guPVG6VOUdDm4rOyTDemLx8TwUGrpjhh7yRQ0tIJILvWZw1DtiIWWXh0fotPxPyj
         FuLA==
X-Gm-Message-State: AOAM530m49q6OpmewTclno9zPJOmaQATnjVyyDAC47lMryhrWu1qElsK
        Ca0IIv3ac52VHkkmDR2xKCh9CK0kuDA=
X-Google-Smtp-Source: ABdhPJx7q3X1rTZBxzDin7Wr9lGnEtP7Y2d1k7qQC3KMoTp9euOQjR3kxBN7iFUoeovHutJBzO/xdg==
X-Received: by 2002:a62:8497:0:b029:155:9366:381b with SMTP id k145-20020a6284970000b02901559366381bmr108419pfd.15.1602203144206;
        Thu, 08 Oct 2020 17:25:44 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id z10sm8850897pff.218.2020.10.08.17.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 17:25:43 -0700 (PDT)
Date:   Thu, 8 Oct 2020 17:25:41 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Amanda Shafack <shafack.likhene@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Introduction - An Outreachy 2020 Applicant
Message-ID: <20201009002541.GB2415320@google.com>
References: <CAGxm6oXSaKoTR3btKRV4bMYUsc3-oKeWSfzrWKkCXgrRorAEAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxm6oXSaKoTR3btKRV4bMYUsc3-oKeWSfzrWKkCXgrRorAEAQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+wireshark-dev@wireshark.org
Hi Amanda,

Amanda Shafack wrote:

> I am Amanda Shafack, an Outreachy 2020 applicant who wishes to
> contribute to the "Add Git protocol support to Wireshark" project.
>
> In addition, I have some experience coding in C and I hope to enhance
> my skill set by contributing to this project.
>
> I am currently going through the project description and contribution
> guidelines.

Welcome!

Since this project would involve Git (for Git protocol) and Wireshark
(where the dissector goes), we're comfortable working with you on
contributions to both Git and Wireshark during the application[1]
period.

https://gitlab.com/wireshark/wireshark/-/wikis/Development/ has some
pointers on getting started with Wireshark development.  I'm cc-ing
the wireshark developers list in case they have suggestions for an
approachable "first patch" idea to get used to that project's
contribution flow.

It's also a good idea to build and run wireshark and see if anything
strikes your eye as something you'd be interested in seeing work
differently.

For Git we have some suggestions for microprojects at
https://git.github.io/Outreachy-21-Microprojects/

Thanks for writing, and I look forward to working with you.  These are
two open source projects that I love and I hope you enjoy working with
them, too. :)

Sincerely,
Jonathan

[1] https://www.outreachy.org/apply/
