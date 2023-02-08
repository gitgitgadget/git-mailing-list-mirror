Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD43C636D6
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 18:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjBHSUh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 13:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjBHSUg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 13:20:36 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7BF113C7
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 10:20:35 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id s89-20020a17090a2f6200b0023125ebb4b1so844409pjd.3
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 10:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0Aa9k1Ju6o7pXi3t+ZDx9f1D2wXHx/QmoMpe+sxttc=;
        b=Uk1MeRCDTSl1Cwv+JP7DbmK4jneBHCIysXSYaxCRr3UmEysw2mclrDhXtSB56LDuJ7
         eVeR5oSPgZTk2kIQY4AY1HRlCAjdHeXrkKCjf2jiqaAz0C4PLJA0UGA1bO3GfCMx1CH8
         xxIX0G3vsKnzaCeLVoS9e0bvkZbUm6t0xUE8J/a9h1nU8XUrjORFXA8xtXjE/pGYqIEC
         XfLw6zGx3gEDQOd6njcXFR0A1GilHlgQK8xw5DzHta3y5nfCgugLDwpkYKhqzGo363yy
         xtnWXKtigMtaNCttlBTRhpOiXAf0wyTv7PhDU7sMKp260PUMEPHl015M4xLfYqbJ7HH1
         aP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B0Aa9k1Ju6o7pXi3t+ZDx9f1D2wXHx/QmoMpe+sxttc=;
        b=ZanGDKnFZQzpS77yUewbmXa+SUNcJtZO/qMQLig0kOsrqg6F5CWt+iGpSI2bvnrPkb
         X4K+AyHW6k0LKOZ9BJmZhM1MVoL0SB37k9Y490fTrsV7wSSHMCxFgIOeWdNlcG2Au2q4
         V5GzEGqcJVVzUBpETxKMTFFiNF384BSypjmUsvuLYbmK2WyOHJCKbSWF5iYyaqweLIJN
         asHpv5XzJTE6TqJnZhqUwqpyTbK7D6uepg0Jlz7Syw8l82kKNfZFueKf68XeLYnRpI0y
         TO6vHQhXB59VaojgXrxgRF9EkaWNhV4M66SPWPdYutKZlXrZua3baZld+R5O7fMh3Dkp
         WjcQ==
X-Gm-Message-State: AO0yUKXxK8vjKGrJpSRsl5DCkpTBjJ81gZQFe83VSfdR19yCKyIi+XkQ
        iwUK7MEcm+TfowHXrA1lnUxbhYE1z1s=
X-Google-Smtp-Source: AK7set8uK1VUK1y+X2vwN2fITPYBdJ/WihyUf4fGnYnFqojGrUPMDnsCG48Hc/etK6a2ibUCXtFwPg==
X-Received: by 2002:a17:903:1d2:b0:196:2ade:6e21 with SMTP id e18-20020a17090301d200b001962ade6e21mr9813648plh.14.1675880434682;
        Wed, 08 Feb 2023 10:20:34 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id k10-20020a63ab4a000000b004df4fbb9823sm9856721pgp.68.2023.02.08.10.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:20:34 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Max Gautier <max.gautier@redhat.com>, git@vger.kernel.org
Subject: Re: git rev-list fails to verify ssh-signed commits (but git log
 works)
References: <Y+PGRaiTTaZ/DtlJ@work-laptop-max>
        <Y+PRTYtFDoE73XEM@coredump.intra.peff.net>
        <xmqqmt5orqgv.fsf@gitster.g>
Date:   Wed, 08 Feb 2023 10:20:33 -0800
In-Reply-To: <xmqqmt5orqgv.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        08 Feb 2023 09:56:16 -0800")
Message-ID: <xmqqh6vwrpce.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> +	/*
>> +	 * yikes, this needs to come early in the function because it
>> +	 * also handles user.signingkey, which would otherwise get
>> +	 * shunted to git_ident_config() below
>> +	 */
>> +	if (git_gpg_config(var, value, cb) < 0)
>> +		return -1;
>> ...
>>  	if (starts_with(var, "user.") ||
>> ...
>>   3. It's possible some refactoring may let us avoid the "yikes" comment
>>      above (e.g., should user.signingkey just go into the normal ident
>>      config handler?).
>
> Hindsight is golden---if this were called gpg.signingkey we wouldn't
> be having this discussion X-<.

I wonder if gpg-interface functions can and should be taught to
initialize themselves lazily without relying on the usual
git_config(git_gpg_config) sequence.  I.e. the first call to
sign_buffer(), check_signature(), get_signing_key_id(), etc.
would internally make a git_config(git_gpg_config) call, with the
current callers of git_config(git_gpg_config) removed.



