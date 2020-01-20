Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B115C32771
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 22:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5510A217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 22:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="W7qxFZq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgATWXG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 17:23:06 -0500
Received: from mout.gmx.net ([212.227.17.22]:38841 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgATWXG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 17:23:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579558983;
        bh=0bpLEqBirq+MJ6NDPJ7128moxOnGn9G1A104Zhq1Sto=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=W7qxFZq+9Oj4qMhT6gHNMNqs7qGTlRFm+5YkCumfZ6907bJOnXJtww/JHZmpRy39S
         BP3c1+Z4QSHy804jkrpAHZJRpRQL5bMtutBytMfHQ526iLWXFnXZ1AFVjdmPEsn1JI
         Ro1vTsy3NcuVOCUsOf8BgxohKdgFy+6q/Fh5/qOY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Wuq-1iwzMx2wLc-005ZLV; Mon, 20
 Jan 2020 23:23:03 +0100
Date:   Mon, 20 Jan 2020 23:23:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH 10/29] bisect: libify `handle_bad_merge_base` and its
 dependents
In-Reply-To: <20200120143800.900-11-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001202321210.46@tvgsbejvaqbjf.bet>
References: <20200120143800.900-1-mirucam@gmail.com> <20200120143800.900-11-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Yp+fMHpvvjUb5tOswF8BaqjfOTRohxLUuOhQVRgBDkXzf/u6qP8
 W/Ky8Z4cugaZBv+bwP99ONtXXy4l576pzjKDzQtPnsHw0e2fZbOZkTFLVvzIIOasT6YnjRY
 b0KXLsBCpfsDInPsfZJDu0fXJoWytXuG/W8MKrOVurjVXYEhRX0fbrjf0F+Dmb5r4euLIev
 ffHWBwqd968rltPzruDJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0P+65ayyWo4=:zn1FYhUueDCaLrVNzKyjLz
 OGonIMdCgdfkffLwG7WpkW/lAetxAZX3vhasFU5WIPqVnprbBxjp+jLJwkKIWCOJZiBDWSWiZ
 CFlxvq08wkhDwkHDMomEkTpPcbMkhbW+Mpxmo07/9ZOYlCngTAdqiZl1lScZcgWGAb+fM2Ndn
 BlF7H/wT9/eaEcBtY1vn3G8rCQ6vkn/Slj+Eqaw/Mq84iJFrq8sPNyqoIxTYtXWPxbnBgPgt3
 pYpS5aaXzsHMeRdTuSpnioL6UvcHQs5Y60B7pg6tUFbAKhSt64YEPSm3yvOUpvzPqAHbk5nAa
 wwJ/XMfkbg58xTkaqZf8SPyu9FqOr+fnm2bjz157xGLmIaeZz+H+/y8EJlhm5pEwB4CWTdk+r
 /+ah3U6PDTYXHf91IQRugIJWcDHsUgFBxh94SclDEaI4ngY/SEviClddDzDsyumrjJIrHNDlB
 agCWAdUj+zSgmMAeXKXP7ByfY5kCsGXEl9Ch0xUnsRFrg0EiAA3f28rnU/hGUF0vPaC1IuBnR
 WvYiwPxW4fyfidIg7Fw8tnDsouxDNjW5aRKfJQqEWxecfoRXkPGXOf9X77kStnngtfwI8ctIz
 BHh7RslOR3b6z5gAZge3Tx+3R5BzWnSSgvRKEjIyaauSYnSfuixa12H6IXnDtR8nTJf+xq8KI
 n+4SW6Rz7xOFQde1DPOGzRWBFFSvF+LC5ePiR3xDWiWRlIFIcwEdsL/i7UKoVil8HIzvkRqko
 BQ0c62QfN4QvQnNJOGMNkgbcyN8AOpdYltIVJhRplZ7zvpTjgy/RZ0zS5kYjW7xYv55x7cbHY
 X8SSlH5tLflMT7iZVoY3nvPfK+SeD7rHshFUtXIUDiWCmR6tPlC6R9S1VzTIt+IkW1RsCmG8Q
 hblkkR6T7ReL3rqlNlIG7qZ9aQZqXctaQa1GsPJIiq8h/XNeHoXIML6koDokRsfA/imL+Lno5
 kCeWH/o3ITCIwjDloCOzWP0N3TgzMxqt2UboI3CCn+yhdLek/RWxtPU3B8gp5BnDvd1rx1+11
 F1zNny+bUNKaRgK7lvRvdKS3CGfrTCRs+T49s0SlH2TkgIzP0TJzXqG/o09DRFNaRvQ+hoacK
 eBy+iCrgeX8HdiwApKr3D9hv3UCalaEZbCkLyjaGTlTFC4oDHDRYTvMOyvrVdyoV3xK+uheLW
 g9HPv4tsiXpl/6dXSahPqNNM+4nTtLYpn38RRS+kAl+iwsN7oMcFMV17PSTkibb+a0lr+Gkej
 LuAJuc2Nj8Zkqr5FNC+RRqvmnLGxP7h1mCcUeATVS1RAYGs62owl7M7cdIKs=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Mon, 20 Jan 2020, Miriam Rubio wrote:

> From: Pranit Bauva <pranit.bauva@gmail.com>
>
> Since we want to get rid of git-bisect.sh it would be necessary to
> convert those exit() calls to return statements so that errors can be
> reported.
>
> Emulate try catch in C by converting `exit(<positive-value>)` to
> `return <negative-value>`. Follow POSIX conventions to return
> <negative-value> to indicate error.
>
> Turn `exit()` to `return` calls in `handle_bad_merge_base()`.
>
> Handle the return value in dependent function check_merge_bases().

This is again a lot of essentially repeated text from earlier commit
messages, but the most pressing question is not addressed...

>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  bisect.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 2b80597a1d..acb5a13911 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -756,7 +756,7 @@ static struct commit **get_bad_and_good_commits(stru=
ct repository *r,
>  	return rev;
>  }
>
> -static void handle_bad_merge_base(void)
> +static int handle_bad_merge_base(void)
>  {
>  	if (is_expected_rev(current_bad_oid)) {
>  		char *bad_hex =3D oid_to_hex(current_bad_oid);
> @@ -777,14 +777,14 @@ static void handle_bad_merge_base(void)
>  				"between %s and [%s].\n"),
>  				bad_hex, term_bad, term_good, bad_hex, good_hex);
>  		}
> -		exit(3);
> +		return -3;

... which is: what does `3` stand for?

Thanks,
Johannes

>  	}
>
>  	fprintf(stderr, _("Some %s revs are not ancestors of the %s rev.\n"
>  		"git bisect cannot work properly in this case.\n"
>  		"Maybe you mistook %s and %s revs?\n"),
>  		term_good, term_bad, term_good, term_bad);
> -	exit(1);
> +	return -1;
>  }
>
>  static void handle_skipped_merge_base(const struct object_id *mb)
> @@ -823,7 +823,8 @@ static int check_merge_bases(int rev_nr, struct comm=
it **rev, int no_checkout)
>  	for (; result; result =3D result->next) {
>  		const struct object_id *mb =3D &result->item->object.oid;
>  		if (oideq(mb, current_bad_oid)) {
> -			handle_bad_merge_base();
> +			res =3D handle_bad_merge_base();
> +			break;
>  		} else if (0 <=3D oid_array_lookup(&good_revs, mb)) {
>  			continue;
>  		} else if (0 <=3D oid_array_lookup(&skipped_revs, mb)) {
> --
> 2.21.1 (Apple Git-122.3)
>
>
