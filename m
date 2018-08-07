Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F296208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 20:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbeHGXNt (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 19:13:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39358 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeHGXNs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 19:13:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so29935wre.6
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 13:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rcHtCHHYPo/HVs/FNS3rJaTA9fEB/IorQOLEM9q2T6U=;
        b=WYxgrI2PLYe6l50rK4phbrWT7n6hD/r81KBpHQC/Z7kIzmwTFDLNMbU59gQaGBclX0
         nt/QpsFH98KRRa47QRowEHoV8jJkiF19oflR3hYf1QBclzykVLrxQSPaERvLCfzeE2Ro
         zvJwe/NEgeQHIJTrr5b1l5YWu1n0beQZz7SeAAs+nRfr5b3Yl038wAesTkF2IaF99w5A
         PBM4xjszqQeSVkxdpL+rnAGqoOWYT017u93hWBpyPG6Bh7SCfiGYnYC2KyQefo/Mq+93
         rFyFSddLkcGAP/yKbM2CKz3f9m5YRGx7ssrBdt/Jqj7jhTW/EDGHAVlOOjorQcOOd+yu
         sgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rcHtCHHYPo/HVs/FNS3rJaTA9fEB/IorQOLEM9q2T6U=;
        b=sBDspo7nZdbh1+PcYn6pCvK8wk73raqfvif2Rs0DzQz+3cUcNyLZfVBG/YQOtosuCM
         kaGT278reCOTQ2TbXJaYc8eM+mL725uaTV37XDl5ENaY0XEhqQgp9pEM4IBTqoHxx2uw
         tIcZildUoWz5qSXCg0D+96JuHz4ed3Mytin99csCMV8z8G3Y0Bu3ngrIva69wxCJDa/g
         Z95A3qswDoYkwXgluFRItBPn34uzjO4D1qAdf7kGjDfPe1ME88sP7RC6nsTaG9xjjOXI
         1uWF64jdqF4JEgBZD+IYLVZDRsLK8V/WQi+q6//JWqbjrt9v+RmJLmrh7oSkygAbLWhT
         5MIQ==
X-Gm-Message-State: AOUpUlFFT4yTQtmCoBjvWgFF5MurLQ13G6odxRFhd6JzRfl1IJLp+q1K
        FMGfZWevXb2jwtAVuONUsl0=
X-Google-Smtp-Source: AA+uWPyHSg8ab20v6cH5FvQE86OBr4wXaNO5qEV1gIXZaLcE6SDzP40anyWISrPkjMNJNA9UqhKkrw==
X-Received: by 2002:a5d:694e:: with SMTP id r14-v6mr20606wrw.278.1533675452247;
        Tue, 07 Aug 2018 13:57:32 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e141-v6sm4491112wmd.32.2018.08.07.13.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 13:57:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] repack: repack promisor objects if -a or -A is set
References: <cover.1533672584.git.jonathantanmy@google.com>
        <61396b2a73a801f62818ad3b691f75170d2e3919.1533672584.git.jonathantanmy@google.com>
Date:   Tue, 07 Aug 2018 13:57:31 -0700
In-Reply-To: <61396b2a73a801f62818ad3b691f75170d2e3919.1533672584.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 7 Aug 2018 13:12:32 -0700")
Message-ID: <xmqqzhxxki84.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +static int write_oid(const struct object_id *oid, struct packed_git *pack,
> +		     uint32_t pos, void *data)
> +{
> +	int fd = *(int *)data;
> +
> +	xwrite(fd, oid_to_hex(oid), GIT_SHA1_HEXSZ);
> +	xwrite(fd, "\n", 1);
> +	return 0;
> +}
> +
> +static void repack_promisor_objects(const struct packed_objects_args *args,
> +				    struct string_list *names)
> +{
> +	struct child_process cmd = CHILD_PROCESS_INIT;
> +	FILE *out;
> +	struct strbuf line = STRBUF_INIT;
> +
> +	prepare_packed_objects(&cmd, args);
> +	cmd.in = -1;
> +
> +	if (start_command(&cmd))
> +		die("Could not start pack-objects to repack promisor objects");
> +
> +	for_each_packed_object(write_oid, &cmd.in,
> +			       FOR_EACH_OBJECT_PROMISOR_ONLY);
> +	close(cmd.in);

for_each_object_in_pack() is a fine way to make sure that you list
everythning in a pack, but I suspect it is a horrible way to feed a
list of objects to pack-objects, as it goes by the .idx order, which
is by definition a way to enumerate objects in a randomly useless
order.

Do we already have an access to the in-core reverse index for the
pack at this point in the code?  If so, we can enumerate the objects
in the offset order without incurring a lot of cost (building the
in-core revindex is the more expensive part).  When writing a pack,
we try to make sure that related objects are written out close to
each other [*1*], so listing them in the offset order (with made-up
pathname information to _force_ that objects that live close
together in the original pack are grouped together by getting
similar names) might give us a better than horrible deltification.
I dunno.

	Side note *1*: "related" has two axis, and one is relevant
	for better deltification, while the other is not useful.
	The one I have in mind here is that we write set of blobs
	that belong to the same "delta family" together.

I do not think such a "make it a bit better than horrible" is necessary
in an initial version, but it deserves an in-code NEEDSWORK comment
to remind us that we need to measure and experiment.

Thanks.
