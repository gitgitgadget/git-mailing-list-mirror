Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94E611F51C
	for <e@80x24.org>; Wed, 30 May 2018 09:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750990AbeE3Jyo (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 05:54:44 -0400
Received: from mout.gmx.net ([212.227.15.19]:38887 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbeE3Jyk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 05:54:40 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZCUG-1fcCLI0lAa-00KuZI; Wed, 30
 May 2018 11:54:28 +0200
Date:   Wed, 30 May 2018 11:54:27 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sequencer: ensure labels that are object IDs are
 rewritten
In-Reply-To: <20180529163236.646275-1-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1805301144470.82@tvgsbejvaqbjf.bet>
References: <20180529163236.646275-1-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0BpOK8XKFBEpxfn2dSyPW+MHxKLoBj1o9KlAXJZgLjpq2e/6I+k
 NB/Ykefheo0NOhjoKuQotJ91S8hGCmjVqkDk0crHcehWNo7VmM5flUl3YCfqiiWOEZ3EN4J
 0dAlbO60tXOgGwOZ/6SlgKDVh5XhkZaH7i4r0S51qyKUrDvZ2zAHK7cbUICaJ/ioQ31xeHT
 HXRwb3VcH0y92uYyncA/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eBrcD/MygZE=:5G7DwjTuftpdiGT6mgnMEo
 OgVvygxm50UcDeLCZFTCnd7isZAvaMf37ikor4qGNWE+ZBmiT1bHD61AZBUZDKEscXZ19ZGmB
 ckuH42szmpJjfe2wtZl5G6UrSfnveCTlUrFQGFvepjjnk5mZqUjmgf4Jo6shSU02E7cVxqnw4
 1YUVecNKrEblSrYd187lsEsTFdLtcVTgreRveugMZInpKBwJ03oeyTXEBmSnuL0diQAlJgVa7
 0VJ2E/wDAJHITatUqkwAiWIitKLCuuC/823UgiusMW9AqnDx31IvUWylumcOs0haXB44DUf5i
 QYNgaLmUKe4Vimjx4ChdXyS7b69w8qZ0r6ou1ZhCF1uOpPY0qQkKNgYlH/ddAnUFggiTY7B/U
 AeSHvbniNw+g/LcCocQj3TFZT2nyXiIkbEM1/mcoWpJS/TyGrAYNJJrHz992mPsIl+ARFuvJR
 hreYXqigmi5MbNcsLR69nJApm6fwB/EAOJYt2rwevYN24QycMTgYgs4rgPSOHg4GLCAZScilq
 o6+x5hPHypIIoGAhu/v2E3Ull/clHo+j86ucylnsmABas8h8XsDzj0A2e9vd2L9MRSA0IftHe
 yVEUZPtFMrfIkdQHnTkiP/DIAzTxV8ptRPqCDnWyIh1ughiwMrxm4LbIPno1zRTuAeQFW3cme
 lZwsDXuPx6RVZ2MUhSGRYdPcS6oRRtwTzHWTofGqVc2FigMxCGrfx7r9yNqNV5doccVtYU2Sy
 fs18yXlOdpaJm7WnYmF8kxTS7zHxruCzcNDWE8bUg7qR/bWQpKmuxFwO4fg9axSOkhs0qNzih
 +U9XABB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

On Tue, 29 May 2018, brian m. carlson wrote:

> When writing the todo script for --rebase-merges, we try to find a label
> for certain commits.  If the label ends up being a valid object ID, such
> as when we merge a detached commit, we want to rewrite it so it is no
> longer a valid object ID.
> 
> However, the code path that does this checks for its length to be
> equivalent to GIT_SHA1_RAWSZ, which isn't correct, since what we are
> reading is a hex object ID.  Instead, check for the length being
> equivalent to that of a hex object ID.  Use the_hash_algo so this code
> works regardless of the hash size.

D'oh. Thank you so much for this fix.

> I noticed this while cleaning up a few instances of GIT_SHA1_* constants
> and thought I'd send a patch.

You thought well!

> diff --git a/sequencer.c b/sequencer.c
> index 1ce63261a3..75ed86a94e 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3636,7 +3636,7 @@ static const char *label_oid(struct object_id *oid, const char *label,
>  				p[i] = save;
>  			}
>  		}
> -	} else if (((len = strlen(label)) == GIT_SHA1_RAWSZ &&
> +	} else if (((len = strlen(label)) == the_hash_algo->hexsz &&

Obviously good!

>  		    !get_oid_hex(label, &dummy)) ||
>  		   (len == 1 && *label == '#') ||
>  		   hashmap_get_from_hash(&state->labels,
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index 3d4dfdf7be..472ad9463c 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -70,6 +70,7 @@ test_expect_success 'create completely different structure' '
>  	merge -C H second
>  	merge onebranch # Merge the topic branch '\''onebranch'\''
>  	EOF
> +	cp script-from-scratch script-from-scratch-orig &&
>  	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
>  	test_tick &&
>  	git rebase -i -r A &&
> @@ -241,4 +242,20 @@ test_expect_success 'refuse to merge ancestors of HEAD' '
>  	test_cmp_rev HEAD $before
>  '
>  
> +test_expect_success 'labels that are object IDs are rewritten' '

Thanks for writing a test, I had been meaning to, but it slipped from my
mind.

> +	git checkout -b third B &&
> +	test_tick &&
> +	test_commit I &&

The test_tick before test_commit is unnecessary.

> +	third=$(git rev-parse HEAD) &&
> +	git checkout -b labels master &&
> +	git merge --no-commit third &&
> +	test_tick &&
> +	git commit -m "Merge commit '\''$third'\'' into labels" &&

Here, the test_tick is required because we commit via `git commit`.

BTW another thing that I had been meaning to address but totally forgot is
this '\'' ugliness. I had been meaning to define SQ="'" before all test
cases and then use $SQ everywhere. Not your problem, though.

> +	cp script-from-scratch-orig script-from-scratch &&

There is nothing in that script that you need. Why not simply

	echo noop >script-from-scratch

or if you care about the branch,

	echo reset $third >script-from-scratch

> +	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
> +	test_tick &&
> +	git rebase -i -r A &&
> +	! grep "^label $third$" .git/ORIGINAL-TODO

I would like to verify in addition that /^label $third-/ is present in
ORIGINAL-TODO, what do you think?

Thank you,
Dscho
