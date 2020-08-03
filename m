Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7668BC433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 14:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 502A920781
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 14:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsHPulQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgHCOQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgHCOQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 10:16:27 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0248C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 07:16:26 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id x7so1078962qvi.5
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 07:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QdMfaD8VGblc9QZeqRPNfcclzx8t98KZiCcsBkhvAic=;
        b=AsHPulQQPoRPqC8BPUW5e3LmXkbJwQq9tnoeA+ZmCr3dhtB++AXT3no0IaKdr9PFd8
         qSjMAMQ2XtyFtDbXlHKCbScvFw3zYsq9cLcQXq+AQa6HIJgAd7dX1FQxpSGFXZtXNZVx
         tyuVu2zepA08ixQpouD1SvA7+12ZLkAqEk0j1WxvawfK3Ugl6V8Rx3z9y5BlZOkrDvv9
         EKTxIrb/8wou1MaFr1p1ka74YKM3PmWm2xapbW3LfVC2k/tkT0q0uoVdeFC5jcB49jeO
         Z1/stlY3vY+JDM+no2X2oD8We0g+SFpvER0pmhpU2hitENSWcPlbcFly2dyCn5to3mnq
         nI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QdMfaD8VGblc9QZeqRPNfcclzx8t98KZiCcsBkhvAic=;
        b=KZ4CywhTPKqtaKFBjxbiBJ4oYvpo3MzBaXVPCJt32TBqgTW1AucV3IvgyL1XIHEfWt
         Mz1amGrSm4jervlu2BrtlTPlF8Xa1keNS1VIFlay33e8Kw1bQs6cw3D1lQJePL7Ye00u
         aLnaGSVjIBt2nPafqJAhcruRGEhAyP+Kj/cdgoX5CefNmXgU9fpK9xFL1nh0bAQcWXHc
         iBYjUmgQ7VQhmBjf644Xa09NDwVo8t0Xe08OaUVFZZtdqlII0+kGMtCp2aswWPlBRbFL
         rbyflGHFg/2zHb9AaIqjk+aY6LlnOsu1qYIsLI+oRFHr4jkwTRsXiJ6wz/usX9cPtfdS
         iVyg==
X-Gm-Message-State: AOAM530j2FDleESubbbMNPIatxrT/BQ3pCocsWwRtT7k35M3i9tGX04c
        AkZtYVwv7bptBR0Lz0Beobk=
X-Google-Smtp-Source: ABdhPJy86rzV8S+sAMF9zgzGqZsJvqW9oYJz0B74eBBa9vVeEo5Tsc7MhqyrR9wGVxV4Des68F8e6Q==
X-Received: by 2002:ad4:54ce:: with SMTP id j14mr17306611qvx.185.1596464186079;
        Mon, 03 Aug 2020 07:16:26 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id 84sm10947586qkl.11.2020.08.03.07.16.24
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 03 Aug 2020 07:16:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 3/3] git.txt: add list of guides
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqqv9i0wvoz.fsf@gitster.c.googlers.com>
Date:   Mon, 3 Aug 2020 10:16:20 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C571F33-0ACE-4C1C-805C-7E8ADE50D18D@gmail.com>
References: <pull.691.git.1596381647.gitgitgadget@gmail.com> <9374d80f0c37a6b6a7f5f76601ee757f89712d0c.1596381647.git.gitgitgadget@gmail.com> <xmqqsgd4rad8.fsf@gitster.c.googlers.com> <xmqqv9i0wvoz.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,=20

> Le 2 ao=C3=BBt 2020 =C3=A0 18:05, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>=20
>>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>>=20
>>> Not all guides are mentioned in the 'git(1)' documentation,
>>> which makes the missing ones somewhat hard to find.
>>>=20
>>> Add a list of the guides to git(1).
>>>=20
>>> Tweak `Documentation/cmd-list.perl` so that it also generates
>>> a file `cmds-guide.txt` which gets included in git.txt.
>>=20
>> Who cleans this?  Do we need a change to Makefile?

Oups! I checked /.gitignore, but forgot to thoroughly check the =
Makefile.

>=20
> A band-aid patch would look like this, BUT.
>=20
>    diff --git a/Documentation/Makefile b/Documentation/Makefile
>    index 39f6fc8de7..616449da88 100644
>    --- a/Documentation/Makefile
>    +++ b/Documentation/Makefile
>    @@ -295,6 +295,7 @@ cmds_txt =3D cmds-ancillaryinterrogators.txt \
>            cmds-plumbingmanipulators.txt \
>            cmds-synchingrepositories.txt \
>            cmds-synchelpers.txt \
>    +       cmds-guide.txt \
>            cmds-purehelpers.txt \
>            cmds-foreignscminterface.txt
>=20
> I think with a bit more work, we can be at a lot better place.  How
> about something along the following line (untested)?
>=20
> Documentation/Makefile      |  3 ++-
> Documentation/cmd-list.perl | 21 ++++++++-------------
> 2 files changed, 10 insertions(+), 14 deletions(-)
>=20
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 39f6fc8de7..80d1908a44 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -295,6 +295,7 @@ cmds_txt =3D cmds-ancillaryinterrogators.txt \
> 	cmds-plumbingmanipulators.txt \
> 	cmds-synchingrepositories.txt \
> 	cmds-synchelpers.txt \
> +	cmds-guide.txt \
> 	cmds-purehelpers.txt \
> 	cmds-foreignscminterface.txt
>=20
> @@ -302,7 +303,7 @@ $(cmds_txt): cmd-list.made
>=20
> cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
> 	$(QUIET_GEN)$(RM) $@ && \
> -	$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(QUIET_STDERR) =
&& \
> +	$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(cmds_txt) =
$(QUIET_STDERR) && \
> 	date >$@
>=20
> mergetools_txt =3D mergetools-diff.txt mergetools-merge.txt
> diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
> index 99f01a0910..af5da45d28 100755
> --- a/Documentation/cmd-list.perl
> +++ b/Documentation/cmd-list.perl
> @@ -43,12 +43,15 @@ sub format_one {
> 	}
> }
>=20
> -while (<>) {
> +my ($input, @categories) =3D @ARGV;
> +
> +open IN, "<$input";
> +while (<IN>) {
> 	last if /^### command list/;
> }
>=20
> my %cmds =3D ();
> -for (sort <>) {
> +for (sort <IN>) {
> 	next if /^#/;
>=20
> 	chomp;
> @@ -56,18 +59,10 @@ sub format_one {
> 	$attr =3D '' unless defined $attr;
> 	push @{$cmds{$cat}}, [$name, " $attr "];
> }
> +close IN;
>=20
> -for my $cat (qw(ancillaryinterrogators
> -		ancillarymanipulators
> -		mainporcelain
> -		plumbinginterrogators
> -		plumbingmanipulators
> -		synchingrepositories
> -		foreignscminterface
> -		purehelpers
> -		synchelpers
> -		guide)) {
> -	my $out =3D "cmds-$cat.txt";
> +for my $out (@categories) {
> +	my ($cat) =3D $out =3D~ /^cmds-(.*)\.txt$/;
> 	open O, '>', "$out+" or die "Cannot open output file $out+";
> 	for (@{$cmds{$cat}}) {
> 		format_one(\*O, $_);

Thanks for the suggestion. I tested it and it works correctly.=20
I've incorporated it to v2.


Philippe.

