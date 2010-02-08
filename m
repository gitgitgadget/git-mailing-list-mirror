From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support working directory located at root
Date: Mon, 08 Feb 2010 09:43:51 -0800
Message-ID: <7v8wb3pqqw.fsf@alter.siamese.dyndns.org>
References: <1265640810-6361-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jo=C3=A3o?= Carlos Mendes =?utf-8?Q?Lu?=
	 =?utf-8?Q?=C3=ADs?= <jonny@jonny.eng.br>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 18:44:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeXea-00073K-Bs
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 18:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321Ab0BHRoB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2010 12:44:01 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37260 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab0BHRoA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2010 12:44:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F2FC98997;
	Mon,  8 Feb 2010 12:44:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=Jqd74Sl7gcvNqrKMO702ki7J3
	BA=; b=jVGuXGbkOwLJE5bigBSKNESE9yjPdwUBSikviLCJPztcXo3JVDXieN8H7
	iR4vhn2uShzBljB/lGY8TNZAi0hlmaGweYWYw9rVXt7jpPGwDVscE/0iDOEgXZAf
	p42NpOKyUD37tgaBanKSLiWdVfDAFEhtpmwjJxPXEOczfvHAYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=al7e44BU7IbRXAE3g/1
	UZCu31THJjfZdVdazShWzjO2YuRUXhvJwD5NpFt4uUTRRrFJdUdAsf3AaO4SC4U4
	GwBNexoAxidDUY6dQBm2DuXtk3nShcQJb2xM4X116UsWUHMb0qcvuB/+A55lZkNm
	7x1N4E0rpw3fV6UaWKgeYuHc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EDB6098991;
	Mon,  8 Feb 2010 12:43:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22B1998982; Mon,  8 Feb
 2010 12:43:52 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 882BF96A-14D9-11DF-9E89-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139300>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Git should work regardless where the working directory is located,
> even at root. This patch fixes two places where it assumes working
> directory always have parent directory.
>
> In setup_git_directory_gently(), when Git goes up to root and finds
> .git there, it happily sets worktree to "".

If you mean "instead set it to "/" and things will work much better."
I agree with the reasoning (not suggesting to reword---just trying to
make sure I understood what you meant).

> In prefix_path(), loosen the outside repo check a little bit. Usually
> when a path XXX is inside worktree /foo, it must be either "/foo", or
> "/foo/...". When worktree is simply "/", we can safely ignore the
> check: we have a slash at the beginning already.

The logic for the "are we inside?" check above sounds correct.  When
work_tree is at root, have "/" in it, and len inside the "if orig is
absolute" block is 1, so memmove() strips out the leading '/' and makes
the result relative to the root level.  Am I reading the code right?

> Not related to worktree, but also set gitdir correctly if a bare repo
> is placed (insanely?) at root.

Yuck, but looks correct.
