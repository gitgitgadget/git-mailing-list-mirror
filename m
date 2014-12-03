From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status / git diff -C not detecting file copy
Date: Wed, 03 Dec 2014 08:01:34 -0800
Message-ID: <xmqqa934lo2p.fsf@gitster.dls.corp.google.com>
References: <CAJxwDJzzNV77cTP4nbzgCvFjjqp3C4X8d3j6uwhYvK4+g4r1YQ@mail.gmail.com>
	<CAGyf7-E_y8zRUKh5RWvAhPXzSgpnVab6e=e1v92rSVVxf+LNJg@mail.gmail.com>
	<CAJxwDJzxUEd3czHpwDtKaERKDhvyCGOzGbKO4X9z44ugTJ2q4w@mail.gmail.com>
	<CAGyf7-F9twCEUY-LN=xEf4=gfNW8oLEHJmTjHRQ2MncHZ2emZQ@mail.gmail.com>
	<20141202065550.GB1948@peff.net>
	<xmqqvblukk98.fsf@gitster.dls.corp.google.com>
	<20141202200910.GB23461@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Bryan Turner <bturner@atlassian.com>,
	Pol Online <info@pol-online.net>,
	Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 03 17:01:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwCN3-0006pN-GT
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 17:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbaLCQBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 11:01:37 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59061 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751291AbaLCQBg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 11:01:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F5FC225A9;
	Wed,  3 Dec 2014 11:01:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E/UeBY2lhMTahwsh/XPaPsGH1Z4=; b=asuMRD
	/mKfuNs/zfEyRmk5rYAxT/SxjAD4HFbr5xwRnm6OSmGB1brExkefHoiW/kul9SOU
	mW3iRuOAl3fSzeMp+8PPKff62RM5ZxfTzDAwPG9ngSynb/0Wf/ufdSzzmk3ORBdY
	KglV4UMCo9UWilsQ7Dc+bOiedKcBWd7YvlV2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BwT/2qPv2L3cOSuZmZdK1CcJFJEnPSXP
	vC+KhKz6wkOQPJ/E8uti6YNly9FqUiPr+oZtuTk9bUpHrHAqPiEWKW8IYkqh960c
	5A4/VQI0j1z0++dhKMT+dO4oSeAJFgKwjLlEozAyA9TLIr9wNQO4PbpeDQ0qEzrV
	ancvfzmsSwE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 54FD9225A8;
	Wed,  3 Dec 2014 11:01:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD4BB225A7;
	Wed,  3 Dec 2014 11:01:35 -0500 (EST)
In-Reply-To: <20141202200910.GB23461@peff.net> (Jeff King's message of "Tue, 2
	Dec 2014 15:09:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A869B860-7B05-11E4-9D38-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260654>

Jeff King <peff@peff.net> writes:

> I find that git.git is often a useful and easy thing to time to
> extrapolate to other projects. It's 1/10th-1/20th the size of the kernel
> (both in tree size and commit depth), which I do consider a "big
> project" (and I have a feeling is what Linus was talking about).
>
> Of course, performance numbers do not always scale linearly with repo
> size.
> ...
> What does impact it is the _size_ of each commit. If you quite
> frequently add a new file while touching tens of thousands of other
> files, then the performance will be a lot more noticeable. And both
> git.git and linux.git are probably better than some other projects about
> having small commits.

Yes, the number of paths touched per-commit in git.git may not be
typical.  If it is unusually lower, that would skew the result, as
the cost of rename detection is proportional to it, and the cost of
-C -C is that number times the number of total paths in the project.

> Still, though. I stand by my earlier conclusions. Even with commits ten
> times as large as the kernel's, you are talking about 3ms added to a
> "status" run (and again, only when you hit such a gigantic commit _and_
> it has an 'A' file).
>
>> It is a fine idea to make this configurable ("status.renames = -C"
>> or something, perhaps?), though.
>
> I think it would be OK to move to "-C" as a default, but I agree it is
> nicer if it is configurable, as it gives a safety hatch for people in
> pathological repos to drop back to the old behavior (or even turn off
> renames altogether).

Yeah I am OK with that, too.
