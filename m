Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B089EB64D9
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 00:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjFPANS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 20:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjFPANQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 20:13:16 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7094426A6
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 17:13:15 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b520c77de0so1359845ad.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 17:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686874395; x=1689466395;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yVu/gMfML8PqHbKR0omhzVj6OtCh3Ty9YCh9MYz1bE=;
        b=GNfLEuDL3kHmrNSHHDY9HxjfG6xjmMzWSqSwSRkk4YlltcFB9itLpCfttYG8HVmCg8
         vc1JIBQC16W0M3231qk1Q16tN5hlWzspUifGlmNFevT3Zd8+PcGyD/B2TR2VCRYVKS+a
         wwHleJdj717XjxESccuN4ceACW7geehv3GhHls+HOvNSXKGEwzSliVQWMkmup95LZ8w4
         nrfgwOoF6nB13k6W3G2Bfbc55Pjrkb7g+iEp2puuZhR6qfMwSupk/ktGhSuofwOKFrRG
         mzFto7Xh0p9cbENymcoifb476izDXOWf/08gN5/keQVYfTKvRg+ZfRD6c7Xp+KWdVLC2
         JEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686874395; x=1689466395;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/yVu/gMfML8PqHbKR0omhzVj6OtCh3Ty9YCh9MYz1bE=;
        b=OTzgtIgJ9HgK0jhXJ7d9+pMoufGh8x7lpLb+B7YiGiWQNU4jMG63dKEBNFsaTlllwC
         IV7o8GYWU1nnbA7+0qrl4RRmKkNjCoTPPMdpeimNPdAdKIZ+7+RpLtdS3HALZTFmhKxQ
         pOlCc3d1Wy+THkit5nD5pCOwgRMv9ssygnaVHrZIVc8Oe7ko3/zR+QRfOAiQ2l+Ngbi6
         ypm3NYLohyZdP6n8jUDSJwhqj6oiIKu41UTGzEA/wnZ092aDl+87MW38ZIIoK/3zf4+w
         6uazaD4fR4C7ifrbXQ6xJKtXRJLunci1+IEGelWy5/YmPdNOXSk2bWpSunyxsWy/ncMW
         ExFg==
X-Gm-Message-State: AC+VfDw6xpaMKuuGM4SzkRQ2IxteFkFblJUVpZ8gNq4lvEIH0G7WBgDj
        BmOtEG9n2Kvkrb092wJVDsI=
X-Google-Smtp-Source: ACHHUZ5UMP9l2K5yHiC9YlPAYC34bxZulORqFJj7YIRVgiV9DynLYPug1PTWtdhIKXkM6L88FNpV4Q==
X-Received: by 2002:a17:902:6804:b0:1b3:b3c5:1d23 with SMTP id h4-20020a170902680400b001b3b3c51d23mr372412plk.56.1686874394739;
        Thu, 15 Jun 2023 17:13:14 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902b58a00b001b0603829a0sm14491962pls.199.2023.06.15.17.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 17:13:14 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 5/9] repack: refactor finishing pack-objects command
References: <20230614192541.1599256-1-christian.couder@gmail.com>
        <20230614192541.1599256-6-christian.couder@gmail.com>
Date:   Thu, 15 Jun 2023 17:13:14 -0700
In-Reply-To: <20230614192541.1599256-6-christian.couder@gmail.com> (Christian
        Couder's message of "Wed, 14 Jun 2023 21:25:37 +0200")
Message-ID: <xmqqilbotgbp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> +static int finish_pack_objects_cmd(struct child_process *cmd,
> +				   struct string_list *names,
> +				   const char *destination)
> +{
> +	int local = 1;
> +	FILE *out;
> +	struct strbuf line = STRBUF_INIT;
> +
> +	if (destination) {
> +		const char *scratch;
> +		local = skip_prefix(destination, packdir, &scratch);
> +	}
> +
> +	out = xfdopen(cmd->out, "r");
> +	while (strbuf_getline_lf(&line, out) != EOF) {
> +		struct string_list_item *item;
> +
> +		if (line.len != the_hash_algo->hexsz)
> +			die(_("repack: Expecting full hex object ID lines only "
> +			      "from pack-objects."));
> +		/*
> +		 * Avoid putting packs written outside of the repository in the
> +		 * list of names.
> +		 */
> +		if (local) {
> +			item = string_list_append(names, line.buf);
> +			item->util = populate_pack_exts(line.buf);
> +		}
> +	}
> +	fclose(out);
> +
> +	strbuf_release(&line);
> +
> +	return finish_command(cmd);
> +}

Computing "is it local?" based on the value of "destination" feels
it belongs to the caller (one of the callers that do need the
computation), not to this function, especially given that the full
value of "destination" is not even used in any other way in this
function.  And the "is_local?" bit can instead be passesd into this
helper function as a parameter.

I wondered what "beautify" was about---the original looks OK to me
already, and while I do not mind to see a full sentence spelled in a
more gramatically correct way like in the postimage, I do not think
the change was worth wasting reviewer's time wondering if there are
other improvements by pointing it out in the proposed log message.

Thanks.
