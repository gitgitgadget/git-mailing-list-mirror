From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug report on update-index --assume-unchanged
Date: Fri, 05 Dec 2014 13:52:36 -0800
Message-ID: <xmqqy4qlojbv.fsf@gitster.dls.corp.google.com>
References: <1417732931.20814.16.camel@segulix>
	<1417759955.10992.2.camel@segulix> <548156E5.2080006@kdbg.org>
	<CACsJy8AVKaq4NJu=23W+wcRgVTQ7hVAOxsVwtZnZsNw6393cTA@mail.gmail.com>
	<1417798622.23238.6.camel@segulix>
	<xmqq1toeq79b.fsf@gitster.dls.corp.google.com>
	<1417815590.23238.11.camel@segulix>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?S=C3=A9rgio?= Basto <sergio@serjux.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 22:52:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx0ns-0006Qa-0D
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 22:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbaLEVwl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Dec 2014 16:52:41 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58942 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751734AbaLEVwj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Dec 2014 16:52:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C792223B01;
	Fri,  5 Dec 2014 16:52:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vwTHgfN+UiVz
	48Ehj30nqASe+9c=; b=tBur5Q/pCAyqTyCUjGg56t8TGEUsx93boqsv33GpoJ/D
	VHeUrTYqegdLGitfJslUXA4GO5Gi/HvnTA7C5O+XPB6rkaRWHa3BKOsiVnLD4mOv
	fvI4SvSaNQCnTqtKmP/UZf7SORI8nxKRA1VYPJDEs12MTO6GkE3nclJQ4x/CCYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kbDCii
	XWQmWF5oP7nqCCMIN3mbpheLbNiHz3wl87iJ8c7B1eZdQvIvcaHru3UKnwa5qjD1
	ah6F7Fu8XORrNV3gjpqLj5yWmS9vtaSlC4l1aSOKlkWbmfGqYjisZwz/DNURGwkF
	xw/Vxr0Ah36cg1VZOyewKXfKccCt/jn9MUDUs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BDE1D23B00;
	Fri,  5 Dec 2014 16:52:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3574B23AFF;
	Fri,  5 Dec 2014 16:52:38 -0500 (EST)
In-Reply-To: <1417815590.23238.11.camel@segulix> (=?utf-8?Q?=22S=C3=A9rgio?=
 Basto"'s message of
	"Fri, 05 Dec 2014 21:39:50 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 07656A98-7CC9-11E4-9F24-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260897>

S=C3=A9rgio Basto <sergio@serjux.com> writes:

> On Sex, 2014-12-05 at 10:30 -0800, Junio C Hamano wrote:
>> Your promise is "these paths I will not modify" and in return you
>> gain performance in "git status"
>
> yeah  so  --assume-unchanged is for administrators of git ,...

Not at all.

Administrators would typically not know (and they would not want to
know) what part of your particular project tree you as an individual
developer is not working on day to day.

This was added primarily by normal users (or as a response to a
request from normal users) on slow filesystems (e.g. Cygwin).  When
they are working on one part of their project tree and know they are
not touching other parts, they wanted to skip slowness of having to
lstat(2) all paths in the project tree to detect what changed during
"git status".
