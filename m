Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CAE41F597
	for <e@80x24.org>; Mon, 16 Jul 2018 20:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbeGPVXA (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 17:23:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55822 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbeGPVXA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 17:23:00 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so4254893wmc.5
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 13:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=At5AR4Ms6XdNpAOh0DH6dPEbySYtwLrcQpBNId9+ZoE=;
        b=g5kgCHQAvthEGq15U7k02nNa/NLv2qkwCVAPlY6gdUwXLFe7q1U0x1CbjPrUaDTG9o
         9KS2M/47hmkng3TWfrYLL8N2TbFzzNW41VHq3sofypeQMf/hF89jbgsnSrnTXu0B/T9f
         zJ+VM0gEGY4nzZ2Y7/JGtIIMIgQJfRb1ndnnuso7X6LCAPjklnvjkUM/5hK7ppSv2TN4
         POaPW9pcGiXUVaKVimvhGvd7gfB+UFOcTn8gBboZHgLd4GG5pOqZr9CPNLRAKQTz5a7P
         Z5cM98WP5uOjufvkv1Ww5VmGc1HFphk3eFgkau9STUYh1/vm+s5q0FuDkJZYKwpwLyPr
         FSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=At5AR4Ms6XdNpAOh0DH6dPEbySYtwLrcQpBNId9+ZoE=;
        b=gCfzERBdz77whhUaBV44qKq8yDB65KjEDjSKw+j+khlWe07tYqp20NvvHjYmxGGEkk
         /Fz24MMJu7+4jCatr6Sp7ujn93I503n54z8wiKkMENSXkFHSSpkfJ1u2ca78qRG+yFmW
         r8Dsspwt3yeHMqnF7JJppHemmON5OdogFpAXJHSmC3QHVj71qBY514TyiuFNKUFgbsYM
         1EFOhBHua4u91wuzxt4QyXeqs+kYGBvU4Jf5edeJsZRhLGGMEDnzW831lLzR7t/7gRP3
         Mn93FydOd2kLVZGHHXJ8z7LW9OhSZIyAvz+3obzZoeGZIZIHCrmHuZXkF1x86pgHB4PA
         DYMg==
X-Gm-Message-State: AOUpUlE3z5TojIepOtBPqp1tyzfUjnFRw1j99a3NCRAsmwU6bJ5YIaWB
        8hDi91zL988LD9OkeE7H344=
X-Google-Smtp-Source: AAOMgpcndQVAwdM4hhHne8ObMaEsfrZvZ7+GlTsbK+s8i/rY9hN/ADLYHBI6XYm/knXHsLEk5voBsA==
X-Received: by 2002:a1c:e3d5:: with SMTP id a204-v6mr10389691wmh.20.1531774430450;
        Mon, 16 Jul 2018 13:53:50 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x184-v6sm8257843wmg.24.2018.07.16.13.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 13:53:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ref-filter: use oid_object_info() to get object
References: <0102016493ab5347-c0429041-6e66-4550-894c-2d500cb2ed8e-000000@eu-west-1.amazonses.com>
        <0102016493ab542d-ea2a3e8c-d6a0-44ca-8fc6-f940fe7e84cd-000000@eu-west-1.amazonses.com>
Date:   Mon, 16 Jul 2018 13:53:49 -0700
In-Reply-To: <0102016493ab542d-ea2a3e8c-d6a0-44ca-8fc6-f940fe7e84cd-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Fri, 13 Jul 2018 12:43:56 +0000")
Message-ID: <xmqqr2k2sy02.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> -static int get_object(struct ref_array_item *ref, const struct object_id *oid,
> -		      int deref, struct object **obj, struct strbuf *err)
> +static int get_object(struct ref_array_item *ref, int deref, struct object **obj,
> +		      struct expand_data *oi, struct strbuf *err)
>  {
> -	int eaten;
> -	int ret = 0;
> -	unsigned long size;
> -	enum object_type type;
> -	void *buf = read_object_file(oid, &type, &size);
> -	if (!buf)
> -		ret = strbuf_addf_ret(err, -1, _("missing object %s for %s"),
> -				      oid_to_hex(oid), ref->refname);
> -	else {
> -		*obj = parse_object_buffer(oid, type, size, buf, &eaten);
> -		if (!*obj)
> -			ret = strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
> -					      oid_to_hex(oid), ref->refname);
> -		else
> -			grab_values(ref->value, deref, *obj, buf, size);
> +	/* parse_object_buffer() will set eaten to 0 if free() will be needed */
> +	int eaten = 1;

Hmph, doesn't this belong to the previous step?  In other words,
isn't the result of applying 1-3/4 has a bug that can leave eaten
uninitialized (and base decision to free(buf) later on it), and
isn't this change a fix for it?

> +	if (oi->info.contentp) {
> +		/* We need to know that to use parse_object_buffer properly */
> +		oi->info.sizep = &oi->size;
> +		oi->info.typep = &oi->type;
>  	}
> +	if (oid_object_info_extended(the_repository, &oi->oid, &oi->info,
> +				     OBJECT_INFO_LOOKUP_REPLACE))
> +		return strbuf_addf_ret(err, -1, _("missing object %s for %s"),
> +				       oid_to_hex(&oi->oid), ref->refname);
> +
> +	if (oi->info.contentp) {
> +		*obj = parse_object_buffer(&oi->oid, oi->type, oi->size, oi->content, &eaten);
> +		if (!obj) {
> +			if (!eaten)
> +				free(oi->content);
> +			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
> +					       oid_to_hex(&oi->oid), ref->refname);
> +		}
> +		grab_values(ref->value, deref, *obj, oi->content, oi->size);
> +	}
> +
> +	grab_common_values(ref->value, deref, oi);
>  	if (!eaten)
> -		free(buf);
> -	return ret;
> +		free(oi->content);
> +	return 0;
>  }

