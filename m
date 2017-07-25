Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3D751F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 23:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbdGYXhk (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 19:37:40 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:38263 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbdGYXhj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 19:37:39 -0400
Received: by mail-pg0-f48.google.com with SMTP id k190so10795988pgk.5
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 16:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7cdYsTp3RLUPhjI8zpahPKAczqkMoiStOtQUgCTpppo=;
        b=LSMnusJRVCzTA/ffEApiBEfzqtAKKHBHQ5i7xgIS+aGAfd9UyxvA1jb55PeMco6iO1
         HyMvu97PwWvyUssaV1TlS5keu/VnlcJmUmqQh82ONSaJo5CoCFKyXFQp4VE+qGJAzWdM
         7xxF/T42416bihSf0mxBFBGmZf0a6WJ1GaO11xOonR5oTvrcedRVE7ISAfdkXd8WAd19
         a56x2yqVSL6Vy54J4f843V/SF7T4L8C+qoW1zQJoBfVbn/9XlS7Bl5ZJbadO8a17M7fJ
         v/C9rF+NjHWmUNQNaffj7TMBFfDfMRcoU4wgHftXHMFvPtADuO/zoWV0Zr70voy4MRdV
         SH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7cdYsTp3RLUPhjI8zpahPKAczqkMoiStOtQUgCTpppo=;
        b=jtyZqjXrfhW6FkRCXTmUke48wNFhI0Y1IgKK+KDKe25yfVmOVyhI0MYM52CW12327z
         qvgyiX5MHlXtpKYOLa5jaRVKL4+Bvwo8tw6mr/F0Qpuc+pzy9EdpMrH082kNCB8c3eY9
         KAtqMIvx7QK7EYW8+gPl1BxC1l56/oiXw+Qr0EEORSUNAzhZTXOJraGZfAvnq37K/YQj
         GCtqDQcdX2GWqMs9jxzJqIorjW33nmhdjdDTiQcMGVudZawguEfBpN3DZ9orIk7eT/XU
         MfnvgK6DMQyYpaT8sHhUIIlJXR5tTdkSeHAxrV3WQvQLPyyWR0m+6DUBVRwgRRUeQMbI
         kuKg==
X-Gm-Message-State: AIVw1134pxzZnChaguJGS6yGYPM/gOvtRe+ZIl8GKhN0DghMnzw6DQKC
        07lwbfMFkoLFF/vF
X-Received: by 10.84.225.146 with SMTP id u18mr22990389plj.328.1501025858679;
        Tue, 25 Jul 2017 16:37:38 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:cccf:9961:8336:68b3])
        by smtp.gmail.com with ESMTPSA id n3sm30339723pfb.87.2017.07.25.16.37.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 16:37:37 -0700 (PDT)
Date:   Tue, 25 Jul 2017 16:37:36 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/15] add, reset: ensure submodules can be added or reset
Message-ID: <20170725233736.GA71799@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170725213928.125998-4-bmwill@google.com>
 <CAGZ79kZByzPbyLUNJ8ViVa2TDk-L+TfnF+wVWRj2d92_MhXPbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZByzPbyLUNJ8ViVa2TDk-L+TfnF+wVWRj2d92_MhXPbg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/25, Stefan Beller wrote:
> On Tue, Jul 25, 2017 at 2:39 PM, Brandon Williams <bmwill@google.com> wrote:
> > Commit aee9c7d65 (Submodules: Add the new "ignore" config option for
> > diff and status) ...
> 
> introduced in 2010, so quite widely spread.
> 
> > ...  introduced the ignore configuration option for
> > submodules so that configured submodules could be omitted from the
> > status and diff commands.  Because this flag is respected in the diff
> > machinery it has the unintended consequence of potentially prohibiting
> > users from adding or resetting a submodule, even when a path to the
> > submodule is explicitly given.
> >
> > Ensure that submodules can be added or set, even if they are configured
> > to be ignored, by setting the `DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG` diff
> > flag.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  builtin/add.c   | 1 +
> >  builtin/reset.c | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/builtin/add.c b/builtin/add.c
> > index e888fb8c5..6f271512f 100644
> > --- a/builtin/add.c
> > +++ b/builtin/add.c
> > @@ -116,6 +116,7 @@ int add_files_to_cache(const char *prefix,
> >         rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
> >         rev.diffopt.format_callback = update_callback;
> >         rev.diffopt.format_callback_data = &data;
> > +       rev.diffopt.flags |= DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
> 
> 
> This flag occurs once in the code base, with the comment:
>     /*
>      * Unless the user did explicitly request a submodule
>      * ignore mode by passing a command line option we do
>      * not ignore any changed submodule SHA-1s when
>      * comparing index and parent, no matter what is
>      * configured. Otherwise we won't commit any
>      * submodules which were manually staged, which would
>      * be really confusing.
>      */
>     int diff_flags = DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
> 
> in prepare_commit, so commit ignores the .gitmodules file.
> 
> This allows git-add to add ignored submodules, currently ignored submodules
> would have to be added using the plumbing
>     git update-index --add --cacheinfo 160000,$SHA1,<gitlink>
> 
> This makes sense, though a test demonstrating the change in behavior
> would be nice, but git-add doesn't seem to change as it doesn't even load
> the git modules config?

I can add a comment to the code but its already being tested in the
submodule test suite.  The only reason this doesn't cause any changes
now is that the gitmodules config is never loaded, but that may
change if we decide to allow lazy-loading of the gitmodules file (like
the last couple patches in this series do).

-- 
Brandon Williams
