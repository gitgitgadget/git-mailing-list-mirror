Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08CE920A78
	for <e@80x24.org>; Wed,  1 Feb 2017 23:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbdBAXYJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 18:24:09 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:33427 "EHLO
        homiemail-a7.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750925AbdBAXYJ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Feb 2017 18:24:09 -0500
Received: from homiemail-a7.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a7.g.dreamhost.com (Postfix) with ESMTP id 7300225C063;
        Wed,  1 Feb 2017 15:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:cc:in-reply-to:references
        :content-type:date:mime-version:content-transfer-encoding; s=
        mattmccutchen.net; bh=2kiIHZyMIGoA3HRZwHPK5d3Xjh0=; b=LFvstkcX73
        rqzOCUNHQoEkkWmuUCUslZFC6Jd/QCIdnp7YyTa8ZjTNSkmfi8iGW1IMUkg4k+Ke
        6pz66uGOrAZsadnabDq5bXm07ChK8/vgXvEuNeTMOmNaRYO14dLfGq2c9FxTmSEA
        BPK7ykQ6bJ486UgCXKojo5igd9a9het3s=
Received: from main (30-9-60.wireless.csail.mit.edu [128.30.9.60])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a7.g.dreamhost.com (Postfix) with ESMTPSA id 23B1A25C062;
        Wed,  1 Feb 2017 15:24:08 -0800 (PST)
Message-ID: <1485991441.28767.2.camel@mattmccutchen.net>
Subject: Re: [PATCH] merge-recursive: make "CONFLICT (rename/delete)"
 message show both paths
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
In-Reply-To: <xmqqh94dockc.fsf@gitster.mtv.corp.google.com>
References: <1485636764.2482.2.camel@mattmccutchen.net>
         <xmqqvaswrv5q.fsf@gitster.mtv.corp.google.com>
         <xmqqh94dockc.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 01 Feb 2017 18:24:01 -0500
Mime-Version: 1.0
X-Mailer: Evolution 3.22.4 (3.22.4-2.fc25) 
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-02-01 at 12:56 -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Matt McCutchen <matt@mattmccutchen.net> writes:
> > ...
> > > Please check that my refactoring is indeed correct!=C2=A0=C2=A0All =
the
> > > existing tests pass
> > > for me, but the existing test coverage of these conflict messages
> > > looks poor.
> >=20
> > This unfortunately is doing a bit too many things at once from that
> > point of view.=C2=A0=C2=A0I need to reserve a solid quiet 20-minutes =
without
> > distraction to check it, which I am hoping to do tonight.
>=20
> Let me make sure if I understood your changes correctly:
>=20
> =C2=A0* conflict_rename_delete() knew which one is renamed and which on=
e
> =C2=A0=C2=A0=C2=A0is deleted (even though the deleted one was called "o=
ther"), but
> =C2=A0=C2=A0=C2=A0because in the original code handle_change_delete() w=
ants to
> =C2=A0=C2=A0=C2=A0always see tree A first and then tree B in its parame=
ter list,
> =C2=A0=C2=A0=C2=A0the original code swapped a/b before calling it.=C2=A0=
=C2=A0In the original
> =C2=A0=C2=A0=C2=A0code, handle_change_delete() needed to figure out whi=
ch one is
> =C2=A0=C2=A0=C2=A0the deleted one by looking at a_oid or b_oid.
>=20
> =C2=A0* In the updated code, the knowledge of which branch survives and
> =C2=A0=C2=A0=C2=A0which branch is deleted is passed from the caller to
> =C2=A0=C2=A0=C2=A0handle_change_delete(), which no longer needs to figu=
re out by
> =C2=A0=C2=A0=C2=A0looking at a_oid/b_oid.=C2=A0=C2=A0The updated API on=
ly passes the oid for
> =C2=A0=C2=A0=C2=A0surviving branch (as deleted one would have been 0{40=
} anyway).
>=20
> =C2=A0* In the updated code, handle_change_delete() is told the names o=
f
> =C2=A0=C2=A0=C2=A0both branches (the one that survives and the other th=
at was
> =C2=A0=C2=A0=C2=A0deleted).=C2=A0=C2=A0It no longer has to switch betwe=
en o->branch[12]
> =C2=A0=C2=A0=C2=A0depending on the NULLness of a_oid/b_oid; it knows bo=
th names and
> =C2=A0=C2=A0=C2=A0which one is which.
>=20
> =C2=A0* handle_modify_delete() also calls handle_change_delete().=C2=A0=
=C2=A0Unlike
> =C2=A0=C2=A0=C2=A0conflict_rename_delete(), it is not told by its calle=
r which
> =C2=A0=C2=A0=C2=A0branch keeps the path and which branch deletes the pa=
th, and
> =C2=A0=C2=A0=C2=A0instead relies on handle_change_delete() to figure it=
 out.
> =C2=A0=C2=A0=C2=A0Because of the above change to the API, now it needs =
to sort it
> =C2=A0=C2=A0=C2=A0out before calling handle_change_delete().
>=20
> It all makes sense to me.=C2=A0=C2=A0
>=20
> The single call to update_file() that appears near the end of
> handle_change_delete() in the updated code corresponds to calls to
> the same function in 3 among 4 codepaths in the function in the
> original code.=C2=A0=C2=A0It is a bit tricky to reason about, though.
>=20
> In the original code, update_file() was omitted when we didn't have
> to come up with a unique alternate filename and the one that is left
> is a_oid (i.e. our side).=C2=A0=C2=A0The way to tell if we did not come=
 up
> with a unique alternate filename used to be to see the "renamed"
> variable but now it is the NULL-ness of "alt_path".

"alt_path" is the same variable that used to be "renamed".  I just
renamed it to be less confusing.

> And the way to
> tell if the side that is left is ours, we check to see o->branch1
> is the change_branch, not delete_branch.
>=20
> So the condition to guard the call to update_file() also looks
> correct to me.

All of the above matches my understanding.  Would it have saved you
time if I had included some of this explanation in the patch "cover
letter"?

Matt

