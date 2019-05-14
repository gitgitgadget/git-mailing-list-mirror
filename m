Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CF861F461
	for <e@80x24.org>; Tue, 14 May 2019 02:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfENC5A (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 22:57:00 -0400
Received: from mout.web.de ([212.227.15.14]:42539 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbfENC47 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 22:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557802613;
        bh=OTXNIszDNK1fyFMHeSMCkhPWHXiIahuq+1YZUfAks1g=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=BoHBFnbeQiMcRM6O2s8tj3i9a44Fef+GLP739+Up3KZ/aZXKinvHL3FC7F+WtxHTQ
         TrUCPA9rITZ/1IlP7C0kk5MjQ/UzMRE2Y2EJCx5pw7MRztbNR7j5AWnX/UtjutcsUf
         OhQP1bPzGMewVlwvpyTFmXKBvgTqSA/Bkh1x8UoI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MHpOP-1hPXk93yLV-003cPE; Tue, 14
 May 2019 04:56:53 +0200
Date:   Tue, 14 May 2019 04:56:51 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v5 3/5] fast-export: avoid stripping encoding header if
 we cannot reencode
Message-ID: <20190514025651.gjtvikhxcjoudkrj@tb-raspi4>
References: <20190513164722.31534-1-newren@gmail.com>
 <20190513231726.16218-1-newren@gmail.com>
 <20190513231726.16218-4-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513231726.16218-4-newren@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:LjKG/SwIbhDTcXeUdL5WlU9DMxe359G+Vkt1A2sUGcxZgWVlQKN
 s6WyWleaIywLPXpCdTm7TgpebtoyyL5ioZdx6I1R9sWJIOzBEKkldATQrU6C7iMtvxX+QAd
 qz6QlOphHVECqUHU2v+aUkDPN+x7/FaP8pN6pik4Rb1OrYx/6JyNSMJ4hIZ7qMlEKasJluP
 BSR9wI49piNP3fqD27X/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LPd1aW6lRzw=:GUKERKAaYJXsKUcPCZXCB1
 wrewYv3onha1MqiR4Ousw9elYqk2VtH7bkZkXnI9V1YyfjiNzjtJNT0z6Zg/1ydZujw9xU0l/
 NWxWhdu2xGp5xMKuH2l/Gh9qcmUQv3RdIHECrzAkea1dfFuqmjwT8OSS8BOmpVpQMUsR+J4N1
 wUpdkqwy78677zQ0cSOnRE8umwmGOLwTxb/KxEN8Q/o6+KIAd7XdIBB0nH0t9zNKyxlzh5gYg
 UHt2aUnC9b2eKYrY2DfrY9R2A1OqDjKNqpymmN9l2+UH5q1oF3bjSxL68tfZyKAsEXluS1fFl
 nXJl6fpYEPq+zN07dn2H100rEjK/b0eWiYC46DUBoDgpdg7FJxNs7I8BtbbkQvuA3vkN/sKjX
 wvR/xkNsxxKjKdpSRcu2shLsi54NOyo71JFNELGuSz97ybyClZ67u6lAi1V0/bzR6I/pgdHqr
 oxUsguwYYYvkTojIL+1M6NV45o/IomAXI50guNMX1v4HcGECjPy9iB0HwBnZ9unGyJZyeFRMe
 ILo7oj+i51XuU/k7M8q4IjaSlz34g7AXC+kiFmc+eJzA0ZCcGnDxi0wRplGrfREYJko6EVMOy
 xGUV17ZuJoFhfn0kQvKT0mTJ8Gq7x3CgJZqi6Brapt+bwlSipfQyN7HWgsFAqZjErVcyhzERd
 I5YsC/TDKu4rMKv4ZWfY7Fe+MpyDubiwtPv494/AHpDcCicqqwABHgQ5cqW3nUec8uPH+tn3R
 K2o34r3+CoFZ5Koix4ic5+lmHxa7t9JxezRP0BZJlmsjeVCw8k+vdugAu6z1QPixZtlUZkeb+
 J1QOaWTcLFXWa0+HKnD7FDRO1pwxc45fhJqYfDN/sq21eDyNisspLHS5A/JOQXXTmRW90Qwi3
 8evhvZCZ+II2hTKafCeP99QR24veoTRBKeZBlMRiv2UbSROr7NjWR2xerP6wbr
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 13, 2019 at 04:17:24PM -0700, Elijah Newren wrote:
> When fast-export encounters a commit with an 'encoding' header, it tries
> to reencode in utf-8 and then drops the encoding header.  However, if it
> fails to reencode in utf-8 because e.g. one of the characters in the
> commit message was invalid in the old encoding, then we need to retain
> the original encoding or otherwise we lose information needed to
> understand all the other (valid) characters in the original commit
> message.

Minor question: "utf-8" or "UTF-8" ?
Mostly we use UTF-8 in Git.

>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/fast-export.c                        |  7 +++++--
>  t/t9350-fast-export.sh                       | 21 ++++++++++++++++++++
>  t/t9350/broken-iso-8859-7-commit-message.txt |  1 +
>  3 files changed, 27 insertions(+), 2 deletions(-)
>  create mode 100644 t/t9350/broken-iso-8859-7-commit-message.txt
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 9e283482ef..7734a9f5a5 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -642,9 +642,12 @@ static void handle_commit(struct commit *commit, st=
ruct rev_info *rev,
>  	printf("commit %s\nmark :%"PRIu32"\n", refname, last_idnum);
>  	if (show_original_ids)
>  		printf("original-oid %s\n", oid_to_hex(&commit->object.oid));
> -	printf("%.*s\n%.*s\ndata %u\n%s",
> +	printf("%.*s\n%.*s\n",
>  	       (int)(author_end - author), author,
> -	       (int)(committer_end - committer), committer,
> +	       (int)(committer_end - committer), committer);
> +	if (!reencoded && encoding)
> +		printf("encoding %s\n", encoding);
> +	printf("data %u\n%s",
>  	       (unsigned)(reencoded
>  			  ? strlen(reencoded) : message
>  			  ? strlen(message) : 0),
> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index c721026260..4fd637312a 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -118,6 +118,27 @@ test_expect_success 'iso-8859-7' '
>  		 ! grep ^encoding actual)
>  '
>
> +test_expect_success 'encoding preserved if reencoding fails' '
> +
> +	test_when_finished "git reset --hard HEAD~1" &&
> +	test_config i18n.commitencoding iso-8859-7 &&
> +	echo rosten >file &&
> +	git commit -s -F "$TEST_DIRECTORY/t9350/broken-iso-8859-7-commit-messa=
ge.txt" file &&
> +	git fast-export wer^..wer >iso-8859-7.fi &&
> +	sed "s/wer/i18n-invalid/" iso-8859-7.fi |
> +		(cd new &&
> +		 git fast-import &&
> +		 git cat-file commit i18n-invalid >actual &&
> +		 # Make sure the commit still has the encoding header
> +		 grep ^encoding actual &&
> +		 # Verify that the commit has the expected size; i.e.
> +		 # that no bytes were re-encoded to a different encoding.
> +		 test 252 -eq "$(git cat-file -s i18n-invalid)" &&
> +		 # ...and check for the original special bytes
> +		 grep $(printf "\360") actual &&
> +		 grep $(printf "\377") actual)
> +'
> +
>  test_expect_success 'import/export-marks' '
>
>  	git checkout -b marks master &&
> diff --git a/t/t9350/broken-iso-8859-7-commit-message.txt b/t/t9350/brok=
en-iso-8859-7-commit-message.txt
> new file mode 100644
> index 0000000000..d06ad75b44
> --- /dev/null
> +++ b/t/t9350/broken-iso-8859-7-commit-message.txt
> @@ -0,0 +1 @@
> +Pi: ?; Invalid: ?
> \ No newline at end of file
> --
> 2.21.0.782.gd8be4ee826
>
