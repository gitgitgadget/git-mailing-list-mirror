From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] diff-lib.c: adjust position of i-t-a entries in diff
Date: Mon, 16 Mar 2015 09:05:45 -0700
Message-ID: <xmqqa8zdrkpy.fsf@gitster.dls.corp.google.com>
References: <1425910445-27383-2-git-send-email-pclouds@gmail.com>
	<1426514206-30949-1-git-send-email-pclouds@gmail.com>
	<5506F3A9.1020704@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 16 17:05:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXXWb-0007Ck-Pt
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 17:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934539AbbCPQFt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Mar 2015 12:05:49 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62984 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933806AbbCPQFs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2015 12:05:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D51AE3FAAA;
	Mon, 16 Mar 2015 12:05:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0TEnJpSqTyu7
	pXGi3E/WBhNkQsM=; b=oP8/UalfRWw04hS2/ayi3par39UPtjzXoiDiG9/gSs5l
	pM+RQ73lRjV/WppL9cGtTAYVKG8jmIeaQrX3k0AmZi/yuAcoMtPNehxbJLFOgiLT
	6WBlz0yZrWLhiJAoPcnieMw1N4wC43HhXB8GZv4qJQH8cZDDyFmVYKLYuDYZUQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=f5xMej
	BcsdyF10U1w26RFns2V/28EMy1GC8cJt7ExGY9qO1uPVbnRLCHhmV8M3bBIPbEQ/
	af7bLUK1iZpw4/ZViWQ+Db4RdUbi2sBPJix327b4y347mmm3bubjVqQNt6bj19/a
	oZq12lfXEpF0P/PcaA77zre8SaPVsLLJrVe8A=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C77CF3FAA9;
	Mon, 16 Mar 2015 12:05:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 22E323FAA8;
	Mon, 16 Mar 2015 12:05:47 -0400 (EDT)
In-Reply-To: <5506F3A9.1020704@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Mon, 16 Mar 2015 16:15:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4EC30888-CBF6-11E4-9F14-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265570>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy venit, vidit, dixit 16.03.2=
015 14:56:
>
>> The test "cache-tree invalidates i-t-a paths" is marked failure
>> because I don't think removing "--cached" from "git diff" is the rig=
ht
>> fix. This test relies on "diff --cached" behavior but the behavior n=
ow
>> has changed. We may need to revisit this test at some point in futur=
e.
>
> I can't quite follow that reasoning. If the test describes expected
> behavior which the patch breaks, then we should not apply the patch. =
If
> the patch changes behavior in an expected way, then we should change =
the
> test to match.

The offending one came from eec3e7e4 (cache-tree: invalidate i-t-a
paths after generating trees, 2012-12-16), which was a fix to an
earlier bug where a cache-tree written out of an index with i-t-a
entries had incorrect information and still claimed it is fully
valid after write-tree rebuilt it.  The test probably should add
another path without i-t-a bit, run the same "diff --cached" with
updated expectation before write-tre, and run the "diff --cached"
again to make sure it produces a result that match the updated
expectation.
