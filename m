Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96551C2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 21:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D116206CB
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 21:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="l3wAHNRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfLZVXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 16:23:49 -0500
Received: from mout.gmx.net ([212.227.17.21]:49039 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfLZVXs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 16:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577395423;
        bh=kyZz5mZ3B2XZ6aRGv+ddpY21Vr4racyi780qABkuMDA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=l3wAHNRzihi9Y+BuiOiB2gFvizD89rx12G5KZnDKBh32ayYgim/pBMEl3ke0Utw6H
         4Tb9IaZ/eTmHL4dBIpCOPBGH46MggTJM1f61zSA1Va2tBre/+qe8Ue3tG8RJj6lIGz
         s+dtRIav0V9NJm/X3ufCjRMc72b9nXBBf8VFy3CQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.lan ([136.243.159.11]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6sit-1jq9j61QAp-018HQy; Thu, 26
 Dec 2019 22:23:43 +0100
Date:   Thu, 26 Dec 2019 22:23:26 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] mingw: only test index entries for backslashes, not
 tree entries
In-Reply-To: <20191226200316.GD170890@google.com>
Message-ID: <nycvar.QRO.7.76.6.1912262221000.46@tvgsbejvaqbjf.bet>
References: <pull.682.git.git.1577382151.gitgitgadget@gmail.com> <4a120fd0b32d2d6492eac6b0494ad6b1bc2ba500.1577382151.git.gitgitgadget@gmail.com> <20191226200316.GD170890@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2LOOjIyGfEx9nEEcaX0WKbmyu1K4YFpIRvAAMKxk5P4h5vadapv
 1GAw7EGH5ne+3c29qsYbBtxxzzExt8hMy2tpDE8bP8B3N3z13GEMobsS3fr/qo3N3FrfhZ8
 i9ux2h5Nf5C5+yGM5GREKOQ0B8l9jIzbxa7ZPnaQ+tU1cIJoAacNtybt2jBmh7NOW8qmm+4
 nLme1gCRq5CPELimlWo3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l8cqVjKD/qE=:jlKZTssatKkWrjSZtY0acl
 3ftT3F+Zgg8Sg4OTLGL1JNFBiyu47Mdyd4Wzd5aXJ1C7SqhVbF0xZPXAcP+BmcRXNuhEXv40Z
 ECo8XsNhqTLnPihEcmb0vWD3o8rk0oX1qkHvkmEY4S5QP6gYJ6jZcxLM1ofoTKd7cooSoxdZZ
 iwvawk41nBGVIl2mYWwRDBOTLbaxjgyKy2zwyNQzTzEc1zB3CgSfU0qivHc/wziNFNLeg0ov6
 RzJk1BevXKD4Xegd2btzB4KHXtgY7sgyLIZoeGFsz9j1gymubEOUB4/RW1Xp4s9buRyTtgb/N
 RDPfKFI+hg2PzhhR6X56bSB+6nIXulyZ56UZRCwRyMz1Kkjf5uwTh1vyswZXvbbT80uiK0vZe
 P7DhODDUgW8wcF2uL84pqmbd0W4rQ/tEorMkjeWLuNzTOO5pzz3INp3qNsW9Mnbh2pffot9ui
 tXhxiwMFLxbAJU+eaR0HXpfhub6CfRjzlAxE6YyGeQQXcdGqIK92P351zoe7tCYWhtE+QHxHv
 c+ZQOADPCm70JAbnxd3Js+/NMvFDXvFlgo8uB2sBp1YD4nkXvl29SaeI21I/YOvKm4bZp2H3y
 zrS7bt1klPwmOsn7SAfpydypdEaBMvXWn7K6UBWf9DvYQUSNOs+pDBhQNveDgvxhZ+5xGpdSe
 RWXXpRk7Fvhj/VUMdsVsbQ6ZFNy7z9dEd9LMxT6/yofGjfBY1Io9hzKEsVSNv1HyEQCjBvae0
 IQS5UlrKR98uDmH21t4JwoQmiRmX2HQNT8QvdDFFZMYOHCe/DA+ufEYIM9UT0gwgPZB9+5wTs
 ZlQl3dn6iWpTSosUCLZoIMxOI7h7YL8QGqUXC/0+Cg/tswiHOOKx37SJ/7kQIxPPehbIKCZ+b
 vBnjrWqgoIM3h7rKZdzm9DnDYLTOLohs6oUs63ur4OAf83PihFV2T7g9pSKVK5LJuIxkn8ZpO
 i3Nlb7f8bM+FhqGiSXPPmetEMWgvWtKNZ0jRn14FTOMDpVhNm05GSyD/ZrbH1aXRnRXtBhoPu
 0klqagOsh+yCDslktDwQud5MkG1/JWI3CDMJa9eOqkfMJmzAGUkaGidynZd/G7Ig4H318zFfX
 xUMkrwbK0QZlykef7UdwPtBakgqy8T/x+e4rWBTqFLcMnugYFpy7WRKyzyBfHrwcHfWfFxzyR
 mV2/DqL1dt9PfDMg1hwyVIa1P7mHjVa2Odr+YSVSKI3VSoHXwdIYffvO/kPiKAioPR2ElFUQy
 0PhE4RrPA6feO/CQyxVOWMaHx9HzZNIO5nNSv2+5zi+TR2zLZJY5YqfJmCj4=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Thu, 26 Dec 2019, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
>
> > During a clone of a repository that contained a file with a backslash =
in
> > its name in the past, as of v2.24.1(2), Git for Windows prints errors
> > like this:
> >
> > 	error: filename in tree entry contains backslash: '\'
> >
> > While the clone still succeeds, a similar error prevents the equivalen=
t
> > `git fetch` operation, which is inconsistent.
> >
> > Arguably, this is the wrong layer for that error, anyway: As long as t=
he
> > user never checks out the files whose names contain backslashes, there
> > should not be any problem in the first place.
>
> Hm.  The choice of right layer depends on what repositories in the wild
> contain.  If there are none containing filenames with '\', then fsck et
> al would be an appropriate layer for this.  With hindsight, it was not
> a good idea to support this kind of filename.
>
> However, between the lines of this commit messages I sense that there
> *are* repositories in the wild using these kinds of filenames.
>
> Can you say more about that?  What repositories are affected?  Do they
> contain such filenames at HEAD or only in their history?  If someone
> wants to check out a revision with such filenames, what should happen?

Yes: https://github.com/zephyrproject-rtos/civetweb contains history where
at some stage, by mistake, a directory was called `\`. It has been fixed a
long time ago, but users obviously still want to be able to clone it ;-)

> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -1278,6 +1278,11 @@ static int add_index_entry_with_check(struct in=
dex_state *istate, struct cache_e
> >  	int skip_df_check =3D option & ADD_CACHE_SKIP_DFCHECK;
> >  	int new_only =3D option & ADD_CACHE_NEW_ONLY;
> >
> > +#ifdef GIT_WINDOWS_NATIVE
> > +	if (protect_ntfs && strchr(ce->name, '\\'))
> > +		return error(_("filename in tree entry contains backslash: '%s'"), =
ce->name);
> > +#endif
> > +
>
> Why is this specific to the GIT_WINDOWS_NATIVE case?  Wouldn't it affect
> ntfs usage on other platforms as well?
>
> [...]
> > --- a/tree-walk.c
> > +++ b/tree-walk.c
> > @@ -43,12 +43,6 @@ static int decode_tree_entry(struct tree_desc *desc=
, const char *buf, unsigned l
> >  		strbuf_addstr(err, _("empty filename in tree entry"));
> >  		return -1;
> >  	}
> > -#ifdef GIT_WINDOWS_NATIVE
> > -	if (protect_ntfs && strchr(path, '\\')) {
> > -		strbuf_addf(err, _("filename in tree entry contains backslash: '%s'=
"), path);
> > -		return -1;
> > -	}
> > -#endif
>
> Ah, it's inherited from there, so orthogonal to this patch.
>
> To summarize: I think the commit message and docs could use some work
> to describe what invariants we're trying to maintain and what
> real-world usage motivates them.

I added this paragraph to the commit message:

    Note: just as before, the check is guarded by `core.protectNTFS` (to
    allow overriding the check by toggling that config setting), and it
    is _only_ performed on Windows, as the backslash is not a directory
    separator elsewhere, even when writing to NTFS-formatted volumes.

Does that clarify the issue enough?
Dscho

>
> Thanks and hope that helps,
> Jonathan
>
>
