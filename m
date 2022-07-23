Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4335CC433EF
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 05:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiGWFP7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jul 2022 01:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiGWFP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jul 2022 01:15:58 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922B441D29
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 22:15:57 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id j22so11790755ejs.2
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 22:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=smAE8lkz0qzm4qA3w82fVv/Q9MnVCX75l1wOEpCmwGo=;
        b=Ox1X5DI5jkgc7POS5kkHK2az3Ya1RA3qm/h1OJrdY8yL3V8vaphL5uJ4NvaMG/m0/o
         +a4j2X8XGRn5/NzMYuDxRa23EOXuFLLl/LlADIReD9+FscLaPWwOqbqJBOA6HP/7AXez
         yhJtKdE/Hd/9eMkqDlkaL7TIRhHaujItM0hSV+MA0ttrXTBBgOahZ/B2SXC41X0s0ox/
         6ptzYhZR1koro87yej9sK1AoomuyfCLOW5gAJyC06nlIj7uw16zI7YXgOm44CsfMC6ou
         X1We4x/ETxR66a41hSyokIiYqTqxVdSSBz12dtQ6Emr5Bw107VJSGtt+HuRtjcRs7eAn
         2m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=smAE8lkz0qzm4qA3w82fVv/Q9MnVCX75l1wOEpCmwGo=;
        b=TTCsuDXCI2eNs44Jl/nVM4gcopXg/axHIctPMSsUpN6xm/gZ5ISMKejZl+5NrbDSs+
         QvETpkUzQ7zRM53HLwMgOfpsZ8pWBLGRgeMns6eYG+l7mb+c3RTl4DND9GIRfAhgvYph
         pKx+/zoGpcKEaL0nHv/vLRXenzJfsj0y+YQry8fu8wMOGx5HiWtw1/GEUt0kehvwVs2t
         gijjuksVlOj0ZOC3ItA2GKyUNdG0dwkc+3EL4pwEpgM2D7py5cpz7NWHE5vw3vOoJXNo
         g7wrGYb9+DkwogAHvDO5i3KXqRTJ3t0uI8u310lwF4/oMMC21m3pgSFujk8rG4Wi3mbf
         gAoA==
X-Gm-Message-State: AJIora8jB8eh72uKEPra+m8IFCASzHRtqtX492C4C5uG7D3FTk6Oid+S
        /rEa4v0F7ljtApsYfTdHtyI=
X-Google-Smtp-Source: AGRyM1vdVOx7LepxzR4i4jUydn4oZpMzYuyTQNzIMXIwjC7S5UuSpFC0PimxE0cq3xAN3yaQfTh6GA==
X-Received: by 2002:a17:907:c08:b0:72b:87a4:dee6 with SMTP id ga8-20020a1709070c0800b0072b87a4dee6mr2363401ejc.283.1658553354964;
        Fri, 22 Jul 2022 22:15:54 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id x1-20020aa7d6c1000000b0043b4d43ebaasm3492830edr.58.2022.07.22.22.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 22:15:54 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oF7UX-005Pcn-JR;
        Sat, 23 Jul 2022 07:15:53 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        christian.couder@gmail.com
Subject: Re: [PATCH 1/2] t/t0021: convert the rot13-filter.pl script to C
Date:   Sat, 23 Jul 2022 06:59:49 +0200
References: <cover.1658518769.git.matheus.bernardino@usp.br>
 <99823077be77bc621cfa8ccf3303bd612da343ad.1658518769.git.matheus.bernardino@usp.br>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <99823077be77bc621cfa8ccf3303bd612da343ad.1658518769.git.matheus.bernardino@usp.br>
Message-ID: <220723.86pmhwquie.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 22 2022, Matheus Tavares wrote:

Looking a bit closer...

> however, that we still use the script as a wrapper at
> this commit, in order to minimize the amount of changes it introduces
> and help reviewers. At the next commit we will properly remove the
> script and adjust the affected tests to use test-tool.

I'd prefer if we just squashed this, if you want to avoid some of the
diff verbosity you could leave the PERL prereq on all the
test_expect_success and remove it in a 2/2 (we just wouldn't run the
test until then).

But I think it's all boilerplate, so just doing it in one step would be
better, reasoning about the in-between steps is harder IMO (e.g. "exec"
escaping or whatever)>

> +static char *rot13(char *str)
> +{
> +	char *c;
> +	for (c = str; *c; c++) {
> +		if (*c >= 'a' && *c <= 'z')
> +			*c = 'a' + (*c - 'a' + 13) % 26;
> +		else if (*c >= 'A' && *c <= 'Z')
> +			*c = 'A' + (*c - 'A' + 13) % 26;
> +	}
> +	return str;
> +}

Looks fine, but we should probably put in our CodingGuidelines at some
point that we don't care about EBCDIC, as this isn't portable C (but
probably portable enough, as we can probably assume ASCII) :)

> +static struct string_list *packet_read_capabilities(void)
> +{
> +	struct string_list *caps = xmalloc(sizeof(*caps));

malloc here...

> +	string_list_init_dup(caps);
> +	while (1) {
> +		int size;
> +		char *buf = packet_read_line(0, &size);
> +		if (!buf)
> +			break;
> +		string_list_append_nodup(caps,
> +					 skip_key_dup(buf, size, "capability"));
> +	}
> +	return caps;
> +}
> +
> +/* Read remote capabilities and check them against capabilities we require */
> +static struct string_list *packet_read_and_check_capabilities(
> +		struct string_list *required_caps)
> +{
> +	struct string_list *remote_caps = packet_read_capabilities();

...and here...
> +	struct string_list_item *item;
> +	for_each_string_list_item(item, required_caps) {
> +		if (!unsorted_string_list_has_string(remote_caps, item->string)) {
> +			die("required '%s' capability not available from remote",
> +			    item->string);
> +		}
> +	}
> +	return remote_caps;

...we'll return it...

> +	remote_caps = packet_read_and_check_capabilities(&supported_caps);
> +	packet_check_and_write_capabilities(remote_caps, &requested_caps);
> +	fprintf(logfile, "init handshake complete\n");
> +
> +	string_list_clear(&supported_caps, 0);
> +	string_list_clear(remote_caps, 0);

..and here you're missing a free(), but I wonder why not just declare
this string_list in this function, and pass it down instead?

It's unfortunate that none of these tests seem to pass with
SANITIZE=leak already, but the new command seems not to leak from a
trivial glance except for in that one case.

Not knowing much about the filtering mechanism, I wonder if this code
here wouldn't be better as a built-in some day. I.e. isn't this all
shimmy we need to talk to some arbitrary conversion filter, except for
the rot13 part?

So if we just invoked a "tr" with run_command() to do the actual rot13
filtering we could do any sort of arbitrary replacement, and present a
variant of this this command as a "if you can't be bothered with
packet-line" in gitattributes(5)...

...but maybe that's hopeless for some reason I'm missing, in any case,
more #leftoverbits.

