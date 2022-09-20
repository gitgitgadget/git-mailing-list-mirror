Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F0BC6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 02:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiITCPB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 22:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiITCPA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 22:15:00 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCDADEF0
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 19:14:56 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id a20so825477qtw.10
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 19:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=/2rMjbjxu6D/hPhPInA3ZoH/EoY1fUklbqYwOmCGfd8=;
        b=iwHRi3hEaN+oS08tu8ZQk8/GkorE9aObUZSdbmuBHuN1V4bsLOpBYjeyy+FUJdboW0
         udAkzXv6en53sJdChrAuQR1+ERjQR3I+4W16DDbIbjM8aVdQT61rXfKGG8oZN3fcSLqg
         sC7+3BsVXRNRbKxop5eVEBbp5ATRgzYBztGJWBTKUpbWjuyaYv0W+p8oniyu36i9Sjrc
         EtdZoS/cGUuRtJvG7KCTOkfPh2h3mHExPg+VamJgxqcY/bbCPgZlxS9R0XHprkhxVATX
         ZS80uRw93P9Rfgb6BC7U5Lzl7fX9fSRhrFsLKO4EYutDL93pmvZsxbCsr0J359iaFp66
         BgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/2rMjbjxu6D/hPhPInA3ZoH/EoY1fUklbqYwOmCGfd8=;
        b=0Xxx1g2rO97rRWXrNeDmaSZWpWkHrzE1HfxTKd1tzS07ci+t/1Ka+58ZnfEZnPI8LA
         9jBQ0MsQV50qf7G4OhZKwhKP/ib1zJBvqtBpBwAG27cRVetHky9q5wKVvSNs5JsMaK40
         y5P5fIuQPPUlwqcct3bFbPVlA0jlo1MeteXWEeNsd2Zz4eiaPqIJ0ObIK0yElcrRkOEG
         6wL8T23DKNZX3BT2Ai+oEjq5CtE3R9OBuiKeTvZg6dvtLTqQdgt+itpwHOnHrTr9H2Yg
         U6GHcudhijr0sPytsecgXJG3HjfSxzS5ZnEeuIerZNGutguFJoK8gDq08fkttGdpsbaR
         vjCg==
X-Gm-Message-State: ACrzQf3qbix0AxvYSdgbqN4WKQdGk36Aw1cnkY/WF4HJiuCGca+bW7gU
        wAY9Bp+PgjBHNA4ejnzNgzM2DTZ382Psow==
X-Google-Smtp-Source: AMsMyM53menpCcrJOt/2DypgbuSyABsDFsDKmMkWRfWnMdmkIgfFfGVwqvp0396qwS67x/PeGnkIFA==
X-Received: by 2002:ac8:7486:0:b0:35a:7195:6a36 with SMTP id v6-20020ac87486000000b0035a71956a36mr17647141qtq.41.1663640095413;
        Mon, 19 Sep 2022 19:14:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a454600b0069fe1dfbeffsm85850qkp.92.2022.09.19.19.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 19:14:55 -0700 (PDT)
Date:   Mon, 19 Sep 2022 22:14:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com, peff@peff.net
Subject: Re: [PATCH] midx.c: use `pack-objects --stdin-packs` when repacking
Message-ID: <YykiHrWvrktCLRCB@nand.local>
References: <9195a9ecd11a19f2c7fb1c70136d2d13fa308010.1663639662.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9195a9ecd11a19f2c7fb1c70136d2d13fa308010.1663639662.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2022 at 10:08:35PM -0400, Taylor Blau wrote:
> Noticed this while working on a semi-related series in:
>
>   https://lore.kernel.org/git/cover.1663638929.git.me@ttaylorr.com/T/
>
> the savings here are pretty modest, but this is in line with the
> strategy we use in the `--geometric` repack mode, which performs a
> similar task.

To expand on my setup a little more, I ran the following script:

--- >8 ---
#!/bin/sh

repack_into_n () {
	rm -rf staging &&
	mkdir staging &&

	git rev-list --first-parent HEAD |
	perl -e '
		my $n = shift;
		while (<>) {
			last unless @commits < $n;
			push @commits, $_ if $. % 5 == 1;
		}
		print reverse @commits;
	' "$1" >pushes &&

	# create base packfile
	base_pack=$(
		head -n 1 pushes |
		git pack-objects --delta-base-offset --revs staging/pack
	) &&
	export base_pack &&

	# create an empty packfile
	empty_pack=$(git pack-objects staging/pack </dev/null) &&
	export empty_pack &&

	# and then incrementals between each pair of commits
	last= &&
	while read rev
	do
		if test -n "$last"; then
			{
				echo "$rev" &&
				echo "^$last"
			} |
			git pack-objects --delta-base-offset --revs \
				staging/pack || return 1
		fi
		last=$rev
	done <pushes &&

	(
		find staging -type f -name 'pack-*.pack' |
			xargs -n 1 basename | grep -v "$base_pack" &&
		printf "^pack-%s.pack\n" $base_pack
	) >stdin.packs

	# and install the whole thing
	rm -f .git/objects/pack/* &&
	mv staging/* .git/objects/pack/
}

# Pretend we just have a single branch and no reflogs, and that everything is
# in objects/pack; that makes our fake pack-building via repack_into_n()
# much simpler.
simplify_reachability() {
	tip=$(git rev-parse --verify HEAD) &&
	git for-each-ref --format="option no-deref%0adelete %(refname)" |
	git update-ref --stdin &&
	rm -rf .git/logs &&
	git update-ref refs/heads/master $tip &&
	git symbolic-ref HEAD refs/heads/master
}

simplify_reachability

for i in 100 1000 5000
do
  echo >&2 "==> $i pack(s)"

  repack_into_n $i

  rm .git/objects/pack/multi-pack-index
  find .git/objects/pack -type f | sort >before

  hyperfine -p './prepare.sh' \
	  'git multi-pack-index repack --batch-size=1G && ./report.sh' \
	  'git.compile multi-pack-index repack --batch-size=1G && ./report.sh'
done
--- 8< ---

...where `git.compile` is has this patch and `git` does not. The two
other scripts (prepare.sh, and report.sh, respectively) look as follows:

--- >8 ---
#!/bin/sh

find .git/objects/pack -type f | sort >after
comm -13 before after | xargs rm -f
rm -f .git/objects/pack/multi-pack-index
git multi-pack-index write
--- 8< ---

...and report.sh:

--- >8 ---
#!/bin/sh

find .git/objects/pack -type f | sort >after
for new in $(comm -13 before after)
do
	echo "==> $new ($(wc -c <$new))"
done
echo "-------------"
--- 8< ---

In general, the timings on git.git packed into 100 packs look something
like:

  Benchmark 1: git multi-pack-index repack --batch-size=1G
    Time (mean ± σ):      4.342 s ±  0.087 s    [User: 12.864 s, System: 0.396 s]
    Range (min … max):    4.235 s …  4.517 s    10 runs

  Benchmark 2: git.compile multi-pack-index repack --batch-size=1G
    Time (mean ± σ):      7.016 s ±  0.119 s    [User: 11.170 s, System: 0.469 s]
    Range (min … max):    6.858 s …  7.233 s    10 runs

But if I rip out the traversal pass towards the end of
`read_packs_list_from_stdin()` in `builtin/pack-objects.c`, the two
timings are equal. So the slow-down here really is from the traversal
pass.

The savings are modest, probably because we're already starting with a
pretty well packed baseline, since we're feeding objects in pack order.
On average, I was able to see around a ~3.5% reduction in pack size or
so.

So, not amazing, but mirroring the behavior of `git repack
--geometric=<n>` is worthwhile for all of the reasons that we do this
there.

I should also mention that this applies cleanly against `master`, and
doesn't depend on or interact with my changes in the series above.

Thanks,
Taylor
