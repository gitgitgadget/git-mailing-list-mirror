Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364F9C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 19:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0644420733
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 19:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ze7SvG9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfLQTca (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:32:30 -0500
Received: from mout.gmx.net ([212.227.15.18]:38383 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfLQTca (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 14:32:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576611140;
        bh=L550bGDv1YyLKszE29L6Ozl+0S6QqkwB0u8CGpAekO4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ze7SvG9wTaTwA7hZCZD61gxdeTvB/i7k27vo2fHW0WL6/QC1IWGVbr91sQEvaSQ8r
         DmQdfgwx0+dQxUS6DcGgDF0YN6fFwFhejcKXKETGQERZKiY3F5Yk2kUBv9SEWyP6D+
         i+x8+tLcUoSlFtNO6LNeS4Rr7TANwhnDVy9I6U80=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpDNl-1huBb92H6N-00qlHx; Tue, 17
 Dec 2019 20:32:20 +0100
Date:   Tue, 17 Dec 2019 20:32:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, blees@dcon.de,
        Kyle Meyer <kyle@kyleam.com>, Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [PATCH v2 6/8] dir: fix checks on common prefix directory
In-Reply-To: <xmqqk16uj1qa.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912172031490.46@tvgsbejvaqbjf.bet>
References: <pull.676.git.git.1575924465.gitgitgadget@gmail.com> <pull.676.v2.git.git.1576008027.gitgitgadget@gmail.com> <9839aca00a10b16d96c47db631ac025281ffc864.1576008027.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1912151126030.46@tvgsbejvaqbjf.bet>
 <CABPp-BE04=A9wx1VfWsghn6scy8aaVFoENxV6YiW2AxgM2jhjQ@mail.gmail.com> <CABPp-BGoC_D6LzzMNyf30wFssTU2WA1kTLmFvJ2Do+Tfg4+YQA@mail.gmail.com> <nycvar.QRO.7.76.6.1912170101230.46@tvgsbejvaqbjf.bet> <xmqqr213iz9z.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1912171157140.46@tvgsbejvaqbjf.bet> <xmqqk16uj1qa.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CL/Zr+WhdR4H1z0T0Kqr8pSla8HhjlfxvCgr+Yjdk8QVbQcVmoC
 nSH4iC9tDtno+FkcOyATUROIGCrttyJisXCw0NIpEV5LwonsMS4BQAPmXubcH9E/ZsHfsrl
 euLpMJ8ZsF7kwzyCc7Tc9a4fHO+rxQdOOlHEtKSKYg0MxYZEQMNxwHmvxJRSzkYVtAlE25T
 HToQRvPLMsL2QRb7BcvNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CiXiZykerPE=:ht0sWM7hNnWMNDVcIon17J
 tifihJcXplk5uNZZ49uKWAN+NXUlGcn3jpBpmhftHiLEE3u2o6heLg8MvOyLtnMucZEbiQ8zy
 YYN0ZxPcwlt4SgV5f2N5cbHtfXUqQlq9goYsDzCEdYeYOKL6yTmF8G4tJB1ELhM+ZffYqI/fu
 vA2pbq5W4sYhcv1Kf5P8gZ5decPOBI6SQ49f0v/iX1WOTUxngLciDNQ0G/DyUCuk1uMmFvJuJ
 FZiHydXeHIY1oY3JRKG1rgLTwsKG4PpKyqu67FnOUfvjBLHHtibO8DjRf7mYcAucjxSQwrsNV
 Uuku5aCmPuqukI29tnEjYC5r6eL/LPirW4EzNcUzt9a3a9MtTmuBL6pySpxbBmj4njRlsSsBT
 P0ZSme7rigCBO/6QV+pOohxMKggrwG2kNEmfQcWeeTETm4qwkK8nSfVsIgnFgRxcwtwhQIy9S
 IaMd+FUW53RKa6wDWOPWeWFjWEYgb20EeSyXHg4IXKiONtI3cd/p5Qu+xTR6nAqKpzp4ApKCd
 NHqg6B2x/ENoSuM+twlqot+wKTgcFGzaui5ZZmgNcDvTEH1NsGJAOJqfzxC+4K663uc5w9aNm
 KkksWD/DJ0kT0nIL1nHJksWpCM8UdhqX1r9lwU2TGP+jGOxLpWtcADm/iLQijgm09CyuXdMgx
 J1MKeyiHaVK4yXQlh1yXXrIs/JeD+gMmTm+JQ/ZZQkDCUzkYTc7QnVqHPlPXLKHUHI58dDJsW
 E4E3QZHZHktn7gXZH6NQ4UkAiSRcHmg99hya3X9VR1fTLqvHwyNrrlv7IdRoTFkyR6seXzdt7
 oaQOxf25ytSjstpDaoPZ+rQZX1UrVqBqP9qjzTRu/oSJKzTKE0oNX8YS3stwqkUuY91O7QgUq
 N7wqwFnWrjnHtPv+oeKM/xYr0khjITVq4MRnMo47du9bv0qlTqVStQrf29NJnsZ2VJB4ee0d8
 /xa6yWL6mQpCcoiBu5WJw9gdzAtGuOtiYn+bwNKce3PQ5bYcMqStzoR9ptinqPKjzANHb4Ud2
 emyUvq1+jXyiOc6medtVUh6GupeOcqE1Kf/Qg7xpp458HOsS2466EVmd+ycPgSdPcpE7II40Y
 G/mZZHeMjqUPVaR2XZzYfrhwC2E9C8ZohopPHqxiM3P2d7BGrGSA/G5HbP1rVAxXqXSATfsJX
 DIpN+7Cn4aPTGt5qojjdlv+Q1gpmQXP5fmzD3rGk9x4JVViY66gzvn9NN11rg9CQLiuGkeOWs
 MV9ekhnVHPeC/uxVJRI1mKq9sea4WiJ2234e0oFBR56DTYFoVhkHzbOuCC5U=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 17 Dec 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> > [XSI][Option Start]
> >> > ino_t  d_ino       File serial number.
> >> > [Option End]
> >> > char   d_name[]    Filename string of entry.
> >> >
> >> > You will notice that not even `d_type` is guaranteed.
> >>
> >> I am reasonably sure that the code (without Elijah's patches anyway)
> >> takes the possibility of missing d_type into account already.
> >>
> >> Doesn't the above mean d_name[] has to be an in-place array of some
> >> size (i.e. even a flex-array is OK)?  It does not look to me that it
> >> allows for it to be a pointer pointing at elsewhere (possibly on
> >> heap), which may be asking for trouble.
> >
> > You are right, of course.
> >
> > ...
> >
> > Is this compliant with POSIX? I guess not. Does it work? Yes, it does.
>
> I actually would not throw it into "it works" category.  The obvious
> implication is that a program like this:
>
> 	static struct dirent *fabricate(const char *name)
> 	{
>         	/* over-allocate as we do not know how long the	d_name[] is */
> 		struct dirent *ent =3D calloc(1, sizeof(*ent) + strlen(name) + 1);
> 		strcpy(ent->d_name, name);
> 		return ent;
> 	}
>
> 	static void show_name(const struct dirent *ent)
> 	{
> 		printf("%s\n", ent->d_name);
> 	}
>
> 	int main(int ac, char **av)
> 	{
> 		struct dirent *mine =3D fabricate("mine");
>                 show_name(mine);
> 		free(mine);
> 		return 0;
> 	}
>
> would be broken if you do not have d_name as an array.
>
> I would not be surprised if the segfaults you saw with Elijah's
> series all were caused by your d_name not being an array, and if
> that is the case, I'd rather see it fixed on your end than fixes
> withdrawn.

I agree with this reasoning.

Ciao,
Dscho
