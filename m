Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2E8F1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 21:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbeJZGQu (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 02:16:50 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41471 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbeJZGQu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 02:16:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id x31-v6so9854034edd.8
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 14:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hz99M6/jnofD4xHrwlE/RyV6r+8tIWn6o29WxBucuy8=;
        b=tYv78+ef63vPpEtuIEcFJZyjvAGAF5djYnz4ONnIRk1UUgbtVmVyrZQo8zx/LAHjyP
         YZTKCCRFjkvm1tQ/tzJ9cR1/CPBvhqz8BODzZvnT0EzPQ5+MJ4t9evmf//7FghVa+dgb
         wBJ/Q0UehSgNldMDpYAajQPX1x3TyTZtl95+HGmJkpROvjwRJDWOLHOzLbu2Y8KofkBW
         kjemGehcq9laJ0jfx/PlwECHCDUqTgLDOKs+R/dHFFS5JdTQexUDQ7KA1vAAAFTpvFEi
         +IMX2OVqJN8CiLvGKnEeU/OQ4rVHKpxGxOFzYr/qa9LxU25xw3beNDZh3GuQG3wAEUQ+
         T2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hz99M6/jnofD4xHrwlE/RyV6r+8tIWn6o29WxBucuy8=;
        b=l5UjzbjtL01J1S6ZNMPAYEWscAQFqWXaHMiirWDkgB6sRK16E64OPM6r+EkrnM1PHt
         tC343+/8P8R6MftLBsrc55mglxtJRMehnyATldn5u26QpoGWJ42vi4Fq5eGQlOAK0gxf
         BbXAaqD8M2ZuiU3rSrHRxLRyuZn0fBzhfHK/IUoWEoJL02QMf1kuWKn5xIHy7wUyjVML
         Y4J+0ZjmJOqysKPntyIXU7KjmY/W6RchdLVPm8MKNl3XFU2EGhvGlk5CO2EYO20/Ci9G
         OKvWPd0mFm9Joy4e1IF4A8T2lDUR71XC6B7yAe1ou5NLvrQ/FEnZ245GgYmxb0kb3lYV
         HCIw==
X-Gm-Message-State: AGRZ1gJRVYmwtpZowY0WE92RXcbnN9W3fEuJGZyhYZn33NGFvE58acM8
        hqJ31hA3i77vRh0JBMaYTZfTMHF3/SMh/Dt1gTAzPw==
X-Google-Smtp-Source: AJdET5cm07iJM7j9nHpLazSBP+Ln76jHtJQ8lFBpvCD5Qsob/DZIvCO4RXmwmrnc9G57vmzUIDMwsaa7DC6dnmt9JXQ=
X-Received: by 2002:a17:906:b7d1:: with SMTP id fy17-v6mr519771ejb.70.1540503745940;
 Thu, 25 Oct 2018 14:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAGZ79kZrK5G-EeGRzxyw0xW3ozo9_aPab4r8fn_Jc4hzKDOEwg@mail.gmail.com>
 <20181023233756.190026-1-jonathantanmy@google.com>
In-Reply-To: <20181023233756.190026-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 25 Oct 2018 14:42:15 -0700
Message-ID: <CAGZ79kY8bXR2OsdmKMyB+OJP67sWCF=N4KfUdUcpKy5ZQwcV9A@mail.gmail.com>
Subject: Re: [PATCH 8/9] fetch: retry fetching submodules if needed objects
 were not fetched
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 23, 2018 at 4:38 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > > Another thing you need to clarify is what happens if the fetch-by-commit
> > > fails. Right now, it seems that it will make the whole thing fail, which
> > > might be a surprising change in behavior.
> >
> > But a positive surprise, I would assume?
>
> Whether positive or negative, I think that this needs to be mentioned in
> the commit message.
>
> As for positive or negative, I tend to agree that it's positive - sure,
> some previously successful fetches would now fail, but the results of
> those fetches could not be recursively checked out anyway.
>
> > > The test stores the result in a normal branch, not a remote tracking
> > > branch. Is storing in a normal branch required?
> >
> > In the test we fetch from another repository, such that in the
> > repository-under-test this will show up in a remote tracking branch?

I messed up there. Yes, we need to fetch into a normal branch
such that the logic of check_for_new_submodule_commits triggers
no matter where it is on the remote.

Your experiment below shows that we cannot fetch into FETCH_HEAD:

> If that were true, I would expect that when this line:
>
> > git fetch --recurse-submodules --recurse-submodules-default on-demand origin refs/changes/2:refs/heads/my_branch &&
>
> is replaced by this line:
>
> > git fetch --recurse-submodules --recurse-submodules-default on-demand origin refs/changes/2 &&
>
> then things would still work. The tests pass with the first line (after
> I fixed a type mismatch) but not with the second. (Also I don't think a
> remote-tracking branch is generated here - the output printed doesn't
> indicate so, and refs/changes/2 is not a branch anyway.)

> > > Also, do you know why this is required? A naive reading of the patch
> > > leads me to believe that this should work even if merely fetching to
> > > FETCH_HEAD.
> >
> > See the next patch, check_for_new_submodule_commits() is missing
> > for FETCH_HEAD.
>
> I see in the next patch that there is an "if" branch in
> store_updated_refs() without update_local_ref() in which
> "check_for_new_submodule_commits(&rm->old_oid)" needs to be inserted. I
> think this is a symptom that maybe check_for_new_submodule_commits()
> needs to be extracted from update_local_ref() and put into
> store_updated_refs() instead? In update_local_ref(), it is called on
> ref->new_oid, which is actually the same as rm->old_oid anyway (there is
> an oidcpy earlier).

I'll look into that.

> > > What is a "default" submodule and why would you need one?
> >
> > s/default/artificial/. Such a submodule is a submodule that has no
> > config in the .gitmodules file and its name == path.
> > We need to keep those around for historic reasons AFAICT, c.f.
> > c68f837576 (implement fetching of moved submodules, 2017-10-16)
>
> Ah, OK. I would call it a fake submodule then, and copy over the "No
> entry in .gitmodules?" comment.

"fake submodule" sounds like
http://debuggable.com/posts/git-fake-submodules:4b563ee4-f3cc-4061-967e-0e48cbdd56cb
which is what I think of when hearing fake submodules.
