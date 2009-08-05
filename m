From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Revamping "git status"
Date: Wed, 05 Aug 2009 09:57:53 -0700
Message-ID: <7vbpmub3la.fsf@alter.siamese.dyndns.org>
References: <1249463746-21538-1-git-send-email-gitster@pobox.com>
 <200908051149.40980.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 05 18:58:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYjoR-0008PO-4x
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 18:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934517AbZHEQ57 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2009 12:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934650AbZHEQ56
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 12:57:58 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57692 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934381AbZHEQ56 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 12:57:58 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AD42D21383;
	Wed,  5 Aug 2009 12:57:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 102F121381; Wed, 
 5 Aug 2009 12:57:54 -0400 (EDT)
In-Reply-To: <200908051149.40980.trast@student.ethz.ch> (Thomas Rast's
 message of "Wed\, 5 Aug 2009 11\:49\:37 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 20E1966A-81E1-11DE-84B4-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124923>

Thomas Rast <trast@student.ethz.ch> writes:

> I also tried finding out which exact commit was causing this, but 4/5
> still segfaults and 1-3 don't even compile:
>
>   builtin-commit.c: In function =E2=80=98show_unmerged=E2=80=99:     =
                            =20
>   builtin-commit.c:827: error: dereferencing pointer to incomplete ty=
pe          =20
>   builtin-commit.c: In function =E2=80=98show_status=E2=80=99:       =
                            =20
>   builtin-commit.c:854: error: dereferencing pointer to incomplete ty=
pe
>   [etc]
>
> These are referring to use of a 'struct wt_status_change_data *', but
> the struct declaration is only in 4/5.  Am I missing something?

I suspect you have a botched patch application.

The result of applying up to [PATCH 3/5] does not even have
show_unmerged/show_status in builtin-commit.c.  These two functions are
introduced by [PATCH 5/5] to implement shortstatus.

I've applied what came back on the list on top of 07a4a3b (Fix typos on
pt_BR/gittutorial.txt translation, 2009-07-31) and all five states comp=
ile
just fine.

    $ git rev-list 07a4a3b.. |
      while read sha1
      do
            git rev-parse $sha1^{tree}
      done
    86363b25b84041cf14110dcc3136f56915778f71
    4625f5bbc43e1158d00aca8b2356047606c0babd
    895698143b2c29af8bfe0cdf6c3f57de3bf080d8
    3c565041ba6e432ff9064a1d8302f49ef33c2605
    c0c2b9c2a55e3df9cce448d59e5d557d07d78a4b
