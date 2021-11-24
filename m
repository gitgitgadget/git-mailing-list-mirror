Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775D2C433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 13:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349658AbhKXNeY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 08:34:24 -0500
Received: from mout.gmx.net ([212.227.17.21]:56289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348773AbhKXNcs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 08:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637760572;
        bh=9kgxlBmWizZE/2KireOyUT7bzVL9vcz15FQYKAUlAT4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cJxlLoxipjMV9s5JNuuTjq3bbxQkLLlEYMSgO6Aaur3uAhq/isCoa20G1pIAgATJt
         namsyhDQJMWLFqQWOzYNkxjz6wnWuF0hCl+54slskaCiiItJTPDtXbsLPsuDP8ZEMQ
         705DIwLFbmetE/4Gh5yopS2y7q15HFJ/EjiF1F+Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1OXT-1melQe3pLX-012ngL; Wed, 24
 Nov 2021 14:29:32 +0100
Date:   Wed, 24 Nov 2021 14:29:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        phillip.wood123@gmail.com, thomas.wolf@paranor.ch,
        Alexander Veit <alexander.veit@gmx.net>
Subject: Re: [PATCH] editor: only save (and restore) the terminal if using
 a tty
In-Reply-To: <xmqqtug293ml.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111241428190.63@tvgsbejvaqbjf.bet>
References: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>        <20211122222850.674-1-carenas@gmail.com> <xmqqa6hvbxob.fsf@gitster.g>        <CAPUEspgDafXHHPvzNijTsPsna76yE8W=JH-78LX3jyaieSmp0A@mail.gmail.com> <xmqqtug293ml.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FdkKbLd0MVx+hK/p6vvMdulWHVYhXNn+bQsr0y7OJBbyOevf8Nm
 65dt0nxnaT8/Y3LnoIWuOLXAxVK4vpx312ItGSWTPYBeR8E0xttaXZzORmdjQDjzr3r6s2n
 qhSlT63d4VTUb0pVyGCkHqVDJ79fQ1xEsDrWyKr6tCVeWc4uvcBzD19PtBygCpE15QUlMpY
 rAfOyeGagpz8Q2aBE8Q6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lgiyWETrfPk=:/QZmLGGsAKMW8xu2FKCp4L
 8sBmqrHJfMdd+72DKdeCx57Mw2iwkrfft8CtY6+bjd3M5/w8PXzKCCsR3hsisQin21rcUy4iP
 lg74JEYFb3wklKCOLddK92HCluO1CKLeNgTmZ+7kfpJ5H2XGYNScdmYCRRCV5vPKo7gG64zuM
 rUaBD0mpms4Z+8o9uH0L9mRTSG9CejVPkWyyuQDlcdFg2kPrlMV6rmvreD7mzxxsWtxOYXwgZ
 3FIFD+uTA40EJoNGywWtFoGE73dhzOeAse8OVpRDpDUlOmOhJnatJ7/6hXfM0krvtqGwKihYL
 WrzHYYSosVWWdGln7K5ycl7IN5EupBUuzFmWSHUk6gJM38tHtS/FM5WAqYgONG6cmiPhhNQox
 iB3eEJPTG+cGDmFkqppsITU1bRWepAz3x6uJ1MOhSS4HPt5/cLEB6HIV9LryEM0t/CX5XVgO0
 QdpMe+ZBbRSXwvTOPTFNHyv05SthPB7Guh3g2fjywRjOE8iD6DZCdpkyVzRWUnv6Vrir+dZdr
 IHrltXIdB3350OiCbXkweSoDnh556CJYQHpLYmaEnw9s/ps/stdldYaiXpagdJ3PaptNabeKP
 EL3ogO14VWx0yJ8+AJmL/zYwFH0Y8JzJ+U3PaZk8fvrggACqPXLl1Qsbe8B/zNvhxiIdsauQf
 96srOtqbAJGWm5ktJaoQU2sM0kXCufCasS/lwEMTiteVrj4BHoFefmr0k6aRHoEqQhhJmLnNl
 SXMTBjnErs12nvFsg1w6HvySbOcC+N2pXkE5iIn/qs8c2yk2POpFjW9511450XlQQQn3CjH1X
 gQbj6oT57NP7cx8uPS+ye3Wkyrd7v71Nw6UkBOYrITGatLsITlnnXcdmUp4yEXlUrx0/OwOqV
 2mhgZ6n/iGg6W30v/xeviGU4ZMPwH/GEwbT5lbePn9nWXkhayPYh6ysCQeURLpo7zeScc+mBB
 aLqDTeYI6TLnrNE+IsLuu0oCKX0VR4mQM5dDOZiKfrov+Y7aYWkwxGujZsGY2pzEFjW8YfMBh
 w+aB/xP11oHISjoyaasSWfTbyXOFVsShWI3zYWL9VShBoa65/ETWavDiLrwlyv+zSb5Y1EW6j
 07V3vgEB4u5gIA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 23 Nov 2021, Junio C Hamano wrote:

> Carlo Arenas <carenas@gmail.com> writes:
>
> > yes, my plan was to minimize the impact of this bugfix by doing this
> > as narrow as possible, but you are correct that if we consider that
> > ...
> > I should have mentioned though that a better fix was forthcoming, just
> > not with so little time before 2.34.1 gets released.
> > ...
> >> In any case, I am quite tempted to just revert the offending topic
> >> for now, but later accept a resurrection patch with this isatty
> >> check rolled in (either at this caller, or inside save_term) when
> >> the dust settles.
> >
> > I indeed suggested[1] a revert but I wouldn't have proposed this
> > alternative if it wouldn't be done safely enough,
>
> I think the minimum impact fix is to revert the whole thing (people
> survived without it for long time), so that is what 2.34.1 will
> hopefully have.  As I said elsewhere, I am open to a rebooted effort
> for the future cycles, but the conclusion for the topic in 2.34 series
> is that we pretend we never heard about it ;-)

Maybe a better approach would be to hide the `save_term()` dance behind a
new config option, and then have it turned on automatically if the
`editor` _happens_ to be `vi` or `vim`.

That would help the problem reported in the Windows Terminal project.

Ciao,
Dscho
