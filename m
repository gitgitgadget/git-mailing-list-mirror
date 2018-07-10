Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D55D1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbeGJSjO (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:39:14 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39923 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389922AbeGJSjN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:39:13 -0400
Received: by mail-wm0-f68.google.com with SMTP id h20-v6so31755wmb.4
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 11:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LrCnwLl0E1o+MckPPGQPMuDEYzgSaiQwKVnELse4FGA=;
        b=dQ8d1Y3fo6ckvJRDD8ningvhzo9sKJ0bKy7lekrexjsudpao9VT39di1LrlXP47bGF
         fFZ+zjRI3AbA/BcuNnU0OC84YlAdFODfAFf7pytApU+w7+LYemsogC0KEIXHw9usLkuo
         bnl6qXdu41i6yz2hB/BFuIR8e3QP0DCDMCwSzXAvIhomsSIl00JaNX5ui7NmkscHclQj
         zZYSbsvNOK0ickAhN25TZIatChJgrdlHfiLedNKNMbl2XbQKyKtyYL/XX0MM8YgqRJYU
         2dz7jEDxYxqpq7rsN9RTaxiqvyRmuz+s6osqdhcaFNYoQvXdKf+Fu/brrJPwiTazRPao
         kcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LrCnwLl0E1o+MckPPGQPMuDEYzgSaiQwKVnELse4FGA=;
        b=GYhxWgeWzxZUW30EYeHVX2+W2yi4Co8SOLBDhcaAS7I4Lyexci5f0XxnQDVJirmJoP
         83YDWZ50B/xjYE7wXKpCAHkg9KMBjPpnJFePaCEonuBU/psLCY5F+RrOOO6foTYM2TWd
         51inWGV4gDK/NTtW91pE/j6HI4eJO8Mkh4biaX5lJncNPFfHY7Esij0AnmKHZZ8wslxX
         umGVWfts6Kxe8dnZqOj7+csqP2ZClbSqtEKwesEEEtGxXvcNvUIziBTLcM4C63UKsEif
         Sra28IUwm7v+Hp54s3JI3GVawtLPlV85lZ58Lw8ruJNxPMQ7XGJIdY+4+iE1iXaL3Lwh
         JN7g==
X-Gm-Message-State: APt69E3KYsFIRueY76NGDYFt7rwrvf+VwVM8GvLSWvDbiFjuZQo1iSrH
        Co4dNqEEBJrOPf+AfYmqcfE=
X-Google-Smtp-Source: AAOMgpdO6/uAAUdcHtmChgCWHzHiD2WToAO7Xy26yjfWwP+xMM3X55e1migat4HlNHQY3qQ9RLfrhA==
X-Received: by 2002:a1c:8a04:: with SMTP id m4-v6mr15020076wmd.137.1531247937041;
        Tue, 10 Jul 2018 11:38:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w135-v6sm53918wme.7.2018.07.10.11.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 11:38:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v3 09/13] sequencer: change the way skip_unnecessary_picks() returns its result
References: <20180702105717.26386-1-alban.gruin@gmail.com>
        <20180710121557.6698-1-alban.gruin@gmail.com>
        <20180710121557.6698-10-alban.gruin@gmail.com>
Date:   Tue, 10 Jul 2018 11:38:55 -0700
In-Reply-To: <20180710121557.6698-10-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 10 Jul 2018 14:15:53 +0200")
Message-ID: <xmqq8t6j6im8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> @@ -4467,7 +4467,7 @@ int skip_unnecessary_picks(void)
>  	}
>  
>  	todo_list_release(&todo_list);
> -	printf("%s\n", oid_to_hex(oid));
> +	*output_oid = oid_to_hex(oid);

The return value from oid_to_hex() is volatile and does not survive
across multiple calls to it.  If this interface is meant to be long
lived (as opposed to an intermediate step during the conversion that
will soon disappear), it probably makes more sense to have the
caller supply an output buffer and call oid_to_hex_r() into it, or
something like that.

> diff --git a/sequencer.h b/sequencer.h
> index 11a533461..25b50efe2 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -88,7 +88,7 @@ int sequencer_add_exec_commands(const char *command);
>  int transform_todos(unsigned flags);
>  enum missing_commit_check_level get_missing_commit_check_level(void);
>  int check_todo_list(void);
> -int skip_unnecessary_picks(void);
> +int skip_unnecessary_picks(const char **output_oid);
>  int rearrange_squash(void);
>  
>  extern const char sign_off_header[];
