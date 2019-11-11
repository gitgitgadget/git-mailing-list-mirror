Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61E161F454
	for <e@80x24.org>; Mon, 11 Nov 2019 01:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfKKBXD (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 20:23:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52377 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfKKBXC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 20:23:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7FB53D43A;
        Sun, 10 Nov 2019 20:22:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6TBtZAVXowkWJ5qrQIITrrTp1Hs=; b=WQpLYd
        Pg3jQzuAa9KykBcy9DCietZLhrN8YfEvFGjWcepQI3vAOSOGJi66xs7HOcH7B5vR
        ZWsrxcYgBoakhSm7t90aEPXntBRi/d0Sk/DTSxcJC1/sc1pcISyET5YbNhhUhQUF
        +z+6a/QTVyTRUJ0ojJfGj1H5meLvIxQ+Y2w98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JQkFmkfSiS8T3kT1s7hSN8hYSqd8oc6P
        2KgiLDm46X7sfuMGwOVS2lraY9nEtGF7+Muh456FPLMzh6Yxb44HgcPC8skj6Obr
        bcJo6C6jvRTYyL91EO13d7/u5w/j50XdvEeoU9ww0pFiLhmsfE0GAjuHqe8wtyVx
        0JT/i4Fqc2s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF6423D439;
        Sun, 10 Nov 2019 20:22:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 326BB3D437;
        Sun, 10 Nov 2019 20:22:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 0/9] Improve odd encoding integration
References: <20191031092618.29073-1-congdanhqx@gmail.com>
        <cover.1573205699.git.congdanhqx@gmail.com>
Date:   Mon, 11 Nov 2019 10:22:55 +0900
In-Reply-To: <cover.1573205699.git.congdanhqx@gmail.com> (Doan Tran Cong
        Danh's message of "Fri, 8 Nov 2019 16:43:42 +0700")
Message-ID: <xmqqlfsnjjf4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA45EBCA-0421-11EA-9BF7-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Doan Tran Cong Danh <congdanhqx@gmail.com> writes:

> The series is shifting from fixing test that failed on musl based Linux to
> correct the internal working encoding and output encoding of git-am
> git-cherry-pick git-rebase and git-revert.
>
> Change from v4:
> - Update commit message per review
> - Add test for last 2 patches
> - Notice a breakage with git rebase --rebase-merges (see patch 7)
>

Re: Patch 3, it indeed is a bit sad that out test framework does not
let us "show" what exactly is being executed in the debug/verbose
mode when we use parameterized test helpers. We designed the test
helpers like test_expect_success and test_eval_ so that the eval'ed
block can access the outer variables safely, i.e. "$flag-$old-$new"
can and should be written inside dq for safety, but the variable
names would be all we see in the verbose log because of that.  But
that's not the end of the world ;-)

I do not have a strong opinion on Patch 9 (I agree we need to fall
back on something sensible and without any change, the system is
quite broken---I do not have a strong opinion on what the fallback
should be); I'd love to hear what sequencer folks think.

Overall this round looks quite good.

Thanks, will queue.




>
> Doan Tran Cong Danh (9):
>   t0028: eliminate non-standard usage of printf
>   configure.ac: define ICONV_OMITS_BOM if necessary
>   t3900: demonstrate git-rebase problem with multi encoding
>   sequencer: reencode to utf-8 before arrange rebase's todo list
>   sequencer: reencode revert/cherry-pick's todo list
>   sequencer: reencode squashing commit's message
>   sequencer: reencode old merge-commit message
>   sequencer: reencode commit message for am/rebase --show-current-patch
>   sequencer: fallback to sane label in making rebase todo list
>
>  configure.ac                     |  49 ++++++++++++++++++
>  sequencer.c                      |  32 ++++++++----
>  t/t0028-working-tree-encoding.sh |   4 +-
>  t/t3433-rebase-i18n.sh           |  84 +++++++++++++++++++++++++++++++
>  t/t3433/ISO8859-1.txt            | Bin 0 -> 15 bytes
>  t/t3433/eucJP.txt                | Bin 0 -> 68 bytes
>  t/t3900-i18n-commit.sh           |  37 ++++++++++++++
>  7 files changed, 195 insertions(+), 11 deletions(-)
>  create mode 100755 t/t3433-rebase-i18n.sh
>  create mode 100644 t/t3433/ISO8859-1.txt
>  create mode 100644 t/t3433/eucJP.txt
>
> Range-diff against v4:
>  1:  daa0c27d28 =  1:  b3d6c4e720 t0028: eliminate non-standard usage of printf
>  2:  c50964f413 !  2:  fe63a6bc44 configure.ac: define ICONV_OMITS_BOM if necessary
>     @@ Commit message
>      
>              make ICONV_OMITS_BOM=Yes
>      
>     -    However, typing the flag all the time is cumbersome and error-prone.
>     +    However, configure script wasn't taught to detect those systems.
>      
>     -    Add a check into configure script to detect this flag automatically.
>     +    Teach configure to do so.
>      
>          Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
>      
>  3:  47888f236c !  3:  30f15075c4 t3900: demonstrate git-rebase problem with multi encoding
>     @@ t/t3900-i18n-commit.sh: test_commit_autosquash_flags eucJP fixup
>      +	new=$3
>      +	msg=$4
>      +	test_expect_failure "commit --$flag into $old from $new" '
>     -+		git checkout -b '$flag-$old-$new' C0 &&
>     -+		git config i18n.commitencoding '$old' &&
>     -+		echo '$old' >>F &&
>     -+		git commit -a -F "$TEST_DIRECTORY/t3900/'$msg'" &&
>     ++		git checkout -b $flag-$old-$new C0 &&
>     ++		git config i18n.commitencoding $old &&
>     ++		echo $old >>F &&
>     ++		git commit -a -F "$TEST_DIRECTORY"/t3900/$msg &&
>      +		test_tick &&
>      +		echo intermediate stuff >>G &&
>      +		git add G &&
>      +		git commit -a -m "intermediate commit" &&
>      +		test_tick &&
>     -+		git config i18n.commitencoding '$new' &&
>     -+		echo '$new-$flag' >>F &&
>     -+		git commit -a --'$flag' HEAD^ &&
>     ++		git config i18n.commitencoding $new &&
>     ++		echo $new-$flag >>F &&
>     ++		git commit -a --$flag HEAD^ &&
>      +		git rebase --autosquash -i HEAD^^^ &&
>      +		git rev-list HEAD >actual &&
>      +		test_line_count = 3 actual
>  4:  42115f1e33 !  4:  17165b81e5 sequencer: reencode to utf-8 before arrange rebase's todo list
>     @@ Commit message
>          Thus, t3900::test_commit_autosquash_flags is failing on musl libc.
>      
>          Reencode to utf-8 before arranging rebase's todo list.
>     -    By doing this, we also remove a breakage introduced in the previous
>     -    commit.
>     +
>     +    By doing this, we also remove a breakage noticed by a test added in the
>     +    previous commit.
>      
>          Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
>      
>     @@ t/t3900-i18n-commit.sh: test_commit_autosquash_multi_encoding () {
>       	msg=$4
>      -	test_expect_failure "commit --$flag into $old from $new" '
>      +	test_expect_success "commit --$flag into $old from $new" '
>     - 		git checkout -b '$flag-$old-$new' C0 &&
>     - 		git config i18n.commitencoding '$old' &&
>     - 		echo '$old' >>F &&
>     + 		git checkout -b $flag-$old-$new C0 &&
>     + 		git config i18n.commitencoding $old &&
>     + 		echo $old >>F &&
>  5:  5a871d7226 =  5:  40fa759492 sequencer: reencode revert/cherry-pick's todo list
>  6:  1c6194a598 !  6:  ed6cfab5d2 sequencer: reencode squashing commit's message
>     @@ sequencer.c: static int commit_staged_changes(struct repository *r,
>      
>       ## t/t3900-i18n-commit.sh ##
>      @@ t/t3900-i18n-commit.sh: test_commit_autosquash_multi_encoding () {
>     - 	old=$2
>     - 	new=$3
>     - 	msg=$4
>     -+	squash_msg=
>     -+	if test $flag = squash; then
>     -+		squash_msg='
>     -+		subject="squash! $(head -1 expect)" &&
>     -+		printf "\n%s\n" "$subject" >> expect &&
>     -+		'
>     -+	fi
>     - 	test_expect_success "commit --$flag into $old from $new" '
>     - 		git checkout -b '$flag-$old-$new' C0 &&
>     - 		git config i18n.commitencoding '$old' &&
>     -@@ t/t3900-i18n-commit.sh: test_commit_autosquash_multi_encoding () {
>     - 		git commit -a --'$flag' HEAD^ &&
>     + 		git commit -a --$flag HEAD^ &&
>       		git rebase --autosquash -i HEAD^^^ &&
>       		git rev-list HEAD >actual &&
>      -		test_line_count = 3 actual
>      +		test_line_count = 3 actual &&
>     -+		iconv -f '$old' -t utf-8 "$TEST_DIRECTORY/t3900/'$msg'" >expect &&
>     -+		'"$squash_msg"'
>     ++		iconv -f $old -t UTF-8 "$TEST_DIRECTORY"/t3900/$msg >expect &&
>     ++		if test $flag = squash; then
>     ++			subject="$(head -1 expect)" &&
>     ++			printf "\nsquash! %s\n" "$subject" >>expect
>     ++		fi &&
>      +		git cat-file commit HEAD^ >raw &&
>     -+		(sed "1,/^$/d" raw | iconv -f '$new' -t utf-8) >actual &&
>     ++		(sed "1,/^$/d" raw | iconv -f $new -t utf-8) >actual &&
>      +		test_cmp expect actual
>       	'
>       }
>  7:  95df3cdadf <  -:  ---------- sequencer: reencode old merge-commit message
>  8:  0606b2408d <  -:  ---------- sequencer: reencode commit message for am/rebase --show-current-patch
>  -:  ---------- >  7:  def9adf97e sequencer: reencode old merge-commit message
>  -:  ---------- >  8:  2e95ca57d2 sequencer: reencode commit message for am/rebase --show-current-patch
>  -:  ---------- >  9:  860dee65f4 sequencer: fallback to sane label in making rebase todo list
