Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5DB82042F
	for <e@80x24.org>; Wed, 16 Nov 2016 23:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935416AbcKPXjm (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 18:39:42 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:35172 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932664AbcKPXjl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 18:39:41 -0500
Received: by mail-it0-f53.google.com with SMTP id c20so240757559itb.0
        for <git@vger.kernel.org>; Wed, 16 Nov 2016 15:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=+b4Ze8jIncYQxqIGJId898urM5lLNN1EXBD0AAPmKW0=;
        b=Ve7O+LG+/o0sEYgIAGrxzxnW63G4dMx4j3K9ppymeBPU+RAj3jo8fvDxdp6OoLig/j
         n8Z3KcnQe3OXlNfg5lZLdZX1tPzbMyPG5QSTeVDExV5Qq+ct7/nJxqhBoeImUPD3+s2d
         DSQ2d1lYpakpOxistoh2dMLWGCK1MKZ8wl6oDO6aMOfc9EjHEOBw9WEQDxI18UQ9Y3EG
         nmPjSLOi37wPKEY0NIl/urVjGOzcf5Krjcl+kaTCVpdUyD5FVTyvX0Iof32NUFxgF/RB
         kCOiH+eU98ajfdPBPfHorHGuJWU1wNIeTN2VzSbcKloSxKzIJE5zFlU5dHOzLdIWWZBr
         kQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+b4Ze8jIncYQxqIGJId898urM5lLNN1EXBD0AAPmKW0=;
        b=WhAkCVWaGKQ34AZ8WlGHearF2jZOrJgEsiwh5whkFYp3TDQKlDtXlYuI+Eptz8uDNv
         ZtFkdTgBiaa6K6zUB1szVZhgE7gjRT7WdX9A1RpcBcqfy/17RJvaqArq6Uvo3LddsK/g
         PYlQTrHNtxN70yHS8nKri7aO9HDixB8lbWrVp9nPZeeVb98BgL02tzglkoCL1/6q62kC
         6h9Fl1ap1QrHjSMUbiiwOf9fujUCOJJeGGQHTF8vkvJfSFBHAdtcEOytdc4MHnSuAm/v
         D87pB5+FQT4hyOUpgovgOJxirgOWzgnQ6wrKaDaLcirHzr0IqXH9bzqpHh7OixLk419x
         afIA==
X-Gm-Message-State: ABUngvcoMmUO+1tjBSXy3bGgoRynZ1wEZPgT2JyKxEMpY+x5nnC2rRrMgPt8cezRJuvWBl9Oz4yxFnXUl3FHZA==
X-Received: by 10.36.156.132 with SMTP id b126mr557831ite.91.1479339580856;
 Wed, 16 Nov 2016 15:39:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.164.219 with HTTP; Wed, 16 Nov 2016 15:39:40 -0800 (PST)
From:   Norbert Kiesel <nkiesel@gmail.com>
Date:   Wed, 16 Nov 2016 15:39:40 -0800
Message-ID: <CAM+g_Nsiu_qqapB+FvwJCBfwEYLTPdHg4DueQWHq4XDNXMCgpQ@mail.gmail.com>
Subject: Rebasing cascading topic trees
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I currently have a situation with cascading topic branches that I need to rebase
regularly.  In the picture below, I want to rebase the tree starting with `E` to
be rebased onto master (my actually cascade is 4 branches deep).

A--B--C--D (master)
   \
    E--F (topic1)
       \
        G--H (topic2)

After running `git rebase --onto master master topic1`, I end up with

A--B--C--D (master)
   |     \
   \      E'--F' (topic1)
    E--F
       \
        G--H (topic2)

I then need to also run `git rebase --onto topic1 F topic2` to arrive at the
desired

A--B--C--D (master)
   |     \
   \      E'--F' (topic1)
    E--F      \
       |       G'--H' (topic2)
       \
        G--H

Problem here is that I don't have a nice symbolic name for `F` anymore after the
first rebase. Rebasing `topic2` first is not really possible, because I do not
have a new graft-point yet.  I currently write down `F` ahead of time (or use
`reflog` if I forgot) `F`, but I wonder if there is a better solution.
