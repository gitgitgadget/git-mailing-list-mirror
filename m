Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC3EC33CB7
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 00:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791B620663
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 00:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mcgwiz-com.20150623.gappssmtp.com header.i=@mcgwiz-com.20150623.gappssmtp.com header.b="05xIkfAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgBAAsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 19:48:25 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46910 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgBAAsY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 19:48:24 -0500
Received: by mail-lf1-f68.google.com with SMTP id z26so6052367lfg.13
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 16:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mcgwiz-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CgV+nKhIrsvXeeORSzal9aRu4VwEImXDtcL9UdVymNI=;
        b=05xIkfACXDYMPxSvoxVnIt+N4r3b9BPev4aEwZqMEC1z5xNsAtsW++KP9S5HfLJ50q
         3gZz5YyWF12VyyTX1SPRIBCBOFQDkhPSx/6O5vqHsjfjn0beoSdk9q/FceU6tneejQra
         LB8M4M1QVJrm2pIj105WeGauxVrvy/Xs7lanIA1eAxYbpE3KqaBOdc0cnLXRZW/opoJ2
         kPProDmitTZ1gMsPsYnzqBfG6PQL/IuKiHemQmFwespg5IxIezTP7Cy7lIdXgiW4DK7p
         +UTJ579aOxp0TGASBfnGaKWdQiANSahUEAdH8XD08VvnnE8XgRWeWsBzHj+hT+CyZpca
         7jSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CgV+nKhIrsvXeeORSzal9aRu4VwEImXDtcL9UdVymNI=;
        b=EQ0VxxlxEyEATc2Bm4kL3C5UUnELe1biXXioGMcpKYkzZbyuORSugWU/hRj/x+Zfgq
         gdqjB11gdMe+4swyRhEdIoxjExhcTP6FP4hZ44/6wq+IWLAl84N86HnIzRYvmKp3g4fB
         WY9jwCH/mv7rxPDLQSAa0dGvAp4qY2bckCaHZtPon5SxfpCFX/a4A2hFOij3cqmYe8go
         3vuq8umL8v0XxaZggDXICawWCqIAPzth7f8/yLCTXq6m/FxsKd8Ly3S2ylH70wl0Miya
         /uhgV12fMiRegBoZSHrfAKUjWW5/F/cU0ZYbBfII1B01Q/q1LNrU/0HspWJOwP7KQvqA
         ST2A==
X-Gm-Message-State: APjAAAU2HFySUmbvIoF9AL+JUSqtqkDUW5zyMi985hymrFqWjTFPUMtW
        ivgytXHWK7wASuroipgBYl7S7uPPZhk=
X-Google-Smtp-Source: APXvYqwfdH42sANU/qsJ0mEV738C84A93MHCpdldiPAKD0Zic3+KTOogfalROgdPSTkJkcbw/xQWxw==
X-Received: by 2002:ac2:5a43:: with SMTP id r3mr6811605lfn.150.1580518102474;
        Fri, 31 Jan 2020 16:48:22 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id v5sm5358678ljk.67.2020.01.31.16.48.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 16:48:22 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id r14so6106826lfm.5
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 16:48:21 -0800 (PST)
X-Received: by 2002:ac2:599c:: with SMTP id w28mr6885232lfn.78.1580518101463;
 Fri, 31 Jan 2020 16:48:21 -0800 (PST)
MIME-Version: 1.0
References: <CAK7jxYgJNvCp=m6rH31HNzN9Mqgaav7_YPvUMZmRb7mdYDZ_1g@mail.gmail.com>
 <20200131091917.GC2857810@coredump.intra.peff.net>
In-Reply-To: <20200131091917.GC2857810@coredump.intra.peff.net>
From:   Mike McGranahan <mike@mcgwiz.com>
Date:   Fri, 31 Jan 2020 16:48:10 -0800
X-Gmail-Original-Message-ID: <CAK7jxYjLoXZhRzUWERmJg9ADNhvJt5SLLymPVktiWcT4RC6VpA@mail.gmail.com>
Message-ID: <CAK7jxYjLoXZhRzUWERmJg9ADNhvJt5SLLymPVktiWcT4RC6VpA@mail.gmail.com>
Subject: Re: Patch text in git-add patch mode lacks whitespace highlighting
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I can confirm this fixes the unexpected behavior I reported. (Thanks!)
I can't speak directly to the plumbing as I don't regularly use thos
tools.

-Mike

On Fri, Jan 31, 2020 at 1:19 AM Jeff King <peff@peff.net> wrote:
>
> On Thu, Jan 30, 2020 at 01:53:52PM -0800, Mike McGranahan wrote:
>
> > I'm using version 2.25.0.windows.1. If I set config "wsErrorHighlight"
> > to "old", and run `git diff -p`, the resulting patch text highlights
> > whitespace differences in the old text.
> >
> > If I then run git-add in interactive patch mode, I expect the diff to
> > include the whitespace highlights. But actually, it does not.
> >
> > Is this a bug? Thanks for your help.
>
> Sort of. It's more of a feature that has not yet been implemented. ;)
>
> Like the rest of the color config, diff.wsErrorHighlight is not enabled
> for scriptable plumbing commands like git-diff-index, etc; it is only
> used for the user-facing porcelain commands like git-diff.
>
> So scripts like git-add--interactive, which use the plumbing under the
> hood, are responsible for deciding which config options should be
> respected and passing the correct command-line options on to the
> plumbing. We do that for color.diff, diff.algorithm, and a few others.
> But nobody has yet taught it that diff.wsErrorHighlight is safe to pass
> (for the user-facing "color" version of the diff).
>
> The solution for the existing perl script would be something like this:
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index c4b75bcb7f..fac1d1e63e 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -46,6 +46,7 @@
>  my $normal_color = $repo->get_color("", "reset");
>
>  my $diff_algorithm = $repo->config('diff.algorithm');
> +my $diff_error_highlight = $repo->config('diff.wsErrorHighlight');
>  my $diff_filter = $repo->config('interactive.difffilter');
>
>  my $use_readkey = 0;
> @@ -727,7 +728,11 @@ sub parse_diff {
>         my @diff = run_cmd_pipe("git", @diff_cmd, "--", $path);
>         my @colored = ();
>         if ($diff_use_color) {
> -               my @display_cmd = ("git", @diff_cmd, qw(--color --), $path);
> +               my @display_cmd = ("git", @diff_cmd, qw(--color),
> +                                  $diff_error_highlight ?
> +                                    "--ws-error-highlight=$diff_error_highlight" :
> +                                    (),
> +                                  qw(--), $path);
>                 if (defined $diff_filter) {
>                         # quotemeta is overkill, but sufficient for shell-quoting
>                         my $diff = join(' ', map { quotemeta } @display_cmd);
>
> but this is all being rewritten in C. I'm not sure how the multiple
> diffs are being handled there.
>
> All that said, I kind of wonder if diff.wsErrorHighlight ought to be
> respected by even plumbing commands. After all, it does nothing unless
> color is enabled anyway, so I don't think it runs the risk of confusing
> a user of the plumbing. It's no different than color.diff.*, which we
> respect even in the plumbing commands (if the caller has manually asked
> for color, of course).
>
> -Peff
