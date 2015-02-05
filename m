From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Move tracking in git diff is not as good as in git status
Date: Thu, 05 Feb 2015 11:01:59 -0800
Message-ID: <xmqq61bgmbbs.fsf@gitster.dls.corp.google.com>
References: <20150205061142.GA31599@odin.ulthar.us>
	<099A7D2D-6033-4A16-91DD-E2288BC5C729@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Scott Schmit <i.grok@comcast.net>,
	git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 20:02:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJRgn-0003gv-5k
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 20:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbbBETCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 14:02:03 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64173 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751274AbbBETCC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 14:02:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 86998350B2;
	Thu,  5 Feb 2015 14:02:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VJKRkaPa8q+ps+wopDgwr76D4Hs=; b=nbJzo2
	GDIMev/ag/Dy1C5ejb95vvBJ7vy4eiDt3PbJjyzVCEI5slXFqYAM0hMBneseFDlb
	EzolU697flmPz9g8SQoKlZal6K3Bbg2xnkUKx68q9qWHthYWJNiczzIxItHsB7JI
	n3pJNUOVzaiFLrCp+vYcYObrU80UAN7sVGprQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kGrl+xezYZgxzKubfpC4MhBSSWQX53UZ
	qSx7/GRNJeQRCOV1g/OJOaELTVAm0XPvSyxFVZdHe9/6YPnFa8gfFKSRkX91iBbW
	wyLnPN4I11izNLAdqtEShF5kaKPf3yK0VhJ1J8V/r1Fhiciscs8jjcJRd4GCiZta
	XRIFHurkIFE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7551A350B1;
	Thu,  5 Feb 2015 14:02:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B24D350AE;
	Thu,  5 Feb 2015 14:02:00 -0500 (EST)
In-Reply-To: <099A7D2D-6033-4A16-91DD-E2288BC5C729@gmail.com> (Kyle J. McKay's
	message of "Wed, 4 Feb 2015 23:39:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 76EEA34A-AD69-11E4-BF81-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263383>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> On Feb 4, 2015, at 22:11, Scott Schmit wrote:
>
>> In my use of git, I've noticed that "git status" is a lot better at
>> tracking moves and renames than "git diff", and this has recently
>> caused
>> me a lot of headaches because a large number of moves were made in a
>> single commit, and it was very difficult to figure out which moves
>> were
>> right and which were wrong.
>>
>> I was using a fairly old version of git (1.7.11), but was able to
>> reproduce it on git 2.2.1.
>>
>> Here's a reproduction recipe:
> [...]
>> # Now "shift" the files
>> git mv 2 3
>> git mv 1 2
> [...]
>> git commit -m "2=1;3=2;"
>>
>> # Neither of these commands get it (but -C gets a glimmer of the
>> truth)
>> git diff -M --stat --summary HEAD~..
>> git diff -C --stat --summary HEAD~..
>
> Ah, but did you try this:
>
>   git diff -B -M --stat --summary HEAD~..

Yes, since f714fb84 (Enable rewrite as well as rename detection in
git-status, 2007-12-02) "git status" internally uses "-B -M".
