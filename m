From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/5] t0060: Add test for manipulating symlinks via absolute paths
Date: Mon, 03 Feb 2014 10:50:17 -0800
Message-ID: <xmqq7g9cf2ty.fsf@gitster.dls.corp.google.com>
References: <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
	<1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
	<1391358940-17373-2-git-send-email-martinerikwerner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, richih@debian.org, tboegi@web.de,
	pclouds@gmail.com, dak@gnu.org
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 19:50:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAObD-00055V-EH
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 19:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033AbaBCSuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 13:50:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55914 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639AbaBCSuW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 13:50:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DED069F96;
	Mon,  3 Feb 2014 13:50:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FjuOHGVZtFVrjgMpTU0M+SEGppw=; b=LyO2Re
	aUTtZssoG8kvlc2xOwbFJ16N9BOT7/Z/ec359UMQYcbsxD1T1rrzGY70tygKv8/S
	vLCdloVflvOeFWaffShpneHRmt7ai7m7QfJdKId4OV2+Q6LcpP9MngQ622XwbggG
	KtugePtXs26QDeTNaauG+KVqBXhpqqu2pCd6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jnJ4CuuJ/dMqJyOWEAX1LCovzeSXXyWR
	LcdyzFCJcIext/cM5D+65lQiVYh6BPZkSR1oV4slU3nKZfwwJgXo/hl4RU+TY/B6
	TLUoypxOXtVVc57cE5Ro4RWNGXAlA35bY8HbHA5KaZlCg21sCxKqqnLSDFSKag+O
	oGKSlDslgqM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B8BA69F95;
	Mon,  3 Feb 2014 13:50:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 376A369F94;
	Mon,  3 Feb 2014 13:50:20 -0500 (EST)
In-Reply-To: <1391358940-17373-2-git-send-email-martinerikwerner@gmail.com>
	(Martin Erik Werner's message of "Sun, 2 Feb 2014 17:35:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 07E59D7C-8D04-11E3-9332-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241447>

Martin Erik Werner <martinerikwerner@gmail.com> writes:

> When symlinks in the working tree are manipulated using the absolute
> path, git dereferences them, and tries to manipulate the link target
> instead.

The above may a very good description of the root cause, but
can we have description of a symptom that is visible by end-users
that is caused by the bug being fixed with the series here, by
ending the above like so:

	... link target instead.  This causes "git foo bar" to
	misbehave in this and that way.

Testing the low-level underlying machinery like this patch does is
not wrong per-se, but I suspect that this series was triggered by
somebody noticing breakage in a end-user command "git foo $path"
with $path being a full pathname to an in-tree symbolic link.  It
wouldn't be like somebody who was bored and ran "test-path-utils"
for fun noticed the root cause without realizing how the fix would
affect the behaviour that would be visible to end-users, right?

Can we have that "git foo $path" to the testsuite as well?  That is
the breakage we do not want to repeat in the future by regressing.

I am guessing "foo" is "add", but I wasn't closely following the
progression of the series.

Thanks.
