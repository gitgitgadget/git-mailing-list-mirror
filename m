Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1FCC4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 21:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA1F9207DE
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 21:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ZMl6iA28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390265AbgJZVq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 17:46:58 -0400
Received: from mail-02.mail-europe.com ([51.89.119.103]:59340 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390251AbgJZVq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 17:46:58 -0400
Date:   Mon, 26 Oct 2020 21:46:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1603748814;
        bh=viyXrIFvIGmIXwHI5F0IbJ2y1YyaL68l116lAn05big=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=ZMl6iA28EVkIj9+04xJbXCcIKWplxJzfSIEOOIo+vPnpjreSusyqPMtEHEFxwN0dG
         nbkVB8uJGYlFPDw4ErOMEGrtMmrK8/JoAYvXGbiDY2Y0YEtbTQX0R/tDPsxCkSfR7K
         FF+10KI9gQrL676+sTz0wiqAIX5CwZGcl5HAdbsY=
To:     Junio C Hamano <gitster@pobox.com>
From:   Joey Salazar <jgsal@protonmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: Joey Salazar <jgsal@protonmail.com>
Subject: Re: [OUTREACHY][PATCH v2] t7006: Use test_path_is_* functions in test script
Message-ID: <Bgt8H4Cev0hu-OKtYHazhsRRIFO_6bAoBqdc4tep09T98tL426R9WXIAMjm7aO4b0uPrZGldPhZ1mV3f9pbS3PDN4bOlb9JkUvvXKtnUFHA=@protonmail.com>
In-Reply-To: <xmqqwnzcd6jf.fsf@gitster.c.googlers.com>
References: <KHJW7elqEfVsIp1V0WKPRVAB5xqCDJjjqLv8flthlDiSsSWjND-VVGG2zL-xOYMstk-q0JR3OiSggcMlFgzkIKm2podjzAyamb0pW-wx1ZY=@protonmail.com> <20201026205028.GC2645313@google.com> <xmqqwnzcd6jf.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you both for the comments and update, squashing both commits make sen=
se to me as well, yet I can incorporate the changes in a new patch (v3) if =
that would be preferred.

Thanks,
Joey

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Monday, October 26, 2020 3:24 PM, Junio C Hamano <gitster@pobox.com> wro=
te:

> Jonathan Nieder jrnieder@gmail.com writes:
>
> > Overall (as someone who's worked a bit with this test script before),
> > looks good to me. Thanks for your work.
> >
> > > -       ${if_local_config}test -e core.pager_used
> > >
> > >
> > >
> > > -       ${if_local_config}test_path_is_file core.pager_used
> > >
> > >
> >
> > This bit is a little subtle: ${if_local_config} is either '' or '! ',
> > and in the latter case the benefit of test_path_is_file printing a
> > message if and only if the result is false goes away.
> > Would the following, squashed in, make sense?
>
> Thanks for a great suggestion. The if_local_config thing was
> inherited and not a problem introduced by Joey, but it is a good
> idea to clean it up at the same time, I think.
>
> > Thanks,
> > Jonathan
> > diff --git i/t/t7006-pager.sh w/t/t7006-pager.sh
> > index fdb450e446a..11327944741 100755
> > --- i/t/t7006-pager.sh
> > +++ w/t/t7006-pager.sh
> > @@ -411,13 +411,13 @@ test_PAGER_overrides() {
> > }
> > test_core_pager_overrides() {
> >
> > -   if_local_config=3D
> >
> > -   pager_wanted=3Dtrue
> >     used_if_wanted=3D'overrides PAGER'
> >     test_core_pager "$@"
> >     }
> >
> >
> > test_local_config_ignored() {
> >
> > -   if_local_config=3D'! '
> >
> > -   pager_wanted=3D
> >     used_if_wanted=3D'is not used'
> >     test_core_pager "$@"
> >     }
> >     @@ -432,18 +432,23 @@ test_core_pager() {
> >     export PAGER &&
> >     test_config core.pager 'wc >core.pager_used' &&
> >     $full_command &&
> >
> >
> > -       ${if_local_config}test_path_is_file core.pager_used
> >
> >
> >
> > -       if test -n '$pager_wanted'
> >
> >
> > -       then
> >
> >
> > -       =09test_path_is_file core.pager_used
> >
> >
> > -       else
> >
> >
> > -       =09test_path_is_missing core.pager_used
> >
> >
> > -       fi
> >
> >
> >     "
> >     }
> >
> >
> > test_core_pager_subdir() {
> >
> > -   if_local_config=3D
> >
> > -   pager_wanted=3Dtrue
> >     used_if_wanted=3D'overrides PAGER'
> >     test_pager_subdir_helper "$@"
> >     }
> >
> >
> > test_no_local_config_subdir() {
> >
> > -   if_local_config=3D'! '
> >
> > -   pager_wanted=3D
> >     used_if_wanted=3D'is not used'
> >     test_pager_subdir_helper "$@"
> >     }
> >     @@ -464,7 +469,12 @@ test_pager_subdir_helper() {
> >     cd sub &&
> >     $full_command
> >     ) &&
> >
> >
> > -       ${if_local_config}test_path_is_file core.pager_used
> >
> >
> >
> > -       if test -n '$pager_wanted'
> >
> >
> > -       then
> >
> >
> > -       =09test_path_is_file core.pager_used
> >
> >
> > -       else
> >
> >
> > -       =09test_path_is_missing core.pager_used
> >
> >
> > -       fi
> >
> >
> >     "
> >     }
> >


