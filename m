Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 310F6207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 17:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753664AbdDZRiV (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 13:38:21 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34184 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753657AbdDZRiT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 13:38:19 -0400
Received: by mail-pg0-f49.google.com with SMTP id v1so3418231pgv.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 10:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=unC9mjU3suxQUNl1//UPDkKKoJd3rU/7uR9lXfXvv00=;
        b=bC0ewmECsXWGFMeOM3PGDDBlh+NnS+tRQ5gfuYfyh6SQxzeQCm+C5TLz8OPXKs6XYp
         Lg0DoyfZTrzV5rx7DUWWXAwg7fBLwSHN7BaHZSj6lqWuoj960BiipDEZvql6+qbFON/u
         8pivtuYo5IHWxlPGx6GOSBsIsu+eMMUaZbGZ6qrP9Ft6x/RUik8NYKpI9mVMaLT+zWrj
         5P0dEyG2gxtvxXQt0Oe0jotYIr/9bwEK66H3LUx/EhLfT8UK0hrtCHRVKRqompx/Uh3q
         ge0OJJSW4R9boibcX0CA8nLQMIwH5JJU2S1yDkkXuqZDT7CYMFpho+lH95uLVmdZU0E7
         whEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=unC9mjU3suxQUNl1//UPDkKKoJd3rU/7uR9lXfXvv00=;
        b=qB/5nuVm9/FZHRTa2jAMCfeUYBWol2JFjOnSIXUyYAj9SSjKBaxSzpHMXws2dp581a
         6EWIeGeR3orkwmCOWCaTwwu590+IDL64ApC5SYKdarYwppkamKWCy57Cip8r/gWb4Wv2
         BoSaoYqqrQJp2qnk/4J7vF3ODhgYfxxoVWC9C9GhZ5FwCuo0iMpzdfZFXYpRQw2rQd/C
         gCVwKemODlMmzY9AGKqMeqylduMUmdGyMKYTGQzRJXhIi7C1HGVgIR8py1+4Lxwm9L7T
         uyVw1BpW/r8DoWobZrqUps3mclEt2DjCyEfUMgLhvfefAhYNAe1dZLxIrpLaQehMMEd2
         ngoQ==
X-Gm-Message-State: AN3rC/6nmENL4ucW0r3XrYzHa+jQdpk54HJB4MEEzFDPoUO432zBnw3T
        wVRQX/+0IGEwL685
X-Received: by 10.84.224.136 with SMTP id s8mr1239721plj.93.1493228298475;
        Wed, 26 Apr 2017 10:38:18 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:544c:eb40:b322:405])
        by smtp.gmail.com with ESMTPSA id a77sm1546420pfe.33.2017.04.26.10.38.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 10:38:17 -0700 (PDT)
Date:   Wed, 26 Apr 2017 10:38:16 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: BUG: wildmatches like foo/**/**/bar don't match properly due to
 internal optimizations
Message-ID: <20170426173816.GA80265@google.com>
References: <CACBZZX5u5fF4fJBJ3CwH0DmLBw4D32jN5o=Om-iqwQdPG93DFg@mail.gmail.com>
 <CACsJy8Ct4VU0XAgJruFECEVxb98MS4P+9Z6D8ag35ySL6OY-0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8Ct4VU0XAgJruFECEVxb98MS4P+9Z6D8ag35ySL6OY-0g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/26, Duy Nguyen wrote:
> On Wed, Apr 26, 2017 at 2:13 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
> > Thought I'd just start another thread for this rather than tack it
> > onto the pathalogical case thread.
> >
> > In commit 4c251e5cb5 ("wildmatch: make /**/ match zero or more
> > directories", 2012-10-15) Duy added support for ** in globs.
> >
> > One test-case for this is:
> >
> >     match 1 0 'foo/baz/bar' 'foo/**/**/bar'
> >
> > I.e. foo/**/**/bar matches foo/baz/bar. However due to some
> > pre-pruning we do in pathspec/ls-tree we can't ever match it, because
> > the first thing we do is peel the first part of the path/pattern off,
> > i.e. foo/, and then match baz/bar against **/**/bar.
> 
> Yeah. I think the prefix compare trick predated wildmatch. When I
> introduced positional wildcards "**/" I failed to spot this. Good
> catch.
> 
> Ideally this sort of optimization should be contained within wildmatch
> (or whatever matching engine we'll be using). It also opens up more
> opportunity (like precompile pattern mentioned elsewhere in this
> thread).
> 
> You need to be careful though, when we do case-insensitive matching,
> sometimes we want to match the prefix case _sensitively_ instead. So
> we need to pass the "prefix" info in some cases to the matching
> engine.
> 
> I guess time is now ripe (i.e. somebody volunteers to work on this ;-)
> to improve wildmatch. "improve" can also be "rewriting to pcre" if we
> really want that route, which I have no opinion because I don't know
> pcre availability on other (some obscure) platforms.

If we do end up improving wildmatch, we may also want the functionality
to (with a flag) have a pattern match a leading directory.  This would
be useful in the submodule case where a user gives a pathspec which
could go into a submodule but we don't want to launch a child process to
operate on the submodule unless the first part of the pattern matches
the submodule.  Right now with recursive grep, if wildcards are used
then the code just punts and says "yeah this pattern may match something
in the submodule but we won't know for sure till we actually try".

-- 
Brandon Williams
