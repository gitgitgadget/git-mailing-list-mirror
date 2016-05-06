From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 01/11] add fetch-pack --diag-url tests for some corner cases
Date: Fri, 06 May 2016 08:52:14 -0700
Message-ID: <xmqqoa8j5glt.fsf@gitster.mtv.corp.google.com>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
	<1462265452-32360-1-git-send-email-mh@glandium.org>
	<1462265452-32360-2-git-send-email-mh@glandium.org>
	<xmqqzis7nn02.fsf@gitster.mtv.corp.google.com>
	<20160503224830.GA21973@glandium.org>
	<20160505215229.GA31157@glandium.org>
	<4349487f-716e-dadf-795b-cf790b03e02d@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri May 06 17:52:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayi3C-0006lp-Tp
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 17:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758161AbcEFPwT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2016 11:52:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758083AbcEFPwS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 11:52:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0105B1670D;
	Fri,  6 May 2016 11:52:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=p36UnkikHG0p
	8z7w1feX4H2mLjU=; b=cBcQa/Cb49S/6PLfj6D6kEJQ4oShVlxzsX39nxAko3bo
	ExxDn0NL4MCBg8epyHG6hAztvuYtWj1TxehfwEkeoJtIPRIYhgXAbhrYz2U5uLfa
	7JoUXGtuioyOSBg1mnhOcbCKKSxsd8VXph29dQvUkW32DsAXHcL8CJEujnWo6yY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jIxcqx
	RRgid4ECO5EYknSFDu/OflF0QNcQ55V6JhioD+m45xCxIT6koH56eCKqVB4a1ogg
	AvYWR5UuTJL3QIcpAfQIP/wVMaud2UI4O6Ic3DhVTgPdw+VJjM2yMD2SHO67YA9h
	OkOCQ112CejNFZo2DjXZxHGdVwr+6L9XP+OuE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EC5DF1670C;
	Fri,  6 May 2016 11:52:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 76F5A1670B;
	Fri,  6 May 2016 11:52:16 -0400 (EDT)
In-Reply-To: <4349487f-716e-dadf-795b-cf790b03e02d@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Fri, 6 May 2016 06:17:04
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 81D1AA8C-13A2-11E6-8478-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293792>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> ssh itself does not use a password:
> ...
> Neither does Git.
> ...
> The user:password came in here:
> Commit 92722efec01f67a54b
> clone: do not use port number as dir name
>
> Actually, looking back, it may have been better to say
> git clone ssh://aaaa:bbbb@host:/path
> is illegal and simply die() out.

RFC2396, which updated RFC1738, discourages the use of :password
in "3.2.2 Server-based Naming Authority", for obvious reasons.

   Some URL schemes use the format "user:password" in the userinfo
   field.  This practice is NOT RECOMMENDED ...

and then this is marked as deprecated in RFC3986 "3.2.1. User
Information".

   Use of the format "user:password" in the userinfo field is
   deprecated.  Applications should not render as clear text any
   data after the first colon (":") character found within a
   userinfo subcomponent unless the data after the colon is the
   empty string (indicating no password).

However, at the parser level that _knows_ the syntax, you shouldn't
be unilaterally turning these "not recommended" and "deprecated" to
"forbidden".  It should be prepared to see ':' to its input, if only
to correctly recognize that as an attempt to express :password, in
order to be able to hide the data after the first colon when running
in verbose mode for example.

I'd recommend that the parser to allow <user>:<password>@<host>, and
at least notice ':' that appears before the first '@' as having a
depreated form of <userinfo>.  After stripping <scheme>:// from the
front, it is OK to assume that everything before the first '@' is
<userinfo> (in RFC2396 lingo), and everything in <userinfo> that is
before the first ':' is <user> when doing so. =20

>>> ...  When you are constrained by the Common Internet
>>> Scheme Syntax, i.e.
>>>
>>>     <scheme>://<user>:<password>@<host>:<port>/<url-path>
>>>
>>> you cannot have arbitrary characters in these parts; within the use=
r
>>> and password field, any ":", "@", or "/" must be encoded.
