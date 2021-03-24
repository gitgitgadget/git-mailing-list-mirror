Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A669C433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 20:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E68261581
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 20:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbhCXUIH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 16:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238067AbhCXUH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 16:07:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B088AC061763
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 13:07:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso1786187pjb.4
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 13:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XIRDGSyJ9Ki3qvfLghFp/DWPOB3YGdds/PrPhh7pSaU=;
        b=bX63s8b+G6FWpu1hOYqDL7r9BBsfBUw7IzCOXhzsWrBZC7OFJ+VeHJVguG7jZVwyEq
         PBwvR/UEIpOjNAhgzWp25qxU3YFMpRaEQsxiO4SDOZZHlyOKIqDBgESVCF61usftTVJC
         lG70UBf4CUJRDpv12cnJ///l46ZFgHcbsFz/PhrUGK5oN/ML90ACRbHW9yhoDYONa9Br
         VOeCzFsyhLXSvYjmObHjD2kgXhxDkqK3MFvlz5jYjul+p1U9r/2oQ73cqm9t40g3pOLy
         tbJ9C24t0+jpSWt0/3fxTcIxwg9k0G29Ddu2VVa2W25mmNJCgUSx45ScO5pHE65ISCq1
         t88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XIRDGSyJ9Ki3qvfLghFp/DWPOB3YGdds/PrPhh7pSaU=;
        b=EaBHKnJiaGuMpsOTvONxIF5dNBvBiabhLXAbXLVI/NtkCWvzetCV31677NIwJr3tMC
         N5MAaSU/i3tTjb4b1SCQwwgaJM3xpBBzYEZvnBCNL2fBpHAxc1n4xDxjYAhV6DN0XK/b
         htPIdSJ3/cUVFX0bEwdf1Rqrer4pCbJ0XoKq+vaOqX2ImjR2N686FxafDcl5Rw8YfaST
         fjPvLuy1AD7tuhirNUH6VhbnTGFp0j5BMM7cuD2IQ25LjBl4pViQ7BpjjCguBU+MnzY1
         ePj7eGYAOA1+8zdqZQubul9Eii+rSIzDlSeQO25Xifdy1zQFMWSRYjgTK/VoLvPFtv9R
         EHvg==
X-Gm-Message-State: AOAM532p6BIAjziabzsSbXx2zs1Np3SgXwDRpERGJtiqXGIM7MXsWhrI
        qLbxoWbDyIBvRDUX1PC37nVmdA==
X-Google-Smtp-Source: ABdhPJynnH1uLVvWDHR2ovN2vGOJklenMK/tPwYajN3WU6w81lv/VpsxuiCUQExTX9qlXXicot7kuQ==
X-Received: by 2002:a17:90a:e646:: with SMTP id ep6mr5256855pjb.101.1616616476060;
        Wed, 24 Mar 2021 13:07:56 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:d027:9201:1f66:e720])
        by smtp.gmail.com with ESMTPSA id y5sm3312744pfl.191.2021.03.24.13.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 13:07:55 -0700 (PDT)
Date:   Wed, 24 Mar 2021 13:07:50 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v8 04/37] hook: include hookdir hook in list
Message-ID: <YFucFoVsJXi1UBX+@google.com>
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-5-emilyshaffer@google.com>
 <87lfashj03.fsf@evledraar.gmail.com>
 <YFt9MQsJAJsjWqo2@google.com>
 <xmqq1rc4z7ry.fsf@gitster.g>
 <CAPig+cRcWUgM=c9k-P1hGZGJEZpSgHXK=_ribJeLVsiQWV3LnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRcWUgM=c9k-P1hGZGJEZpSgHXK=_ribJeLVsiQWV3LnQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 24, 2021 at 03:23:30PM -0400, Eric Sunshine wrote:
> 
> On Wed, Mar 24, 2021 at 3:12 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Not just we do not want "hookdir" placed inside _(),
> >
> >                         printf("%s: %s\n",
> > +                              (item->from_hookdir
> > +                               ? "hookdir"
> > +                               : config_scope_name(item->origin)),
> >                                item->command.buf);
> >
> > we do not want the "%s: %s\n" to be placed inside _() and get munged
> > into "%2$s: %1$s\n" for languages that want the order swapped, for
> > example.
> >
> > So perhaps the comment should be about the entire output, i.e.
> > "don't translate the output from this helper, as it is meant to be
> > machine parseable", or something?
> 
> Having the word "translate" in the comment automatically implies
> localization, which confuses the issue. It would be clearer to avoid
> that word altogether. Perhaps something along the lines of:
> 
>     /* machine-parseable output; do not apply _() localization */

After I read Ævar's comments on the next patch in this series, I decided
to rework the comments and translation markers for this whole section.

  if (item) {
          if (item->from_hookdir) {
                  /*
                   * TRANSLATORS: do not translate 'hookdir' as
                   * it matches the config setting.
                   */
                  switch (should_run_hookdir) {
                  case HOOKDIR_NO:
                          printf(_("hookdir: %s (will not run)\n"),
                                 item->command.buf);
                          break;
                  case HOOKDIR_ERROR:
                          printf(_("hookdir: %s (will error and not run)\n"),
                                 item->command.buf);
                          break;
                  case HOOKDIR_INTERACTIVE:
                          printf(_("hookdir: %s (will prompt)\n"),
                                 item->command.buf);
                          break;
                  case HOOKDIR_WARN:
                          printf(_("hookdir: %s (will warn but run)\n"),
                                 item->command.buf);
                          break;
                  case HOOKDIR_YES:
                  /*
                   * The default behavior should agree with
                   * hook.c:configured_hookdir_opt(). HOOKDIR_UNKNOWN should just
                   * do the default behavior.
                   */
                  case HOOKDIR_UNKNOWN:
                  default:
                          printf(_("hookdir: %s\n"),
                                   item->command.buf);
                          break;
                  }
          } else {
                  /*
                   * TRANSLATORS: "<config scope>: <path>". Both fields
                   * should be left untranslated; config scope matches the
                   * output of 'git config --show-scope'. Marked for
                   * translation to provide better RTL support later.
                   */
                  printf(_("%s: %s\n"),
                          config_scope_name(item->origin),
                          item->command.buf);
          }
  }
