Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87AA31FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 22:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbdCXWap (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 18:30:45 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34868 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbdCXWao (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 18:30:44 -0400
Received: by mail-pf0-f195.google.com with SMTP id n11so514376pfg.2
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 15:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i1hzs9TiFAt6ONFSWFff5Am7TRk4Kn3aL/OsU7Z9AgU=;
        b=u7ImijcEclyr3cIp60QnptVc0kxinmzchjU+GqJrgaloUwANgR+jHk0gFo5xtCw6pc
         /yHR+qn1CmDLpzTM0N4FKPOwOVIDz1YkRBQ2NJoswRJ4fqL0j22MDaSq45Yl1qsGPaz2
         84mv89eljd0+3kcFVFuEZlocOLTSpJg9buYMIrQSgl4l6rY35i9UA2x1Yu4829nI2NLg
         44b34ng9fszI4sdngWfFPvWp2/x5BM0yTaKkEuk7q2f1a1IbfP5KhMrVdhzZh1p9of3d
         spNTUP7Rmr4JlvZHGvSw+dyHKx+3A100FgZrpUB1u8VlPluPnSYPgD5PzfJVHFqqLorK
         Fc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i1hzs9TiFAt6ONFSWFff5Am7TRk4Kn3aL/OsU7Z9AgU=;
        b=euOLWH1n4e9hLM/bEnOJVM2paHQwnNpYLeS7ymphco3LvI5csYK5vWNWjqEZaPC6ey
         i0dwb0j39uCE3jioArcRLLK+EpR0RRge4No11a5asS2n7NIJt1do9pSxHN6afUcG8ZhO
         WLbldoEmpdI3Y/uZaKjmGYhM39h+YaOAuAZtaq7TuXsULVvW9zcKijogPE1b1i/8rImZ
         qOy8cS7kpYLdR4Me3IpSQtQPmqV1FUew/AbFAswSMJNkxr9975EqNVDFz+SjGsAC1V7o
         u8BXtaa5AYXbXUuyMzOUIWjrwBFaKWEJLsHk2lCY59s9IXG8rQQAsh5GQDSim/er3Opf
         SguA==
X-Gm-Message-State: AFeK/H1bT1Du1KfOny+L9IijZ5RRCRDFzLecrhabl6Z3SmKRRZcWqDTzYRpqUH1jeLVFBQ==
X-Received: by 10.99.227.69 with SMTP id o5mr11606660pgj.133.1490394642870;
        Fri, 24 Mar 2017 15:30:42 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:8597:ae41:db75:6a97])
        by smtp.gmail.com with ESMTPSA id a8sm6556118pfa.30.2017.03.24.15.30.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 15:30:42 -0700 (PDT)
Date:   Fri, 24 Mar 2017 15:30:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 2/7] submodule.c: factor out early loop termination in
 is_submodule_modified
Message-ID: <20170324223040.GG31294@aiede.mtv.corp.google.com>
References: <20170323223338.32274-7-sbeller@google.com>
 <20170324182902.19280-1-sbeller@google.com>
 <20170324182902.19280-3-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170324182902.19280-3-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> --- a/submodule.c
> +++ b/submodule.c
> @@ -1075,16 +1075,15 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
>  	len = strbuf_read(&buf, cp.out, 1024);
>  	line = buf.buf;
>  	while (len > 2) {
> -		if ((line[0] == '?') && (line[1] == '?')) {
> +		if ((line[0] == '?') && (line[1] == '?'))
>  			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
> -			if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
> -				break;
> -		} else {
> +		else
>  			dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
> -			if (ignore_untracked ||
> -			    (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED))
> -				break;
> -		}
> +
> +		if ((dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
> +		    ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) || ignore_untracked))

nit: long line

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git i/submodule.c w/submodule.c
index aba89661a7..8934d97359 100644
--- i/submodule.c
+++ w/submodule.c
@@ -1087,8 +1087,10 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 			dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
 
 		if ((dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
-		    ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) || ignore_untracked))
+		    (ignore_untracked
+		     || (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED))) {
 			break;
+		}
 
 		next_line = strchr(line, '\n');
 		if (!next_line)
