From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Unconfuse git clone when two branches at are HEAD.
Date: Sat, 07 Sep 2013 08:50:26 -0700
Message-ID: <xmqqwqmsvdfh.fsf@gitster.dls.corp.google.com>
References: <20130906155204.GE12966@inner.h.apk.li>
	<6649DD0E3B6B4CE59D330217786B6B05@PhilipOakley>
	<xmqqfvthyfui.fsf@gitster.dls.corp.google.com>
	<94A71512041A4F9BB402474DB385E310@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Andreas Krey" <a.krey@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Sep 07 17:50:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIKmW-0000DP-6d
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 17:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814Ab3IGPuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 11:50:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50058 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797Ab3IGPue (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 11:50:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEA5F3ECF0;
	Sat,  7 Sep 2013 15:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DWpWy0U+5dWKLsFk6airkbHKYEo=; b=x1EMBi
	j+TciLTZFikqM4mPnU6+5KVO5d4mjwYuDhIt5lxDmdtQJnwOIf+ooXox9pCbIllQ
	KkLvuDzCkLDJOUv4qZ14QvGizJZ+azNIXOvOJr+deCrHFFXNlk4gMuSzVjU/Mo7N
	ikzWsxrkT5l7czovH4/NQrnhRGNtxKFsfaMlY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CGtNfepf8oOADnq1X00zO2xazsrCUyQs
	m8Pw4EY0OMfcvZXJ2fHCpUT759joG66RhFmrpfvDEqhudMWHN6Y8Y+nGeHxgnUx7
	ufuZAhHfQY/UVkS3pRj2W2mcgNkvgDkZqQB4it0dlZDDMXfY2zAtiWEf8P4oWBNj
	bY1vtxTgIJQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F0873ECEF;
	Sat,  7 Sep 2013 15:50:33 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44F8D3ECE5;
	Sat,  7 Sep 2013 15:50:30 +0000 (UTC)
In-Reply-To: <94A71512041A4F9BB402474DB385E310@PhilipOakley> (Philip Oakley's
	message of "Sat, 7 Sep 2013 00:19:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3971B1AE-17D5-11E3-8527-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234134>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
>> "Philip Oakley" <philipoakley@iee.org> writes:
>>
>>> Does this have any impact on the alleged bug in `git bundle --all`
>>> (which can then be cloned from) where the current HEAD ref wasn't
>>> included in the bundle? Or am I mis-remembering?
>>
>> Not "current HEAD ref", but "git clone" will fail to check out from
>> a bundle that does not include HEAD ref (it is easy to just say
>> "reset --hard master" or whatever after it, though).
>>
>> I think I suggested to update "git bundle" to include HEAD when
>> there is no HEAD specified some time ago, but I do not think anybody
>> was interested, so this may be a non-issue.
>>
> Just had a quick look at a very quick test repo (10 objects, 2
> branches) and the bundle file does contain the HEAD ref, but again it
> has the two ref/heads/* are better than one problem, in that the clone
> from the bundle checks out master, whilst the source repo has feature
> checked out.

I do not think the bundle header records symref any differently from
other refs, so a HEAD that points at a commit that is at the tip of
more than one ref needs to be guessed at the extraction end, just
like the network-transfer case discussed in this thread.

But this thread is not about updating the current bundle format to a
new one, so any of the updates proposed in these patches will not
affect it.
