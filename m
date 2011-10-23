From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Sun, 23 Oct 2011 02:46:59 -0700
Message-ID: <7vehy459bg.fsf@alter.siamese.dyndns.org>
References: <1319277881-4128-1-git-send-email-pclouds@gmail.com>
 <7vobx863v3.fsf@alter.siamese.dyndns.org>
 <CACsJy8B=TsC4A=R6b3jyYBCvorEDBYHQ8uA864WrB0-3pgNyKA@mail.gmail.com>
 <7vipng5k80.fsf@alter.siamese.dyndns.org>
 <CACsJy8CA2cqJqt7cUN1CdnOb3=qE6B2XTd1oQKZ7osVz09kSGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= 
	<avarab@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 23 11:47:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHue6-00007s-1M
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 11:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231Ab1JWJrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Oct 2011 05:47:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43108 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753845Ab1JWJrD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2011 05:47:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 820D13259;
	Sun, 23 Oct 2011 05:47:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7J0pdlx8GZu/NDW9oPZMu00FsaQ=; b=k8s3ZW
	W9CnGqFyX6uFszNn/bAR+EONm+SCb5aI8PqR880gy3Hbc0syXKz04H++Edoi42Bo
	C1qAT1lB9kwilId5hfRC9rNFuFTMmy5hzTCauNOXKGhdMU1RmXMFgvk2a1WkyFqY
	8fzP3tSGcWij7h6EjBEQQtexOBn9NsVTmVt7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XtLx2iiKKcJJUQXQuzlNGX9JzzcmldKR
	38mp0kJKYK2GOsn/imbhR81k8Y6ZEgOhueejBlXTitbjNaawZs7pc5PtMZeFRc/e
	0dXf6juYaopA1UbWYdmc1kc7zBAf6+GZhHHqtIkxLoPCbSUhekEtsAcH3jwOdigj
	2PSWXa7mMmk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79CEC3258;
	Sun, 23 Oct 2011 05:47:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C3F63257; Sun, 23 Oct 2011
 05:47:00 -0400 (EDT)
In-Reply-To: <CACsJy8CA2cqJqt7cUN1CdnOb3=qE6B2XTd1oQKZ7osVz09kSGg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sun, 23 Oct 2011 17:37:16 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4B7294E-FD5B-11E0-AA8C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184131>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Sun, Oct 23, 2011 at 4:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> The low level object format of our commit is textual header fields, each
>> of which is terminated with a LF, followed by a LF to mark the end of
>> header fields, and then opaque payload that can contain any bytes. It does
>> not forbid a non-Git application to reuse the object store infrastructure
>> to store ASN.1 binary goo there, and the low level interface we give such
>> as cat-file is a perfectly valid way to inspect such a "commit" object.
>
> cat-file is fine, commit-tree (or any commands that call
> commit_tree()) cuts at NUL though.
> I wonder how git processes commit messages in utf-16.

That is exactly what I am saying.

Perhaps you didn't either read or understand what you omitted from your
quoting; otherwise you even wouldn't have brought up utf-16.

Let me requote that part for you.

> But when it comes to "Git" Porcelains (e.g. the log family of commands),
> we do assume people do not store random binary byte sequences in commits,
> and we do take advantage of that assumption by splitting each "line" at
> LF, indenting them with 4 spaces, etc. In other words, a commit log in the
> Git context _is_ pretty much text and not arbitrary byte sequence.

Think what would cutting at a byte whose value is 012 and adding four
bytes whose values are 040 to each of "lines" that formed with such
cutting do to UTF-16 goo, even if it does not contain any NUL byte. As far
as Git Porcelains are concerned, it is no different from random binary
byte sequences.
