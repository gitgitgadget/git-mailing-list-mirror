From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Thu, 04 Apr 2013 15:26:48 -0700
Message-ID: <7vy5cyexuf.fsf@alter.siamese.dyndns.org>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com>
 <CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com>
 <CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com>
 <515DEE86.3020301@web.de> <7vd2uagd10.fsf@alter.siamese.dyndns.org>
 <CALkWK0kQ8qYXHKr4e93A1dh3Y1vL+HZvMR_1xtKkUr-_7bMS6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git List <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 05 00:27:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNscv-0003fo-IC
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 00:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765267Ab3DDW0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 18:26:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44494 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765261Ab3DDW0v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 18:26:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F69113865;
	Thu,  4 Apr 2013 22:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xFEYf3ayKCtk5hkV9QKg5fA0+2Q=; b=DYmKvZ
	YEQbucUdGO1TZwETVAO9I7ehoJinAtnAZvrvxJ9dG3NOKtY1nw+MOmDggzAxj70X
	SS5q+pknOsopRDP8QGU+0I0bWKH5To+AcJQJix8BHw4WL5k1gs8Jp89gv0TjTi8J
	d9chVgcYSmLfSRziNKVPnfBlu9RkKmnVZciyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C4mTEODbowrugBcQHORB4X7xhNHVszhl
	gt149k3o+t1pUYKGOV3UZPuwAaJA4yoZY/lzMnNZ2G8jweM+Yg2XA1C+UrTXRNxN
	PqjfXT0saFvJWp6ZyVI0Fk06BSXDcznDudewBGUWT/p2aaQBKsLDYkxQd92gDIE7
	76OtajgZwGM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8683D13863;
	Thu,  4 Apr 2013 22:26:50 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3CFA13861; Thu,  4 Apr
 2013 22:26:49 +0000 (UTC)
In-Reply-To: <CALkWK0kQ8qYXHKr4e93A1dh3Y1vL+HZvMR_1xtKkUr-_7bMS6Q@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Fri, 5 Apr 2013 03:48:17 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BE540766-9D76-11E2-B2B4-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220117>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> When you are changing information _about_ submodules (e.g. you may
>> be updating the recommended URL to fetch it from), you can use the
>> usual tools like "git diff" to see how it changed, just like changes
>> to any other file.  If the information _about_ a submodule A is
>> stored at path A, and at the same time you have a working tree that
>> corresponds to the root of the submodule A at that path, it gets
>> unclear what "git diff A" should report.  Should it report the
>> change in the submodule itself, or should it report the change in
>> the information _about_ the submodule?  By separating these two
>> concepts to two different places, .gitmodules design solves the
>> issue nicely.
>
> git diff-link.  Just turn it into a buffer and diff as usual.

Sounds like you are saying that you can pile a new command on top of
new command to solve what the existing tools people are familar with
can already solve in a consistent way without adding anything new.
Are you going to dupliate various options to "git diff" and "git
log" in "git diff-link"?  Will you then next need "git log-link"?
