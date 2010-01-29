From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Custom git completion
Date: Fri, 29 Jan 2010 09:42:48 -0800
Message-ID: <7v4om4kdt3.fsf@alter.siamese.dyndns.org>
References: <9b69cfcf1001290457s6b7fad6cs5a915f16a11f5782@mail.gmail.com>
 <20100129151127.GA21821@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Rhodes Clymer <david@zettazebra.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 29 18:43:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Naus5-0001Hn-BC
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 18:43:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498Ab0A2Rm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 12:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752983Ab0A2Rm6
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 12:42:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071Ab0A2Rm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 12:42:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B49CB95553;
	Fri, 29 Jan 2010 12:42:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OzcBcgF2m0kIZigSRF0lguAq0yw=; b=hlKjw0
	O0ntY1U+Bc0iTKHdlSiknzu/bMQK5TkGfL8A4Ss+XED3NqSqUxyn0PLD2wPGEDNE
	AXPcKcvJCzXgsWEwWq7U+kD61TRBAHPgmhBi+zvYG4cU9gWSHsGvyAEWwALuObKJ
	e2wICp0ogRRV2qmn6PrFTOr7j5kQNIsFQiGRg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FazbN9B/LwENNgn8ljKmBXaYvIgFpoPR
	SwaCJCiBUdDUkkaR3XX7r3HfT5C/Vd8+v41tW3bMZS1Vx/C+yRsnyvyMkPjjJ2bJ
	XlwziPe2OTWF0sYZhehESuy4tg5uKVNzVBJgPGCx4BDz2yO6ry8/bKwUpovO0Udu
	Dmufcw+upvk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 836D595552;
	Fri, 29 Jan 2010 12:42:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB72395551; Fri, 29 Jan
 2010 12:42:49 -0500 (EST)
In-Reply-To: <20100129151127.GA21821@spearce.org> (Shawn O. Pearce's message
 of "Fri\, 29 Jan 2010 07\:11\:27 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BA3B2CF2-0CFD-11DF-BD9A-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138330>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> David Rhodes Clymer <david@zettazebra.com> wrote:
>> Unless I read it incorrectly, the completion script included with
>> git-core does not make it easy for users to write completion scripts
>> for custom git commands. I can extend git itself by creating a command
>> "git-foo", and placing it in my path.
>
> git config --global alias.foo /home/me/bin/my-git-foo
>
> git foo will now complete correctly.  No need to modify the
> completion code.

Yes.  Aliases and custom subcommands are found from 'git help" output just
fine (you need to install new subcommand in exec-path).

But.

How does the completion code learn what options and arguments such aliases
and subcommands (e.g. "git foo") take without being told?

An alias that uses another git subcommand (i.e. the ones that do not start
with a bang "!") seems to be handled correctly, but one of my aliases is
this:

    [alias]
	lgm = "!sh -c 'GIT_NOTES_REF=refs/notes/amlog git log \"$@\" || :' -"

and the completion code doesn't (and it is unfair to expect it to) notice
that "git log" is run under the hood.  I cannot say "git lgm sp/<TAB>" and
choose from the list of topics from you.
