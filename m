From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log -p unexpected behaviour - security risk?
Date: Sun, 21 Apr 2013 11:25:44 -0700
Message-ID: <7vzjwru4ev.fsf@alter.siamese.dyndns.org>
References: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
	<20130420140051.GB29454@ruderich.org>
	<7vd2towdiq.fsf@alter.siamese.dyndns.org>
	<CAHQ6N+pKb-44rOM7ocYMvSDyimvAGZppX1Gc=st59aVKzJSBKw@mail.gmail.com>
	<20130421102150.GJ10429@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>,
	Simon Ruderich <simon@ruderich.org>,
	Git List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 20:25:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTyxU-0005WJ-OJ
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 20:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890Ab3DUSZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 14:25:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34074 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753741Ab3DUSZs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 14:25:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5298A1629A;
	Sun, 21 Apr 2013 18:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f1tFwgTfyu0Aji4B3g5tjkE85WQ=; b=soPYNt
	0jQcXi+GtpXKht5QbidkaLpGVGyH9/SVWgjvog9+5dSk/yt+FQ1eUHGk83KeDCQc
	eihBCSyLL7oXXf6W/qcuYXQHk6rsHzQ+cNpNakNXUJY8Bjevw6CQk+RFukPRMfUQ
	uEnLr0O863Tk41hyDSI3Go8zDfIPUpbo7i9rw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H2ktiAJUVXyV6XS8ZSlI3JIlogI9cyd1
	EShf3ujCzPXyfZl+Q5gS9xfEynf4mS/15oG5PdoeOsa/1syxtyx2wHLyQiCyUXhU
	13MGzNIyMbk/wnG5hFZOk7ZdIroqkFJbPW2RBvfdim3YCPA9cpRK8rfA659j8F+R
	k8vyvl/T3Dw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4872C16298;
	Sun, 21 Apr 2013 18:25:46 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFAD016296;
	Sun, 21 Apr 2013 18:25:45 +0000 (UTC)
In-Reply-To: <20130421102150.GJ10429@elie.Belkin> (Jonathan Nieder's message
	of "Sun, 21 Apr 2013 03:21:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E20C8146-AAB0-11E2-87A3-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221960>

Jonathan Nieder <jrnieder@gmail.com> writes:

> That's why if you want to review the code you are pulling in as a
> whole, it is worthwhile to do
>
> 	git diff HEAD...FETCH_HEAD
>
> That is how you ask "What code changes does FETCH_HEAD introduce?"
> before putting your stamp of approval on them by merging and pushing
> out the result.

And the only way to retroactively review that a merge C did not do
anything funly is to check "git diff C^1 C", assuming that you
already trust C^1, the state before you performed the merge.
Incidentally, this works for non-merge commits just as well.

"git log -m -p" is not the default because most of the time people
are not interested in seeing what it shows over "--cc" or "-c".  It
is a repetition of what you would get from individual patches on the
side branch merged that you will later see in the traversal of that
command. "--cc/-c" gives a representation for tricky merge cases
where people could likely have made a mistake, or had correctly
resolved semantic conflicts (e.g. one side renames a function, the
other side adds a callsite, the merge result renames the function
new caller calls).

For the purpose of a "merge audit" John seems to want, the only way
is to wade through "log -m -p" output.  
