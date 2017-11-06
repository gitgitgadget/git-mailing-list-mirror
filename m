Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99F8E20A10
	for <e@80x24.org>; Mon,  6 Nov 2017 22:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751607AbdKFWwQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 17:52:16 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:47665 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751509AbdKFWwP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 17:52:15 -0500
Received: by mail-pf0-f171.google.com with SMTP id z11so8831776pfk.4
        for <git@vger.kernel.org>; Mon, 06 Nov 2017 14:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7fXLdSO35B2q6nBtMqS1I8Tdjy/OaIr5yexi9ceNlSc=;
        b=MG509f56n822wRNCoL+pUdmDecyfeZhu7GRJaMGyvDZPgGY0OnZ1AITw+SpAHtPk08
         eOrU8bMw7RFoB7MsJ/toW154bG0NmzaKKGD0lujRq9BWhlENsKihZWtxZ9wqi2LZ2YX3
         35SIln+Df9MATpzCXhSSSXECAgiwlu7WJeXgk5+3UGoev3O/Cbh++SAp9QYni24F5+Xi
         VE0UfUyOa7SrSU5SDwnGMDxdR5zFiSyVdtbfdW2B1+Q9FB1gO+XtfKO/Gt5Ffrp64UnO
         9x5BSbWC/nbBAz+gxzxPAbQQ4JIzQRjgDcTOMFWhK/vUiCs+cLdBROJIwcAgGCJ66Rbp
         x9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7fXLdSO35B2q6nBtMqS1I8Tdjy/OaIr5yexi9ceNlSc=;
        b=WkhXycOmdG/7CrgacGlRyRl7JI9Q53xf1Y5+ZqxNzvkDLHn3s102Qe9T9o74DcA4G6
         +R3KvYJvOt0naXBYtGnZzBWduUtb98iH87Sm4Mu72il93LE/G3Yh3vV9MArbr2Nld9i1
         kTET2nbj9IKkFmfgPMgJe+LC2b/kjOntK5+qMyBYWesi/Kqp8tiAysbfR0piwtFV8tL/
         zwdfRA+bOwjIGGBK2u2/7XGI5yTV1ZNpGo48clGUusVeI7EbNNtPXiqd778iEYV6OFGQ
         w+mAjuRaWJu9+7rG8xXKNjOh8Y4Z2yyLkjnmfNhldxK1ooqTG2U7euuzif3UD2Z85KS9
         G2ug==
X-Gm-Message-State: AMCzsaV1uMualXYVLhieAveEbH1lvBvVKpMdgVO25rdes3u0sVqKVRs4
        pfOWOSkuIvGq8b7jG94XtBBzDOSszzs=
X-Google-Smtp-Source: ABhQp+RlGqtPbmTdRbakJ4nojf+To+SN+cqOb6yDnnNvV5WmYF3QEdT5nnyXMAJ2Nx3Dfy4pJDWPdA==
X-Received: by 10.98.133.152 with SMTP id m24mr18388660pfk.62.1510008734765;
        Mon, 06 Nov 2017 14:52:14 -0800 (PST)
Received: from google.com ([2620:0:100e:422:c487:838c:3a00:2278])
        by smtp.gmail.com with ESMTPSA id l79sm25235959pfb.33.2017.11.06.14.52.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Nov 2017 14:52:13 -0800 (PST)
Date:   Mon, 6 Nov 2017 14:52:12 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Orgad Shaneh <orgads@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] wt-status: actually ignore submodules when requested
Message-ID: <20171106225212.GB131418@google.com>
References: <CAGHpTB+jKiXr45tKVEVTtszN7OBTW7W_FqKu7aAjsB8Tmx9N3Q@mail.gmail.com>
 <20171106220819.178881-1-bmwill@google.com>
 <CAGZ79kY5d3hhBCstY+UPpjhDbq=v_QXL+vtKz1fLdxo2Qhj5DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kY5d3hhBCstY+UPpjhDbq=v_QXL+vtKz1fLdxo2Qhj5DA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/06, Stefan Beller wrote:
> On Mon, Nov 6, 2017 at 2:08 PM, Brandon Williams <bmwill@google.com> wrote:
> > Since ff6f1f564 (submodule-config: lazy-load a repository's .gitmodules
> > file, 2017-08-03) rebase interactive fails if there are any submodules
> > with unstaged changes which have been configured with a value for
> > 'submodule.<name>.ignore' in the repository's config.
> >
> > This is due to how configured values of 'submodule.<name>.ignore' are
> > handled in addition to a change in how the submodule config is loaded.
> > When the diff machinery hits a submodule (gitlink as well as a
> > corresponding entry in the submodule subsystem) it will read the value
> > of 'submodule.<name>.ignore' stored in the repository's config and if
> > the config is present it will clear the 'IGNORE_SUBMODULES' (which is
> > the flag explicitly requested by rebase interactive),
> > 'IGNORE_UNTRACKED_IN_SUBMODULES', and 'IGNORE_DIRTY_SUBMODULES' diff
> > flags and then set one of them based on the configured value.
> >
> > Historically this wasn't a problem because the submodule subsystem
> > wasn't initialized because the .gitmodules file wasn't explicitly loaded
> > by the rebase interactive command.  So when the diff machinery hit a
> > submodule it would skip over reading any configured values of
> > 'submodule.<name>.ignore'.
> >
> > In order to preserve the behavior of submodules being ignored by rebase
> > interactive, also set the 'OVERRIDE_SUBMODULE_CONFIG' diff flag when
> > submodules are requested to be ignored when checking for unstaged
> > changes.
> >
> > Reported-by: Orgad Shaneh <orgads@gmail.com>
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  t/t3426-rebase-submodule.sh | 16 ++++++++++++++++
> >  wt-status.c                 |  4 +++-
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/t/t3426-rebase-submodule.sh b/t/t3426-rebase-submodule.sh
> > index ebf4f5e4b..760c872e2 100755
> > --- a/t/t3426-rebase-submodule.sh
> > +++ b/t/t3426-rebase-submodule.sh
> > @@ -40,4 +40,20 @@ git_rebase_interactive () {
> >
> >  test_submodule_switch "git_rebase_interactive"
> >
> > +test_expect_success 'rebase interactive ignores modified submodules' '
> > +       test_when_finished "rm -rf super sub" &&
> > +       git init sub &&
> > +       git -C sub commit --allow-empty -m "Initial commit" &&
> > +       git init super &&
> > +       git -C super submodule add ../sub &&
> > +       git -C super config submodule.sub.ignore dirty &&
> > +       > super/foo &&
> > +       git -C super add foo &&
> > +       git -C super commit -m "Initial commit" &&
> > +       test_commit -C super a &&
> > +       test_commit -C super b &&
> > +       test_commit -C super/sub c &&
    +       set_fake_editor &&
> > +       git -C super rebase -i HEAD^^
> 
> The previous test `set_fake_editor` already, though I am unsure
> about the current directory. It turns out that the setting of the fake
> editor is done via environment variable using absolute path to
> the generated `fake_editor.sh`, hence it works even when
> invoking a rebase in another directory/repo. Spooky.
> 
> Also we do want to be able to skip previous tests,
> which this might be a problem for. Can we have a 'setup'
> that sets up the fake editor instead of repeating it here or
> hoping the previous tests has run? (Calling for a refactoring
> during a regression fix is bad taste, so maybe just take this
> patch as is and put it to the #leftoverbits ?)

Thanks for catching that.  'set_fake_editor' definitely needs to be set
(like what i did above in-line).

> 
> > +'
> > +
> >  test_done
> > diff --git a/wt-status.c b/wt-status.c
> > index 29bc64cc0..94e5ebaf8 100644
> > --- a/wt-status.c
> > +++ b/wt-status.c
> > @@ -2262,8 +2262,10 @@ int has_unstaged_changes(int ignore_submodules)
> >         int result;
> >
> >         init_revisions(&rev_info, NULL);
> > -       if (ignore_submodules)
> > +       if (ignore_submodules) {
> >                 DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
> > +               DIFF_OPT_SET(&rev_info.diffopt, OVERRIDE_SUBMODULE_CONFIG);
> > +       }
> 
> There are a couple of submodule related flags:
> 
> #define DIFF_OPT_IGNORE_SUBMODULES   (1 << 18)
> ...
> #define DIFF_OPT_DIRTY_SUBMODULES    (1 << 24)
> #define DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES (1 << 25)
> #define DIFF_OPT_IGNORE_DIRTY_SUBMODULES (1 << 26)
> #define DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG (1 << 27)
> 
> We don't need to pay attention to 24,25,26 here, because
> DIRTY_SUBMODULES and IGN_* are only used to specify further
> interest, the generic INORE_SUBMODULES turns off any submodule
> handling. (so if we were to turn them on as well, it would still be correct,
> though it may have performance impact -- I shortly wondered if we'd rather
> want to have a mask covering all submodule related flags, specifically
> all flags invented in the future ;) )
> 
> The patch looks good to me (i.e. I am convinced by review it fixes the
> regression), so maybe we can put the test refactor on top of it, which
> then doesn't need fast-tracking down to the maintenance track?
> 
> Thanks,
> Stefan

-- 
Brandon Williams
