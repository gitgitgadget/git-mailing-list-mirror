From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash: support user-supplied completion scripts for
 user's git commands
Date: Fri, 29 Jan 2010 12:32:12 -0800
Message-ID: <7viqakireb.fsf@alter.siamese.dyndns.org>
References: <9b69cfcf1001290457s6b7fad6cs5a915f16a11f5782@mail.gmail.com>
 <20100129151127.GA21821@spearce.org>
 <7v4om4kdt3.fsf@alter.siamese.dyndns.org>
 <20100129175950.GE21821@spearce.org>
 <7vockciyb8.fsf@alter.siamese.dyndns.org> <20100129190642.GA31303@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	David Rhodes Clymer <david@zettazebra.com>,
	git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jan 29 21:32:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaxW6-000293-9J
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 21:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754286Ab0A2Uc1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 15:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753742Ab0A2Uc1
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 15:32:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34963 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541Ab0A2Uc0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2010 15:32:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BFE2A95123;
	Fri, 29 Jan 2010 15:32:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=sfYDk9fPEfuP
	/ogBaI4FzFtlkBo=; b=dZZs/+iUcWXRGhRqTR0ilY6hXvLoGPM5SqLWk/zsqe50
	xp0+HTunjtibDNSOZUd9v98O0cXax49nVTaL0Iu3zz/Srq3j4X6lW4possMsVL32
	YSDDpr+GBR71q8b4z4wrNvXHm3IPGn6GWWIS2sBBu9xBKUtIaNt8uDQ47GScHlw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Kwgt+J
	3NJKJi9z6XmYBDB6Y71+IL3aPt+PGLeA2KjVKssfrpYBWxne7Rz3lbVi9WEFPqM4
	Er+Nm+j0i7NpaX1ekAze9HBP4pigmxF0DD88lvyWvO0BF9v3Rc8eMr5VqReomQbC
	ol3nFL3syLBrMJpHXLZWyoOOM5sXJqgSgnZJs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 790EF9511D;
	Fri, 29 Jan 2010 15:32:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 927D69511C; Fri, 29 Jan
 2010 15:32:14 -0500 (EST)
In-Reply-To: <20100129190642.GA31303@neumann> ("SZEDER =?utf-8?Q?G=C3=A1bo?=
 =?utf-8?Q?r=22's?= message of "Fri\, 29 Jan 2010 20\:06\:42 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 659C975E-0D15-11DF-AB6A-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138348>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Instead of having a huge hard-coded list of command-completion
> function pairs (in _git()), the completion script will figure out
> which completion function to call based on the command's name.  That
> is, when completing the options of 'git foo', the main completion
> script will check whether the function '_git_foo' is declared, and if
> declared, it will invoke that function to perform the completion.  If
> such a function is not declared, it will fall back to complete file
> names.  So, users will only need to provide this '_git_foo' completio=
n
> function in a separate file, source that file, and it will be used th=
e
> next time they press TAB after 'git foo '.

I think the basic idea is sound, but I have a minor issue with the name=
s.

Admittedly, we have already taken over _git_foo (and "_git") namespace,
and anybody who uses bash with the completion support cannot write thei=
r
own shell function with these names for purposes that are unrelated to
completion, so in that sense, the patch is not introducing a new proble=
m,
but making it a documented interface and casting it in stone will make =
the
namespace contamination issue harder to rectify later.

So if we were to go in the direction as the patch proposes (which I thi=
nk
is a good idea), we might want to rename them to __git_completion_foo o=
r
something that is less likely to collide with whatever names users migh=
t
want to use.  It is my understanding that the only published interface =
so
far is __git_ps1.
