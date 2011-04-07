From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug Report: git add
Date: Wed, 06 Apr 2011 18:09:37 -0700
Message-ID: <7vbp0ihnou.fsf@alter.siamese.dyndns.org>
References: <4D9BA35E.6040204@dcook.org>
 <20110407005750.GC28813@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Darren Cook <darren@dcook.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 07 03:09:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7djO-00035u-Uo
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 03:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757149Ab1DGBJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 21:09:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757132Ab1DGBJs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 21:09:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D0504B53;
	Wed,  6 Apr 2011 21:11:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/t/MwtwY/RAt7Z9tNMW94Y+2Yec=; b=JoEqjQ
	JaQavafs9slclmha/uUHG2DVIeGTOFJZSWHUTbYnmLx8sPsZUpzwue9c42Gqq2at
	jypT3f8J61TiARrjj57zYVvBW6+MeIliVJjXGgeKzLASHbwId8lVHJwOv07+7+2d
	SqDsHjZPfmFpws3jY8OSSA5zv0LyxaubPpDr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LzJq5yoK75X5cPnRQ9XYaKb/+2dtnCKo
	TzpnPLQfoJ7fvmAyOnUfjCmJyavG4/Ah+u2XKkReewVCEGr++5hPRRmiu+G8a/Kp
	g8locQqlcV+FkSxpVhc+fsUn9knjNED8Akgu2GatC5+Z4d25a8K6HKnb3s76NjX9
	UAt5PXZ4jD8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 27A1C4B43;
	Wed,  6 Apr 2011 21:11:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 094C34B42; Wed,  6 Apr 2011
 21:11:32 -0400 (EDT)
In-Reply-To: <20110407005750.GC28813@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 6 Apr 2011 20:57:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC61D698-60B3-11E0-8762-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171032>

Jeff King <peff@peff.net> writes:

>>   mkdir settings
>>   cd settings
>>   git init
>>   touch x
>> ...
>>   cd ..
>>   git init
>>   git add settings/
>>    (should complain)
>
> If you do "git add settings" (without the slash) it will add the
> repository as a submodule.  Which is not the behavior you asked for, but
> is at least reasonable. So the real bug seems to me the fact that "git
> add settings/" and "git add settings" behave differently.

Also if "git add settings/x" does not complain, that would be a bigger
issue, whose solution would probably be in the same area.

It may finally be the time to rename has_symlink_leading_path() function
and enhance its feature.  It happens to check leading symlinks, but its
real purpose is to check if the given path is outside the working tree,
and a path that is in a subdirectory with its own .git repository
certainly is outside the working tree.  The callers should be able to say
what check is being asked for by naming the _purpose_ of the test ("is
this path outside the working tree?"), not the mechanics ("does the path
have a symlink that points outside?").
