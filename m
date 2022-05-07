Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC64C433EF
	for <git@archiver.kernel.org>; Sat,  7 May 2022 18:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386966AbiEGTAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 May 2022 15:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238531AbiEGTAO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 May 2022 15:00:14 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D8A6160
        for <git@vger.kernel.org>; Sat,  7 May 2022 11:56:27 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id j12so6163733oie.1
        for <git@vger.kernel.org>; Sat, 07 May 2022 11:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+u137V4yQ83bKjufPeZ0Lj20FZtCV8RwanXL5H1Nki0=;
        b=cZPjeM3qNn1/c+ICN63qkx5xwIcenxdYgPsEK2hJkHydRymwrpOFrp6K7+THbpAR0+
         iS0Uq9BDX9J1B9HFZz6fxVBsKKZfckWhPcID14p6D/k9BNN3qQ252of9PzU2NWzo8R9c
         GdQrCtB0kYROie8vBHJyeEYf32mKHWtra3Xc0WYf6LC+Q3RsCwctB89pYAy1dFnp6t3T
         cv17BYCH+z5X/3Z0lUrMK8J0je9KDJ6krzFAOSr8ACXtfZzNHVc/oxcWM3GQP8sr3gIX
         cjLJBKr2osFm9znlLzKvHs5avvu3CdX6mOWDsNO/p7JiIq4Sn6+LzXG+NYj9ecWDud73
         J4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+u137V4yQ83bKjufPeZ0Lj20FZtCV8RwanXL5H1Nki0=;
        b=TJJ1wC4sehPO57mA6tSic5PHnqYmNQEFOYnnXL1GjeoDOqnAFaTGYY5g/y828qcOTZ
         L96V42U3Go9KBiQIhTHxfttHm60A594khTJpGMjQxzV82sJtb5wRf/3JtYyZRZrqiN/z
         p0IBXKf73N1oCNlKgqtLdqRjNHK9Hr3dLes65vXxfRYcdV7x55Um9/0mFObPcs5LoUTo
         rhDxidMa4pq+oUWOwrO/dDbEFRv6Qd+NjGLdPh1i/feXOk6/rdDPkYnS9CoP/ErJ6vgj
         kj5XLlVlLqF77L/Jh3cu4/L1szS6US/2YLO1KJwaIZgTN4PqYrA6OCob9N0s4yIPaSiX
         bhiQ==
X-Gm-Message-State: AOAM532vXtdhx/ziMtafgnBYg7C6gokrpxXthUpOsWtxQ+O08mDqRRpn
        Z5QD3UWdbWGwSG4vMZhQI1c=
X-Google-Smtp-Source: ABdhPJzqvpYvKwoEFTJtt7D2YtURo99za7KgOdjIpsPhqWtO3NJ0laKHoLj6sHQ2N4LMHGlfKQpRlA==
X-Received: by 2002:a05:6808:d46:b0:326:3fe:68bf with SMTP id w6-20020a0568080d4600b0032603fe68bfmr7347765oik.201.1651949786301;
        Sat, 07 May 2022 11:56:26 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id 35-20020a9d0f26000000b006060322123esm2920100ott.14.2022.05.07.11.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 11:56:25 -0700 (PDT)
Date:   Sat, 7 May 2022 11:56:24 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        Guy Maurel <guy.j@maurel.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Subject: Re: [RFC PATCH v4 2/3] git-compat-util: avoid failing dir ownership
 checks if running privileged
Message-ID: <20220507185624.k5n6xihvzcuuj3vt@carlos-mbp.lan>
References: <20220503065442.95699-1-carenas@gmail.com>
 <20220507163508.78459-1-carenas@gmail.com>
 <20220507163508.78459-3-carenas@gmail.com>
 <xmqqv8uhgsaz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqv8uhgsaz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 07, 2022 at 10:34:44AM -0700, Junio C Hamano wrote:
> Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:
> 
> > +		/*
> > +		 * env_id could underflow/overflow in the previous call
> > +		 * and if it will still fit in a long it will not report
> > +		 * it as error with ERANGE, instead silently using an
> > +		 * equivalent positive number that might be bogus.
> > +		 * if uid_t is narrower than long, it might not fit,
> > +		 * hence why we  need to check it against the maximum
> > +		 * possible uid_t value before accepting it.
> > +		 */
> > +		if (!*endptr && !errno && env_id <= (uid_t)-1)
> > +			*id = env_id;
> 
> Thanks for very clearly spelling out why you care.  It makes it much
> easier to explain why I disagree with the line of reasoning ;-)

Funny enough the comment doesn't even scratch the surface on the genius
of that (uid_t)-1 and how it also prevents people with a signed uid_t
to misuse this code as well, while still allowing uid_t > INT_MAX.

As mentioned in the cover letter, the code without this is indeed broken
and unsafe to use in that case, so we will need to do something else (as
spelled there as well), I we were to proceed with it, which as I said
before I am totally OK with (granted we do that something else, and
promess not to misuse this somewhere later and open us to a potentially
embarrasing bug.

> This code may be exercised by a potential attacker, but we know that
> the codepath is entered only when euid==ROOT_UID.  The attacker may
> or may not have used 'sudo', and we cannot trust the value of
> SUDO_UID at all.  But that is OK.  If the attacker already is root
> on the box, they do not have to use "git" or exercise this new code
> in order to attack anybody on the box already.  This requires us to
> exclude social engineering attack to tell a victim to run "sudo",
> set SUDO_UID to a specific value, and run something, but at last I
> have been excluding that from the beginning.  There are easier
> things you can tell the potential victim to cause harm while being
> root.

Agree, but even if I put a scary looking warning and tried to make this
code harder to use than it needs to be, is fairly visible and there had
been already suggestions of removing that restriction.

Which is why I said this is more a defensive programming solution than
real protection under the current constrains.

> Now the whole point of adding this new code to _weaken_ the existing
> check is to help legitimate users who are authorised to become root
> via "sudo" on the box.  Making it easier for them to use "git" while
> tentatively gaining root priviledge so that they can do "make
> install" in a repository they own.
> 
> We know that this code is meant to be exercised after a potential
> victim gained euid==ROOT_UID via 'sudo', and SUDO_UID is exported by
> the command for the original user.  If uid_t is narrower than ulong
> (e.g. 16-bit uid_t vs 64-bit ulong), and if it is unsigned, the only
> effect the extra check is doing is to exclude the unfortunate user
> with uid==65535 from using "sudo git describe".

not quite, the check does "<=" so excludes no legitimate users, what
is excludes is bit multiplers of those valid users ids to work, so
if an obviously impossible to get legitimately and therefore bogus if
uid_t is 16bit value of 65536 even gets here we will not assume it was
root instead, which I would find personally embarrasing.

> In exchange, the only attack scenario the code prevents is this,
> IIUC.
> 
>  * You, the aspiring cracker, are a user not allowed to run "sudo" on
>    the box, and you know your uid is 1000
> 
>  * You look for another user, a potential victim, whose uid is 1000
>    modulo 65536 (if your uid_t is 16-bit) and who can run "sudo" on
>    the box.
> 
>  * You prepare a malicious repository, invite that user there and
>    ask them to run "sudo something" there.
> 
> I'd say such an attack vector is not likely, and a user with maximum
> allowed uid_t value is equally not that likely, so I do not care too
> deeply either way---and in such a case, I do prefer a simpler code.

as I do as well, but this is only 4 characters long and getting rid of
it means we now have to do either of :

  * hope nobody has a signed uid_t as this code is broken in that case
    and will misbehave widly, more importantly we also lost our only
    way to find them and warn them ahead of time that they need to patch
    it.
  * add some aditional way to detect it and avoid this code and maybe
    even provide an alternative.

and also :

  * move back to strtol and potentially break the feature for half the
    valid users if uid_t is 32-bit unsigned as it is most likely to be
    in 32-bit systems.
  * move to an even wider integer so it will be always wider than uid_t
    which means we have to move a lot more code around at least.

Carlo
