Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F0DC33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 21:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B11B2072E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 21:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hA1Bngnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgAQVbf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:31:35 -0500
Received: from mout.gmx.net ([212.227.17.20]:45905 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgAQVbe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 16:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579296678;
        bh=Avt7AtBmyUi+okHM9zSO2BVsIHcPB0udWLo+Gyu7uxs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hA1BngnmYewTz296IQluxpN+2XY+aHoqcNJiReD/0pbk1kjW6abXjOplGbK3CGxlA
         dvB4cPN0jkA17M838j2pIq8ezJn4M276b3d6bbGgIEcBpkHMWBfFwOdS4di6JaYAUj
         CJKIpF6wTjIFqDokd5Mha+znR+ZKKZi3qgMdsRT4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFKKX-1iqdGZ2A4f-00FmuY; Fri, 17
 Jan 2020 22:31:18 +0100
Date:   Fri, 17 Jan 2020 22:31:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] rebase -i: re-fix short SHA-1 collision
In-Reply-To: <xmqqimladjh3.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2001172229300.46@tvgsbejvaqbjf.bet>
References: <pull.529.git.1579209506.gitgitgadget@gmail.com>        <ad50cd1b92e3e52309536f3a84064571a224a0da.1579209506.git.gitgitgadget@gmail.com> <xmqqimladjh3.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1YUwipu2aiJghu838C9PnLSDhgpVeaeyISDPzXX+8+fvomMYula
 JER59uU5SV4XTNlMsJNCONuWFYCMe3kpbflAyTlGZAQgIXgwJgVdQLWu6mlI0hBnPkEZ2jp
 7prCqsGAc/JvJvVV7K9dbYE4OuAWwYF9+JxWWlu8FoT9CFkTqU1DxsB8HOX/hty/n66RG/C
 B9Fl8xrKOTXOGHnPHe9Lw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JbiHbuNmLPg=:8uMryyc1zu6Wis9Wi5sqwQ
 5gKalq42Qs6EAj56nRP8e/9iE2AXaU7axuZQ/HFd7p/+1q2BAAlm3BNxNyHA9G8jWI/azc2XM
 sHyVFeTpwXYB2uoY3qzW4Flp/1En3ZVCn9mVFnkef85H1ELpyIar/nmUt72FOsT22/onf9UNP
 SxHM5uzYQdNCpBV/9DQHhxk1Hde22f7DLRDNS3+PG2/oc+QgoiQgxNviQ9rWttvsNAU9b4Nkl
 JqWydu7ZUB9onbQtYXWJNUJeXfItWfergduBHKtb0W6uiCwtUiVYQe5xspQSCqPMnGOdBm+Nk
 FOKMlJVYnWJ39NfqkMzV71/qKmTOe/VtgNYNZE45ATJQ8d3Owq0GEg22jGvSnTJ6TXNysK9Vl
 hwl5kO947xI8dJpA71O/SnVl2v4Rbsi/PjKP7Y4gq34+ObNO95App2UP8D9pCzu88wOsxBpr7
 L5FuhH7V9gnHzPY565t1VeFDqvqegjLkNgpY3Tzs6ifOvlqWhuq3uAbxVrint8IskLqSNonnE
 +/HxvRu+DbVJ08MfW3Qp4ZkfwRC3kJPLI+nxCV/aVoJBpfABqsCXyDri9/s5dnTeID6Wlb2Un
 3oBgOpL57lbn5VOr+qhSOubfGplsy77VYsRQ4n4Wdnn91fUaLmkpdasvrJ2pxFPCU19PruZ0E
 Uo0vqYS6foHzJuiGp6GXAsxWYNAhx0eRjaOEVEQY2oPDmhAJNNF2XDkVIj31GZstMi3+48Ze3
 0rO9WC9yQhgpNO6Lv9SD7XK62KwhGwuSIsnDM1MjuECPsa/vPKsJ0Iq/nCp6CM3I79+6M30EK
 sxGFVC4RYwYU8x1c5M7ZCKAXbCjpLGKvxIeVkW5oe6enDuSp3+NTtissGWkgMaNnS/FPw6kST
 j1d6CUlJGJfeEHfv6MehgGZUbxV8mh+/cykT7ihx65BNS0hgyZb/aL8BWTTIYWUjyhLkHB1GD
 B80CQf185zgrK/pdlGJKhYeDrwut5v46GmqSdKHBC7o6U0RuLxRB70TpqYJ3q289mXf5FEz1X
 s/fKX1ui934LEdExwN31gAhbng1gtxdASvIXCGt1br6sD+GH7oEs5Fu7dfX4Iz01VodKnavJq
 F717TGBE8hUhhRFBChXsPNTurxlZs6PHXbu7fYjKq6nDqZeohsYYxrf6g9IhNFvy8UwQwSczD
 W9ULCXNZhTlufjiZW9yhmy3SW3Tgu7Gp3TE8mUGgQpREP2DPLCrJn9R4RQ/D7aNTIWTO/T3Am
 WUgGxrEJRUoFa+aYeQNOjxWmq9ls0wcCsDjAT6b+ncbG6Bhafp5rfLhZ5BUc=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 17 Jan 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > +	/* Expand the commit IDs */
> > +	todo_list_to_strbuf(r, &new_todo, &buf2, -1, 0);
> > +	strbuf_swap(&new_todo.buf, &buf2);
> > +	strbuf_release(&buf2);
> > +	new_todo.total_nr -=3D new_todo.nr;
> > +	if (todo_list_parse_insn_buffer(r, new_todo.buf.buf, &new_todo) < 0)=
 {
> > +		fprintf(stderr, _(edit_todo_list_advice));
> > +		checkout_onto(r, opts, onto_name, &onto->object.oid, orig_head);
> > +		todo_list_release(&new_todo);
> > +		return error(_("invalid todo list after expanding IDs"));
> > +	}
>
> The above happens after edit_todo_list() returns and then the
> resulting data (i.e. new_todo) that came from the on-disk file has
> been parsed with an existing call to todo_lsit_parse_insn_buffer()?
>
> I am wondering when this if() statement would trigger, iow, under
> what condition the result of "Expand the commit IDs" operation fails
> to be parsed correctly, and what the user can do to remedy it.

You're right, this is defensive code to guard against bugs, but the error
message suggests that it might be a user error: it isn't.

> Especially given that incoming new_todo has passed the existing
> parse and check without hitting "return -1" we see above in the
> context, I am not sure if there is anything, other than any
> potential glitch in the added code above, that can cause this second
> parse_insn_buffer() to fail.  Shouldn't the body of if() be simply a
> BUG()?

It should.

Will fix,
Dscho

> Or am I somehow missing a hunk that removes an existing call to
> parse&check?
>
> > diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactiv=
e.sh
> > index ae6e55ce79..1cc9f36bc7 100755
> > --- a/t/t3404-rebase-interactive.sh
> > +++ b/t/t3404-rebase-interactive.sh
> > @@ -1264,13 +1264,24 @@ test_expect_success SHA1 'short SHA-1 setup' '
> >  test_expect_success SHA1 'short SHA-1 collide' '
> >  	test_when_finished "reset_rebase && git checkout master" &&
> >  	git checkout collide &&
> > +	colliding_sha1=3D6bcda37 &&
> > +	test $colliding_sha1 =3D "$(git rev-parse HEAD | cut -c 1-7)" &&
> >  	(
> >  		unset test_tick &&
> >  		test_tick &&
> >  		set_fake_editor &&
> >  		FAKE_COMMIT_MESSAGE=3D"collide2 ac4f2ee" \
> > -		FAKE_LINES=3D"reword 1 2" git rebase -i HEAD~2
> > -	)
> > +		FAKE_LINES=3D"reword 1 break 2" git rebase -i HEAD~2 &&
> > +		test $colliding_sha1 =3D "$(git rev-parse HEAD | cut -c 1-7)" &&
> > +		grep "^pick $colliding_sha1 " \
> > +			.git/rebase-merge/git-rebase-todo.tmp &&
> > +		grep "^pick [0-9a-f]\{40\}" \
> > +			.git/rebase-merge/git-rebase-todo &&
> > +		git rebase --continue
> > +	) &&
> > +	collide2=3D"$(git rev-parse HEAD~1 | cut -c 1-4)" &&
> > +	collide3=3D"$(git rev-parse collide3 | cut -c 1-4)" &&
> > +	test "$collide2" =3D "$collide3"
> >  '
> >
> >  test_expect_success 'respect core.abbrev' '
>
>
