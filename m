Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C24C34031
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 23:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F5B2068F
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 23:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bXXvq+7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgBRX42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:56:28 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35018 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgBRX42 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 18:56:28 -0500
Received: by mail-pj1-f65.google.com with SMTP id q39so1715187pjc.0
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 15:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ok+LIIBWb4N5XHX0zDpaAq+XHyxUAclUlJg6AKFMzHw=;
        b=bXXvq+7zArYBx8FGFoqOyU3h/VC3sJOjmDuNXV5NcequmUrcaCGD/G7qT826AiaqOh
         ECMlkPnWd0dRRMzuwuABADynYDWC2oqPzc3T443Y1S7wDr3KYSUOARjgUSY6UUT3qLzI
         mschn3MynsKz2Ngx+nRp/V7EK2pHwslLj3APzCMLSv9KysPrBF6U8ofsWGhCq9167EUj
         qGz2tLJ31JFepvUshyKZwj9FmiX7an8fEf/AZakMOUkzZlkfG992iPPb06qIdj7OJ7qZ
         8tJuubgYWwvJKQxDQqVUSpoPS3JC+2roQ9vufUi+j1iUU+vb/PPpunboD8pcIRfAtT/K
         7APw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ok+LIIBWb4N5XHX0zDpaAq+XHyxUAclUlJg6AKFMzHw=;
        b=Rn9mvFj4IhZWgOWwVjCUSjeT7yQFLdmEN20+0GsG5LgYCam5NTj+s1atuEzcOKGKAF
         y8qkroHbwRq5nwC06IuKJrK5Wkr24GQi3argU4ekjQenzW20iD8FYkJNI97bPwhH4Y5f
         dZny6N6SRYSajzo45eZIjBXgPFuhuX39/bxFMakAtbKMAoDmKf4FNhblVBYc6vt4BUny
         Ujs+Vw/CiA4GDNe/GobQspjyptkJWiNKiVyyMaOpA+S79SquxmfSZEVBy3tE6uaexvZa
         Wkd3B3r2pdXSv8+IjDH+iA+5+xhvUdOejN88vZ289bxtPczjSVziXBXp6fEqKzRlHPJ8
         G9kg==
X-Gm-Message-State: APjAAAV+uv+LmdZQGWxPvEtBcxNizmNHZfIuwe6TMqHlrwDxouZx3jH7
        aO8bDai9siZPSAQSa82pyZD2Ew==
X-Google-Smtp-Source: APXvYqwt8FRiphQSCJpJN+r57mETOW2+iO8xV7dF8wrqyluTcdejQBQKO6m7E+9nu/2pHOqjXOSY+w==
X-Received: by 2002:a17:902:5ac9:: with SMTP id g9mr22424825plm.69.1582070187501;
        Tue, 18 Feb 2020 15:56:27 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id e6sm130948pfh.32.2020.02.18.15.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 15:56:27 -0800 (PST)
Date:   Tue, 18 Feb 2020 15:56:22 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 03/15] bugreport: add tool to generate debugging info
Message-ID: <20200218235622.GB1461@google.com>
References: <20200214015343.201946-1-emilyshaffer@google.com>
 <20200214015343.201946-4-emilyshaffer@google.com>
 <xmqqzhdlnksn.fsf@gitster-ct.c.googlers.com>
 <20200215015729.GN190927@google.com>
 <xmqq1rqvogif.fsf@gitster-ct.c.googlers.com>
 <20200218234628.GA1461@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218234628.GA1461@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 03:46:28PM -0800, Emily Shaffer wrote:
> On Sat, Feb 15, 2020 at 10:24:40AM -0800, Junio C Hamano wrote:
> > I am actually OK if we limit the use of this tool to "use with a
> > repository that is not corrupt", as coping with these kinds of
> > breakages that in the main Git executable we deem "needs manual
> > intervention" inside a single process is too painful (it would have
> > been easier to cope with these too if we stuck with a script that
> > invokes many discrete commands and acts on their errors, but that is
> > optimizing for rare case and not recommended).  But we should tell
> > users about the limitation and encourage them to ask for help in non
> > automatable means.
> 
> I think you're saying, "Mention this drawback in the manpage for
> git-bugreport." Sounds like a good idea to me, so I'll add it for v8.

I'm pretty unsure about how you wanted this to sound; rather than
sending a v8 only to revise it a lot, I'll send the paragraph for
wordsmithing beforehand. Is this what you meant?

  This tool is invoked via the typical Git setup process, which means that in some
  cases, it might not be able to launch - for example, if a relevant config file
  is unreadable. In this kind of scenario, it may be helpful to manually gather
  the kind of information listed above when manually asking for help.

 - Emily
