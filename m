From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] bisect--helper: add "--next-exit" to output bisect
 results
Date: Mon, 20 Apr 2009 01:44:34 -0700
Message-ID: <7vprf7k93h.fsf@gitster.siamese.dyndns.org>
References: <20090419115607.c7089503.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Apr 20 10:46:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvp8w-0001LS-Fk
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 10:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086AbZDTIop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 04:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbZDTIop
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 04:44:45 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809AbZDTIoo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 04:44:44 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D1CCE103E9;
	Mon, 20 Apr 2009 04:44:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2299B103E8; Mon,
 20 Apr 2009 04:44:40 -0400 (EDT)
In-Reply-To: <20090419115607.c7089503.chriscool@tuxfamily.org> (Christian
 Couder's message of "Sun, 19 Apr 2009 11:56:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7EC275AA-2D87-11DE-ABF4-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116950>

Christian Couder <chriscool@tuxfamily.org> writes:

> The goal of this patch is to port more shell code from the "bisect_next"
> function in "git-bisect.sh" to C code in "builtin-bisect--helper.c".
>
> So we port the code that interprets the bisection result and stops or
> continues (by checking out the next revision) the bisection process.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

Just to make sure I understand correctly, with this and patch 5/5, we can
then drop the --next-vars helper command, right?

> @@ -16,6 +17,12 @@ static const char **rev_argv;
>  static int rev_argv_nr;
>  static int rev_argv_alloc;
>  
> +static const unsigned char *current_bad_sha1;
> +
> +static const char *argv_diff_tree[] = {"diff-tree", "--pretty", NULL, NULL};
> +static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
> +static const char *argv_show_branch[] = {"show-branch", NULL, NULL};

I do appreciate that you kept this step in "rewrite in C" theme a straight
rewrite to still call out the executables.  We can turn these into
internal calls in future steps, but that is a separate issue.

I suspect that the show-branch call outlived its usefulness with this
patch; it will now be a low hanging fruit to call format_commit_message()
internally to reduce one fork+exec.

Thanks, queued.
