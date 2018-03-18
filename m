Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EF3D1F404
	for <e@80x24.org>; Sun, 18 Mar 2018 20:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754520AbeCRUQ3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 16:16:29 -0400
Received: from shout02.mail.de ([213.128.151.217]:34321 "EHLO shout02.mail.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754579AbeCRUQM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 16:16:12 -0400
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Mar 2018 16:16:11 EDT
Received: from postfix02.mail.de (postfix02.bt.mail.de [10.0.121.126])
        by shout02.mail.de (Postfix) with ESMTP id 2B15E6001B;
        Sun, 18 Mar 2018 21:09:23 +0100 (CET)
Received: from smtp02.mail.de (smtp02.bt.mail.de [10.0.121.212])
        by postfix02.mail.de (Postfix) with ESMTP id 0F286C000E;
        Sun, 18 Mar 2018 21:09:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
        s=mailde201610; t=1521403763;
        bh=vb42Pgvb5A3JRvKf4ykt3QPreJWJbk4hbcaQ9drxrmw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T/Vno81SBoYGsNPxooR5IEOZ5aIDn7uLixJJKM4ysykYEjTlWlmhu/hqu+vAjrPd+
         c1fmsNNKa0FlCGwUu6lJxSo8FredO3M/rTNzob1XGoL1BVUYPX22xgi+GyVQU6t3oS
         UPJB6iv+hUafeVzTLf4OQnfCXNXqQaLUB+2iD8FI=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp02.mail.de (Postfix) with ESMTPSA id 5F873102E58;
        Sun, 18 Mar 2018 21:09:22 +0100 (CET)
Date:   Sun, 18 Mar 2018 21:09:08 +0100
From:   Stefan Moch <stefanmoch@mail.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Simon Doodkin <helpmepro1@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: Re: feature-request: git "cp" like there is git mv.
Message-ID: <20180318210908.3ed94777.stefanmoch@mail.de>
In-Reply-To: <xmqqinb87f70.fsf@gitster-ct.c.googlers.com>
References: <20171216013130.GB188893@aiede.mtv.corp.google.com>
        <20171231191156.28359-1-stefanmoch@mail.de>
        <xmqqinb87f70.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 3108
X-purgate-ID: 154282::1521403762-000006B1-CE4E6B11/0/0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Junio C Hamano <gitster@pobox.com> [2018-02-07T11:49:39-0800]:
> Stefan Moch <stefanmoch@mail.de> writes:
>=20
> > * Jonathan Nieder <jrnieder@gmail.com> [2017-12-15T17:31:30-0800]: =20
> >> This sounds like a reasonable thing to add.  See builtin/mv.c for
> >> how "git mv" works if you're looking for inspiration.
> >>=20
> >> cmd_mv in that file looks rather long, so I'd also be happy if
> >> someone interested refactors to break it into multiple
> >> self-contained pieces for easier reading (git mostly follows
> >> https://www.kernel.org/doc/html/latest/process/coding-style.html#funct=
ions). =20
> >
> > I looked at builtin/mv.c and have a rough idea how to split it
> > up to support both mv and cp commands.
> >
> > But first I noticed and removed a redundant check in cmd_mv,
> > also added a test case to check if mv --dry-run does not move
> > the file. =20
>=20
> I guess these two patches went unnoticed when posted at the end of
> last year.  Reading them again, I think they are good changes.

Thanks.

Are such redundant checks in general a pattern worth searching
for and cleaning up globally? Or is this rather in the category
of cleaning up only when noticed?


> As a no-op clean-up of a127331c ("mv: allow moving nested
> submodules", 2016-04-19), the attached would also make sense, I
> would think.
>=20
> Thanks.
>=20
>  builtin/mv.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 9662804d23..9cb07990fd 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -266,10 +266,11 @@ int cmd_mv(int argc, const char **argv, const
> char *prefix) const char *src =3D source[i], *dst =3D destination[i];
>  		enum update_mode mode =3D modes[i];
>  		int pos;
> -		if (show_only || verbose)
> -			printf(_("Renaming %s to %s\n"), src, dst);
> -		if (show_only)
> +		if (show_only) {
> +			if (verbose)
> +				printf(_("Renaming %s to %s\n"),
> src, dst); continue;
> +		}
>  		if (mode !=3D INDEX && rename(src, dst) < 0) {
>  			if (ignore_errors)
>  				continue;
>=20

As Stefan Beller already noted, this changes the printing
behavior:
<https://public-inbox.org/git/CAGZ79kbX4uhDpdp0kH=3D8+5tj_zLWZbtbMUb5WWtOeX=
WRQz8K3Q@mail.gmail.com/>

See also the output of

    git mv -n
    git mv -n -v
    git mv -v


without your patch:

    $ git mv -n 1 2
    Checking rename of '1' to '2'
    Renaming 1 to 2
    $ git mv -n -v 1 2
    Checking rename of '1' to '2'
    Renaming 1 to 2
    $ git mv -v 1 2
    Renaming 1 to 2


and with your patch:

    $ git mv -n 1 2
    Checking rename of '1' to '2'
    $ git mv -n -v 1 2
    Checking rename of '1' to '2'
    Renaming 1 to 2
    $ git mv -v 1 2


Having different outputs of =E2=80=9Cgit mv -n=E2=80=9D and =E2=80=9Cgit mv=
 -n -v=E2=80=9D seems
odd, but not necessarily wrong. However, =E2=80=9Cgit mv -v=E2=80=9D with no
output at all, does not what the documentation says:

       -v, --verbose
           Report the names of files as they are moved.


