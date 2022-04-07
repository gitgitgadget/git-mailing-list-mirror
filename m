Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E52C433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 18:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiDGSR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 14:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiDGSR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 14:17:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9EF229CBC
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 11:15:57 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 869C01813E2;
        Thu,  7 Apr 2022 14:15:54 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=odODsQPjzKAdE
        jIJBWe5Shtp2mddJ1YXrhK65z6oyDI=; b=YayDMF+bit57/E2mVtkYEkoC0vn66
        KiTh/ZztLt/OFpuhIqwicBEJ5OxpFomEBvFWncctPrv5d+U9zA0CdKlsNxRrYrBm
        5sXlwGwdXpTcEkyITbqPgHu5Ca3axD+xvpZUmvGePPwXkRECm4EsrkAcTPKsvH49
        1cW7fURcCdYHFs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7ED3F1813E1;
        Thu,  7 Apr 2022 14:15:54 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.192.242])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DBD771813DD;
        Thu,  7 Apr 2022 14:15:50 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Thu, 7 Apr 2022 14:15:47 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] doc: replace "--" with {litdd} in
 credential-cache/fsmonitor
Message-ID: <Yk8qU66OzzIEwDP4@pobox.com>
References: <20220406184122.4126898-1-tmz@pobox.com>
 <220407.86h774dcyk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <220407.86h774dcyk.gmgdl@evledraar.gmail.com>
X-Pobox-Relay-ID: C1A05B4A-B69E-11EC-A676-C85A9F429DF0-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C6var,

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> Looks good, for the linkgit case let's check it in "make check-docs":
>=20
> diff --git a/Documentation/lint-gitlink.perl b/Documentation/lint-gitli=
nk.perl
> index 1c61dd9512b..2f46b261282 100755
> --- a/Documentation/lint-gitlink.perl
> +++ b/Documentation/lint-gitlink.perl
> @@ -46,6 +46,7 @@ sub report {
>  		my ($target, $page, $section) =3D ($1, $2, $3);
> =20
>  		# De-AsciiDoc
> +		my $raw_page =3D $page;
>  		$page =3D~ s/{litdd}/--/g;
> =20
>  		if (!exists $TXT{$page}) {
> @@ -61,6 +62,7 @@ sub report {
>  			report($pos, $line, $target, "wrong section (should be $real_sectio=
n)");
>  			next;
>  		}
> +		report($pos, $line, $target, "should link '--' as '{litdd}')") if $r=
aw_page =3D~ /--/;
>  	}
>  	# this resets our $. for each file
>  	close ARGV if eof;

Excellent, thanks!  I had run the lint-docs-gitlink target
to see if it reported any issue, but it hadn't.  With this,
prior to the change I made to git-update-index.txt, it
properly reports the issue:

    make -C Documentation/ lint-docs-gitlink
    ...
	LINT GITLINK git-update-index.txt
    git-update-index.txt:531: error: git-fsmonitor--daemon[1]: should lin=
k '--' as '{litdd}'), shown with 'HERE' below:
    git-update-index.txt:531:	'linkgit:git-fsmonitor--daemon[1]' <-- HERE
    make: *** [Makefile:442: .build/lint-docs/gitlink/git-update-index.ok=
] Error 1
    make: *** Deleting file '.build/lint-docs/gitlink/git-update-index.ok=
'
    make: Leaving directory '/src/git/Documentation'

Cheers,

--=20
Todd
