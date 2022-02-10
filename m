Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFBAC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 22:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344853AbiBJWMX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:12:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241989AbiBJWMX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 17:12:23 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ABAF7C
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 14:12:23 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id 9so9881187pfx.12
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 14:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=621+nWvJb+ZwB/1DysjUJ7LkWet/lRDtB5dCLX5T0bQ=;
        b=Fm3mTivSeCk6dGQAY57h/FRQ309a8QUXI+hDCGV5amSIfhtkbv5UwybCcN1YtJZrR7
         K9CWiwTXluw/7zbhm4W63h4d5wbXJlJGnPhtRdXLG4RacAvUoS9mZWF4e2uBAwVRXkT4
         9JrD85FNYUrDRTuwZxIHWWV0gt8z7/0jcIzadXhmZ2aLvP7fuWhN1nm3t5HKsmh4hrOL
         6ccOH05nteB7pic2//MEoAi/rIz11ir5UVQD6Savx7gMca29xJK1UvNMHi1mexjvu2ok
         ZQ5NHeMLIOYYgo9kj5ZFvOr26qVMGq+2xzkvFTtQF9z2E880bvYjd52pugm/tMOA1vAc
         JTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=621+nWvJb+ZwB/1DysjUJ7LkWet/lRDtB5dCLX5T0bQ=;
        b=OghWIp1R5GQagM8YBRjY7PlmY7CfidYlzqOzBtJjBldBKXD506HLr67lOi/PUj421D
         LgrFhOIyku2mGqw7paabUvDJdB6iFrCGPA8t3sEi76ct7lcodXMGrnidtv0jXbmtc4J5
         iKpZpKlW1Nj8Nqlnhkt6F/mua2aMPfWfGDr/MNBProWaV+w66ukgzTR3I4MKF9wqGKNe
         HRe3wOZx1DB94/M08gPVKfrAtlvatqFwFW36WJfSctAj5UGyVOTxOEaWcLIK6ua0rifX
         MZ34KoRFA3s3K18rpRKW860O601ZXher6uNWHN/hrz0M1tFEYf08Ir5IS+2ZauX04GeN
         XaeQ==
X-Gm-Message-State: AOAM532vyXlcrpPKCpZMToEZmg+uPzEPGT0rmCoj0dix/uD4LB/pQDWV
        Q5i1rgguM0V6x1IJv7L3111Rgw==
X-Google-Smtp-Source: ABdhPJyJYEIivCms/jmMkCNjuGx+hFD/d9+qvpDE+7Pb4O2lkPs+W1MVqn1aBTEC9j3MX9cAmYGbrA==
X-Received: by 2002:a65:688e:: with SMTP id e14mr1164520pgt.219.1644531142988;
        Thu, 10 Feb 2022 14:12:22 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:2ffe:b88a:5bb7:a099])
        by smtp.gmail.com with ESMTPSA id p20sm174623pgd.21.2022.02.10.14.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:12:21 -0800 (PST)
Date:   Thu, 10 Feb 2022 14:12:16 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 0/5] teach submodules to know they're submodules
Message-ID: <YgWNwIE4ZLSWAr6n@google.com>
References: <20211117005701.371808-1-emilyshaffer@google.com>
 <20220203215914.683922-1-emilyshaffer@google.com>
 <220204.86pmo34d2m.gmgdl@evledraar.gmail.com>
 <YgF5V2Y0Btr8B4cd@google.com>
 <xmqqk0e6gt5j.fsf@gitster.g>
 <YgHE4iaV8QHRw64U@google.com>
 <xmqqy22lcj2m.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy22lcj2m.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 08, 2022 at 10:24:49AM -0800, Junio C Hamano wrote:
> 
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > My point with this example is that it's useful to have a definition of
> > what is a submodule repository, to make it unambiguous whether this
> > repository is a submodule or whether it's just a repository that
> > happens to have been cloned inside of a git-managed worktree.
> 
> OK, together with the other "no need to let NFS automounter worry
> about parent directories", it makes a very successful argument for a
> single bit (i.e. this is a free-standing repository and is not a
> submodule, so no need to auto-discover if it is one).  I think the
> "Alternatively" you later mention to solve ambiguity with just a
> single bit, without "this is a submodule of that superproject"
> linkage, is essentially the same?

That resolution - "teach submodules to know they're submodules, but not
whose submodule they are" - would still count as a success to me. The
reason I proposed a path instead of a boolean here was simply because
storing a path is a boolean (by whether it's present or not) *and*
additional information (the path to the superproject), and it seemed
silly to me to opt for less information. Or, to put it another way - "am
I a submodule?" seems pretty vital, and "yes, and I belong to xyz" is an
optimization on top of that. So I don't terribly mind sending this as
just a boolean, if we feel that the effort to keep it up outweighs the
benefit of saving us a filesystem walk.

I'm not completely convinced that it does, though - would the addition
of a 'git fsck' check for this config be satisfactory? In other words,
is the problem that the execution of this series wasn't thorough enough
and it should be refined, or that the concept itself is beyond saving?

 - Emily

> 
> But I do not think it argues for the need to say "a config, not
> filesystem layout, must be the single source of truth to say which
> superproject this repository belongs as its submodule".
> 
> > This would be the first time in git history that we are saying a
> > property of a repository depends on having to examine files outside of
> > it.
> 
> Well, path-based configuration inclusion, with configuration driven
> hooks, I do not think the distinction matters much anymore in these
> days.
> 
> > I guess the main question I'd have is, why _wouldn't_ I want a
> > submodule to be able to point to the superproject containing it?
> 
> Because with (the absense of) a single "this is freestanding" bit, 
> by default the filesystem layout can already "point" at it?
