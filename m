From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] t5403: do not use access repos with GIT_DIR when
 worktree is involved
Date: Wed, 12 Oct 2011 21:27:30 -0700
Message-ID: <7vwrc95xe5.fsf@alter.siamese.dyndns.org>
References: <1318412105-13595-1-git-send-email-pclouds@gmail.com>
 <1318412105-13595-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 06:27:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RECtO-0007PK-Cc
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 06:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705Ab1JME1d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Oct 2011 00:27:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36470 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058Ab1JME1d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2011 00:27:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46DCC1150;
	Thu, 13 Oct 2011 00:27:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FH5ETsCK9jqD
	U1AvFq2BB3yVGv4=; b=MWIaiMWqeLrztMnuGqMn8YvrCx3mevg6sq0sPFoxLh40
	FcCB50XW/3CpPDRpm3EJwr9VWnroK5qDs3FauSsSTOJ4QDaXh2JgLeMiy1b3aQ/4
	5OzsPZmx7AoD1Js6Fc+WdgGoyM05vWrlmh+4eEzOO/bUm6Ea6zA1+TsTZ+XKFnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cmndSm
	zRtheazpZcFrdTP3ztXcOeLG1Jc60NTWtsXulwMd+/IjMnefErwr7Cv9BhPR3WAr
	Ajj6uu5MFKFr3DpJmiuKNITb98IiYd5JqT6IR3XKXsqDB1+DuntVjA2yPOXAObSW
	PQlb+3R4tzGOTbny3NIhDlHX5eBtOcljJgrC8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ECC5114F;
	Thu, 13 Oct 2011 00:27:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5945114E; Thu, 13 Oct 2011
 00:27:31 -0400 (EDT)
In-Reply-To: <1318412105-13595-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 12 Oct
 2011 20:35:05 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AABF7446-F553-11E0-8D04-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183438>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Setting GIT_DIR alone means worktree is current directory for legacy
> reasons. Avoid using that, instead go to the worktree and execute
> commands there.
>
> The troublesome command is "GIT_DIR=3Dclone2/.git git add clone2/b". =
The
> real worktree is clone2, but that command tells git worktree is $(pwd=
).
> What does user expect to add then? Should the new entry in index be "=
b"
> or "clone2/b"?

There is no troublesomeness here, as the semantics has been clearly
defined and (hopefully) stayed constant before the days when GIT_WORK_T=
REE
was invented.

Assuming that there is no core.worktree in clone2/.git/config and there=
 is
no GIT_WORK_TREE environment variable, "GIT_DIR=3D$anything git add
clone2/b" should add a path "clone2/b" to the index controlled by that
$GIT_DIR no matter where $anything is.

I would like to find out the motivation behind this patch. Even though =
I
find the ancient style stale and unsightly, we would want to keep the
(GIT_DIR is set, GIT_WORK_TREE is not set anywhere) combination working
for people who have work habits (read: old scripts) that rely on it. So=
 we
would discourage new tests from using ancient style, but at the same ti=
me,
we would not want to remove _all_ existing ones.

Unless we are trying to break them without knowing, and declare that we
deprecated it after the fact, which is not exactly the way we want to
remove existing (mis)feature.

Same comment applies to the other patch that removes the test that uses
update-index && update-ref combination to a lessor degree.

The [PATCH 2/3] is a genuine improvement, though.

Thanks.
