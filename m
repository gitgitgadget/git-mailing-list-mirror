Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BF2C3F2D7
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 16:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA526214DB
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 16:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7NEm/o3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbgCCQ3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:29:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55038 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730411AbgCCQ3K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 11:29:10 -0500
Received: by mail-wm1-f66.google.com with SMTP id i9so2564630wml.4
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 08:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9+12buehby7qs0N/+nwJIpHsFOmxykW7CQC6gHidF3A=;
        b=g7NEm/o3EotINQ7VJPwlUudUe0otG12cSMcAK9hzWDwZH1Fy+tpxmDLVqyNmpKw51x
         SY+gKBQzy11QIjV7uyi4AZGzfa59Yt2BMTPyEeNcUZgHvdEcZrhOl8pvvxoJ+AZnd11Z
         9pBAltk1hcOwMD/r6Wzumogy7mrBsMbN6C7pbCdw615OaILmANNkHAwNC7kqcD1OwWaa
         vvCODjkBb4Bu13ODZ3mm0hmQKqdsfosSX6mKisGMZjwfk/W+fG07zKXGPxrpjNC+8xtv
         4EPYmtf2LaVG7AvMshd0NaKzg5aY3YDbbKyeLC5tPO58UWj/McEQE/nVvLu5IKTt+462
         XH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9+12buehby7qs0N/+nwJIpHsFOmxykW7CQC6gHidF3A=;
        b=QNDz/H+ZR5E+g4I2IEzn6Dw4KKZg3oU6K8aaliVyBNLkdowfRPGhEUPqoXlhSaGAnd
         W/nN+FMos/lrBnDXAsqtxFlA57lGJ/H6vwsz0FyM7GU9dyJzVSrvc0ke4IzxuVQTcPzh
         ulUNgE8hOW/6XiORLDGZK1vUvy/U892Bkr52jkbQ+d0jQZONRsz1oTmt3Pw8OgDxoyeY
         WtcoBCJaui9AbKAYkExCVnqshLDdfSAPSbrn42Xom7EQBTXTU0lAkHgkltXnzSCyBLRi
         0A0Eo4fzXr5LChMbL6lOecmD5+nDr4J2RBZBIIyzdiI2HrNXXRMcnJLmbq7oKHajxpkR
         IiBQ==
X-Gm-Message-State: ANhLgQ3DyHOK6pfJtWvs/P7r1KQczzLYiaBsByTfUPuyakgNDvEcYGA1
        7VeHzS+lRS4UJTQiUNGkhbMPFqmB92Q=
X-Google-Smtp-Source: ADFU+vsSsCZSqnjyQtBQe8Z1fpjCS2/JRM7odddNEvJHLqEXKfYJvh1Da6widXcXp8rLt+UUhUTihg==
X-Received: by 2002:a1c:c344:: with SMTP id t65mr4871977wmf.97.1583252949201;
        Tue, 03 Mar 2020 08:29:09 -0800 (PST)
Received: from feanor (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id t83sm4707629wmf.43.2020.03.03.08.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 08:29:08 -0800 (PST)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
Date:   Tue, 3 Mar 2020 17:29:06 +0100
To:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] remote.c: fix handling of %(push:remoteref)
Message-ID: <20200303162906.xadbaeaq4nurqsem@feanor>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Tue, 03 Mar 2020 17:25:29 +0100
References: <20200302133217.GA1176622@coredump.intra.peff.net>
 <20200303161223.1870298-1-damien.olivier.robert+git@gmail.com>
 <20200303161223.1870298-3-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200303161223.1870298-3-damien.olivier.robert+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have some remarks/questions:

From Damien Robert, Tue 03 Mar 2020 at 17:12:23 (+0100) :
> +	if (remote->push.nr) {
> +		char *dst;
> +		dst = apply_refspecs(&remote->push, branch->refname);
> +		if (!dst)
> +			return NULL;
> +		return dst;
> +	}

Should I simply `return apply_refspecs(&remote->push, branch->refname);`
here, or is it a good form to always check for a NULL return value even if
we do nothing with it?

> +	case PUSH_DEFAULT_MATCHING:
> +	case PUSH_DEFAULT_CURRENT:
> +		return branch->refname;

Here I follow the logic of branch_get_push1, but the case of
push.default=matching is not quite correct, because we never check
that we have a matching remote branch. On the other hand we cannot check
this until we contact the remote, so I don't know how we could get around
that.


-- 
Damien Robert
http://www.normalesup.org/~robert/pro
