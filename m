Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EA0C35249
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 03:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF192085B
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 03:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bhL2LNr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgBEDPa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 22:15:30 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54775 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgBEDPa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 22:15:30 -0500
Received: by mail-pj1-f68.google.com with SMTP id dw13so324232pjb.4
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 19:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J0utM2LAPvetm9rlsyQBAB1AGWrTr+9SsS2WTbPADXo=;
        b=bhL2LNr98LDhqVOCMwTT2yma3p53Bil9SpyXdVI7fUC48fXLcrhnmZdMJSfSUGDOzW
         lyDfRLFvE9UTpRLEXT9zeWSH6tT1iR+pqWdwC60xL5Rtlj1184HUb+FIaWbVCwMG9Ltu
         NIABq2UKqUhQh54XVK3iX5E7RpjwuxxYz/J41WRDIWOMAxPF61ECVpmsJRZTRZuCtJdh
         o6t7RcFhhQ2YDAi2grauJHy72XJGGKm9J8hiV4XHV1BRQIgheePBMZ5pt+1LHJ1faBcM
         IjtUdilWJohSkE3YT2jUixkqDKwPkJjNVmqaxXzHPlnmzE2cGjFs9kk/4ooCLtCCWuyg
         /nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J0utM2LAPvetm9rlsyQBAB1AGWrTr+9SsS2WTbPADXo=;
        b=scufE1HAtwmJyQ76jewP5MUmh1In5uX/26Gc9l23zGSB2iDJVW54jK5berCdK0YXIt
         aYLJtR9ATba/gDT182bcg+zbAGlXFoOZJBgiZb4SNHMXbOFBJUfPszGE4jmAH3ol14Ox
         uBIgEj4MPLgO6WZgVMmP9Xi1ydBhHiivq5FitgReAfFvYmexD6MDCb2Fa3n6okA6fKCY
         erUpExNa8DVn/MMLlcn+BaSkrgyIEFt4eV+xmb3XmR5NgDtPF5asYbNJsikLV9Bv9WTn
         v/NWcTwdJV1kZfTdPfCAY3IvSXOdD+g3msA/iKnl5X/Xi8F4ttAEsl9+LwGs/AnUsBy/
         BdVA==
X-Gm-Message-State: APjAAAUQXn5JFb9cKJSOQBDFTL759IruT93LWn+PPQsHbON5ZoySNZrV
        oUQudlNxKWLaaJvzs0Rz/x53mEWO0Hk=
X-Google-Smtp-Source: APXvYqwc/kbSdERWRQtPxZi99qvYDeYeYJAYeI3fVCRoK+yPvt3DKuhm+mfJIeTnnbnMOwEFAx2aGQ==
X-Received: by 2002:a17:90a:b318:: with SMTP id d24mr3171994pjr.142.1580872529410;
        Tue, 04 Feb 2020 19:15:29 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id y16sm25612206pfn.177.2020.02.04.19.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 19:15:28 -0800 (PST)
Date:   Tue, 4 Feb 2020 19:15:24 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 13/15] bugreport: add packed object summary
Message-ID: <20200205031524.GQ87163@google.com>
References: <20200124033436.81097-1-emilyshaffer@google.com>
 <20200124033436.81097-14-emilyshaffer@google.com>
 <xmqq8sli89eu.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8sli89eu.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 04, 2020 at 11:00:41AM -0800, Junio C Hamano wrote:
> emilyshaffer@google.com writes:
> 
> > From: Emily Shaffer <emilyshaffer@google.com>
> >
> > Alongside the loose object counts, it can be useful to show the number
> > of packs and packed objects. This way we can check whether the repo has
> > an appropriate ratio of packed to loose objects to help determine
> > whether it's behaving correctly.
> 
> This lets the enumeration machinery to enumerate at the individual
> object level, relies on the enumeration machinery to show your
> callback all objects from the same pack before an object from a
> different pack, to count both objects and packs.
> 
> But given that packfiles record how many objects there are in the
> pack, and that the packfile.c layer must know what are the pack
> files we have available, I wonder if we have an API already to allow
> us to enumerate each packfile, and while counting the number of
> times our callback was called, add the objects contained in each of
> them.  If there isn't, it does not sound like a bad API function to
> add (i.e. given a repository r, iterate over r->objects->packed_git
> and let the API caller see each of them; the API caller can grab
> num_objects and add them up).

Yeah, I don't see one. I'll go ahead and add it - that sounds
straightforward enough.

 - Emily
