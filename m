Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CABA01F859
	for <e@80x24.org>; Thu,  8 Sep 2016 01:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753010AbcIHBut (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 21:50:49 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33120 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753837AbcIHBuo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 21:50:44 -0400
Received: by mail-pa0-f42.google.com with SMTP id cm16so11808096pac.0
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 18:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3/PhCUknAxq0LP7dx75PPGoqsehFYS89FXF3+rpyfa0=;
        b=GaGz/5aFoePh+uu8qlWhuSP4IpyblJq8SkQf22KzD3NYU+xkJhO6KH3IzRtrAUjpU2
         tMXY0ysmzg6x+HUIiqXSbzqG5kZBKxkOPOHPhu4ZPPSPP4EJnWLgpCT5tjQhsnQCKGeI
         eiNm1uX+3+4spPM/gOJUJiGNYpzKEHtqABuz8VyzSoTXyLSBTugoi8gtke1qd1lDqJgL
         Hy1OK3FsH3nyGPDxgLZlycw8lBONAfFD1IU46+Cc5jjPSvdWroW7WPVnickIJZt8Zeic
         5NVDL5hgx8n1TFgl6U1WVWJP0FSlu2sJ/EVq1hk4GB8g+rP/yv4TsMWVPEWZDxc7k2WC
         6rJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3/PhCUknAxq0LP7dx75PPGoqsehFYS89FXF3+rpyfa0=;
        b=MkpZoEPjxGptQCqb+OrZ6WOvzVsWwBX6RpL034wKgQ8OCiJ2zjDAVZ8kfYYIYS+wxi
         8b2yJ8rsRFVMgHSblhmvhPMIi4lirDDn10PdULn/VCf1GQwCKfN63HYvucq1KfYJn8LM
         RC7ORMC/Sl7FUHnJ1a4NGbicQa67K+C+1B5Mo63+YES9RqyitNUHctBa0clsTQsTN3UU
         UrNpHhegWfrofKsGmrt4/6Da1f1ciXQfQmlseX7MlI6kHwRG6KK/AQJ/+Z5/82wCsfE/
         LclexwtvY3oN93kla6gRFHEVDJ4eKwPlcsjtWDQwCvnvAfdRRcidc3j0riZvoWzncO/g
         GcqA==
X-Gm-Message-State: AE9vXwM2/wsMTAirGU296FN8Lb8Qt6t+doIHrOcFLVP1woBuealH3CC60M/Lcnfi+lfwmw==
X-Received: by 10.66.197.131 with SMTP id iu3mr87552457pac.97.1473299443087;
        Wed, 07 Sep 2016 18:50:43 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:60fa:bcd3:3f9b:dd2])
        by smtp.gmail.com with ESMTPSA id f62sm15293592pfj.75.2016.09.07.18.50.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Sep 2016 18:50:42 -0700 (PDT)
Date:   Wed, 7 Sep 2016 18:50:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, spearce@spearce.org, sbeller@google.com,
        peff@peff.net, gitster@pobox.com, Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] connect: tighten check for unexpected early hang up (Re:
 [PATCH v3 2/2] connect: advertized capability is not a ref)
Message-ID: <20160908015040.GF25016@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com>
 <cover.1473291819.git.jonathantanmy@google.com>
 <4b09bb7a5b7f4eb5fc31df3d98ce7ffc042eb367.1473291819.git.jonathantanmy@google.com>
 <20160908013431.GC25016@google.com>
 <20160908014555.GD25016@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160908014555.GD25016@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:

> Subject: connect: tighten check for unexpected early hang up
[...]
> @@ -131,7 +131,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>  				  PACKET_READ_GENTLE_ON_EOF |
>  				  PACKET_READ_CHOMP_NEWLINE);
>  		if (len < 0)
> -			die_initial_contact(got_at_least_one_head);
> +			die_initial_contact(first_line);

This should say !first_line.

I'll add tests if the patch seems like a good idea.

Thanks,
Jonathan
