From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG? in --dirstat when rearranging lines in a file
Date: Fri, 08 Apr 2011 12:56:50 -0700
Message-ID: <7vtye834al.fsf@alter.siamese.dyndns.org>
References: <201104071549.37187.johan@herland.net>
 <BANLkTinEipewx2+Cx7Us0BSoSbjjU9uE6A@mail.gmail.com>
 <201104081646.35750.johan@herland.net>
 <BANLkTinv3SSYWn==F=ans4uHuHJhTrfjDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Apr 08 21:57:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8Hnp-00006l-Sp
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 21:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757802Ab1DHT5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 15:57:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34110 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757782Ab1DHT5C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 15:57:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 231DA4E0B;
	Fri,  8 Apr 2011 15:58:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HmiQ+Tg5dV0V/41CoiWyE1Q/y/Y=; b=o9KOqz
	E+GAv4XHFpK6bduH3L3evWF+V/QfWEkpGBW5OlXCQS/eFNfROIQeG4eP15TB/NiO
	qI3hiiFRfm7ikPcntQvU36FXwSovJgzs7xm3AcIzoH5YNXVbWY80Z6vgGSyS0HlQ
	VH2VvtCSxQw0/B3zTGWmhNY8D6j/2WVck5hAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nZVySYLQpmjugQZvq9jR/8AlJaWyHge6
	kBW51CHM2EIJ4TiOo9/b87G+fF9fC1w9kI2QBgViDErwoeM85smv570AKbsNlGHj
	rredMOgegZodB+hVnVnFu+2B3avNaSnlM2f6JZi8ACN2WDbvHcm5c6Fiac2gkYF4
	B6hyHpxznJU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E26C34E09;
	Fri,  8 Apr 2011 15:58:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A93794E08; Fri,  8 Apr 2011
 15:58:48 -0400 (EDT)
In-Reply-To: <BANLkTinv3SSYWn==F=ans4uHuHJhTrfjDQ@mail.gmail.com> (Linus
 Torvalds's message of "Fri, 8 Apr 2011 08:04:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0DA3E1A-621A-11E0-8490-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171153>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Apr 8, 2011 at 7:46 AM, Johan Herland <johan@herland.net> wrote:
>>
>> #2: Improve --dirstat-by-file. It doesn't really care about the per-file
>> analysis done by --dirstat, but only whether or not a file has changed
>> at all. Since the diff queue does not contain unchanged files (<- this
>> is an assumption that I hope someone with more diffcore knowledge can
>> verify),
>
> Hmm.
>
> I think that with renames, the diff queue _can_ contain unchanged
> files (ie pure renames).
>
> Also, I think -CC (aka --find-copies-harder), _every_ file ends up in
> the diff queue because that's how it does the detection.

Both are correct, but the output phase happens after diffcore_std() cleans
up the unused and unchanged filepairs thrown into the queue for the
purpose of find-copies-harder, so you shouldn't have to worry about them.

When you rename a file without changing its contents, what do you want to
see in --dirstat-by-file output?  I assume that you do not want to show
anything, so it would be sufficient to compare the two object names.
