From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: add -i and --introduced modifier for --contains
Date: Tue, 22 Apr 2014 10:58:08 -0700
Message-ID: <xmqqppk95jrj.fsf@gitster.dls.corp.google.com>
References: <1397681938-18594-1-git-send-email-mcgrof@do-not-panic.com>
	<xmqqppkhexw3.fsf@gitster.dls.corp.google.com>
	<CAB=NE6VvDrMQ4ybF10MpXM-2672OdUTC_Rp2mdO3a5fuo1-H1Q@mail.gmail.com>
	<xmqqfvlbga4r.fsf@gitster.dls.corp.google.com>
	<20140422102713.GC366@quack.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, git@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>, Jiri Slaby <jslaby@suse.cz>,
	Andreas Schwab <schwab@suse.de>, Jeff King <peff@peff.net>
To: Jan Kara <jack@suse.cz>
X-From: git-owner@vger.kernel.org Tue Apr 22 19:58:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcexX-0007wT-W1
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 19:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933571AbaDVR6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 13:58:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42802 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932850AbaDVR6N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 13:58:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D388E7FC2A;
	Tue, 22 Apr 2014 13:58:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mQJJjRTSAyePJ5NiRPUyfO5iT9Y=; b=D4Mm0B
	EZc9T41VYPjbErhHEU9+zFNYz3Ti5omwbATr+EdPinyJq2CfwUpWXTiToPUL/mU7
	dOPWV/f+qcsBY1odyBBGKTzGU1C1rE0W7n0/nQEANBHNUQJS6sW2TeLZDbOk9SJ+
	vD2c9RM2Y3fNYvLlMbZbx4ZpOE8Ke6vCJeIHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KEJLwwoC6eFMP4L7P+QpmWEDkXXfjsAy
	gwgVA9Vjcpf/JxiJ2Ekb4Mv5ZCM+tJRPYrW4mYO6DVxmeejZFC2n4yU56nrVQ04s
	Ec7JktS7Q+qETUxzdrAIqqm60Qy7Di3s15qhvxJKQY37PphxGkczxEIX+oR8CZJz
	CPX7Kjm6Ooo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD4E87FC28;
	Tue, 22 Apr 2014 13:58:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E5747FC1E;
	Tue, 22 Apr 2014 13:58:10 -0400 (EDT)
In-Reply-To: <20140422102713.GC366@quack.suse.cz> (Jan Kara's message of "Tue,
	22 Apr 2014 12:27:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AA6331F6-CA47-11E3-9F48-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246760>

Jan Kara <jack@suse.cz> writes:

> On Thu 17-04-14 10:04:52, Junio C Hamano wrote:
>> So perhaps the rule should be updated to do something like:
>> 
>>     - find candidate tags that can be used to "describe --contains"
>>       the commit A, yielding v3.4, v3.5 (not shown), and v9.0;
>> 
>>     - among the candidate tags, cull the ones that contain another
>>       candidate tag, rejecting v3.5 (not shown) and v9.0;
>>
>>     - among the surviving tags, pick the closest.
> ...
> Regarding the strategy what to select when there are several
> remaining tags after first two steps I would prefer to output all such
> tags.

Yes, as I mentioned in another subthread ($gmane/246488), different
projects want different tie-breaking rules at the third step, and
your "show all to give more information to the user" could be
another mode of operation.

I offhand do not think the current name-rev machinery is set up to
compute your variant easily, though.
