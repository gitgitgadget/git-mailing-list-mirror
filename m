Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889F3ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 15:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiIAPKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 11:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbiIAPK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 11:10:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D64C248FE
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 08:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662044997;
        bh=8LWQRAjHOxohFYta9LlttBYnq8LrxTDU/xyUg9EcV6Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XF1N1dXa22tA/ttzBDunZsQGuQ3bttFqMf7VQ0/L4VTgOjdtubwWLHYl9M+ZlAB5p
         Wt+iT6CsyyZMZHapAROkYVGLYbXwfF0srPSkbTWuWc11E3VwJrBX19QqK78IXRhJcF
         yxri48h+fZ5zXn3zpXJ902rVKSunXxTvTbjac+BY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNh1-1p2Z9X3NxH-00hw68; Thu, 01
 Sep 2022 17:09:56 +0200
Date:   Thu, 1 Sep 2022 17:09:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 2/3] add -p: gracefully handle unparseable hunk headers
 in colored diffs
In-Reply-To: <19d4c44b-868e-628d-5715-54f37ef56c0d@gmail.com>
Message-ID: <1q42767p-7oqo-np69-0099-2r5784q5q140@tzk.qr>
References: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com> <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com> <cd1c51005068247fc92f1c515469bcd384bfe589.1661977877.git.gitgitgadget@gmail.com> <19d4c44b-868e-628d-5715-54f37ef56c0d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+AkVuwdyFFXONWk/zSS4U0ZN/+gqe4xnHk8ZJCEc2yqofUuul7N
 Q02OcPyiEPIyK12sTIy8oD4eXLcMXzAr1dS9MxtyUox81eyKBWmfK9lAPHEmxUayWRMjj9Y
 t7bf+abHNvLajwLmAEbx4wVt3ZM7aufVwExl4hyfTRWduOR22zI54uhhbEdIp6JTv0jlayU
 3Tiiuzy2lxvsB4UMbBf5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pMCgRkR+6+A=:3esySZg4xDFrD/p52sGnek
 JkzV5boDjwQXblzm4gA1BVyq5ukdlrqq1kX1ZLohE8h5m4WW8vgamYfXjTekuFAjAhq4kKNDg
 NiZPyxMnstdfclM3JlZqWA5nKuGuFpdg8qWZT4zJSPNvnu2bIF318BzTulQXyZQx1BYLjE/qi
 iUg+IcgXS51rH+gbKzWurMcf0sqhWbIuM/evrsB7oMhdBP7Km8NduXwz+w1PeN6DEZKlU/Z0t
 wkhIDID0XnD2avGBs0huCEPkg/V2R+FMUs98r5lINUni8JLHHMYQIWoDfoEvopTcWnaysn5mF
 CJBekc1fUFe9H3FUkNgCVbAc04vqbAxxZvN6ktgqZUtu0ETU/Qgw0ih5Etwc84DlK/D7jTLoA
 +1ADFzIlJPDu5DRRa0oducivaWSMlapcqAos6vhj0nEjiNDTKs/HMU8Mwlgby28EJ6ce+bDw9
 Dfn79RdHJE5xd1fB/rb9iI4pzIHt9d7V+ZL3dI+/TX345FWLVD9xW0wNmD4rGDwNehlOGQ8Ar
 tIVAEEA5MmmiOkm7+dsUU43F0eA8DFjx3N9NROJq9hFNbECvsM5CTGF7s6jMgVTG7Tr8fWAVR
 Uh6JercTl/+iZ2Ig5UYVFD8RTBufPZv6Mbt/bOsZyUZn6nGUg3oLiDtmQ63GcbeHukxLfsfhr
 fmhV/cJGqUU7vxTlZYNqPwNojv9eTFo5nJ7A9g3mebhp5/hwA3aPLRz2Da7Q/YvOHwG86Ti5y
 LSUE7pJk69X0Zf88xK5QFrXJxJ6XXdWndt924uu3tkJMagal+yWSP3XxS+J1s+DQZAGyN0yir
 rgHnsA8DpgE/9RutqYey6rX7I9tyawSgUGGTf5kAE2L6bXYitfMc/0hnk2phG9y05M5HckPNk
 09R7wqCzyJaXX6OGqkfvevu9AbGoLXQAdj2Zfgr6v84/KDESHIrqsTpUkJq3CGDDTFwWMniM3
 eGwLlhtF31G4NcIoplx+cW+pYeYJcTuhrkw/FgTP1x31z6hg6wF3E51InJFVxxeqo5vMV4knt
 MMd6i4rf1ZTsoJ3iIZHcuhPwPcUut+CgAWjkYpOAt58/Z5r/Acqv1x892OFPFXt9thwH7Nl8m
 1oUhF0iwLo0tPKz53GGZrOk5Y5b04mG3dOFld7yLAvECNhf3FJcS+mnKBpf5E6X/fZbWmgOAH
 7ul9X8Cp6uprcMJByvcOCws3mp
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 1 Sep 2022, Phillip Wood wrote:

> On 31/08/2022 21:31, Johannes Schindelin via GitGitGadget wrote:
> [...]
> > @@ -358,15 +359,14 @@ static int parse_hunk_header(struct add_p_state =
*s,
> > @@ struct hunk *hunk)
> >    if (!eol)
> >    	eol =3D s->colored.buf + s->colored.len;
> >   	p =3D memmem(line, eol - line, "@@ -", 4);
> > -	if (!p)
> > -		return error(_("could not parse colored hunk header '%.*s'"),
> > -			     (int)(eol - line), line);
> > -	p =3D memmem(p + 4, eol - p - 4, " @@", 3);
> > -	if (!p)
> > -		return error(_("could not parse colored hunk header '%.*s'"),
> > -			     (int)(eol - line), line);
> > +	if (p && (p =3D memmem(p + 4, eol - p - 4, " @@", 3)))
>
> nit: there should be braces round both arms of the if, but it's hardly t=
he
> first one that does not follow our official style.

Fixed.

> > @@ -666,18 +666,20 @@ static void render_hunk(struct add_p_state *s, s=
truct
> > @@ hunk *hunk,
>                 if (!colored) {
>                         p =3D s->plain.buf + header->extra_start;
>                         len =3D header->extra_end - header->extra_start;
>                 } else {
>                         strbuf_addstr(out, s->s.fraginfo_color);
>
> I don't think we want to add this escape sequence unless we're going to
> dynamically generate the hunk header

True.

>
>                         p =3D s->colored.buf + header->colored_extra_sta=
rt;
>                         len =3D header->colored_extra_end
>                                 - header->colored_extra_start;
>
> If we cannot parse the hunk header then len is non-zero...
>
>                 }
> >   -		if (s->mode->is_reverse)
> > -			old_offset -=3D delta;
> > -		else
> > -			new_offset +=3D delta;
> > -
> > -		strbuf_addf(out, "@@ -%lu", old_offset);
> > -		if (header->old_count !=3D 1)
> > -			strbuf_addf(out, ",%lu", header->old_count);
> > -		strbuf_addf(out, " +%lu", new_offset);
> > -		if (header->new_count !=3D 1)
> > -			strbuf_addf(out, ",%lu", header->new_count);
> > -		strbuf_addstr(out, " @@");
> > +		if (!colored || !header->suppress_colored_line_range) {
> > +			if (s->mode->is_reverse)
> > +				old_offset -=3D delta;
> > +			else
> > +				new_offset +=3D delta;
> > +
> > +			strbuf_addf(out, "@@ -%lu", old_offset);
> > +			if (header->old_count !=3D 1)
> > +				strbuf_addf(out, ",%lu", header->old_count);
> > +			strbuf_addf(out, " +%lu", new_offset);
> > +			if (header->new_count !=3D 1)
> > +				strbuf_addf(out, ",%lu", header->new_count);
> > +			strbuf_addstr(out, " @@");
> > +		}
> >
> >     if (len)
> >      strbuf_add(out, p, len);
>
> ... and so we print the filtered hunk header here and do not reset the c=
olor
> below. That is probably ok as the filter should be resetting it's own co=
lors
> but we shouldn't be printing the color at the beginning of the line abov=
e in
> that case.
>
>                 else if (colored)
>                         strbuf_addf(out, "%s\n", s->s.reset_color);
>                 else
>                         strbuf_addch(out, '\n');

I've changed the code so that the `suppress_colored_line_range` code path
prints no extra sequence but the hunk header and the hunk verbatim (they
still have to be two separate `strbuf*()` calls because the hunk could be
edited).

Since this code path now also returns early, the patch avoids the
indentation change altogether.

>         }
>
>
> > diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> > index 8a594700f7b..47ed6698943 100755
> > --- a/t/t3701-add-interactive.sh
> > +++ b/t/t3701-add-interactive.sh
> > @@ -767,6 +767,16 @@ test_expect_success 'detect bogus diffFilter outp=
ut' '
> >   	grep "mismatched output" output
> >   '
> >
> > +test_expect_success 'handle iffy colored hunk headers' '
> > +	git reset --hard &&
> > +
> > +	echo content >test &&
> > +	printf n >n &&
> > +	force_color git -c interactive.diffFilter=3D"sed s/.*@@.*/XX/" \
> > +		add -p >output 2>&1 <n &&
> > +	grep "^[^@]*XX[^@]*$" output
>
> I was wondering why this wasn't just `grep "^XX$"` as we should be print=
ing
> the output of the diff filter verbatim. That lead to my comments about
> outputting escape codes above. Apart from that this patch looks good.

I changed it to `^XX$` as you suggested.

Thank you for your excellent review,
Dscho

>
> Best Wishes
>
> Phillip
>
> > +'
> > +
> >   test_expect_success 'handle very large filtered diff' '
> >    git reset --hard &&
> >    # The specific number here is not important, but it must
>
>
