Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A933220254
	for <e@80x24.org>; Mon, 27 Feb 2017 22:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbdB0Wol (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 17:44:41 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34058 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751586AbdB0Woh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 17:44:37 -0500
Received: by mail-pg0-f68.google.com with SMTP id s67so2367264pgb.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 14:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Vq9pkOn1xQxzJmUDuEdtNsIXMGQihEuemcc0r7FVRHY=;
        b=qkZDUn9Fq96yH1eToF6Zm1u753uG57+TZiyw1UbOepYsDHhLU5X+NnVRZJXlIYcKap
         G0vSFU3ZLjvJOuQXYVEGia54/RWEre6BlQ7d+LsH8Ng0NakfL6BLOtvKfAP94Pvhybmz
         1rGDT7edPuSFDqZdt6vNukX/totjKfsojgwDouDPGP1AzvarWym5zPwmdeChavwLK+Tj
         LI3qEc03PoR7c0+UkSc22tPrNKw8mJlADAl2j7hqxypOx5r+dRCtIf6/ZkI829g4eEIa
         Bh0JNubnrzfsAcUVytiXwrFXbknDIcFjr3txGNhKGoyplgAl7J/6y09x4osq7KP/+6gG
         C+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Vq9pkOn1xQxzJmUDuEdtNsIXMGQihEuemcc0r7FVRHY=;
        b=uRnPvoaIgS/cgszIrLbCrDnzNQbvDQihbvsWutccedtOY2MrSXl5wt+G/n3jYVLcrx
         0X8pQRuCoS4wbUwuH7mylpd18NHXLonRvWuaUDyu3rFOFQLw6y27MeKnHDdBA3+gXuP5
         XrFAXibyu31U6pxmqJZQogDJ+9zDTEzZz0Z5Pd+GNUgoXJL30stXmZBdA11FxC0DybJD
         GAdmjQTUwiE2N2/Nsau8utDnSSncnYVAlNBKZCAQDJkXx+oTE42dcys/D/8TnKhjDS80
         mZ8/E8NXO8yjZAVrzBc8pcZ7fTbzpmZJHPU+wyCVOc8iEtszohdwJ7BQpNdxTfru+VZB
         7U/A==
X-Gm-Message-State: AMke39kaBk6OkQrCv0MFf3ia8gv9PAKmKzbywJ1/afJj0G9srn0MOShKiJMCooZ4gHr3+g==
X-Received: by 10.99.215.5 with SMTP id d5mr23508669pgg.51.1488227552589;
        Mon, 27 Feb 2017 12:32:32 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id r73sm32317820pfe.55.2017.02.27.12.32.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 12:32:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sunny@sunbase.org,
        Jakub =?utf-8?Q?Nar?= =?utf-8?Q?=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 4/6] stash: teach 'push' (and 'create_stash') to honor pathspec
References: <20170219110313.24070-1-t.gummerer@gmail.com>
        <20170225213306.2410-1-t.gummerer@gmail.com>
        <20170225213306.2410-5-t.gummerer@gmail.com>
Date:   Mon, 27 Feb 2017 12:32:31 -0800
In-Reply-To: <20170225213306.2410-5-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sat, 25 Feb 2017 21:33:04 +0000")
Message-ID: <xmqqa897wf1c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

>  	if test -z "$patch_mode"
>  	then
> -		git reset --hard ${GIT_QUIET:+-q}
> +		if test $# != 0
> +		then
> +			git reset ${GIT_QUIET:+-q} -- "$@"
> +			git checkout ${GIT_QUIET:+-q} HEAD -- $(git ls-files -z --modified "$@")

"ls-files -z" on the command line?  

Apparently new tests do not cover the correctness of this codepath.

I wonder if this

	git ls-files -z --modified "$@" |
	git checkout-index -z --stdin

is what the above "checkout" wanted to do.  The "reset" in the
previous step presumably updated the index entries that match
specified pathspec to those of the HEAD, so checking out the paths
that match "$@" from the index would be the same as checking them
out from the HEAD (while updating the index with them).

> +			git clean --force ${GIT_QUIET:+-q} -d -- "$@"
> +		else
> +			git reset --hard ${GIT_QUIET:+-q}
> +		fi

Thanks.
