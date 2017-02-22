Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6D77201A9
	for <e@80x24.org>; Wed, 22 Feb 2017 01:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753016AbdBVBGO (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 20:06:14 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36434 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752397AbdBVBGM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 20:06:12 -0500
Received: by mail-pg0-f68.google.com with SMTP id z128so2082727pgb.3
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 17:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tcTjTUyBpOmrj28Ml1Ghb0RmJiCNFeLtf5MHTBSsnn0=;
        b=UD7l/Fnu3IHKuPFfFspmP42Y6BfgCw0Uhu0SaPjvVO3EeP5vjnE3GC7AmWLLZXX9XI
         LJTc086Q9gphHirhpIDjZaTawDV+dzUq12yjlcLjNch/gOuIh4zv5mntLPZaq0F3S+tT
         tGwd2foFLBRqUbc636cDD90cRjGiIrmNBCDdv6xzOAqjSGrLdoPDPQrfvzHhotnzPCBc
         6Jm7xb41wJs2y+6tFPQrC1Pfv6KDSCiX1Owei7DgYAJ1OOBBMDodDJ3ROBhHl+x+ge92
         QkRvFEcJEaIgydwWBJp0sszCfu1kJDKMAGT6iCcwn+qzPfMWuakdIm4F4FH7M0tZFmAw
         ZEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tcTjTUyBpOmrj28Ml1Ghb0RmJiCNFeLtf5MHTBSsnn0=;
        b=XM4ntxZN/WfDIScnvfl1u6jgyulzci0z24ur/LoYjkedpKFHJhWujWw4MYk99Uug5J
         coMdds8fLV+MEu+I600X4h+CuCiQz41cxcC+t20qKjFmAXL6Mx3XFxqW2prUm4oIh7cj
         P6Cnmw01QRULRlcs3nSqeYaHPvkOI53F3fuyzyUCVO5dNoPGR2HhuB+NqRrckP41rkq7
         Kx5lSenCnRxO5yXwQpqrkj0isF0HRTs1YnRmyVXrY4hymiwYJgUAvir7BKMf9Y9JWTci
         OydMxGlq8UGe5uAT1qcNKk54DZHbu/cBqnCmWvpm2eY7Ejrm7g+JpGton4z4dj8C8yLs
         4fJw==
X-Gm-Message-State: AMke39mXY2CBdjzgOsfsLBAzPPScF+V3W36KaOt9yS+XePrt/aWeL1PMMfa1nCYFku5kdw==
X-Received: by 10.98.94.2 with SMTP id s2mr36588911pfb.133.1487725571730;
        Tue, 21 Feb 2017 17:06:11 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d997:8b5d:f579:2a90])
        by smtp.gmail.com with ESMTPSA id g2sm23934714pfg.105.2017.02.21.17.06.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 21 Feb 2017 17:06:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "git\@vger.kernel.org" <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] config: reject invalid VAR in 'git -c VAR=VAL command'
References: <20170215111704.78320-1-larsxschneider@gmail.com>
        <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com>
        <f238248f-0df2-19a5-581d-95c8a61b4632@google.com>
        <xmqqy3x712if.fsf@gitster.mtv.corp.google.com>
        <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
        <xmqqa89n10df.fsf_-_@gitster.mtv.corp.google.com>
        <D0CDD1AC-05CA-47F3-8CB5-61EA1C6515A8@gmail.com>
        <20170216232730.xsx3xks5ppjws5rg@sigill.intra.peff.net>
        <xmqqwpcptxps.fsf@gitster.mtv.corp.google.com>
        <xmqqino5jia8.fsf@gitster.mtv.corp.google.com>
        <xmqq37f7gyuj.fsf_-_@gitster.mtv.corp.google.com>
        <CAGZ79kbR2QQyYO1dnQ0jW3-ztKEFj1MtJfDqEc0xoftMFeN=WA@mail.gmail.com>
        <xmqqlgszffm0.fsf@gitster.mtv.corp.google.com>
        <xmqqd1ebfd9l.fsf_-_@gitster.mtv.corp.google.com>
Date:   Tue, 21 Feb 2017 17:06:10 -0800
In-Reply-To: <xmqqd1ebfd9l.fsf_-_@gitster.mtv.corp.google.com> (Junio
        C. Hamano's message of "Tue, 21 Feb 2017 13:24:38 -0800")
Message-ID: <xmqqfuj7dofx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>  	/* find the last dot (we start from the first dot we just found) */
> -	for (last_dot = cp; *cp; cp++)
> +	for (; *cp; cp++)
>  		if (*cp == '.')
>  			last_dot = cp;

This line probably needs this fix-up on top.

-- >8 --
Subject: [PATCH] config: squelch stupid compiler warnings

Some compilers do not realize that *cp is always '.' when the loop
to find the last dot begins, and instead gives a useless warning
that says last_dot may be uninitialized.

Squelch it by being a bit more explicit if stupid.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index e7f7ff1938..90de27853f 100644
--- a/config.c
+++ b/config.c
@@ -239,7 +239,7 @@ static int canonicalize_config_variable_name(char *varname)
 		return -1; /* no section? */
 
 	/* find the last dot (we start from the first dot we just found) */
-	for (; *cp; cp++)
+	for (last_dot = cp; *cp; cp++)
 		if (*cp == '.')
 			last_dot = cp;
 
-- 
2.12.0-rc2-231-g83a1c8597c

