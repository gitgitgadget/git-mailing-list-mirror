Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9133520987
	for <e@80x24.org>; Mon,  3 Oct 2016 12:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbcJCMtg (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 08:49:36 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:45730 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752609AbcJCMte (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 08:49:34 -0400
Received: (qmail 17997 invoked from network); 3 Oct 2016 12:49:32 -0000
Received: (qmail 424 invoked from network); 3 Oct 2016 12:49:31 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <jnareb@gmail.com>; 3 Oct 2016 12:49:25 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1475498965.1776.23.camel@sapo.pt>
Subject: Re: [PATCH v2 05/11] i18n: add--interactive: mark message for
 translation
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Date:   Mon, 03 Oct 2016 12:49:25 +0000
In-Reply-To: <32b8c9ed-82df-0d71-a610-064b6ebf7a4e@gmail.com>
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
         <1472646690-9699-6-git-send-email-vascomalmeida@sapo.pt>
         <xmqqbmzby3tc.fsf@gitster.mtv.corp.google.com>
         <32b8c9ed-82df-0d71-a610-064b6ebf7a4e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A Sáb, 01-10-2016 às 19:09 +0200, Jakub Narębski escreveu:
> W dniu 26.09.2016 o 01:09, Junio C Hamano pisze:
> > Vasco Almeida <vascomalmeida@sapo.pt> writes:
> > 
> >> -            print colored $prompt_color,
> $patch_mode_flavour{VERB},
> >> -              ($hunk[$ix]{TYPE} eq 'mode' ? ' mode change' :
> >> -               $hunk[$ix]{TYPE} eq 'deletion' ? ' deletion' :
> >> -               ' this hunk'),
> >> -              $patch_mode_flavour{TARGET},
> >> -              " [y,n,q,a,d,/$other,?]? ";
> > 
> > I hate to say this but expanding this single-liner into if/elsif/
> > cascade of uncountable number of arms is simply a disaster.
> 
> Even if we turn this "single"-liner composition of sentence into
> interpolation (allowing for reordering of parts in translation),
> like
> 
>    print colored $prompt_color, __x("{verb} {noun}{maybe_target}
> [y,n,q,a,d,/{other},?]? ",
>         verb => $patch_mode_flavour{VERB}, noun =>
> $patch_mode_noun{$hunk[$ix]{TYPE}},
>         maybe_target => $patch_mode_flavour{TARGET} || "", other =>
> $other);
> 
> This would of course require N__() on values of hash, somewhere.
> 
> the problem is that the ordering may need to change depending on
> verb: "Stage", "Stash", "Unstage", "Apply", "Discard", and/or noun:
> "mode change", "deletion", "this hunk", and/or presence and value
> of maybe_target: " to index", " from worktree", " from index and
> worktree",
> " to index and worktree".

So it does not work, unfortunately. The plus side is it would be very
concise compared to laying every combination as entire sentences.
However, if it worked, I think it would be a bit difficult to translate
and translators would be prone to commit some mistake somewhere. It may
be harder to translate a sentence by its bits than translate it as a
whole.
