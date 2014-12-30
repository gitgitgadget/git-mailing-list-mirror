From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why do dates in refspecs require the reflog?
Date: Tue, 30 Dec 2014 12:47:02 -0800
Message-ID: <xmqq1tngsw55.fsf@gitster.dls.corp.google.com>
References: <CAHd499Cvy=zi=9utoZ2bEgdSUTjkveHMP2OvVFPBHq7W2MuoZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 21:47:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y63hD-0003eb-O6
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 21:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbaL3UrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 15:47:11 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54346 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751321AbaL3UrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 15:47:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 334472ABD3;
	Tue, 30 Dec 2014 15:47:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rNEU2H4MfNBMMRogFYnOvnjATn4=; b=Ch/ZHF
	v4w9/k0gC1j+bcn3yuFnzMq9GrffXAnRfzql2pf4QyIRfyrreAQQjeuy/PLojZ8d
	QCJIAcMwdUN6altpsCjl+q3q440+OiB6dc3ehLPom0NAh4WMijoVK8KjlXmB6lDA
	v9KfV0oG8yCAjeJCz4FBuWDpWgYCBs7PjW83k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ImWijfLMbWuB1JUtcD9S6AFwwyYOTEEo
	uLODyP+wENiV26faBAbpTra2B9jfG8OZ9NAOGAif4de4HctxhOq2vX3o81d9DEim
	vGJFQC2egaILqJaJ/Smw3G37dgs8UQDmAbXcwQeRuOUKsmTTgl3EE0MRgz4Cv1rp
	56pPowPG/Y0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 297D92ABD2;
	Tue, 30 Dec 2014 15:47:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 933762ABD1;
	Tue, 30 Dec 2014 15:47:03 -0500 (EST)
In-Reply-To: <CAHd499Cvy=zi=9utoZ2bEgdSUTjkveHMP2OvVFPBHq7W2MuoZQ@mail.gmail.com>
	(Robert Dailey's message of "Tue, 30 Dec 2014 14:12:15 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 02829442-9065-11E4-BDA8-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261943>

Robert Dailey <rcdailey.lists@gmail.com> writes:

> ... how can I view the
> contents of a file at a specified relative time frame ...

"git log --until=A --since=B master" asks Git to start traversing
the history backward from the tip of your current 'master' branch,
without showing anything until it finds a commit with timestamp A
(or before), and then show the commits it finds during the traversal
until it finds a commit with timestamp B (or before) and then stop.

Which I think is the closest thing you are asking for.

Note that there is *no* guarantee that any of these commits you find
that way was actually at the tip of the public history (i.e. the one
casual users would have seen after running "git clone" at that time).

The committer may have started working at around time B, worked for
quite some time, and pushed the result out way after time A.  Then
the first time general public observed the commits you find in that
time range could be after time A by many weeks, which is perfectly
normal in the real, distributed, world.
