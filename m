Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B68C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 13:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B48920729
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 13:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XHzvdnTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHJNYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 09:24:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:60559 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbgHJNYK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 09:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597065845;
        bh=WNQufU1P+ltWgFcPRRGZACX/NM09ymPNPQePyV1KBoU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XHzvdnTAUubq/8LhEbGbYGWLKCZM04xLv7nin3TKizAFVYqosulArNhWBytGbETR3
         rVgUFUgl/zTkzKmAsnC0ssOVA6s2LC9M5yNnnANk264u6d/dQc3/5VvvCdexM6obgt
         fPJl//DCeu960iMsVTKtDmLPDv3oxJs4J/48BDG4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.90.36] ([213.196.212.215]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMGNC-1kOJ3j2A0k-00JFdQ; Mon, 10
 Aug 2020 15:24:05 +0200
Date:   Mon, 10 Aug 2020 15:24:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        kaartic.sivaraam@gmail.com, liu.denton@gmail.com,
        pc44800@gmail.com, stefanbeller@gmail.com
Subject: Re: [PATCH 4/4] submodule: port submodule subcommand 'summary' from
 shell to C
In-Reply-To: <20200715184153.GA52607@konoha>
Message-ID: <nycvar.QRO.7.76.6.2008101519090.50@tvgsbejvaqbjf.bet>
References: <20200715184153.GA52607@konoha>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zdxXxT5fa384rB62Ma3MeneypMmm/KgTX72bSIOs2Yli2zSbx09
 JdXWlhWTb8iznFxSENdOqqmiNqkG2p4XnwTZRxe3SGRoNQ43V6/bSpkcWC+Z/lOk16Vn+Ec
 dbMfUDgAbSULCbwaGrvntQZinXqMEUON3xnH3qJAlGq6Bc44fdI5XwFocAWyFkX32dtjqQm
 IWTTTvaElff0/2U777W1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:STNrt5dUiJo=:s5W/yJxnxhHCqQB+bCjs1h
 6WeeqVfwatwlEsIZG0NJMtaOHPxrNW48LaFEsG8CrOVHX8IZuLvA8K7RPrcUi2u1drtwy/9v+
 wk4NTkzIZg2EUhizb1yBJ9KA2fhr09v2knH8Ae4p4fAtVgfnhUvA6zjBEyVI8iZCSB+3O1rhY
 oLCS+KnLuE/DNlp3XILR3h9QqdvOYHryVmS/JayCpgDVUPrb9Np7utW5b2c3RyM1KetPwLPBl
 bZa5kcjCOHY23SO8/BHAjZTA4QLgQzkt2FPYvAN/M9hTRcadMInfiK1llX6oyOfC0cxGLrMPs
 h7avEjBwo4IGXzBL5kUB+m1ZaIeELgr6LgXw/8AUkL4GVM5a9jWSbSdQz/GayMfBxEzqzLHY5
 663ZKdwrekSptNwhS4c1CzjgVZkeolvZra9+hcLwxBRcD0h4+mKck8SwRSge8OIdQ53fL1m4g
 UOdBFAyfNg34mtoG8vsXwJdjuV8SVk769rUcqbEKO6DdAASDXNKyRQHf6WrcN2KX8FJEF9qd8
 +Dic1ehI5Mp5mg8kQLSsBKL7ASyjBnusKIkw/INsezOt6MS2C32E53uPT4ThaX3nNXdLleT0M
 gKz4nuSlk2UaxqISDq5gcQFsdliZDsPEsV3XnVmPGE8hLSM/4ZkY3FlHEnqZjq3BCTUrWZRKG
 yaflY2DgLwC2f3JbhvuPhIduHdFKqKKq0Gf4I/J3/SeguYJvBYUde1RHAEODyf3AUz5ADNXf3
 ui6aBRAmstWuuTLacauEWG8X/81y4Pav305j/YT2kmLA37YOQ+5B+fV2HfTcf8pkRLQdOVCrm
 zpIuzRAeEHo4RWQnd7j2tW1QGxbOJzxL07LDJ1w/e0gXVx+E7A69pfYRRrHrgWPBvb9sW3KLc
 e5fyumFtVRX1jPUa7CFjadrsYbpEGhQs7SsXQX9OibKunFi7xxCT2j7/0eAq9Q9mwB/Pgs4hP
 IEqpMAxzJtSC+pf0eLIbPqZzSU9Cc9X+omrx6X3zMHcOLbu6385DolObQ+KKUgeet4h1ELbi+
 LJEz+krIJiqPi5mrQT6lkIxZOmEqV4neZUKzfyepk5g6L2OpdMhHmN9p9ucgvH4FMEwGvcN/c
 0RqRsJnpbWQJUtoxW0a6yPTgTV5ZtYhLhmmqWXasvPKdoOnmAGgxm09DBmICUVuXXSB4xWAra
 ZItrwniixYEasSf0gGG0Z3jjyVz8ALex+sBK5NQ09mujraWifSp/x/6BvuIdbIq4Av0aeinoc
 sWu4bbKbV/dxWitM1KL+r19c93youB9szZeH2/g==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On Thu, 16 Jul 2020, Shourya Shukla wrote:

> BTW in your review of my patch,
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2007031712160.50@tvgsbejva=
qbjf.bet/
> you said this:
> --------------->8--------------
> > +			 */
> > +			struct child_process cp_rev_parse =3D CHILD_PROCESS_INIT;
> > +			struct strbuf sb_rev_parse =3D STRBUF_INIT;
> > +
> > +			cp_rev_parse.git_cmd =3D 1;
> > +			cp_rev_parse.no_stderr =3D 1;
> > +			cp_rev_parse.dir =3D p->sm_path;
> > +			prepare_submodule_repo_env(&cp_rev_parse.env_array);
> > +
> > +			argv_array_pushl(&cp_rev_parse.args, "rev-parse",
> > +					 "HEAD", NULL);
> > +			if (!capture_command(&cp_rev_parse, &sb_rev_parse, 0)) {
> > +				strbuf_strip_suffix(&sb_rev_parse, "\n");
> > +				get_oid_hex(sb_rev_parse.buf, &p->oid_dst);
> > +			}
> > +			strbuf_release(&sb_rev_parse);
> > +		} else if (S_ISLNK(p->mod_dst) || S_ISREG(p->mod_dst)) {
> > +			struct child_process cp_hash_object =3D CHILD_PROCESS_INIT;
> > +			struct strbuf sb_hash_object =3D STRBUF_INIT;
> > +
> > +			cp_hash_object.git_cmd =3D 1;
> > +			argv_array_pushl(&cp_hash_object.args, "hash-object",
> > +					 p->sm_path, NULL);
> > +			if (!capture_command(&cp_hash_object,
> > +					     &sb_hash_object, 0)) {
> > +				strbuf_strip_suffix(&sb_hash_object, "\n");
> > +				get_oid_hex(sb_hash_object.buf, &p->oid_dst);
> > +			}
> > +			strbuf_release(&sb_hash_object);
>
> It would probably be shorter, less error-prone, and quicker to use
> `index_fd()` directly.
> --------------->8--------------
>
> What exactly did you mean here and where should the index_fd() be used?

Well, `index_fd()` is the function that `git hash-object` uses to
calculate the hash of a given file (in this case, specified via the path
`p->sm_path`).

You could open an fd to that file directly, use `index_fd()` to calculate
the hash, and thereby avoid spawning another (totally unnecessary)
process.

Ciao,
Dscho
