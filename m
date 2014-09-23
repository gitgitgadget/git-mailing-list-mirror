From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git tag --contains: avoid stack overflow
Date: Tue, 23 Sep 2014 15:41:09 -0700
Message-ID: <xmqqk34ugdtm.fsf@gitster.dls.corp.google.com>
References: <20140417215817.GA822@sigill.intra.peff.net>
	<20140423075325.GA7268@camelia.ucw.cz>
	<xmqqeh0nzwq9.fsf@gitster.dls.corp.google.com>
	<20140423191628.GA20596@sigill.intra.peff.net>
	<xmqqk3afydq2.fsf@gitster.dls.corp.google.com>
	<20140423205533.GA20582@sigill.intra.peff.net>
	<xmqqfvl3ycwk.fsf@gitster.dls.corp.google.com>
	<20140424122029.GA8168@camelia.ucw.cz>
	<20140424122439.GB8168@camelia.ucw.cz> <871tr688a4.fsf@igel.home>
	<20140923160552.GA20624@peff.net> <87wq8u3t4l.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Stepan Kasal <kasal@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Sep 24 00:41:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWYls-0000RH-OW
	for gcvg-git-2@plane.gmane.org; Wed, 24 Sep 2014 00:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756867AbaIWWlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 18:41:15 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62308 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755443AbaIWWlO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 18:41:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 82E7B3B239;
	Tue, 23 Sep 2014 18:41:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cG6lVSopE4EMHr8WRFZhKruoiEQ=; b=DOvWw2
	S+6Iw2vaVeGmw2NQ1IR5oQr4uqfATPu6qIMEac6VRxK/UFq+bgiPY3tkPfo0pJOP
	hEcqGHrQf8yvZuMOYk5BkKHp02TSpj/vSuVaiYwSF7+3KpPJXETUjy2ZzUiMMf6r
	yJZC26bvGtwZmwqPFIdxBHi+OqVylQnArVE6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SEC4V1CxOkxBky56oSzBYydqu4F7Hfbs
	+82Vtdlp+zdZAu3WFC0L9IwU/HxXw/h46I/JM3b0fqVDJ8/r1iLGAO27CRnOavTH
	5GgDYG6m31WcFbn9AO4jygWjl2MOHC6mz2NZKB5bSH/05o/Sv+Fi4WoR0PwMpLPr
	NYXjjFsV5Ok=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 56FF03B238;
	Tue, 23 Sep 2014 18:41:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 066E23B230;
	Tue, 23 Sep 2014 18:41:10 -0400 (EDT)
In-Reply-To: <87wq8u3t4l.fsf@igel.home> (Andreas Schwab's message of "Tue, 23
	Sep 2014 23:48:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B768FF58-4372-11E4-8300-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257448>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Jeff King <peff@peff.net> writes:
>
>> But if we do want to keep it, does bumping it to 128 (and bumping the
>> 4000 to 8000 in the test below it) work?
>
> It works for all architectures supported by the openSUSE build service.
>
> https://build.opensuse.org/package/show/home:AndreasSchwab:f/git
>
> Andreas.

So this on top of cbc60b67 (git tag --contains: avoid stack
overflow, 2014-04-24) and merge it to maint and upwards?

 t/t7004-tag.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index e4ab0f5..c564197 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1424,7 +1424,7 @@ EOF
 '
 
 run_with_limited_stack () {
-	(ulimit -s 64 && "$@")
+	(ulimit -s 128 && "$@")
 }
 
 test_lazy_prereq ULIMIT 'run_with_limited_stack true'
@@ -1433,7 +1433,7 @@ test_lazy_prereq ULIMIT 'run_with_limited_stack true'
 test_expect_success ULIMIT '--contains works in a deep repo' '
 	>expect &&
 	i=1 &&
-	while test $i -lt 4000
+	while test $i -lt 8000
 	do
 		echo "commit refs/heads/master
 committer A U Thor <author@example.com> $((1000000000 + $i * 100)) +0200
