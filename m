Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373A2C43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 09:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242411AbiFIJbW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 05:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242744AbiFIJbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 05:31:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771452B344F
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 02:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654767007;
        bh=eGMgIxLI8hdyhjFUF21ORmKXoUzIwp5d8JTHAOoiiFs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FAnKVhE2sm2bIS1CzCd/L9hSgk4zgutxONz9IdKaDJbNy2Y3bja7xVk6Jogc+LlUH
         Q7aaLfK5xK7UtQtezc4GZH9kiBaGH7cEVkg4j26uyQWWp2MT8sRE6w/ap6NWDvPUZt
         THtoVo6ViOMelh8LhOyKvQl+mnIjta4nS55xXhcI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.206.165] ([213.196.213.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N63VY-1nfIxj1UQy-016Qks; Thu, 09
 Jun 2022 11:30:07 +0200
Date:   Thu, 9 Jun 2022 11:30:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Han Xin <chiyutianyi@gmail.com>
cc:     nksingh85@gmail.com, avarab@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, l.s.r@web.de, neerajsi@microsoft.com,
        newren@gmail.com, philipoakley@iee.email, stolee@gmail.com,
        worldhello.net@gmail.com, zhiyou.jx@alibaba-inc.com
Subject: Re: [RFC PATCH] object-file.c: batched disk flushes for
 stream_loose_object()
In-Reply-To: <20220609030530.51746-1-chiyutianyi@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2206091114070.349@tvgsbejvaqbjf.bet>
References: <7ba4858a-d1cc-a4eb-b6d6-4c04a5dd6ce7@gmail.com> <20220609030530.51746-1-chiyutianyi@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YuJhpzLvnwjmh8bm1nkBFsThQFHsBIftJrKzsWj7Ko33CugCjR0
 0welKRmWARST9tnitCkrULsoKNj7Fb2hA/2l6HmuOYPcA/LPPnqh4WDEUBjlHGyRrWhF1by
 IX9gwPcnE7/VpR5ZCp6qh8M3wZSz7KZs/258pJZqK/LIAwGO6JqJ1EWQdytn/mQEari1sda
 xBtDcF5uzDi2y4+1V0XuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nv+XjeJ0dsM=:+WBUixUdIcdLa2uUSBSE7C
 dWTglLjZ0awNB4mPrE/RKeJxazUYCwYOqKSbqGphVLdzyHcCZZlONUjHms/pFyd+0osuFEo4V
 JUT5N60eKLvZKEhYEa3pcUA7mAoM5fhqWu1XDTNqf12eBKUbgGEQ+YVn07ajfZgMFdzHQSrRg
 sXe94tuPAatUd1R9HKO+skoxiJe1BDLEj5A+h1cwEQFiw0kPObpmoJ+it6R8hqJewmm6BgVER
 hszayCcmEfAX4RJrzWRg+89KHPoqMRI2FOQC1s3jSc5GM2/eXtE4QT/W6096aJwbE0Jx6pFLT
 a7HZgM617B7tbrFGLIf8S9ozLGXadEk/ByqpyNoPb53KTfuB9VP9/5Ews+u7lm7dgscQFDBmN
 yBo50lQoSvfoqUA5ATx2IpaleYO3XlwheBQh/tw+BwqCY782FweWP4M8IMFKtmsfHHk4rnTYh
 yezVya2LsZUl4wkE7NTX0zoI9XTtj/eEsiLLQ4/gaq16vb6vH7AyFi5ua0ilR8NGpdgKAsNmF
 sOxvLCyBLSNPHHhRTvS9F6FXfMymzhWLFxmHfIEcRJ7GDbxFdAn0J/DNJw5sisMYu06l6b8QQ
 ipDV0UxsK5F5cVNOfm4N1OM6jbTzLoJ+b4NiGP2ufK5pgXQQ1hddrStucm9903fnLcBQ1kr+j
 otVSgA7NAJmRnLvWgNjLQ3/QOy0mmwpOBX7eFDX/FHnpVB/syCG+SAx7nTwzSZPvYigg/4cBI
 Jl33UDyDXQIJfl472TDHQzfDrJnakdW5dzEBkx7zkPifDWl5QjWA0dZ+OE1ZkcZmVXv2ciOac
 LLkFxkc59/fxlwQVs8J666U2/uOwTPe2OW8a9ST0Eb9i5FG/UaBFuBf0kA/E3lSTNPvjaeWLV
 bmjTJ6DLvu7P02cEzz1/u2ghQSKgGr3xwplh7J4IIz82PSQkLWw4Tl5SFZEK//OdcN0p1sXzU
 ypIUHz3LWBEBvTVruNEl/GLrgWmlzTrS3eoJOU+duckvzVIlswIUAyZQ3xV/eos9F3c/lJrc9
 2FYxHcR3CrByylpz8dyNtfaq3kDAZzvqQk19MwDEkRK9UqklWCPD7r+gacSj5QtWRg8mJzL4m
 X5YyRgtX0iZGvmilPsWHdZ+A3Vag4DdK0KK5nk8uljowjqirIArb4MffH3HcqmWrvJoEGwaDy
 2iAIw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 9 Jun 2022, Han Xin wrote:

> Neeraj Singh[1] pointed out that if batch fsync is enabled, we should st=
ill
> call prepare_loose_object_bulk_checkin() to potentially create the bulk =
checkin
> objdir.
>
> 1. https://lore.kernel.org/git/7ba4858a-d1cc-a4eb-b6d6-4c04a5dd6ce7@gmai=
l.com/
>
> Signed-off-by: Han Xin <chiyutianyi@gmail.com>

I like a good commit message that is concise and yet has all the necessary
information. Well done!

> ---
>  object-file.c                   |  3 +++
>  t/t5351-unpack-large-objects.sh | 15 ++++++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/object-file.c b/object-file.c
> index 2dd828b45b..3a1be74775 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2131,6 +2131,9 @@ int stream_loose_object(struct input_stream *in_st=
ream, size_t len,
>  	char hdr[MAX_HEADER_LEN];
>  	int hdrlen;
>
> +	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
> +		prepare_loose_object_bulk_checkin();
> +

Makes sense.

>  	/* Since oid is not determined, save tmp file to odb path. */
>  	strbuf_addf(&filename, "%s/", get_object_directory());
>  	hdrlen =3D format_object_header(hdr, sizeof(hdr), OBJ_BLOB, len);
> diff --git a/t/t5351-unpack-large-objects.sh b/t/t5351-unpack-large-obje=
cts.sh
> index 461ca060b2..a66a51f7df 100755
> --- a/t/t5351-unpack-large-objects.sh
> +++ b/t/t5351-unpack-large-objects.sh
> @@ -18,7 +18,10 @@ test_expect_success "create large objects (1.5 MB) an=
d PACK" '
>  	test_commit --append foo big-blob &&
>  	test-tool genrandom bar 1500000 >big-blob &&
>  	test_commit --append bar big-blob &&
> -	PACK=3D$(echo HEAD | git pack-objects --revs pack)
> +	PACK=3D$(echo HEAD | git pack-objects --revs pack) &&
> +	git verify-pack -v pack-$PACK.pack |
> +	    grep -E "commit|tree|blob" |
> +		sed -n -e "s/^\([0-9a-f]*\).*/\1/p" >obj-list

Here, I would recommend avoiding the pipe, to ensure that we would catch
problems in the `verify-pack` invocation, and I think we can avoid the
`grep` altogether:

	git verify-pack -v pack-$PACK.pack >out &&
	sed -n 's/^\([0-9a-f][0-9a-f]*\).*\(commit\|tree\|blob\)/\1/p' \
		<out >obj-list

>  '
>
>  test_expect_success 'set memory limitation to 1MB' '
> @@ -45,6 +48,16 @@ test_expect_success 'unpack big object in stream' '
>  	test_dir_is_empty dest.git/objects/pack
>  '
>
> +BATCH_CONFIGURATION=3D'-c core.fsync=3Dloose-object -c core.fsyncmethod=
=3Dbatch'
> +
> +test_expect_success 'unpack big object in stream (core.fsyncmethod=3Dba=
tch)' '
> +	prepare_dest 1m &&
> +	git $BATCH_CONFIGURATION -C dest.git unpack-objects <pack-$PACK.pack &=
&

I think the canonical way would be to use `test_config core.fsync ...`,
but the presented way works, too.

> +	test_dir_is_empty dest.git/objects/pack &&
> +	git -C dest.git cat-file --batch-check=3D"%(objectname)" <obj-list >cu=
rrent &&

Good. The `--batch-check=3D"%(objectname)"` part forces `cat-file` to read
the actual object.

> +	cmp obj-list current
> +'

My main question about this test case is whether it _actually_ verifies
that the batch-mode `fsync()`ing took place.

I kind of had expected to see Trace2 enabled and a `grep` for
`fsync/hardware-flush`. Do you think that would still make sense to add?

Thank you for working on the `fsync()` aspects of Git!
Dscho

> +
>  test_expect_success 'do not unpack existing large objects' '
>  	prepare_dest 1m &&
>  	git -C dest.git index-pack --stdin <pack-$PACK.pack &&
> --
> 2.36.1
>
>
