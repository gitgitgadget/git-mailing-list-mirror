Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6704651C5B
	for <git@vger.kernel.org>; Wed,  8 May 2024 23:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715212194; cv=none; b=Q5X4+DmlIEM5Jb7XuQO2eIKCR6nkEJyrD20izH03TtYFAbNj4X5LI6+xH189oRGHf5QMohlfU2Ljyy5j8BeMWU3MU2mKJ9twmzwrJL+BZ6xrPwZcJdF1AiWUjS7+t+d21cn3bxpBd3+dh6jdDeYyNyCf4xGl6bwlMevGypkOosc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715212194; c=relaxed/simple;
	bh=A/7m4f2ElrUh6cGYQ5G/YPDry5T5uWrD3fzTUTnCWTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wec2sOzd03X7IQI16ihjipLsEaoKq529jQQpXLbF2Aob68hG3sqDUtT0piyuhAn0YfO4ZYqPcTEUPjXF7To2iLWBLWGrA7pN6i7aF3prhaOZ+Jki9xpKwNhG0BugHXMLT+CjozwY6sLccUVh3uxNm/cLAwSeN8HHt8YSsMuYps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bLOxILII; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bLOxILII"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B89451E65A;
	Wed,  8 May 2024 19:49:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=A/7m4f2ElrUh6cGYQ5G/YPDry5T5uWrD3fzTUT
	nCWTA=; b=bLOxILIIha0DGxXNj6dsv3P7Oyfc331UiLLI3YY+zgv6D+6EuxY3vM
	cq16aPZ4LJ0blBL2dQD1sOuNmocklpsOdeIU+BSzYpDszA/06d8kqUMgJxM98emE
	acad0RSrzf4HQSAtYxALNOb5PSMW6jTKqCON8nu4DKJec6bx4gaOM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B1B6A1E659;
	Wed,  8 May 2024 19:49:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 35C201E658;
	Wed,  8 May 2024 19:49:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] bundle-uri: show progress when downloading from
 bundle URIs
In-Reply-To: <20240508124453.600871-1-toon@iotcl.com> (Toon Claes's message of
	"Wed, 8 May 2024 14:44:49 +0200")
References: <20240508124453.600871-1-toon@iotcl.com>
Date: Wed, 08 May 2024 16:49:46 -0700
Message-ID: <xmqqr0ebx3s5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A77238A6-0D95-11EF-9183-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Toon Claes <toon@iotcl.com> writes:

> Toon Claes (4):
>   progress: add function to set total
>   http: add the ability to log progress
>   remote-curl: optionally show progress for HTTP get
>   bundle-uri: enable git-remote-https progress
>
>  bundle-uri.c                |  4 +++-
>  http.c                      | 32 ++++++++++++++++++++++++++++++++
>  http.h                      |  5 +++++
>  progress.c                  |  6 ++++++
>  progress.h                  |  1 +
>  remote-curl.c               |  8 +++++++-
>  t/helper/test-progress.c    |  5 +++++
>  t/t0500-progress-display.sh | 24 ++++++++++++++++++++++++
>  t/t5557-http-get.sh         | 15 +++++++++++++++
>  9 files changed, 98 insertions(+), 2 deletions(-)

This topic, when built on tip of recent tip of 'master'
(d4cc1ec35f), or merged to 'seen', seems to break t5558.


$ sh t5558-clone-bundle-uri.sh -i -v
Initialized empty Git repository in /home/gitster/w/git.git/t/trash directory.t5558-clone-bundle-uri/.git/
expecting success of 5558.1 'fail to clone from non-existent file': 
	test_when_finished rm -rf test &&
	git clone --bundle-uri="$(pwd)/does-not-exist" . test 2>err &&
	grep "failed to download bundle from URI" err

warning: failed to download bundle from URI '/home/gitster/w/git.git/t/trash directory.t5558-clone-bundle-uri/does-not-exist'
ok 1 - fail to clone from non-existent file

expecting success of 5558.2 'fail to clone from non-bundle file': 
	test_when_finished rm -rf test &&
	echo bogus >bogus &&
	git clone --bundle-uri="$(pwd)/bogus" . test 2>err &&
	grep "is not a bundle" err

warning: file at URI '/home/gitster/w/git.git/t/trash directory.t5558-clone-bundle-uri/bogus' is not a bundle or bundle list
ok 2 - fail to clone from non-bundle file

expecting success of 5558.3 'create bundle': 
	git init clone-from &&
	git -C clone-from checkout -b topic &&
	test_commit -C clone-from A &&
	test_commit -C clone-from B &&
	git -C clone-from bundle create B.bundle topic

Initialized empty Git repository in /home/gitster/w/git.git/t/trash directory.t5558-clone-bundle-uri/clone-from/.git/
Switched to a new branch 'topic'
[topic (root-commit) 0ddfaf1] A
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 A.t
[topic d9df450] B
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 B.t
ok 3 - create bundle

expecting success of 5558.4 'clone with path bundle': 
	git clone --bundle-uri="clone-from/B.bundle" \
		clone-from clone-path &&
	git -C clone-path rev-parse refs/bundles/topic >actual &&
	git -C clone-from rev-parse topic >expect &&
	test_cmp expect actual

Cloning into 'clone-path'...
done.
ok 4 - clone with path bundle

expecting success of 5558.5 'clone with path bundle and non-default hash': 
	test_when_finished "rm -rf clone-path-non-default-hash" &&
	GIT_DEFAULT_HASH=sha256 git clone --bundle-uri="clone-from/B.bundle" \
		clone-from clone-path-non-default-hash &&
	git -C clone-path-non-default-hash rev-parse refs/bundles/topic >actual &&
	git -C clone-from rev-parse topic >expect &&
	test_cmp expect actual

Cloning into 'clone-path-non-default-hash'...
done.
ok 5 - clone with path bundle and non-default hash

expecting success of 5558.6 'clone with file:// bundle': 
	git clone --bundle-uri="file://$(pwd)/clone-from/B.bundle" \
		clone-from clone-file &&
	git -C clone-file rev-parse refs/bundles/topic >actual &&
	git -C clone-from rev-parse topic >expect &&
	test_cmp expect actual

Cloning into 'clone-file'...
done.
ok 6 - clone with file:// bundle

expecting success of 5558.7 'construct incremental bundle list': 
	(
		cd clone-from &&
		git checkout -b base &&
		test_commit 1 &&
		git checkout -b left &&
		test_commit 2 &&
		git checkout -b right base &&
		test_commit 3 &&
		git checkout -b merge left &&
		git merge right -m "4" &&

		git bundle create bundle-1.bundle base &&
		git bundle create bundle-2.bundle base..left &&
		git bundle create bundle-3.bundle base..right &&
		git bundle create bundle-4.bundle merge --not left right
	)

Switched to a new branch 'base'
[base 65d47d5] 1
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 1.t
Switched to a new branch 'left'
[left 918de9f] 2
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 2.t
Switched to a new branch 'right'
[right d1bc9f9] 3
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 3.t
Switched to a new branch 'merge'
Merge made by the 'ort' strategy.
 3.t | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 3.t
ok 7 - construct incremental bundle list

expecting success of 5558.8 'clone bundle list (file, no heuristic)': 
	cat >bundle-list <<-EOF &&
	[bundle]
		version = 1
		mode = all

	[bundle "bundle-1"]
		uri = file://$(pwd)/clone-from/bundle-1.bundle

	[bundle "bundle-2"]
		uri = file://$(pwd)/clone-from/bundle-2.bundle

	[bundle "bundle-3"]
		uri = file://$(pwd)/clone-from/bundle-3.bundle

	[bundle "bundle-4"]
		uri = file://$(pwd)/clone-from/bundle-4.bundle
	EOF

	git clone --bundle-uri="file://$(pwd)/bundle-list" \
		clone-from clone-list-file 2>err &&
	! grep "Repository lacks these prerequisite commits" err &&

	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
	git -C clone-list-file cat-file --batch-check <oids &&

	git -C clone-list-file for-each-ref --format="%(refname)" >refs &&
	grep "refs/bundles/" refs >actual &&
	cat >expect <<-\EOF &&
	refs/bundles/base
	refs/bundles/left
	refs/bundles/merge
	refs/bundles/right
	EOF
	test_cmp expect actual

65d47d507bde981075d2f2532bb104e4b58b9170 commit 213
918de9f3988f29866b94f657626edb7247c7ddbd commit 213
475812ed564e3085586d0b0acc392cec0a90c18e commit 261
d1bc9f9c222df7b7de791db57cdf7e8ba0627c3e commit 213
d9df4505cb3522088b9e29d6051ac16f1564154a commit 213
65d47d507bde981075d2f2532bb104e4b58b9170 commit 213
918de9f3988f29866b94f657626edb7247c7ddbd commit 213
d1bc9f9c222df7b7de791db57cdf7e8ba0627c3e commit 213
0ddfaf193ff13d6ab39b7cbd9eed645e3ee2f050 commit 165
d9df4505cb3522088b9e29d6051ac16f1564154a commit 213
ok 8 - clone bundle list (file, no heuristic)

expecting success of 5558.9 'clone bundle list (file, all mode, some failures)': 
	cat >bundle-list <<-EOF &&
	[bundle]
		version = 1
		mode = all

	# Does not exist. Should be skipped.
	[bundle "bundle-0"]
		uri = file://$(pwd)/clone-from/bundle-0.bundle

	[bundle "bundle-1"]
		uri = file://$(pwd)/clone-from/bundle-1.bundle

	[bundle "bundle-2"]
		uri = file://$(pwd)/clone-from/bundle-2.bundle

	# No bundle-3 means bundle-4 will not apply.

	[bundle "bundle-4"]
		uri = file://$(pwd)/clone-from/bundle-4.bundle

	# Does not exist. Should be skipped.
	[bundle "bundle-5"]
		uri = file://$(pwd)/clone-from/bundle-5.bundle
	EOF

	GIT_TRACE2_PERF=1 \
	git clone --bundle-uri="file://$(pwd)/bundle-list" \
		clone-from clone-all-some 2>err &&
	! grep "Repository lacks these prerequisite commits" err &&
	! grep "fatal" err &&
	grep "warning: failed to download bundle from URI" err &&

	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
	git -C clone-all-some cat-file --batch-check <oids &&

	git -C clone-all-some for-each-ref --format="%(refname)" >refs &&
	grep "refs/bundles/" refs >actual &&
	cat >expect <<-\EOF &&
	refs/bundles/base
	refs/bundles/left
	EOF
	test_cmp expect actual

warning: failed to download bundle from URI 'file:///home/gitster/w/git.git/t/trash directory.t5558-clone-bundle-uri/clone-from/bundle-5.bundle'
warning: failed to download bundle from URI 'file:///home/gitster/w/git.git/t/trash directory.t5558-clone-bundle-uri/clone-from/bundle-0.bundle'
65d47d507bde981075d2f2532bb104e4b58b9170 commit 213
918de9f3988f29866b94f657626edb7247c7ddbd commit 213
475812ed564e3085586d0b0acc392cec0a90c18e commit 261
d1bc9f9c222df7b7de791db57cdf7e8ba0627c3e commit 213
d9df4505cb3522088b9e29d6051ac16f1564154a commit 213
65d47d507bde981075d2f2532bb104e4b58b9170 commit 213
918de9f3988f29866b94f657626edb7247c7ddbd commit 213
d1bc9f9c222df7b7de791db57cdf7e8ba0627c3e commit 213
0ddfaf193ff13d6ab39b7cbd9eed645e3ee2f050 commit 165
d9df4505cb3522088b9e29d6051ac16f1564154a commit 213
ok 9 - clone bundle list (file, all mode, some failures)

expecting success of 5558.10 'clone bundle list (file, all mode, all failures)': 
	cat >bundle-list <<-EOF &&
	[bundle]
		version = 1
		mode = all

	# Does not exist. Should be skipped.
	[bundle "bundle-0"]
		uri = file://$(pwd)/clone-from/bundle-0.bundle

	# Does not exist. Should be skipped.
	[bundle "bundle-5"]
		uri = file://$(pwd)/clone-from/bundle-5.bundle
	EOF

	git clone --bundle-uri="file://$(pwd)/bundle-list" \
		clone-from clone-all-fail 2>err &&
	! grep "Repository lacks these prerequisite commits" err &&
	! grep "fatal" err &&
	grep "warning: failed to download bundle from URI" err &&

	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
	git -C clone-all-fail cat-file --batch-check <oids &&

	git -C clone-all-fail for-each-ref --format="%(refname)" >refs &&
	! grep "refs/bundles/" refs

warning: failed to download bundle from URI 'file:///home/gitster/w/git.git/t/trash directory.t5558-clone-bundle-uri/clone-from/bundle-5.bundle'
warning: failed to download bundle from URI 'file:///home/gitster/w/git.git/t/trash directory.t5558-clone-bundle-uri/clone-from/bundle-0.bundle'
65d47d507bde981075d2f2532bb104e4b58b9170 commit 213
918de9f3988f29866b94f657626edb7247c7ddbd commit 213
475812ed564e3085586d0b0acc392cec0a90c18e commit 261
d1bc9f9c222df7b7de791db57cdf7e8ba0627c3e commit 213
d9df4505cb3522088b9e29d6051ac16f1564154a commit 213
65d47d507bde981075d2f2532bb104e4b58b9170 commit 213
918de9f3988f29866b94f657626edb7247c7ddbd commit 213
d1bc9f9c222df7b7de791db57cdf7e8ba0627c3e commit 213
0ddfaf193ff13d6ab39b7cbd9eed645e3ee2f050 commit 165
d9df4505cb3522088b9e29d6051ac16f1564154a commit 213
ok 10 - clone bundle list (file, all mode, all failures)

expecting success of 5558.11 'clone bundle list (file, any mode)': 
	cat >bundle-list <<-EOF &&
	[bundle]
		version = 1
		mode = any

	# Does not exist. Should be skipped.
	[bundle "bundle-0"]
		uri = file://$(pwd)/clone-from/bundle-0.bundle

	[bundle "bundle-1"]
		uri = file://$(pwd)/clone-from/bundle-1.bundle

	# Does not exist. Should be skipped.
	[bundle "bundle-5"]
		uri = file://$(pwd)/clone-from/bundle-5.bundle
	EOF

	git clone --bundle-uri="file://$(pwd)/bundle-list" \
		clone-from clone-any-file 2>err &&
	! grep "Repository lacks these prerequisite commits" err &&

	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
	git -C clone-any-file cat-file --batch-check <oids &&

	git -C clone-any-file for-each-ref --format="%(refname)" >refs &&
	grep "refs/bundles/" refs >actual &&
	cat >expect <<-\EOF &&
	refs/bundles/base
	EOF
	test_cmp expect actual

65d47d507bde981075d2f2532bb104e4b58b9170 commit 213
918de9f3988f29866b94f657626edb7247c7ddbd commit 213
475812ed564e3085586d0b0acc392cec0a90c18e commit 261
d1bc9f9c222df7b7de791db57cdf7e8ba0627c3e commit 213
d9df4505cb3522088b9e29d6051ac16f1564154a commit 213
65d47d507bde981075d2f2532bb104e4b58b9170 commit 213
918de9f3988f29866b94f657626edb7247c7ddbd commit 213
d1bc9f9c222df7b7de791db57cdf7e8ba0627c3e commit 213
0ddfaf193ff13d6ab39b7cbd9eed645e3ee2f050 commit 165
d9df4505cb3522088b9e29d6051ac16f1564154a commit 213
ok 11 - clone bundle list (file, any mode)

expecting success of 5558.12 'clone bundle list (file, any mode, all failures)': 
	cat >bundle-list <<-EOF &&
	[bundle]
		version = 1
		mode = any

	# Does not exist. Should be skipped.
	[bundle "bundle-0"]
		uri = $HTTPD_URL/bundle-0.bundle

	# Does not exist. Should be skipped.
	[bundle "bundle-5"]
		uri = $HTTPD_URL/bundle-5.bundle
	EOF

	git clone --bundle-uri="file://$(pwd)/bundle-list" \
		clone-from clone-any-fail 2>err &&
	! grep "fatal" err &&
	grep "warning: failed to download bundle from URI" err &&

	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
	git -C clone-any-fail cat-file --batch-check <oids &&

	git -C clone-any-fail for-each-ref --format="%(refname)" >refs &&
	! grep "refs/bundles/" refs

warning: failed to download bundle from URI '/bundle-5.bundle'
warning: failed to download bundle from URI '/bundle-0.bundle'
65d47d507bde981075d2f2532bb104e4b58b9170 commit 213
918de9f3988f29866b94f657626edb7247c7ddbd commit 213
475812ed564e3085586d0b0acc392cec0a90c18e commit 261
d1bc9f9c222df7b7de791db57cdf7e8ba0627c3e commit 213
d9df4505cb3522088b9e29d6051ac16f1564154a commit 213
65d47d507bde981075d2f2532bb104e4b58b9170 commit 213
918de9f3988f29866b94f657626edb7247c7ddbd commit 213
d1bc9f9c222df7b7de791db57cdf7e8ba0627c3e commit 213
0ddfaf193ff13d6ab39b7cbd9eed645e3ee2f050 commit 165
d9df4505cb3522088b9e29d6051ac16f1564154a commit 213
ok 12 - clone bundle list (file, any mode, all failures)

checking prerequisite: NOT_ROOT

mkdir -p "$TRASH_DIRECTORY/prereq-test-dir-NOT_ROOT" &&
(
	cd "$TRASH_DIRECTORY/prereq-test-dir-NOT_ROOT" &&
	uid=$(id -u) &&
	test "$uid" != 0

)
prerequisite NOT_ROOT ok
expecting success of 5558.13 'fail to fetch from non-existent HTTP URL': 
	test_when_finished rm -rf test &&
	git clone --bundle-uri="$HTTPD_URL/does-not-exist" . test 2>err &&
	grep "failed to download bundle from URI" err

warning: failed to download bundle from URI 'http://127.0.0.1:5558/does-not-exist'
ok 13 - fail to fetch from non-existent HTTP URL

expecting success of 5558.14 'fail to fetch from non-bundle HTTP URL': 
	test_when_finished rm -rf test &&
	echo bogus >"$HTTPD_DOCUMENT_ROOT_PATH/bogus" &&
	git clone --bundle-uri="$HTTPD_URL/bogus" . test 2>err &&
	grep "is not a bundle" err

warning: file at URI 'http://127.0.0.1:5558/bogus' is not a bundle or bundle list
ok 14 - fail to fetch from non-bundle HTTP URL

expecting success of 5558.15 'clone HTTP bundle': 
	cp clone-from/B.bundle "$HTTPD_DOCUMENT_ROOT_PATH/B.bundle" &&

	git clone --no-local --mirror clone-from \
		"$HTTPD_DOCUMENT_ROOT_PATH/fetch.git" &&

	git clone --bundle-uri="$HTTPD_URL/B.bundle" \
		"$HTTPD_URL/smart/fetch.git" clone-http &&
	git -C clone-http rev-parse refs/bundles/topic >actual &&
	git -C clone-from rev-parse topic >expect &&
	test_cmp expect actual &&

	test_config -C clone-http log.excludedecoration refs/bundle/

Cloning into bare repository '/home/gitster/w/git.git/t/trash directory.t5558-clone-bundle-uri/httpd/www/fetch.git'...
Cloning into 'clone-http'...
Downloading via HTTP: 100% (520/520)^MDownloading via HTTP: 100% (520/520), 520 bytes | 520.00 KiB/s, done.
ok 15 - clone HTTP bundle

expecting success of 5558.16 'clone HTTP bundle with non-default hash': 
	test_when_finished "rm -rf clone-http-non-default-hash" &&
	GIT_DEFAULT_HASH=sha256 git clone --bundle-uri="$HTTPD_URL/B.bundle" \
		"$HTTPD_URL/smart/fetch.git" clone-http-non-default-hash &&
	git -C clone-http-non-default-hash rev-parse refs/bundles/topic >actual &&
	git -C clone-from rev-parse topic >expect &&
	test_cmp expect actual

Cloning into 'clone-http-non-default-hash'...
Downloading via HTTP: 100% (520/520)^MDownloading via HTTP: 100% (520/520), 520 bytes | 520.00 KiB/s, done.
ok 16 - clone HTTP bundle with non-default hash

expecting success of 5558.17 'clone bundle list (HTTP, no heuristic)': 
	test_when_finished rm -f trace*.txt &&

	cp clone-from/bundle-*.bundle "$HTTPD_DOCUMENT_ROOT_PATH/" &&
	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
	[bundle]
		version = 1
		mode = all

	[bundle "bundle-1"]
		uri = $HTTPD_URL/bundle-1.bundle

	[bundle "bundle-2"]
		uri = $HTTPD_URL/bundle-2.bundle

	[bundle "bundle-3"]
		uri = $HTTPD_URL/bundle-3.bundle

	[bundle "bundle-4"]
		uri = $HTTPD_URL/bundle-4.bundle
	EOF

	GIT_TRACE2_EVENT="$(pwd)/trace-clone.txt" \
		git clone --bundle-uri="$HTTPD_URL/bundle-list" \
		clone-from clone-list-http  2>err &&
	! grep "Repository lacks these prerequisite commits" err &&

	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
	git -C clone-list-http cat-file --batch-check <oids &&

	cat >expect <<-EOF &&
	$HTTPD_URL/bundle-1.bundle
	$HTTPD_URL/bundle-2.bundle
	$HTTPD_URL/bundle-3.bundle
	$HTTPD_URL/bundle-4.bundle
	$HTTPD_URL/bundle-list
	EOF

	# Sort the list, since the order is not well-defined
	# without a heuristic.
	test_remote_https_urls <trace-clone.txt | sort >actual &&
	test_cmp expect actual

65d47d507bde981075d2f2532bb104e4b58b9170 commit 213
918de9f3988f29866b94f657626edb7247c7ddbd commit 213
475812ed564e3085586d0b0acc392cec0a90c18e commit 261
d1bc9f9c222df7b7de791db57cdf7e8ba0627c3e commit 213
d9df4505cb3522088b9e29d6051ac16f1564154a commit 213
65d47d507bde981075d2f2532bb104e4b58b9170 commit 213
918de9f3988f29866b94f657626edb7247c7ddbd commit 213
d1bc9f9c222df7b7de791db57cdf7e8ba0627c3e commit 213
0ddfaf193ff13d6ab39b7cbd9eed645e3ee2f050 commit 165
d9df4505cb3522088b9e29d6051ac16f1564154a commit 213
ok 17 - clone bundle list (HTTP, no heuristic)

expecting success of 5558.18 'clone bundle list (HTTP, any mode)': 
	cp clone-from/bundle-*.bundle "$HTTPD_DOCUMENT_ROOT_PATH/" &&
	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
	[bundle]
		version = 1
		mode = any

	# Does not exist. Should be skipped.
	[bundle "bundle-0"]
		uri = $HTTPD_URL/bundle-0.bundle

	[bundle "bundle-1"]
		uri = $HTTPD_URL/bundle-1.bundle

	# Does not exist. Should be skipped.
	[bundle "bundle-5"]
		uri = $HTTPD_URL/bundle-5.bundle
	EOF

	git clone --bundle-uri="$HTTPD_URL/bundle-list" \
		clone-from clone-any-http 2>err &&
	! grep "fatal" err &&
	grep "warning: failed to download bundle from URI" err &&

	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
	git -C clone-any-http cat-file --batch-check <oids &&

	git -C clone-list-file for-each-ref --format="%(refname)" >refs &&
	grep "refs/bundles/" refs >actual &&
	cat >expect <<-\EOF &&
	refs/bundles/base
	refs/bundles/left
	refs/bundles/merge
	refs/bundles/right
	EOF
	test_cmp expect actual

fatal: failed to download file at URL 'http://127.0.0.1:5558/bundle-5.bundle'
fatal: failed to download file at URL 'http://127.0.0.1:5558/bundle-0.bundle'
not ok 18 - clone bundle list (HTTP, any mode)
#	
#		cp clone-from/bundle-*.bundle "$HTTPD_DOCUMENT_ROOT_PATH/" &&
#		cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
#		[bundle]
#			version = 1
#			mode = any
#	
#		# Does not exist. Should be skipped.
#		[bundle "bundle-0"]
#			uri = $HTTPD_URL/bundle-0.bundle
#	
#		[bundle "bundle-1"]
#			uri = $HTTPD_URL/bundle-1.bundle
#	
#		# Does not exist. Should be skipped.
#		[bundle "bundle-5"]
#			uri = $HTTPD_URL/bundle-5.bundle
#		EOF
#	
#		git clone --bundle-uri="$HTTPD_URL/bundle-list" \
#			clone-from clone-any-http 2>err &&
#		! grep "fatal" err &&
#		grep "warning: failed to download bundle from URI" err &&
#	
#		git -C clone-from for-each-ref --format="%(objectname)" >oids &&
#		git -C clone-any-http cat-file --batch-check <oids &&
#	
#		git -C clone-list-file for-each-ref --format="%(refname)" >refs &&
#		grep "refs/bundles/" refs >actual &&
#		cat >expect <<-\EOF &&
#		refs/bundles/base
#		refs/bundles/left
#		refs/bundles/merge
#		refs/bundles/right
#		EOF
#		test_cmp expect actual
#	
1..18
