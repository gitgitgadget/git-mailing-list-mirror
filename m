From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] create_default_files(): don't set u+x bit on $GIT_DIR/config
Date: Mon, 17 Nov 2014 07:42:29 -0800
Message-ID: <xmqqbno5zvdm.fsf@gitster.dls.corp.google.com>
References: <1416122508-30654-1-git-send-email-mhagger@alum.mit.edu>
	<1416122508-30654-2-git-send-email-mhagger@alum.mit.edu>
	<CAPig+cQ6j-3_Ng8DVT3FYk8T6DippEbYDhQq5v3DTJhGgBhPDQ@mail.gmail.com>
	<5469C40B.4080601@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Nov 17 16:42:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqORq-0007D9-2o
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 16:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbaKQPme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 10:42:34 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64230 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750964AbaKQPmd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 10:42:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EBFD21ED69;
	Mon, 17 Nov 2014 10:42:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+nQG5Agi9mVn+x2sCugBqu43lLE=; b=edg7/K
	9bMOSvXUa9XMcxf6rk0IYZ5ibDU2YOqqvVEWFMbejjJOjHGTG1iLYCRXUV3Vb9IO
	SIN8iKGSCYIcLUVcxGLkB79XKKzqwCCsa/iVkRJKiPThOlPV5pjZ3UqdZ5Fqq5tp
	cVhfVQZXcGx07jOTDdz+Ncj45ZIwPIJfOoSTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iUcUNUi0oDQUbwTY2u3dEWiZSCkP+5oq
	Fp7pRxlbII22seOSkYQshiUBC3pOJbRmP4f/AfiDDguRwbftCBkMxZz2idgGrJZg
	BJBBErC3Hqb/eBQGgIWLqWZJOdv1XFmK0/U1lZTLHy+rBmQOsce3E/yB8FUEm5Xt
	i7DQxMLVlYY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E1EFF1ED68;
	Mon, 17 Nov 2014 10:42:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 35FCE1ED67;
	Mon, 17 Nov 2014 10:42:34 -0500 (EST)
In-Reply-To: <5469C40B.4080601@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 17 Nov 2014 10:46:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5964BEBE-6E70-11E4-8F73-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This seems like a one-off bug caused by a specific instance of odd code.
> It could only recur if somebody were to remove the line that I added,
> which would be a *very* odd mistake to make given that its purpose is
> pretty obvious.

Or some other code that comes _after_ your new code touches the
file.

You cannot anticipate what mistake others make.

Shouldn't something like this be sufficient?

 t/t0001-init.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index e62c0ff..acdc1df 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -12,6 +12,13 @@ check_config () {
 		echo "expected a directory $1, a file $1/config and $1/refs"
 		return 1
 	fi
+
+	if ! test_have_prereq POSIXPERM || test -x "$1/config"
+	then
+		echo "$1/config is executable?"
+		return 1
+	fi
+
 	bare=$(cd "$1" && git config --bool core.bare)
 	worktree=$(cd "$1" && git config core.worktree) ||
 	worktree=unset
