From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tackling Git Limitations with Singular Large Line-seperated Plaintext files
Date: Fri, 27 Jun 2014 10:48:49 -0700
Message-ID: <xmqqegya2qgu.fsf@gitster.dls.corp.google.com>
References: <CAJoVafc1LMxmvCiWci3N+AuAZBsABR3Wb3c6c3stw93OJZ7Scw@mail.gmail.com>
	<CAJo=hJtJCy96SRYmOxEpEMoEVcaegv0SCG0_AH2u0=bSrHZi_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jarrad Hope <me@jarradhope.com>, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 19:49:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0aGj-0008AL-2z
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 19:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbaF0Rs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 13:48:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61194 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751755AbaF0Rs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 13:48:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9909C22642;
	Fri, 27 Jun 2014 13:48:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tKYoZoCFmK2tC5kK4rWPSCBYav0=; b=t7S2TH
	wVlNLfpyrg8P8F7OYW1yOJ8NJWYHVuXKbswMuHbCWnxnIgXjjj2JTN2JcnUVxKOZ
	hS/CktjRWC5zHzMQT/hifXXFzPu94yvyIXwOsb2TLaIjTjIAhC1n08ah9d/HzIAn
	1Z4mxvNzRD86niyKkch4vKSceAP9MwBQC3wRM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FAojUK+CBHDRTuL4CdlbjjW54nUPnled
	t1z8l2UZH50ra7ji5m6r2z5wpoA5jmKA+ahjTllza2cfOsY+XR4JIyj7s/xU9gWP
	QgIhaw8vUgFxzW2frYJzESEu7e3sx6jmV+4vzolVSh29gucLKfNJSMr+Lf89rXze
	PhVYnW23wPI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9015822640;
	Fri, 27 Jun 2014 13:48:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D75B62263E;
	Fri, 27 Jun 2014 13:48:42 -0400 (EDT)
In-Reply-To: <CAJo=hJtJCy96SRYmOxEpEMoEVcaegv0SCG0_AH2u0=bSrHZi_A@mail.gmail.com>
	(Shawn Pearce's message of "Fri, 27 Jun 2014 08:45:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 478C2398-FE23-11E3-B6CE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252564>

Shawn Pearce <spearce@spearce.org> writes:

> Git does source code well. I don't know enough to judge if DNA/RNA
> sequence storage is similar enough to source code to benefit from
> things like `git log -p` showing deltas over time, or if some other
> algorithm would be more effective.
>
>> From my understanding the largest problem revolves around git's delta
>> discovery method, holding 2 files in memory at once - is there a
>> reason this could not be adapted to page/chunk the data in a sliding
>> window fashion ?
>
> During delta discovery Git holds like 11 files in memory at once....

Even though the original question mentioned "delta discovery", I
think what was being asked is not "delta" in the Git sense (which
your answer is about) but is "can we diff two long sequences of text
(that happens to consist of only 4-letter alphabet but that is a
irrelevant detail) without holding both in-core in their entirety?",
which is a more relevant question/desire from the application point
of view.

"Is there a reason this could not be adapted?"  No, there is no
particular reason why this "could not".  I think that the only
reason we only do in-core diff is because "adapting to page/chunk"
hasn't been anybody's high priority list of itches to scratch.
