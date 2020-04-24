Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B95C2BA1A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 06:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B1C2166E
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 06:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQjoEgc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgDXGsJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 02:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726051AbgDXGsJ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 02:48:09 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510A7C09B045
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 23:48:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y25so4356999pfn.5
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 23:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VzKYSRH6EP48Bvq5qd/y7Lro4AQqfRKGp15Rx24/AXo=;
        b=mQjoEgc96uNVmHkT/bCZvw3bu59szuWIWLKBScrm1KEc+bUiPzHRMnzQMApM1vMEnS
         G/wXD8n6jdvpOzxnYQPPtqIAYyG1HV7DkwaQxNtEeZPioQYnrLrZAoKPsGcdrgu6zcIA
         aT8ZyzPcY1MFRk27/KRtrAnolMv6NfyuNgUeEZoCvoD8HO00JBa3sI8hPWuiQ9GszcWl
         /RUs2HbsLrO6oitjk7NFv77j55fkT0MBsxnGjy6Wva2ICvREoeNGd8/gI0NIKJKtDMYV
         B02qeI3pSbMYj3rnaeOu4nTt88porBc3tGlNyPVwy8mjKaaWujrk7C9BotiDmO4HAmI9
         pbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VzKYSRH6EP48Bvq5qd/y7Lro4AQqfRKGp15Rx24/AXo=;
        b=thrljPu2aUq7X7qduWUd0aPGhzjm3cJNu0fST8tN/ibGjwKDnae7qC8bh0CR5f04Fu
         AQB8SYLXrvf5Bq78wkZLByz8yVYSmLr3QgSJBiUdLtaLZOH8AKayP60/qoSoERkPOPjy
         6YHkX674qc1ArTnoD/LdZFc4J7ti+vOJ0Ew6SZfyN11XusLOtcsDAf4kMrJ9nQ3yKwrL
         aGdvyhwelXmeQHOKq4FpjcpzlFUyYLvhpZ27RsN8TqQpKOieU3osiHXwoqygPAYXUyvX
         z+CYYOHt92zs8K3Lt6LMt8oR+tHnjeFMJz61hjUAuieARwjLVcn81ujEtIKrnoSE9BO/
         H8Mw==
X-Gm-Message-State: AGi0Pua2hw1F1PxOncxivzbr5B+EsJVuabpK0RB9rTyi3nbkmhDIJkHG
        plNMJHM0uYnHQnzKOl5etUs=
X-Google-Smtp-Source: APiQypJ71Vt1QoAIoIM8lIGaPQbKcEe61JnIjNZQBdF42MCtTExSOf49qJX0vwouaK7dLFlvjis0gw==
X-Received: by 2002:a63:f0b:: with SMTP id e11mr7441889pgl.155.1587710887503;
        Thu, 23 Apr 2020 23:48:07 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id x200sm4044723pgx.50.2020.04.23.23.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 23:48:07 -0700 (PDT)
Date:   Thu, 23 Apr 2020 23:48:05 -0700
From:   Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= <carenas@gmail.com>
To:     lars.fricke@googlemail.com
Cc:     git@vger.kernel.org
Subject: Re: p4merge no longer working after upgrade to 2.26.0
Message-ID: <20200424064805.GB44448@Carlos-MBP>
References: <CANYt6aFi+6vKRD71digEh-D0RKkLPBRtek5t8zA-8_cPzwexkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANYt6aFi+6vKRD71digEh-D0RKkLPBRtek5t8zA-8_cPzwexkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

does it say it is "not currently available" if you run:

  $ git mergetool --tool-help

does it work if you do :

  $ git config --global merge.guitool p4merge
  $ git config --global mergetool.p4merge.trustExitCode true

or change your PATH to include the location of the tool?

Carlo

PS. mergetool.prompt is a valid confguration, but not mergetool.$TOOL.prompt
