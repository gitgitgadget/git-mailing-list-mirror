From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] interpret-trailers: add option for in-place editing
Date: Tue, 19 Jan 2016 12:58:12 -0800
Message-ID: <xmqqfuxt9ti3.fsf@gitster.mtv.corp.google.com>
References: <1452790676-11937-1-git-send-email-tklauser@distanz.ch>
	<1452790676-11937-3-git-send-email-tklauser@distanz.ch>
	<xmqqio2vki0i.fsf@gitster.mtv.corp.google.com>
	<CAPig+cRRdca7PfkqppY2X7KSFpHX0yH19fxRL+w_=u9vg7NV9A@mail.gmail.com>
	<xmqqio2pbgov.fsf@gitster.mtv.corp.google.com>
	<CAPig+cRi2knygjeaMtojAr65BE71B-z7q+s8V5rcGrV9Qja6jw@mail.gmail.com>
	<CAPig+cRozqCKdC2+nyG-UM6xFo_sSqa7OhGgcycyyDQujZHtHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tobias Klauser <tklauser@distanz.ch>,
	Christian Couder <chriscool@tuxfamily.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 21:58:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLdM4-00060N-OU
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 21:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757732AbcASU6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 15:58:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57708 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757242AbcASU6O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 15:58:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 070C73D583;
	Tue, 19 Jan 2016 15:58:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NpBY907b3an+C9pIS9XvyKtLNoQ=; b=Inb1k2
	gIVfwPwZPkNgox3449A4/EnpPimMHNTZFOuHV0T5MKgvgS51NxPBrjiE3i0gXsvW
	gJoNSCuZNQ4zxFDeSt2+Ppy/h5Fnkh9bOkAvru8EkM6D8o+efKCGspyKM/Uk+Atc
	HNupej5EOMhkAp36vjuZkqnCmTp8KKkbqw4xE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y03OJ/JuwzjqjfjWyH6nTF5157f1S8jG
	NCT0+YAjLI98nZrHheaSYjtVhkw9RMyX3+sYmumA7wA7b0Qc6JedR4UrLM3Lnuvz
	QxVo4rEi52psBQCjXVCYCL5WlmE7Vim7SUt647xqrqa5doHIiOh3rotMr7CG2gNm
	XoVvh5D6K+E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F168D3D582;
	Tue, 19 Jan 2016 15:58:13 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5AFC13D580;
	Tue, 19 Jan 2016 15:58:13 -0500 (EST)
In-Reply-To: <CAPig+cRozqCKdC2+nyG-UM6xFo_sSqa7OhGgcycyyDQujZHtHA@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 19 Jan 2016 13:10:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5ACD9C14-BEEF-11E5-B632-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284377>

Eric Sunshine <sunshine@sunshineco.com> writes:

> My understanding is that SANITY is an expectation that directory
> permissions work in an expected POSIXy way: that is, a file can't be
> deleted when its containing directory lacks 'write', and a file can't
> be read/accessed when the directory has neither 'read' nor 'execute'.
> This doesn't say anything about root not being allowed to read a file
> when the file itself lacks 'read'.

In short, SANITY is "does looking at permission bits sufficient to
anticipate what the filesystem would do?" while POSIXPERM is "can
chmod be used to tweak permission bits of the filesystem" (a
filesystem that lacks permission bits support would qualify as
!POSIXPERM, as there is nothing to tweak in the first place).

I suspect the comment added by f400e51c and its patch description
stressed too much about permission of a directory affecting what we
can do to files inside the directory, and failed to describe another
criteria for a sane environment: "files whose permission bits say
you shouldn't be able to read or write cannot be read or written".
Traditionally, running tests as root was one major way to break
SANITY, but as f400e51c noticed, "can we write to '/'?", which was
an old-fashioned way to catch the only case where SANITY does not
hold on POSIX systems [*1*], cannot catch insanity on non-POSIX
system like Cygwin.

POSIXPERM is more about "if we do chmod, does filesystem remember it
so that ls -l reports the same?"  Output from "git grep POSIXPERM t"
shows that some users of it also assume that it requires "we can
make something executable by doing chmod +x and unexecutable by
doing chmod -x" (and that is fine--running tests as root would not
make an unexecutable file executable).  The tests that require
POSIXPERM but not SANITY can be run by root (I am not saying that
running tests as root is safe or sane, though) and are expected to
produce the same result as they were run by a non-root user.


[Footnote]

*1* This is an old-fashioned way back when everybody on UNIX was
    sane and / had 0755 permission bits everywhere.  Some people
    make their / owned by sysadmin group and give 0775 bits, and
    "test -w /" would incorrectly say that the environment lacks
    SANITY when run by non-root users in the sysadmin group, even
    though our tests like "chmod -r file && ! cat file" (drop
    readable bit, expect it to become unreadable) guarded by SANITY
    can correctly run by them.

    Back when f400e51c was written, checking `whoami` was suggested
    as an alternative as a workaround for this "/ may be writable by
    a non-root person and not a good SANITY check" issue, but that
    was rejected because it obviously would not work on Cygwin.
