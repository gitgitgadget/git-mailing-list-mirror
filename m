From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: file named - on git commit
Date: Mon, 28 Jan 2013 13:01:29 -0800
Message-ID: <7vobg9uimu.fsf@alter.siamese.dyndns.org>
References: <51065540.1090007@renemoser.net>
 <87txq11sbk.fsf@pctrast.inf.ethz.ch> <20130128204140.GA7759@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Rene Moser <mail@renemoser.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 22:01:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzvpy-0004eP-G7
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 22:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753721Ab3A1VBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 16:01:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48812 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650Ab3A1VBc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 16:01:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D034EB11A;
	Mon, 28 Jan 2013 16:01:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mSdAFxvH2iEc4dFJ4m8AZYNsVd4=; b=k3pt8i
	dyZTdmlDFZz1eMq26lXdevWYBK3VVvEdOoxJ2LjUXAcjdnah+J4//EfNNUXwyw4k
	UL03jSHBRYNcNUy/B3mjY3flsLfVZkzAA/XDv7f23RXoL59H/SAq8WJre7hsnHSv
	3wn3/+Mxz5HTF2SszjnvJNpILQIi5V3UVgKFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f/+/C7WHv0ASBTds55wa4oBXA5uu+fii
	YpN7I4BXzR3oUlOqHxlYnZzU4N1BqoAjBS8E6Fo2aVv4t7wXHcNxmnsoqFkpzI5k
	6BGAe+Jp+79lwOOFph3BAbIveSmh3x6dAujqlrZePEbGIXgLPm1bNutObJquF6he
	U67qteTGTBM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2845B119;
	Mon, 28 Jan 2013 16:01:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 228AAB114; Mon, 28 Jan 2013
 16:01:31 -0500 (EST)
In-Reply-To: <20130128204140.GA7759@google.com> (Jonathan Nieder's message of
 "Mon, 28 Jan 2013 12:41:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4070692-698D-11E2-9514-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214873>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thomas Rast wrote:
>> Rene Moser <mail@renemoser.net> writes:
>
>>> Found a little issue in git version 1.7.9.5 if a file named "-", causing
>>> "git commit" to read from stdin.
>>>
>>> (So you must hit ctrl-d or ctrl-c to finish the commit.)
> [...]
>> This was fixed by Junio around 4682d85 (diff-index.c: "git diff" has no
>> need to read blob from the standard input, 2012-06-27), which is
>> included starting with v1.7.12 and the v1.7.11.3 maint release.  Please
>> upgrade.
>
> Should upgrade-averse folks stuck on 1.7.10.y (like Debian 7.0, which
> is currently in the release candidate stage) take this fix?  Do you
> happen to know of any other fixes such people would want?

There are files with four dotted decimal numbers in their names in
the Documentation/RelNotes/ directory to help distro maintainers
like you to figure it want.

This is a tangent, but even with a project like git that is managed
with a good use of topic branch workflow, we may want to have a way
to reliably identify the tip of an ancient fix like this.  People
may be able to bisect down to 4682d85, and in this particular case,
I happen to know that there wasn't any side-effect breakage
introduced by that commit, but there needs to be an easy way (it
can be expensive to compute) to make sure there is no follow-up fix
to that particular commit.

I can read "git rev-list --parents | grep -C3 $(git rev-parse 4682d85)"
and then figure out what the children commits of that fix are, of
course, but I suspect most people will view it as primitive ;-)
