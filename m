From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Improving merge failure message
Date: Tue, 08 Sep 2009 00:48:23 -0700
Message-ID: <7vk509ev20.fsf@alter.siamese.dyndns.org>
References: <20090908153101.6117@nanako3.lavabit.com>
 <7vbplmhr0i.fsf@alter.siamese.dyndns.org>
 <7veiqhgb4y.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0909080020i3daa92aar952fc5102df62bdb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 09:48:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkvRf-0006CA-H5
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 09:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbZIHHsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 03:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753798AbZIHHsd
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 03:48:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43771 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927AbZIHHsa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 03:48:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C4E6F2A442;
	Tue,  8 Sep 2009 03:48:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wPxpokB5eKYOEiQoZSaW5vU6OFs=; b=L6f0K5
	SE8eChrB3Ye49wZTbj94B/f3k3cgZZygD0mnRcQJrkLMb9ZQXnzvkEkBT04bUUw2
	n/2Es59HqzJsBMgygX0rQRgGx2ReXGotQxwbJHbOsZ4ZFUzfQNl9ByUdV6pqx5rS
	4EQIKdYFnsP+sivFdeaOXkAo5mrd0Tnmita6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aoDxH5NafM35bL9VK31ZLu8f91MQ+92h
	9ooXH3ZOe25NY6QTW4Q8DzWMSuuOHj2xMZ98Q+eBIrYPKIdKBwVebgv6L8Djm+6g
	FQHCiGf1nMulZFVoqIN2nUHlHKwP8eDJbfjWnlczuBmnAOiaWWUh2rLNj2n9bMZI
	f9cOkJhwqF4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CE8B2A441;
	Tue,  8 Sep 2009 03:48:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D28732A440; Tue,  8 Sep
 2009 03:48:24 -0400 (EDT)
In-Reply-To: <fabb9a1e0909080020i3daa92aar952fc5102df62bdb@mail.gmail.com>
 (Sverre Rabbelier's message of "Tue\, 8 Sep 2009 09\:20\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FF354E8C-9C4B-11DE-8E91-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127986>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Tue, Sep 8, 2009 at 09:15, Junio C Hamano<gitster@pobox.com> wrote:
>> +               /* would_overwrite */
>> +               "Your local changes to '%s' will be clobbered by merge.  Aborting.",
>
> Still scary, shouldn't that be s/will be/would be/ ?

Thanks, very true indeed.  "It would be clobbered if we were to continue
hence we abort." is how we want to explain our behaviour, so "would" is
definitely better here.

>> +               /* not_uptodate_dir */
>> +               "Updating '%s' would lose untracked files in it.  Aborting.",

This is "merge would resolve to have a file X, but you have a directory X
in your work tree and it is not empty" case.

I'll leave the exact wording up to other people.  My primary focus was to
end all of these messages with "Aborting."

This turns out to be a continuation of an older discussion thread back in
May 2008, and I do not know if anybody took up the challenge back then.  I
wouldn't be surprised if "checkout", which was the topic of the old
thread, has some other scary plumbing message still seeping through to the
UI layer.  Perhaps there are some other commands that needs similar kind
of love.
