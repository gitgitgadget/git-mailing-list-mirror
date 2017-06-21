Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 465EF20401
	for <e@80x24.org>; Wed, 21 Jun 2017 18:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbdFUSPE (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 14:15:04 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33962 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbdFUSPD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 14:15:03 -0400
Received: by mail-pg0-f68.google.com with SMTP id j186so29390101pge.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 11:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/IgAjmwIpb+3W/FvIdwcsbDWy6pT2nd/rGWXFcc+ljY=;
        b=Se++tcd532hklhDjTQQ71pt8fT75/npjU7vVxTwupFqI7ZE8+umYGJ3d7ou1RQMynk
         Ix1Uuc10anXlL4t6oK/+VfOPC34f5x5zrjaVoAmM7C4viE0QTyxYxAUMtONyIp/kW8uk
         DfvZidGOnKTMqhuCZ2ciVwp6gkc9r1YJmCVI+8X+yBDE+vuHLXEKe5lE03JG1l0+c677
         FNgstyH+sTIL4irR8NAuyHm5aOhCOVPcyWpajWjNVRhBvPTn7ks8dS6SJzY35rUW1xpB
         0+KgsfrDKFjX2Rs6chKaCTV74DgJokBVsYX6hto8Ln9QETmFaNqGizmA6wb5SJ5+9yh8
         BVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/IgAjmwIpb+3W/FvIdwcsbDWy6pT2nd/rGWXFcc+ljY=;
        b=UMqzQUcQXndX2zrL7t5PURz/sIEm13jbZOyDWmL/2wT5ayRyN4L07BgifU6r517B5k
         EIEGL8uvHjC91bifHtl0tSBrPhC3aFkdjq2raKUYbCTnd20DCnEfYwIxcrgo9afukNcc
         RBLou8rjG2aYREuDdXgAxX7dBCYYHcZvBoV8qnsWX5Tul7JpSWlFomrZ2M5Fcu8/CYY7
         Xb1YVdv+8MqXjDB/ZL4mYUaHqi5VWQa9htVUdSzKU4mkqliRrhM0AntGwnS9dE9lp8Zv
         bLI8MvWOeGkT0wOc2kfOq+yRyMw9F0taF2JXizIMN/hd0Ic074FM3Mc6w3NSL90LytFE
         1guQ==
X-Gm-Message-State: AKS2vOxx/VVBC/k1/AsSOXgro6EdWZCfLznlX5Y05t7BEK9R3GNLf743
        zzxpyzLY3QgTMw==
X-Received: by 10.84.254.11 with SMTP id b11mr43364688plm.209.1498068902699;
        Wed, 21 Jun 2017 11:15:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id g86sm34811175pfk.101.2017.06.21.11.15.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 11:15:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 7/8] sha1_file: do not access pack if unneeded
References: <cover.1497920092.git.jonathantanmy@google.com>
        <cover.1497035376.git.jonathantanmy@google.com>
        <cover.1497920092.git.jonathantanmy@google.com>
        <fb656dfeb96e3c69f612fed924d0d9dec592c772.1497920092.git.jonathantanmy@google.com>
Date:   Wed, 21 Jun 2017 11:15:01 -0700
In-Reply-To: <fb656dfeb96e3c69f612fed924d0d9dec592c772.1497920092.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 19 Jun 2017 18:03:14 -0700")
Message-ID: <xmqq8tklqkbe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Add an option to struct object_info to suppress population of additional
> information about a packed object if unneeded. This allows an
> optimization in which sha1_object_info_extended() does not even need to
> access the pack if no information besides provenance is requested. A
> subsequent patch will make use of this optimization.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>

I think the motivation is sound, but...

> diff --git a/sha1_file.c b/sha1_file.c
> index 24f7a146e..68e3a3400 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -3020,6 +3020,13 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>  		}
>  	}
>  
> +	if (!oi->typep && !oi->sizep && !oi->disk_sizep &&
> +	    !oi->delta_base_sha1 && !oi->typename && !oi->contentp &&
> +	    !oi->populate_u) {
> +		oi->whence = OI_PACKED;
> +		return 0;
> +	}
> +

... this "if" statement feels like a maintenance nightmare.  The
intent of the guard, I think, is "when the call wants absolutely
nothing but whence", but the implementation of the guard will not
stay true to the intent whenever somebody adds a new field to oi.

I wonder if it makes more sense to have a new field "whence_only",
which is set only by such a specialized caller, which this guard
checks (and no other fields).

> diff --git a/streaming.c b/streaming.c
> index 9afa66b8b..deebc18a8 100644
> --- a/streaming.c
> +++ b/streaming.c
> @@ -113,6 +113,7 @@ static enum input_source istream_source(const unsigned char *sha1,
>  
>  	oi->typep = type;
>  	oi->sizep = &size;
> +	oi->populate_u = 1;
>  	status = sha1_object_info_extended(sha1, oi, 0);
>  	if (status < 0)
>  		return stream_error;

By the way, populate_u feels very misnamed.  Even if that union
gains details about other types of representations, your caller that
flips populate_u would not care about them.  This bit is about
learning even more detail about a packed object, so a name with
"packed" somewhere would be more appropriate, I would think.
