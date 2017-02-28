Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A00DD202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 22:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbdB1WPq (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 17:15:46 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33474 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbdB1WPp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 17:15:45 -0500
Received: by mail-pf0-f193.google.com with SMTP id p185so1908652pfb.0
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 14:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rwQ9eu2rO1Z151tqE6WukSioSwko6aO/4ZXvp3gZQXc=;
        b=lWb7vnwJl+JYTzXh+PmMy8oxMzOkzGJtcoLP/dKv6YaBBv0TlfMWVHV4xb8jJwxWpQ
         mgDencnSKZ3NJOpO9l/WSdzyHdOduwe15EsAdjjFB74+NMGA5mjOnmj+gssHoTFeCna8
         JVK9Jk9G3x8OwJA6BBbY4zhDdrjMS0TpdajmnpcVTcbsHb4nrS6RwTB4WKZx8+A6fwpg
         obGrmPe/akj2nA8fzJRKigBQ6t1yYlmDxQ/Bqg4nOVMAEZulWp+t7iNIbFC0Ii/+K42U
         N1EU1atT3MYcxBvlhYkRSEXo10rBjXLzrenZO45cM8CoaBcCVp6EGMB+1H1mDDa9Jyny
         7vTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rwQ9eu2rO1Z151tqE6WukSioSwko6aO/4ZXvp3gZQXc=;
        b=uLz9eB02tadrctFeR4NdNWQ9YLsaCZywev1TNVXePEEqVS4vP3g9FAjDLLeI+IbzDL
         Xessc5TO63+weAcCOmQ4ynmyd06sI3FKb9bTSrjSRD6g+2PUo5HcFq1HmJ/AD5VivlOp
         lWvxqe9hiqUz+ZZaL0ncj3c6qmZpwLOo6dbJuDa4igHMYacsr01mKK00Iw+z04zYJfbf
         2t9ImMDgAMigIe04c4Hnr03QvdohHRLcJOuWQjqQ1SZ+68DyIQ5ycbIn+n9bqv1Kw75F
         gtD/E8X+3tj577mRNeV/Ou7q57QUBWoPHzGlp6GQaenDuuZOTiYYeZlg0Sd9fjiFZQGW
         ssBg==
X-Gm-Message-State: AMke39kz4H3imHwoiuCM6/84Nc/6PX4ZZcN9BL+7CQyUSqTZ1gYZBA+XuEIdgJZ0TeGZSQ==
X-Received: by 10.98.153.25 with SMTP id d25mr5078924pfe.15.1488320143545;
        Tue, 28 Feb 2017 14:15:43 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:e0d7:55f8:67f2:62dd])
        by smtp.gmail.com with ESMTPSA id a77sm6101760pfj.1.2017.02.28.14.15.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Feb 2017 14:15:42 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sunny@sunbase.org,
        Jakub =?utf-8?Q?Nar?= =?utf-8?Q?=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v8 4/6] stash: teach 'push' (and 'create_stash') to honor pathspec
References: <20170225213306.2410-1-t.gummerer@gmail.com>
        <20170228203340.18723-1-t.gummerer@gmail.com>
        <20170228203340.18723-5-t.gummerer@gmail.com>
Date:   Tue, 28 Feb 2017 14:15:42 -0800
In-Reply-To: <20170228203340.18723-5-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Tue, 28 Feb 2017 20:33:38 +0000")
Message-ID: <xmqqo9xmhshd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> +			git reset ${GIT_QUIET:+-q} -- "$@"
> +			git ls-files -z --modified -- "$@" |
> +			git checkout-index -z --force --stdin
> +			git checkout ${GIT_QUIET:+-q} HEAD -- $(git ls-files -z --modified "$@")

I think you forgot to remove this line, whose correction was added
as two lines immediately before it.  I'll remove it while queuing.

> +			git clean --force ${GIT_QUIET:+-q} -d -- "$@"

Thanks.
