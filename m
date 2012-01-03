From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Tue, 03 Jan 2012 11:34:08 -0800
Message-ID: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
References: <20111014211921.GB16429@sigill.intra.peff.net>
 <1318803076-4229-1-git-send-email-drizzd@aon.at>
 <20120102092508.GA10977@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 03 20:34:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiA7l-0005Qu-CX
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 20:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627Ab2ACTeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 14:34:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59636 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754510Ab2ACTeL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 14:34:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6C9E57B0;
	Tue,  3 Jan 2012 14:34:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZA3eEokC9Tl23ysa47J/kq9M878=; b=MTOlNT
	asgD6K2QRheK1bGSW1Ic9mpxvdY0V8frPqaD6s1lhi3PWTEaYu9V3KEX67csA+cU
	j2dro6ySeedsR4o2j0D5Pl5Lalg2aAZNVsRapaMjfbMewXV/PUzjMtL4Y3ol7fS+
	+1yDfF1P+3MXYVmWMEpJgBH0v84xezbhSkhqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PE/TAy052+qh0MMhooI8EyngiujXbvbG
	Lx2tYUwPfBZrqH4Btrj/JOH3R4sCIAaeNhHcPZXVjJIZwPl07brb5xWhFUQDxzB8
	sQGD3GQUD1uHYcQFFlG+GimYPo6itHBtHd5xRgV0tfKZFKdGDReFSn2yPimLcX+e
	DRHUZiRkNNQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBD6F57AD;
	Tue,  3 Jan 2012 14:34:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1249457AB; Tue,  3 Jan 2012
 14:34:09 -0500 (EST)
In-Reply-To: <20120102092508.GA10977@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Mon, 2 Jan 2012 03:25:08 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E897F340-3641-11E1-B48C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187878>

Jonathan Nieder <jrnieder@gmail.com> writes:

> (+cc: Erik, Ilari, Duy)
> Hi,
>
> Clemens Buchacher wrote:
>
>> [Subject: daemon: add tests]
>
> Can't believe I missed this.  That seems like a worthy cause ---
> can someone remind me why this is dropped, or if there are any
> tweaks I can help with to get it picked up again?

Thanks for your interest in this.

>> diff --git a/t/lib-daemon.sh b/t/lib-daemon.sh
>> new file mode 100644
>> index 0000000..30a89ea
>> --- /dev/null
>> +++ b/t/lib-daemon.sh
>> @@ -0,0 +1,52 @@
>> +#!/bin/sh
>> +
>> +if test -z "$GIT_TEST_DAEMON"
>> +then
>> +	skip_all="Daemon testing disabled (define GIT_TEST_DAEMON to enable)"
>> +	test_done
>> +fi
>> +
>> +LIB_DAEMON_PORT=${LIB_DAEMON_PORT-'8121'}

In lib-httpd.sh, LIB_HTTPD_PORT is defined in a similar way, but that is
always overridden by the users and the convention there is to use the test
numbers (cf. "git grep LIB_HTTPD_PORT t/"), which should be followed here
as well.

I am not very keen on the "lib-daemon.sh", GIT_TEST_DAEMON, etc. naming to
pretend as if "git daemon" will forever be the only daemon we will ever
ship, by the way.  We might one day want to add an inotify daemon, a
daemon for the git-pubsub protocol or somesuch.

>> +DAEMON_PID=
>> +DAEMON_DOCUMENT_ROOT_PATH="$PWD"/repo
>> +DAEMON_URL=git://127.0.0.1:$LIB_DAEMON_PORT
>> +
>> +start_daemon() {
>> +	if test -n "$DAEMON_PID"
>> +	then
>> +		error "start_daemon already called"
>> +	fi
>> +
>> +	mkdir -p "$DAEMON_DOCUMENT_ROOT_PATH"
>> +
>> +	trap 'code=$?; stop_daemon; (exit $code); die' EXIT
>> +
>> +	say >&3 "Starting git daemon ..."
>> +	git daemon --listen=127.0.0.1 --port="$LIB_DAEMON_PORT" \
>> +		--reuseaddr --verbose \
>> +		--base-path="$DAEMON_DOCUMENT_ROOT_PATH" \
>> +		"$@" "$DAEMON_DOCUMENT_ROOT_PATH" \
>> +		>&3 2>&4 &
>> +	DAEMON_PID=$!
>> +}
>> +
>> +stop_daemon() {
>> +	if test -z "$DAEMON_PID"
>> +	then
>> +		return
>> +	fi
>> +
>> +	trap 'die' EXIT
>> +
>> +	# kill git-daemon child of git
>> +	say >&3 "Stopping git daemon ..."
>> +	pkill -P "$DAEMON_PID"

How portable is this one (I usually do not trust use of pkill anywhere)?

>> +	wait "$DAEMON_PID"
>> +	ret=$?
	# Please comment what 143 is on this line.
>> +	if test $ret -ne 143
>> +	then
>> +		error "git daemon exited with status: $ret"
>> +	fi
>> +	DAEMON_PID=
>> +}
>> ...
>> +test_expect_success 'prepare pack objects' '
>> +	cp -R "$DAEMON_DOCUMENT_ROOT_PATH"/repo.git "$DAEMON_DOCUMENT_ROOT_PATH"/repo_pack.git &&
>> +	(cd "$DAEMON_DOCUMENT_ROOT_PATH"/repo_pack.git &&
>> +	 git --bare repack &&

As the later tests assume there will be only one pack, don't you want at
least "-a" and possibly "-a -d" here?

>> +	 git --bare prune-packed
>> +	)
>> +'
>> +
>> +test_expect_success 'fetch notices corrupt pack' '
>> +	cp -R "$DAEMON_DOCUMENT_ROOT_PATH"/repo_pack.git "$DAEMON_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
>> +	(cd "$DAEMON_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
>> +	 p=`ls objects/pack/pack-*.pack` &&
>> +	 chmod u+w $p &&
>> +	 printf %0256d 0 | dd of=$p bs=256 count=1 seek=1 conv=notrunc
>> +	) &&
>> +	mkdir repo_bad1.git &&
>> +	(cd repo_bad1.git &&
>> +	 git --bare init &&
>> +	 test_must_fail git --bare fetch $DAEMON_URL/repo_bad1.git &&
>> +	 test 0 = `ls objects/pack/pack-*.pack | wc -l`
>> +	)
>> +'
>> +
>> +test_expect_success 'fetch notices corrupt idx' '
>> +	cp -R "$DAEMON_DOCUMENT_ROOT_PATH"/repo_pack.git "$DAEMON_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
>> +	(cd "$DAEMON_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
>> +	 p=`ls objects/pack/pack-*.idx` &&
>> +	 chmod u+w $p &&
>> +	 printf %0256d 0 | dd of=$p bs=256 count=1 seek=1 conv=notrunc
>> +	) &&
>> +	mkdir repo_bad2.git &&
>> +	(cd repo_bad2.git &&
>> +	 git --bare init &&
>> +	 test_must_fail git --bare fetch $DAEMON_URL/repo_bad2.git &&
>> +	 test 0 = `ls objects/pack | wc -l`
>> +	)
>> +'
>> +
>> +test_remote_error()
>> +{
>> +	do_export=YesPlease
>> +	while test $# -gt 0
>> +	do
>> +		case $1 in
>> +		-x)
>> +			shift
>> +			chmod -X "$DAEMON_DOCUMENT_ROOT_PATH/repo.git"

I find the use of cap X here dubious; it makes your intention unclear.

Are you interested in the current status of 'x' bits on that directory, or
are you more interested in dropping the executable/searchable bits from
the directory no matter what its current status is (rhetorical: I fully
expect that the answer is the latter)? The same comment applies to the use
of "chmod +X" at the end of this helper function.
