From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] diff: add test for --no-index executed outside repo
Date: Mon, 16 Dec 2013 11:42:42 -0800
Message-ID: <xmqqob4goa4t.fsf@gitster.dls.corp.google.com>
References: <xmqqtxe8pu05.fsf@gitster.dls.corp.google.com>
	<1387221810-32374-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 16 20:42:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vse42-0000jP-L8
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 20:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755406Ab3LPTmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 14:42:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35202 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755341Ab3LPTmq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 14:42:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A67C5BD48;
	Mon, 16 Dec 2013 14:42:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qLsuSEKJ3F7FVPyjQslhBUyFTIY=; b=Y269Uu
	Vcq8QOX1tZpSHA8ERUGE6AsJ9A78o8wsfLE8DImoojlMpJYsnUAUygd7lpb+5bQ3
	2aOI94xUu+FsxE9Tzs9ZxkAYMIm9xJbAJnCnADBzw9pWLyiAOExJ6a8MuBXDFCu+
	7n9CumKSeXYdx3tXRuqiLm8FDTOX3LPKn0n2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=szqU+AGiInOfcmVdP2+fvstb0/TR7bUC
	wHoWORgLQ5qpOy+8DcABFDDz39XUMHazWpyr8qusW/ysWMTRA2rbUu8Rg/7OAV1P
	TV5+sK6ZrURO2qlSXv1UsKdMsK4eBcua3WPnCMV98MZ9cjasBy7E1e6oshxgvC+J
	YoCO0kqG1tQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 599305BD47;
	Mon, 16 Dec 2013 14:42:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D1AF5BD45;
	Mon, 16 Dec 2013 14:42:44 -0500 (EST)
In-Reply-To: <1387221810-32374-1-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Mon, 16 Dec 2013 20:23:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3BD5AFC8-668A-11E3-B4DD-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239357>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> 470faf9 diff: move no-index detection to builtin/diff.c breaks the error
> message for "git diff --no-index", when the command is executed outside
> of a git repository and the wrong number of arguments are given. 6df5762
> diff: don't read index when --no-index is given fixes the problem.
>
> Add a test to guard against similar breakages in the future.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>
>>> Thanks, I've missed that one.  It only happens when run outside a git
>>> repository, but the same  comments still apply.  Will fix and send a
>>> re-roll.
>>
>> Please don't, as the last round has already been pushed on 'next'.
>
> Sorry about that, should have checked first.
>
>> An incremental change on top would also illustrate more clearly what
>> breakage needed to be fixed, which would be another good thing. It
>> could even come with a new test that makes sure that the above
>> command line is diagnosed correctly as a mistake ;-).
>
> The breakage is actually fixed with the second patch as described in
> the commit message above, so here is just a test against future
> breakages.  This test only works when the test root is outside of a
> git repository, as otherwise nongit will not be set.  Is there another
> way to write it?

Perhaps use CEILING, like this (untested)?

	mkdir -p test-outside/non/git &&
        (
                GIT_CEILING_DIRECTORIES=$TRASH_DIRECTORY/test-outside &&
		export GIT_CEILING_DIRECTORIES &&
		cd test-outside/non/git &&
		do whatever non-git thing here
	)
