Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A1FC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 23:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhKVXmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 18:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhKVXmd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 18:42:33 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC23C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 15:39:25 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id p2so39965430uad.11
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 15:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FWh58Es4oH0Rvm8GvftCTOz9P0uZDG0qbZZF2V5rOSg=;
        b=X035KJB3M8RGG1V63fshsyMder2GeqOwLQKxrMw2UdkYLIAhSoB+6mf3hqHbKxc3Bn
         PwSCS4+4ItDFV6ano6n7Y/jeaSNfLWas9wt1sz4hbXFRQ4NS1Gd0ZHf8nl9AW+FRrW+t
         E6d6CzZG5YrCEVEXIOugZF/gBy3qzFKwadREeqSmKEGUmVIpRvjy5O2Eush5qzcxmoj9
         fzRnwKfpS5W6fkdpqfdpwi1MMnzlIG7W/jqkN1zbeiQOLI1W5Q1A/+3eY3gDnipD4Po6
         JGiAnSgt0SerzbVlQsK7F638djYlRgP9wZyUgLmBiYH74MqL5qLtEpp/Bj/OMo4oIwXF
         WLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FWh58Es4oH0Rvm8GvftCTOz9P0uZDG0qbZZF2V5rOSg=;
        b=IGCmigGmwuwauL17FIYgqEpI8DCeU4yCGfDLYUrygjyiQWAIU5wpr9oWYuBx+uhtO3
         XGnkPk/YT6NGfnP/hdot8t/YgxacnPgtA/MdQ3vBuFO96knGcedi/jebUedZuaMb5F49
         zZQazjt2V8wscPtsm0/hahZzfWlkcy69qcExdlNNmvmcMVtogJ3Fri54K4jbALqcOktg
         81HNmbX8+FvMu8KgarxwDTZ45C038kRMrmlLKDTQBXGBwPKySGaH3Y9XJBaMuX3PCSvu
         3/TnmqduXCPMT92EoWLr3OGh32DXQhxaULksolCFzdOMTofxEwHUCbcLTQmo8gtTqOgZ
         kdFQ==
X-Gm-Message-State: AOAM530y9B3lPd99S2Sj6Q2gpox0MQplhiCKcrphohQptHLAODGFaLin
        PbHsl6RjyGZm8nBMc2hTG7A/YV1mTxyJ5/T+K64U6Wf7nH4=
X-Google-Smtp-Source: ABdhPJwtoYlaNchgGSL/rX1wEgwFkjQbeXYEeDPxeB3sJCQFLMLk6OOfd80BRjiDOAzyXNhM9pUpVhDkkWhIFm6H1Pc=
X-Received: by 2002:ab0:14a7:: with SMTP id d36mr1322042uae.96.1637624364971;
 Mon, 22 Nov 2021 15:39:24 -0800 (PST)
MIME-Version: 1.0
References: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>
 <20211122222850.674-1-carenas@gmail.com> <xmqqa6hvbxob.fsf@gitster.g>
In-Reply-To: <xmqqa6hvbxob.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 22 Nov 2021 15:39:12 -0800
Message-ID: <CAPUEspgDafXHHPvzNijTsPsna76yE8W=JH-78LX3jyaieSmp0A@mail.gmail.com>
Subject: Re: [PATCH] editor: only save (and restore) the terminal if using a tty
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        thomas.wolf@paranor.ch, Alexander Veit <alexander.veit@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 3:03 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
>
> > If the editor is invoked without a controlling terminal, then
> > saving the state and restoring it later is not very useful and
> > could generate signals that the invoking process wouldn't know
> > how to handle.
> >
> > if git's standard output is not connected to a terminal, then
> > presume there is no need to worry if the invoking terminal could
> > garble it.
>
> Shouldn't the logic apply equally to all callers of save_term()?
>
> In other words, why aren't we doing this check inside save_term()
> implementation?  i.e. before opening /dev/tty, we can do isatty(1)
> and return -1 if it is false, or something?  That way, when we gain
> the second caller to save/restore other than editor (prehaps the
> pager code path wants to do this?  I dunno), we do not have to
> remember that isatty() check must be made before doing save_term(),
> no?

yes, my plan was to minimize the impact of this bugfix by doing this
as narrow as possible, but you are correct that if we consider that
the only caller for  save_term() is in editor.c then it would had make
more sense to put it there to begin with and with supportability in
mind for the future; but save_term() is also called internally, and so
the logic would also propagate to other places that use
compat/terminal.c (like our fallback version of getpass() or `git add
-p`).

I should have mentioned though that a better fix was forthcoming, just
not with so little time before 2.34.1 gets released.

> In any case, I am quite tempted to just revert the offending topic
> for now, but later accept a resurrection patch with this isatty
> check rolled in (either at this caller, or inside save_term) when
> the dust settles.

I indeed suggested[1] a revert but I wouldn't have proposed this
alternative if it wouldn't be done safely enough, agree though that
without a successful report that it fixes the problem by the reporter
(who has since moved[2] on to a different hack which was proposed by
Peff), a revert is always safer.

Carlo

[1] https://lore.kernel.org/git/xmqqilwjbyj4.fsf@gitster.g/T/#mad3fd4d0015e=
c939c1e0001444d5affd720d56b2
[2] https://git.eclipse.org/r/c/jgit/jgit/+/187938
