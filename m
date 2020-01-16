Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE106C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D98020661
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YvyxNeR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388478AbgAPVJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:09:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34807 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgAPVJD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 16:09:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id i6so10834712pfc.1
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 13:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yLRSyFWLyrOQd9lvVl96KAkeM0CwM/LE9mXqpnfzODw=;
        b=YvyxNeR+3bKfAdf7EAycXIcEBgIvpVsyCcBxkj4ZNoUgfcT+ZDdUP78ggLSa9HwoRL
         bS0m69wbIqKNozZOL3Tu/Al8RpchG68Tpot6vjKIpajkyW17vOZZAFvceH2zYQf7L3Bl
         mpH3OY6Y4IWXF6AVjfwkBD+x+3rPZMnlw39oPvqftopSstd6dfnfvYJtZWE3eEgRz6Q0
         Sbsc16Ycq7xtF30faWXB8ScJRQtWuFkZtX7UMPDotEy3aQgEEJZ2xbvJlD0qpqOjMUEy
         uNX24i/fEhwHf1TR3Icray58Y2JmT3Q07JLiSTMXZNMT1r8Hw70GEQ78e9nl13hC/x83
         6o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yLRSyFWLyrOQd9lvVl96KAkeM0CwM/LE9mXqpnfzODw=;
        b=dQXMfg3gmAWz5THqO+57a8wfj8LwCRHP4FiIAp+uHfn9LXZayjuD8XwPn5riWqmM0c
         drHk3WnaD53vNCquKPsMmDg8Rrng3rsxmXfQCsLgTSZ/K3YyQDlrVT92ZOeGHBWaO6md
         yVn0Uy3KG4Wbkh0y/AZ9Q94dNsg/CVkCvsPZyaXbcBOlBQFyeZzGJ8aYHSElFts1/LII
         Dq4DzXse//egtHIdJoTdniq04IhTlxjGjtSqbn6sC4h1v99emWk8nT7lKZGTqGTGZmS4
         Kh2RhyECqvmLTv/UxTLVizCFEA7agmzOsp43Dnsl7Ffjzv98GXJkszGC/5UY0eWlpVBf
         bYzA==
X-Gm-Message-State: APjAAAWoBdyUVl7Ux1LQeOObKgkos43IDbgEtI1GbFfhcBzuOvT07GId
        jMnCdnpbyB6ge36W0A3rzu+NpQ==
X-Google-Smtp-Source: APXvYqwBD6KMzp1fFXTgD5Cb2Q3Bp8WdBAWi9gEzHNMDVjwfqK4J7y72HK0GaRFPa2MpR87LB+UGug==
X-Received: by 2002:aa7:946a:: with SMTP id t10mr39683997pfq.165.1579208942163;
        Thu, 16 Jan 2020 13:09:02 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id d20sm4614767pjs.2.2020.01.16.13.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 13:09:01 -0800 (PST)
Date:   Thu, 16 Jan 2020 13:08:57 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] Documentation for common user misconceptions
Message-ID: <20200116210857.GJ181522@google.com>
References: <20191102192615.10013-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102192615.10013-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 02, 2019 at 07:26:11PM +0000, brian m. carlson wrote:
> This series includes four patches that update the documentation to
> address common user misconceptions.

Hm, is this still waiting for a reroll? Someone just ran into the
user.name/username confusion in #git-devel today:
https://colabti.org/irclogger/irclogger_log/git-devel?date=2020-01-16#l79

 - Emily
