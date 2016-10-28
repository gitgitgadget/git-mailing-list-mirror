Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F04102035F
	for <e@80x24.org>; Fri, 28 Oct 2016 22:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761633AbcJ1WQG (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 18:16:06 -0400
Received: from homie.mail.dreamhost.com ([208.97.132.208]:55632 "EHLO
        homiemail-a61.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1761338AbcJ1WQF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Oct 2016 18:16:05 -0400
Received: from homiemail-a61.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a61.g.dreamhost.com (Postfix) with ESMTP id 2258A5781B3;
        Fri, 28 Oct 2016 15:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        mattmccutchen.net; bh=nukY3ZadwEXOCim+0gTFZ2/HGCw=; b=dby5VUlOi4
        8r6C6+0WlvWsCz+khUsJGKveh8lVojR+wpl4g34sVMA6YkjZB5kUowqwCqTRvf7s
        TsdEfEC1Gl19sL0o8vNRD+M4nDL40arFrcO2f4tiZr3PPY0sfVi+nNhhQIb+Amxk
        Y4wpeTckLztynL6qjKgu/dbl+iO0yZfug=
Received: from main (30-9-219.wireless.csail.mit.edu [128.30.9.219])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a61.g.dreamhost.com (Postfix) with ESMTPSA id C57DB5781B4;
        Fri, 28 Oct 2016 15:16:04 -0700 (PDT)
Message-ID: <1477692961.2904.36.camel@mattmccutchen.net>
Subject: Re: Fetch/push lets a malicious server steal the targets of "have"
 lines
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Fri, 28 Oct 2016 18:16:01 -0400
In-Reply-To: <xmqqmvhoxhfp.fsf@gitster.mtv.corp.google.com>
References: <1477690790.2904.22.camel@mattmccutchen.net>
         <xmqqmvhoxhfp.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2016-10-28 at 15:00 -0700, Junio C Hamano wrote:
> Let me see if I understood your scenario correctly.
>=20
> Suppose we start from this history where 'O' are common, your victim
> has a 'Y' branch with two commits that are private to it, as well as
> a 'X' branch on which it has X1 that it previously obtained from the
> server.=C2=A0=C2=A0On the other hand, the server does not know about Y1=
 or Y2,
> and it added one commit X2 to the branch 'x' the victim is
> following:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0victi=
m=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0server
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0Y1---Y2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
/=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0---O---O---X1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0---O---O---X1---X2
>=20
> Then when victim wants to fetch 'x' from the server, it would say
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0have X1, have Y2, have Y1, have O
>=20
> and gets told to shut up by the server who heard enough.=C2=A0=C2=A0The
> histories on these two parties will then become like this:
>=20
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0victi=
m=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0server
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0Y1---Y2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
/=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0---O---O---X1---X2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0---O---O---X1---X2

Then the server generates a commit X3 that lists Y2 as a parent, even
though it doesn't have Y2, and advances 'x' to X3. =C2=A0The victim fetch=
es
'x':

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0victim =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0Y1---Y2---- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(Y2)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0---O---O---X1---X2---X3 =C2=A0 ---O---O---X1---X2=
---X3

Then the server rolls back 'x' to X2:

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0victim =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Y1---Y2----
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
=C2=A0=C2=A0=C2=A0=C2=A0---O---O---X1---X2---X3 =C2=A0 ---O---O---X1---X2

And the victim pushes:

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0victim =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Y1---Y2---- =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Y1---Y2----
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 / =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
=C2=A0=C2=A0=C2=A0=C2=A0---O---O---X1---X2---X3 =C2=A0 ---O---O---X1---X2=
---X3

Now the server has the content of Y2.

If the victim is fetching and pulling a whole "directory" of refs, e.g:

fetch: refs/heads/*:refs/remotes/server1/*
push: refs/heads/for-server1/*:refs/heads/*

then instead of generating a merge commit, the server can just generate
another ref 'xx' pointing to Y2, assuming it can entice the victim to
set up a corresponding local branch refs/heads/for-server1/xx and push
it back. =C2=A0Or if the victim is for some reason just mirroring back an=
d
forth:

fetch: refs/heads/*:refs/heads/for-server1/*
push: refs/heads/for-
server1/*:refs/heads/*

then it doesn't have to set up a local branch as separate step.

Matt
