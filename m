Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CABCF1F404
	for <e@80x24.org>; Thu,  1 Mar 2018 21:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161971AbeCAVZj (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 16:25:39 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40025 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161816AbeCAVZg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 16:25:36 -0500
Received: by mail-wm0-f66.google.com with SMTP id t6so14880977wmt.5
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 13:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MmPJ6y/nIBAdO7oWYmFofRv6WI0fF4A89x+GsneaI+c=;
        b=ihrbyC+6Ube/jhYJthjLDnUKUNf/7ss1/LsmrpGL5MkEaTRdVN4qShDfDLZb70K0d+
         UzUR2er13YQ9eURzE7/cTBqVj59zEHFxoeyB6a8dEhiWDuBv/btE30Zxpo+Pa4duIx9j
         lwoEThY5zwKbYG5w7idBHiWL6dr2UEVTQhKETdWbec1zoIAR39m9iIdN7xSdpwQTYnWR
         dMy+bbJAq0zVzpvxxQ235zSBFzaatw4ghPE0JkQCUd+msiXd6GicbjzLLeF27oQaI+oN
         BDcunecaNe51aRkfACraw9NiORnCEOkW4lvKlpLuMQ+uudy3cuu68otngJIX8zhzhZj8
         gnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MmPJ6y/nIBAdO7oWYmFofRv6WI0fF4A89x+GsneaI+c=;
        b=RdZ0PykPWV2/NT40swW89r4vWs8M+KZrUetvIDpoY1u/x7Xsqcw1bwa9E3X1USMWDi
         0gh8Dol1HZDssaWLFNcf4CqdV/s0UtEgr5uRZpVf+3O+/irzCK0x6HhC6IhKpvvHOXvI
         EjkfKskS88gMcSUaDXgyJtwRtDZxGIaTzJGF/vGJwO+0HDdmfOmN4F7G83MHk4DmtulN
         jA1bS7MkbIGGsyoF/SKNbWwEnxqd2LUdfE4qTc4sPRVYHiSBIeFig/0nXjKpcf+OwHBv
         CjjVqGoT/cr5PbWec15shZ4sZv8LgVzw5fTYpbrxJLqC67GbMYV/NWxGTwOUT5E2R/3q
         nfAA==
X-Gm-Message-State: AElRT7FhsOwgM7ijan+43zbU/63wedmiH3s0zn0hLlENV2JWU4iVvbAA
        SMK4dDPJirfuAGwE4ITJFQAoEaJl
X-Google-Smtp-Source: AG47ELuCCoLog2xGRfay6K0dlKUx67tibGrWrXQGCtpDssaRXIMgDABregcvWxu5TtIqnxfQIUxNSQ==
X-Received: by 10.28.171.10 with SMTP id u10mr2902526wme.108.1519939533771;
        Thu, 01 Mar 2018 13:25:33 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o9sm5740785wrf.43.2018.03.01.13.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 13:25:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 06/35] transport: use get_refs_via_connect to get refs
References: <20180207011312.189834-1-bmwill@google.com>
        <20180228232252.102167-1-bmwill@google.com>
        <20180228232252.102167-7-bmwill@google.com>
Date:   Thu, 01 Mar 2018 13:25:32 -0800
In-Reply-To: <20180228232252.102167-7-bmwill@google.com> (Brandon Williams's
        message of "Wed, 28 Feb 2018 15:22:23 -0800")
Message-ID: <xmqqy3jbebeb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Remove code duplication and use the existing 'get_refs_via_connect()'
> function to retrieve a remote's heads in 'fetch_refs_via_pack()' and
> 'git_transport_push()'.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  transport.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)

Nice ;-)
