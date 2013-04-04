From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] count-objects: output "KiB" instead of "kilobytes"
Date: Thu, 04 Apr 2013 09:27:08 -0700
Message-ID: <7vvc82jm77.fsf@alter.siamese.dyndns.org>
References: <7vip44a8xl.fsf@alter.siamese.dyndns.org>
 <1364993331-20199-1-git-send-email-mihai@mihaic.ro>
 <7vd2ub7k7c.fsf@alter.siamese.dyndns.org>
 <CADyhzG3HJhrXJAoTfyHUsg=8ZmUUwUgrNfUiLHF0Ws=gSERAqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mihai =?utf-8?Q?Capot=C4=83?= <mihai@mihaic.ro>
X-From: git-owner@vger.kernel.org Thu Apr 04 18:27:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNn0t-00007h-HH
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 18:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762975Ab3DDQ1P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Apr 2013 12:27:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37480 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762933Ab3DDQ1M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Apr 2013 12:27:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81F4513027;
	Thu,  4 Apr 2013 16:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TOaBpPkaUn+t
	F3QBeN56rL0M5Fg=; b=X7o7IrIs0MPyoR0DhlQyqejEJfHx1K3lmDG64SdayEg4
	wxpf3BSDut1JqzIjwH1CYhWx27akJ7/CS7mmRUvyF0hYImW/TYc2L8jfwDCf2nEB
	qi2OLcjR8d/GREYbkcU7ZWfS0Z3hEcV4gVGelLNZWChe6PNnA5AiDcWTC109kx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mVm/7k
	qLH3FLs7O87U8f681gW6KCtHEBZUAceBGvHv8KTPxvkhJ66RUaaNs+685jtNztTH
	NJ5IpXGgR0GQ9DgpeuDcbbEqVNMaXKJ739UQh+LJ3lM6Qmil0dpqD2bVlx7PLWm4
	6VwL2hnYMWx6EbqSTmWy05E/6MwW7ogATQOFI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77A9A13026;
	Thu,  4 Apr 2013 16:27:11 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E61CE13025; Thu,  4 Apr
 2013 16:27:10 +0000 (UTC)
In-Reply-To: <CADyhzG3HJhrXJAoTfyHUsg=8ZmUUwUgrNfUiLHF0Ws=gSERAqw@mail.gmail.com> ("Mihai
 =?utf-8?Q?Capot=C4=83=22's?= message of "Thu, 4 Apr 2013 15:18:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 803F6240-9D44-11E2-9A75-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220029>

Mihai Capot=C4=83 <mihai@mihaic.ro> writes:

> The git manual contains an explicit warning about the output of a
> porcelain command changing: "The interface to Porcelain commands on
> the other hand are subject to change in order to improve the end user
> experience."

Yeah, I know that, as I wrote it ;-)

Aside from count-object being not exactly a Porcelain, the statement
does not give us a blank check to make random changes as we see fit.
There needs to be a clear improvement.

I am just having a hard time weighing the benefit of using more
accurate kibibytes over kilobytes and the possible downside of
breaking other peoples' tools.

Perhaps it would be alright if the change was accompanied by a
warning in the Release Notes to say something like:

        If you have scripts that decide when to run "git repack" by
	parsing the output from "git count-objects", this release
	may break them.  Sorry about that.  One of the scripts
	shipped by git-core itself also had to be adjusted.  The
	command reports the total diskspace used to store loose
	objects in kibibytes, but it was labelled as "kilobytes".
	The number now is shown with "KiB", e.g. "6750 objects,
	50928 KiB".

	You may want to consider updating such scripts to always
	call "git gc --auto" to let it decide when to repack for
	you.

Also, I suspect that for the purpose of this exact output field,
nobody cares the difference between kibibytes and kilobytes.
Depending on the system, we add up either st.st_blocks or st.st_size
and the result is not that exact as "how much diskspace is
consumed".
