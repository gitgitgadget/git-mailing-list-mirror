From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] request-pull: do something if $3 is passed
Date: Tue, 17 Feb 2015 13:03:10 -0800
Message-ID: <xmqqiof01ca9.fsf@gitster.dls.corp.google.com>
References: <1424110568-29479-1-git-send-email-bonzini@gnu.org>
	<xmqqiof163kk.fsf@gitster.dls.corp.google.com>
	<54E31405.5040502@gnu.org>
	<xmqqvbj01fbz.fsf@gitster.dls.corp.google.com>
	<54E3A5E2.6060806@gnu.org>
	<CA+55aFw_pKtraqwMMsqsYgF=ikShH=6ybtb7+QPr8r=77kmoVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paolo Bonzini <bonzini@gnu.org>,
	Git Mailing List <git@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 22:03:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNpIc-0006oj-MV
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 22:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424AbbBQVDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 16:03:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64165 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752304AbbBQVDN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 16:03:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 116CF37233;
	Tue, 17 Feb 2015 16:03:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qf6vdba2zPNNXz0S2faspeVx37o=; b=YH1pUu
	ROk8cjJXSJWj/h2T4E3lBMBDOa55NpaNH/ly4okK2uS7L1QBJrGWn6zApEZdL/4/
	LbDreMPM6ZwqfesJ21hAvSDUKo70qfsx9BW+LVkbIupCTGrJpUav+aKBTgUQp7d9
	OmMZC0c9hQG7YWN1SK6A3oxqrHHMR6PZOSSRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t3K6OGmLsue0G1E2bnHqA06GKmPpDk6W
	0ZHPIH2oW0T15aHPKYwHDePynHWfx7Q7i6I/RyAIIX38PADZVAt/hLwRiLsG8THW
	73LK99bshilL7Uq7FMmOlbP+MMLwT/sbI7cia4wBbN7Wp06gblk2sFs89QL7cL77
	pIwSAaJZCcQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 02A5D37232;
	Tue, 17 Feb 2015 16:03:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 41E2637231;
	Tue, 17 Feb 2015 16:03:12 -0500 (EST)
In-Reply-To: <CA+55aFw_pKtraqwMMsqsYgF=ikShH=6ybtb7+QPr8r=77kmoVQ@mail.gmail.com>
	(Linus Torvalds's message of "Tue, 17 Feb 2015 12:42:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 621F166A-B6E8-11E4-A9BF-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263984>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> HEAD is not a tag. Never has been, never will be. If you want me to
> pull a tag, then you damn well should say what tag you want, not just
> randomly say HEAD.
>
> So what is it you want to do? At no point is "HEAD should resolve as a
> tag" sensible.

"HEAD should resolve as a tag" is not sensible, but "HEAD should
locally DWIM to something sensible" is still possible, no?

We could for example make the rule for unset $3 case like this,
instead of the current "missing $3 is a request to pull HEAD":

    If you have one and only one signed tag that happens to point at
    the commit sitting at HEAD, behave as if that tag was given as
    the third argument from the command line.

    Otherwise, if you are on a branch, behave as if that branch was
    given as the third argument from the command line.

    If you are not on any branch, error out.
