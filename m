Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F413E16D4FD
	for <git@vger.kernel.org>; Thu,  2 May 2024 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680347; cv=none; b=eiI0RVIJtd5HyKpJXoyVLRe1Lo+QQuGKG3qIPDBkHUd32SS9jgUctqmlZ5CDRVrcMb9qgPDUB+sqgpRT4mJtE5UWjVIPiXBxBdsTeZVXlVpDSHi0h6vHB8LbMnmTeTSq+IyjdjPBrCgQ0mcWyGSaUFF3IlKrlQu7s67ehYbdkh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680347; c=relaxed/simple;
	bh=7qB79ovHtBVH0cF1PacY4DEaisByfwBtbQItCX1//Pc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dvM77UeATdjpYNKcNr122JlPZ4LZiUiaoYJ4geELxlfilIhMB27DILJlCUwjTmvvz6IzfsdinJ+pjcITi/afvrd6ZFdqSV2VF63yJyeo0v766zfuUh1y3/ofEBTrQDXwdE+SKBe84IH5ZM4ySIyDyz8erSSYjTjzbfo/+CEY3a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=R9Nsj6g6; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R9Nsj6g6"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9000231D8A;
	Thu,  2 May 2024 16:05:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7qB79ovHtBVH0cF1PacY4DEaisByfwBtbQItCX
	1//Pc=; b=R9Nsj6g6PToyE9hC+q5RtbRBDqSruNlqPVNfZ7w4/b56QJGwwmSKkQ
	lBeMimoZBrHqE0iiryaFcq64RnlRdKvfs19yAuvPBO+kntxCRr3FhNOSMfI9Fodr
	qLdMC8e6ftmPwxzZskwDET94CdE8haKcolgEXog5XztP61yZF7Ang=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 88AD031D89;
	Thu,  2 May 2024 16:05:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0934D31D88;
	Thu,  2 May 2024 16:05:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
  git@vger.kernel.org
Subject: Re: t4216-log-bloom.sh broken ?
In-Reply-To: <xmqq7cgcdm4f.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	02 May 2024 12:55:44 -0700")
References: <xmqq8r0ww0sj.fsf@gitster.g> <20240502055621.GA29945@tb-raspi4>
	<xmqqsez0fbam.fsf@gitster.g> <20240502185903.GA11895@tb-raspi4>
	<20240502192622.GA1841@szeder.dev> <xmqq7cgcdm4f.fsf@gitster.g>
Date: Thu, 02 May 2024 13:05:40 -0700
Message-ID: <xmqqwmocc73f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5A6B505E-08BF-11EF-8416-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> ... it is a very unsatisfactory workaround, compared to a world where we
> do not have to worry about such a broken mv (perhaps by noticing a
> broken macOS /bin/mv and automatically doing mv () { mv -f "$@" }
> for them).
>
> I am curious what other differences Torsten will find out between
> good macs and bad ones.  Perhaps we can narrow down the bad apples?

In any case, while we are waiting, I did a few "grep":

    $ git grep 'mv \(.*\)\.tmp \1' t
    t/lib-t6000.sh:	mv sed.script.tmp sed.script
    t/t7508-status.sh:	rm "$1" && mv "$1".tmp "$1"
    t/t8011-blame-split-file.sh:	mv one.tmp one &&
    t/t8011-blame-split-file.sh:	mv two.tmp two &&
    t/t9400-git-cvsserver-server.sh:	mv merge.tmp merge &&
    t/t9400-git-cvsserver-server.sh:	mv merge.tmp merge &&
    t/t9802-git-p4-filetype.sh:		mv empty-symlink,v.tmp empty-symlink,v

    $ git grep 'mv "\(.*\)\.tmp" "\1"' t
    t/lib-chunk.sh:	mv "$fn.tmp" "$fn"
    t/t3404-rebase-interactive.sh:	mv "$1.tmp" "$1"
    t/t5515-fetch-merge-logic.sh:	mv "$file.tmp" "$file"
    t/t7600-merge.sh:) >"$1.tmp" && mv "$1.tmp" "$1"
    t/t9001-send-email.sh:	mv "$1.tmp" "$1"
    t/t9001-send-email.sh:	mv "$1.tmp" "$1"

    $ git grep 'mv \(.*\)+ \1' t
    t/t4025-hunk-header.sh:	mv file+ file
    t/t6402-merge-rename.sh:	mv A+ A &&
    t/t6402-merge-rename.sh:	mv A+ A &&
    t/t6432-merge-recursive-space-options.sh:	mv text.txt+ text.txt &&
    t/t6432-merge-recursive-space-options.sh:	mv text.txt+ text.txt &&

There is nothing other than the one we found in lib-chunk.sh that
work on files under .git/objects/ that are made read-only, so we
should be OK with a workaround like the attached.

 t/lib-chunk.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git c/t/lib-chunk.sh w/t/lib-chunk.sh
index a7cd9c3c6d..9f01df190b 100644
--- c/t/lib-chunk.sh
+++ w/t/lib-chunk.sh
@@ -13,5 +13,6 @@ corrupt_chunk_file () {
 	fn=$1; shift
 	perl "$TEST_DIRECTORY"/lib-chunk/corrupt-chunk-file.pl \
 		"$@" <"$fn" >"$fn.tmp" &&
-	mv "$fn.tmp" "$fn"
+	# some vintages of macOS 'mv' fails to overwrite a read-only file.
+	mv -f "$fn.tmp" "$fn"
 }
