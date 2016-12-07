Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCB8D1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 22:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932434AbcLGWNw (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 17:13:52 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35760 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbcLGWNv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 17:13:51 -0500
Received: by mail-pg0-f52.google.com with SMTP id p66so166371238pga.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 14:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SGmu+2KYbm5V5Ro6MVTZJq+9w32ei+DvZBFSF/P9onU=;
        b=H/iUYqtPgxWvmbdUiFbRT2PFapxwnUMOQrCdsLtNOdpAaxXNAXV3jWVwb1qytEetfT
         UP8zxDkuBWFNkKTCF4AI58gmVmnImXEekF+ACY7PbdeYHBMWJfkJ9pkR15LqY26Yg1uS
         KrAC8Hk7XClQN3l+RuWgz/lpg1YIrwbvv4jm/wdqTbI1SNO4l2S+quEcxUzh+bAsB477
         ZXJelH1oxIFRh0bxco3zuZGLTK/kFcwin580zRQw0txomVE8WCXycML71PUfDjEMCD1o
         WM8VmtmfvGuYvAyaSjHrt3hKE5SgVjeaNa1tJGHsprfdEZpL8PVy0tkaYqxveoKZrflx
         vmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SGmu+2KYbm5V5Ro6MVTZJq+9w32ei+DvZBFSF/P9onU=;
        b=SR6QScFqsyr9JwQMBOU+oIH9OC7Cz7adEpdPnCXQTKaBMXoI2QckOo5oC5Z/MUCgy0
         5Pl3vctElD68b+YYtAL7u3vNDEpm7cNbAsdK0VLgPWEolBQRJl+rYh96kQz1+RivUzHI
         cUlMXo0t4dvScWVAgAyYdBvs6/6k49XPXxVQwfzo96+IN5/2qsT+dMHxnZXjrM5vmChO
         nWsm6lTrv79hCHFeHKLUkup7owqcrVSduwMDGVwekTrQc0u3g6pvydwvSpxrpEA3fal3
         atcGkOuWrI+z6VX2GRaWR1LharqMHRiDnGPtYskWvSidoQ2pzDnpJPZ81ca3ZzoJCYVt
         yVBA==
X-Gm-Message-State: AKaTC00SH4sO6HcmzDWLp9uk8COeQ3LdbmmI7BzT8zw7pMSH46FsaF0glpjilkpjVnlCBg3g
X-Received: by 10.99.159.26 with SMTP id g26mr125384166pge.62.1481148817949;
        Wed, 07 Dec 2016 14:13:37 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ccae:4719:31da:e07d])
        by smtp.gmail.com with ESMTPSA id p68sm44945400pfd.11.2016.12.07.14.13.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 14:13:36 -0800 (PST)
Date:   Wed, 7 Dec 2016 14:13:35 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com
Subject: Re: [PATCH] real_path: make real_path thread-safe
Message-ID: <20161207221335.GA116201@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1480964316-99305-2-git-send-email-bmwill@google.com>
 <xmqqtwagy65q.fsf@gitster.mtv.corp.google.com>
 <20161207001018.GD103573@google.com>
 <b73e61f8-0cff-b33e-118a-e530d367c94c@ramsayjones.plus.com>
 <20161207201409.GA19743@tb-raspi>
 <xmqqtwafwkdt.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqtwafwkdt.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07, Junio C Hamano wrote:
> Torsten Bögershausen <tboegi@web.de> writes:
> 
> > But in any case it seems that e.g.
> > //SEFVER/SHARE/DIR1/DIR2/..
> > must be converted into
> > //SEFVER/SHARE/DIR1
> >
> > and 
> > \\SEFVER\SHARE\DIR1\DIR2\..
> > must be converted into
> > \\SEFVER\SHARE\DIR1
> 
> Additional questions that may be interesting are:
> 
>     //A/B/../C		is it //A/C?  is it an error?
>     //A/B/../../C/D	is it //C/D?  is it an error?
> 


Also is //.. the same as //?  I would assume so since /.. is /

-- 
Brandon Williams
