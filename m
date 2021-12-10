Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC66C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 07:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237871AbhLJIBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 03:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbhLJIBp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 03:01:45 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5048C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 23:58:10 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id l22so16518511lfg.7
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 23:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkCMF7/++toXpkfjdpVg4vPGs1SkEAk8keokIcfmfM8=;
        b=WivOuYtcPf0U0DoSxTI2H+4FhfEv1RQ6IqAP6t6YZAOKBKScl38Ju0XW4H68uLz8Mf
         p8x7/b6nSIWMGz2mKFn68sM5ZMS2CMwAu2ANMfNwBTpP4MvIEQGGL0BrqyY4tW+vFHJg
         mmVIyH++D2ej4oNgOa1WOKo2sgzum8jkJlIFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkCMF7/++toXpkfjdpVg4vPGs1SkEAk8keokIcfmfM8=;
        b=GBYNxkyWWJuuQ7L4kZ9rng0qgNfCQKxpn9eRQpOX1j2ftXhcQzSxx5GMThslpiQeus
         9FxtZFvxswzAtO/b8wsXHTM3TqbGXOJ8r0CQuTpIACCE9o4PPi+6Iwn/wb2M2tDTA0Id
         r4eeiMqDnkT2UK/FPHR1tzt/vR5TuB7l8ajMBTjfw9HCTwQ18pPKu9B18uSh2w8gSoOo
         sQmch6WywTbw/FD8kbCfSpOq1n3ee3gNZwDKbX5oTCBUPjMWcpM/43ZVcoIwqO9i/7QP
         XHNTZoWygW5f88NLkP/grpZwOlqM6p6236MJ5stNFfzJxXVSINfVtH5Ep8+CCV0tJF/Y
         +Auw==
X-Gm-Message-State: AOAM530E8f0YcalS0/rqCDojXErMJS9i5GmJyi2aiXiV5whW8j781tao
        9SF+fPKo9bneaO6vrOATLCyRlSpbPevVUDgnkWNITJ9NgnEnaA==
X-Google-Smtp-Source: ABdhPJwU8sUFpssReUFGf6XGe+0W5UX14PRR0vyjF7R8Cto9ThXCEVZOK+8aHXGr+ATjsrmSSCoA7XcBZasSKkHB1YM=
X-Received: by 2002:ac2:4c48:: with SMTP id o8mr10553921lfk.690.1639123089030;
 Thu, 09 Dec 2021 23:58:09 -0800 (PST)
MIME-Version: 1.0
References: <20211209201029.136886-1-jholdsworth@nvidia.com> <20211209201029.136886-7-jholdsworth@nvidia.com>
In-Reply-To: <20211209201029.136886-7-jholdsworth@nvidia.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Fri, 10 Dec 2021 07:57:58 +0000
Message-ID: <CAE5ih7_gvbOwvoO4deqDm_8Nk9XWzrdHGHEsgdiEb7+7YxtGwg@mail.gmail.com>
Subject: Re: [PATCH 6/6] git-p4: Resolve RCS keywords in binary
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 9 Dec 2021 at 20:11, Joel Holdsworth <jholdsworth@nvidia.com> wrote:
>
> Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
> ---
>  git-p4.py | 31 ++++++++++---------------------
>  1 file changed, 10 insertions(+), 21 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index c362a5fa38..87e6685eb6 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -46,6 +46,9 @@
>
>  p4_access_checked = False
>
> +re_ko_keywords = re.compile(rb'\$(Id|Header)(:[^$\n]+)?\$')
> +re_k_keywords = re.compile(rb'\$(Id|Header|Author|Date|DateTime|Change|File|Revision)(:[^$\n]+)?\$')

I'm not sure what's going on here, but it does not look like just
turning off support for python2.x.


> +
>  def p4_build_cmd(cmd):
>      """Build a suitable p4 command line.
>
> @@ -532,20 +535,12 @@ def p4_type(f):
>  #
>  def p4_keywords_regexp_for_type(base, type_mods):
>      if base in ("text", "unicode", "binary"):
> -        kwords = None
>          if "ko" in type_mods:
> -            kwords = 'Id|Header'
> +            return re_ko_keywords
>          elif "k" in type_mods:
> -            kwords = 'Id|Header|Author|Date|DateTime|Change|File|Revision'
> +            return re_k_keywords
>          else:
>              return None
> -        pattern = r"""
> -            \$              # Starts with a dollar, followed by...
> -            (%s)            # one of the keywords, followed by...
> -            (:[^$\n]+)?     # possibly an old expansion, followed by...
> -            \$              # another dollar
> -            """ % kwords
> -        return pattern
>      else:
>          return None
>
> @@ -2035,11 +2030,10 @@ def applyCommit(self, id):
>                  kwfiles = {}
>                  for file in editedFiles | filesToDelete:
>                      # did this file's delta contain RCS keywords?
> -                    pattern = p4_keywords_regexp_for_file(file)
> +                    regexp = p4_keywords_regexp_for_file(file)
>
> -                    if pattern:
> +                    if regexp:
>                          # this file is a possibility...look for RCS keywords.
> -                        regexp = re.compile(pattern, re.VERBOSE)
>                          for line in read_pipe_lines(["git", "diff", "%s^..%s" % (id, id), file]):
>                              if regexp.search(line):
>                                  if verbose:
> @@ -2968,14 +2962,9 @@ def streamOneP4File(self, file, contents):
>              print("\nIgnoring apple filetype file %s" % file['depotFile'])
>              return
>
> -        # Note that we do not try to de-mangle keywords on utf16 files,
> -        # even though in theory somebody may want that.

This comment appears to have been stripped out, does that mean that we
now *do* try to demangle keywords on utf16?

> -        pattern = p4_keywords_regexp_for_type(type_base, type_mods)
> -        if pattern:
> -            regexp = re.compile(pattern, re.VERBOSE)
> -            text = ''.join(c.decode() for c in contents)
> -            text = regexp.sub(r'$\1$', text)
> -            contents = [text.encode()]
> +        regexp = p4_keywords_regexp_for_type(type_base, type_mods)
> +        if regexp:
> +            contents = [regexp.sub(rb'$\1$', c) for c in contents]
>
>          if self.largeFileSystem:
>              (git_mode, contents) = self.largeFileSystem.processContent(git_mode, relPath, contents)
> --
> 2.33.0
>
