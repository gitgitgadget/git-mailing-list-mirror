From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-quiltimport: fix security risk because of
 un-sanitized $level.
Date: Wed, 12 Mar 2008 13:55:56 -0700
Message-ID: <7v63vr64rn.fsf@gitster.siamese.dyndns.org>
References: <20080312204648.GA28729@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Mar 12 21:56:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZY0C-00005x-GK
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 21:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbYCLU4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 16:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbYCLU4E
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 16:56:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbYCLU4C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 16:56:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 48351140E;
	Wed, 12 Mar 2008 16:56:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8DAED140B; Wed, 12 Mar 2008 16:55:58 -0400 (EDT)
In-Reply-To: <20080312204648.GA28729@artemis.madism.org> (Pierre Habouzit's
 message of "Wed, 12 Mar 2008 21:46:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76987>

Pierre Habouzit <madcoder@debian.org> writes:

> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>
>   I assume that nobody will have a series with -p1000 in it :)
>   sorry for this gross mistake in the first place.
>
>   [ for the inattentive readers $level was used without quoting, for
>     good reasons as it's sometime empty and then we don't want to pass
>     an empty argument to git-apply, though someone could use that to run
>     arbitrary commands, not nice ]

A traditional way to deal with that situation in shell scripts is to use
this idiom:

	${var_that_may_not_be_set+"$var_that_may_not_be_set"}

You can use :+ in place of + to also reject empty string on modern
systems.

#!/bin/sh
not_set=t ; unset not_set
is_set=t

report () {
	echo "I got $# args"
        i=1
        for it
        do
        	echo "$i: $it"
                i=$(( $i+1 ))
	done
        echo
}

report sending not_set ${not_set:+"$not_set"} string
report sending is_set ${is_set:+"$is_set"} string
