Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B22C41F404
	for <e@80x24.org>; Thu,  1 Mar 2018 21:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162002AbeCAVZI (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 16:25:08 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37150 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161994AbeCAVZG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 16:25:06 -0500
Received: by mail-wr0-f196.google.com with SMTP id z12so8064243wrg.4
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 13:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+ZdgRxIe8l836oil3Ey9i/MEGdS0q02uJR4+hZAs30w=;
        b=b8ohHHfi4pm35gkjN2KZZIKYc9R4b6M7HkAbP49RE2ieBzDa/16MP3L0qWxrw8GcVt
         Ex1v6aYG91D/K3hLiw3zHqd197qwIgNFGQ1dd2rnrQJS9+2a++APAjQSkXP9mYvwRsAQ
         +dGL2rLmh8zcSdD5pNE5t7wzN3BdDWnK333suPR4kjxwYdXDaubr+r1lgSUBGodHfN5c
         J8wpEdFEWw4QqOid6TgtW04kwEwkV83EwYyh4KKp0h4tTLhaH+UWAdggmPcwBNJ4BIRi
         FQbh5BiFtCdn2/xD29tsuFaogGTvCu1Z56A13MHtuEpt9kzlpVYlqG3cRCoRYXz/6iaD
         woLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+ZdgRxIe8l836oil3Ey9i/MEGdS0q02uJR4+hZAs30w=;
        b=YAXgV5s+LjLgNwpO+0YEDGwWYS/OF6cOIGHSzn0tElSuCSv/LRUnq0eANk1AV2dkDE
         Duyj9zGAdmpaWlMehXphsFjY6x6nx0VhvT/QW6dWQIl9Vw2HAy+jycFMpLqoVmn9s/Z6
         FhT31SwTtUlLqbl++R9w4RFgOxDHw0SC7pYHsbUSnyrwTeS7bPFVlXe0l/3PEZFwJOxm
         wCIrYrwDEGRxwByZMkVbTqu2m96rbkBzfQQyXeuMGIdfrOhpwOlqrrXido6sAZ8sStg3
         tmVu+34IzyzR5qXrc8km/a1VfoyzWKI1Ex9xBjHfUG0DiiY/JX21LwGIem2ttngh07gn
         crHg==
X-Gm-Message-State: APf1xPCKqwZ/P7NdrsyBt3SZgm5ojgWsvRTAl1g3+y4DKU320tSt0Vfw
        N3oLqaFU/8Uja8J/2st4z4c3KApD
X-Google-Smtp-Source: AG47ELvh6kYX9s8qWcMipSbzfTARwzvj6asHwwUw5NCRmOGp3SMN8n3LXQDaspnPOWDnSdcOMFwWQw==
X-Received: by 10.223.158.10 with SMTP id u10mr3167092wre.165.1519939504988;
        Thu, 01 Mar 2018 13:25:04 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o11sm4692540wrg.91.2018.03.01.13.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 13:25:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 05/35] upload-pack: factor out processing lines
References: <20180207011312.189834-1-bmwill@google.com>
        <20180228232252.102167-1-bmwill@google.com>
        <20180228232252.102167-6-bmwill@google.com>
Date:   Thu, 01 Mar 2018 13:25:04 -0800
In-Reply-To: <20180228232252.102167-6-bmwill@google.com> (Brandon Williams's
        message of "Wed, 28 Feb 2018 15:22:22 -0800")
Message-ID: <xmqq371jfpzj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Factor out the logic for processing shallow, deepen, deepen_since, and
> deepen_not lines into their own functions to simplify the
> 'receive_needs()' function in addition to making it easier to reuse some
> of this logic when implementing protocol_v2.

These little functions that still require their incoming data to
begin with fixed prefixes feels a bit strange way to refactor the
logic for later reuse (when I imagine "reuse", the first use case
that comes to my mind is "this data source our new code reads from
gives the same data as the old 'shallow' packet used to give, but in
a different syntax"---so I'd restructure the code in such a way that
the caller figures out the syntax part and the called helper just
groks the "information contents" unwrapped from the surface syntax;
the syntax may be different in the new codepath but once unwrapped,
the "information contents" to be processed would not be different
hence we can reuse the helper).

IOW, I would have expected the caller to be not like this:

> -		if (skip_prefix(line, "shallow ", &arg)) {
> -			struct object_id oid;
> -			struct object *object;
> -			if (get_oid_hex(arg, &oid))
> -				die("invalid shallow line: %s", line);
> -			object = parse_object(&oid);
> -			if (!object)
> -				continue;
> -			if (object->type != OBJ_COMMIT)
> -				die("invalid shallow object %s", oid_to_hex(&oid));
> -			if (!(object->flags & CLIENT_SHALLOW)) {
> -				object->flags |= CLIENT_SHALLOW;
> -				add_object_array(object, NULL, &shallows);
> -			}
> +		if (process_shallow(line, &shallows))
>  			continue;
> +		if (process_deepen(line, &depth))
>  			continue;
		...

but more like

		if (skip_prefix(line, "shallow ", &arg) {
			process_shallow(arg, &shallows);
			continue;
		}
		if (skip_prefix(line, "deepen ", &arg) {
			process_deepen(arg, &depth);
			continue;
		}
		...

I need to defer the final judgment until I see how they are used,
though.  It's not too big a deal either way---it just felt "not
quite right" to me.


