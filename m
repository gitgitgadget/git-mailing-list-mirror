Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AF7C388F9
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 01:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D648A22258
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 01:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrZm7wi4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgJ1Bia (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 21:38:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41305 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1833050AbgJ0XnN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 19:43:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id c20so1836267pfr.8
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 16:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GubRMWRDgW1Fvb9KXdHhJ3dWUHM2JzQH32hD2a/t/A8=;
        b=qrZm7wi4hDmSN86Emevp9+yuSk1UAJBmPe1NPqeKfor/FIL5J2CgyhwaHTaESBu/V5
         QA/Kkimzrywtki8e5rSjFOErA1blRhvcn9k6/nzLdoqLY52JUDCzheO6Nb3IRPlBKgWt
         Bteb1gvxCYupe3ae0Dbb136/tJs7yC6kxzjcQf/97F/X2BSYNtL3Yk9JV29+uEC11oN3
         hYM2udInCqv0mDPEVB5+IsOLTjCfmhDi4UffeKXQsiKbWU0NYm56fhhMa6HriZnyvmpx
         2oqQIHTrxhaCOVd13ax3ni+ul7D2wZjhloZRp7xXR9wAu1yv4KGXbIlsDTPfgnmWunof
         JakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GubRMWRDgW1Fvb9KXdHhJ3dWUHM2JzQH32hD2a/t/A8=;
        b=My3WLa8mpPF/UPcwlV62CnKp/fq3uJYFj/lQaahS9sLveo/tyPhCQAtuki3ngAJ0hm
         UAPlx6RUeaFRQM08qV27iyMCRjSxIYdrEItNzPcbTMqHNsWbn+a9zsE+jvci+AHOCzjQ
         7O5YFfGXLmh1r44D1xeKUGYJDCejqm0KhVLRA+ZvZFh8UAuVpKiLWLCgDV5hNo9cujIo
         R/XfzgPQZtpq0uuNblfc0TMCUD69ngxVN7+0CKgjLMEbASmrX1ntn4+PEzuzleaguP+5
         4l3U6W/N0W/5KrF4p02DPKw9FC2vy/FOOmQBEPyUkBclGleoY0byinb+DKFVOUSDY/UQ
         WjOA==
X-Gm-Message-State: AOAM5337juj8yml8jtgzvouO5ajwcbuPoOoCIADLpo3GcnFPnDJvIaP0
        ICi8+FJNKPZUsr0jx/6Z/fDcn0mltcY=
X-Google-Smtp-Source: ABdhPJzy99Bp8avYtD/DSU0Qossc/0JzKTdvxuz07qlfufrxlfHLDtfjjGLg6t+pjP/ChaUI7SQUcA==
X-Received: by 2002:a62:2ce:0:b029:160:77b1:8d60 with SMTP id 197-20020a6202ce0000b029016077b18d60mr4686601pfc.9.1603842192036;
        Tue, 27 Oct 2020 16:43:12 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id e1sm3612388pfd.198.2020.10.27.16.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 16:43:11 -0700 (PDT)
Date:   Tue, 27 Oct 2020 16:43:09 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 7/8] verify_path(): disallow symlinks in
 .gitattributes and .gitignore
Message-ID: <20201027234309.GA1298045@google.com>
References: <20201005121609.GA2907272@coredump.intra.peff.net>
 <20201005121645.GG2907394@coredump.intra.peff.net>
 <20201027033518.GH2645313@google.com>
 <20201027075853.GH3005508@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027075853.GH3005508@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Oct 26, 2020 at 08:35:18PM -0700, Jonathan Nieder wrote:

>> Observations:
>>
>> - since some widely used repositories have .gitignore symlinks, I
>>   think we can't forbid it in fsck, alas
>
> I am a little puzzled here. You said you had the fsck checks for the
> last year, so why did they just come up now? I guess nobody sets
> transfer.fsckObjects, and because you were testing only with clients,
> your server implementation didn't reject pushes?
>
> I agree it's annoying for them if they fail fsck, but it's not entirely
> a show-stopper. There are config options for fine-tuning what you're
> willing to enforce or ignore. But they of course are also annoying to
> use, because every receiver of a transfer needs to set them (on GitHub,
> for example, you have to email Support).

Yes.  And to reiterate the point a little: the reason nobody sets
transfer.fsckObjects is that we haven't made it easy to distinguish
between "hard error, should never be overridden" checks (like
BAD_PARENT_SHA1), "new tools shouldn't write these but they exist in
important repos like perl.git and anything consuming Git repositories
needs to cope with them" (like MISSING_SPACE_BEFORE_DATE from some
commits' concatenated authors), and so on.

> So I won't be too devastated to remove the symlink checks, or possibly
> downgrade them to purely warnings (or "info"; the naming in fsck.c is
> confusing, because the transfer operations take even warnings as fatal.
> I suspect we could do with some cleanup there).

Downgrading the .gitignore check to warning sounds okay.  .gitmodules
would still want to be an error, of course.

>> - it would be useful to be able to check whether these symlinks would
>>   not escape the worktree, for a more targeted check.  It might be
>>   nice to even respect these settings when they would not escape the
>>   worktree, but not necessarily
>
> I actually wrote a patch several years ago for checking symlinks (not
> just these ones, but _any_ symlinks in the repo, but of course it would
> be easy to limit it more). It's included at the end of this mail. It's
> been part of my daily build for many years, so I'm confident it doesn't
> crash or have other bad behavior. But it's possible the logic for what
> it catches is faulty.
[...]
> Here's the patch.

Nice!  I'll try to find time to experiment with this.

[...]
>> - we could use a clearer error message than "invalid path".
>
> That part is tricky. The "invalid path" error comes from the caller of
> verify_path(), and we have no way to pass back an intelligent error
> there. We can call error() ourselves, of course. That adds an extra line
> of output, but it's rare enough for verify_path() to fail that it's
> likely OK. However, I would worry that some callers might be surprised
> by it producing output at all.
>
> An alternative is letting the caller pass in a strbuf that we fill out
> with an extra error string.

I think passing in a struct to govern error handling sounds nice.
Alternatively, this might suggest that verify_path is not the right
place for the user-facing check: it's useful because it's exhaustive,
but it may be that we can also catch the same issue earlier and
produce a nicer diagnostic.

>> There's some room for improvement in "git checkout"'s error handling,
>> too --- I think my ideal would be if the operation would fail
>> entirely, with an advice message describing a checkout command that
>> would succeed (But how do I checkout another commit while excluding
>> some files? Should it suggest a sparse checkout?).
>
> I suspect it's too late for "fail entirely". We may have already written
> to the filesystem, and rolling back is difficult and error-prone. In
> general I'd expect to checkout what we can, produce errors for the rest,
> and let the user work from there with "git status".
>
> But I may be wrong. The problem is loading the value into the index, not
> writing it to the filesystem. So perhaps the relevant code paths load
> the index fully before writing out anything to the filesystem, and it's
> easy to rollback. But I imagine they are using unpack-trees' flag to
> update the filesystem, and I assume that checks out as it loads entries
> (but I didn't confirm).

Right, this would require taking two passes.  I think we do already
perform two passes (first deletions, then additions); I'll have to
look a little more closely to see whether this is straightforward to
do.

I do still like the idea of not respecting .gitignore and
.gitattributes symlinks, by the way.  What the experiences upthread
tell me is just that users need better facilities for repairing
existing repositories.

Thanks,
Jonathan
