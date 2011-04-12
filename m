From: Junio C Hamano <gitster@pobox.com>
Subject: Re: precommit hook broken with "git commit <filename>"
Date: Tue, 12 Apr 2011 14:04:00 -0700
Message-ID: <7vvcyjnpvj.fsf@alter.siamese.dyndns.org>
References: <BANLkTimB=TZ1gP-18ywbZUOZSbDamkRwCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "C. Scott Ananian" <cscott@laptop.org>
X-From: git-owner@vger.kernel.org Tue Apr 12 23:04:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9kky-000051-63
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 23:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468Ab1DLVEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 17:04:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932412Ab1DLVEK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 17:04:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 277334A19;
	Tue, 12 Apr 2011 17:06:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YqvN1rsZYhk4yt+4L3+6czoUpe0=; b=aesowv
	Z/S4Dj84ziYqnR+EhQHQOmtjZu90LLFKd96IHjvcSV1iSsEEUVz8xGU7REuZwtGq
	q7vBkKHV+9CRB0TjkAcGCZoDS3grtpOhD5ywQD492spOaXSu0obxSVOEyiyF/qgw
	kVyJ8VlTZQ4cJ1MA49K73Z/Wa6QO2F4IX2Xd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EBlRP5dpt6XEUHkJVhDOjSqqBe+wwrsr
	PyPPjUA9BLVHiCL+wp0k8CDqxAONjRQvTHkv/Ffcolr0JH6duEAKp6iq4904FdgU
	WaSN60MqaN6Cm1F4SMSsuvZTRUG1etPrq7I1Ltu55o8uBYES2KvUPO5xhgkvWjLa
	BLVM00L7x+Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F03AD4A17;
	Tue, 12 Apr 2011 17:06:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C51524A16; Tue, 12 Apr 2011
 17:05:59 -0400 (EDT)
In-Reply-To: <BANLkTimB=TZ1gP-18ywbZUOZSbDamkRwCg@mail.gmail.com> (C. Scott
 Ananian's message of "Tue, 12 Apr 2011 11:17:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC9A4DCC-6548-11E0-90B5-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171420>

"C. Scott Ananian" <cscott@laptop.org> writes:

> It appears that "git commit <filename>" breaks the git precommit hook.
>  Every other git command updates the index to make the
> commit-about-to-be-made before running the precommit hook, and indeed
> the 'pre-commit.sample' distributed with git assumes that the index
> reflects the commit.  However, in the case of "git commit <filename>"
> the man page states "the commit will ignore changes staged in the
> index, and instead record the current content of the listed files
> (which must already be known to git)".

Doesn't the command call the pre-commit hook with GIT_INDEX_FILE
environment set to the temporary index used to create the (partial)
commit?  The sample pre-commit hook runs "diff --cached" between that
index and HEAD (or the empty tree), and should show the change about to be
committed.
