From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] Fix setup of $GIT_DIR in git-sh-setup.sh
Date: Sun, 17 Feb 2008 21:44:07 -0800
Message-ID: <7v1w7au8d4.fsf@gitster.siamese.dyndns.org>
References: <1203286456-26033-1-git-send-email-hjemli@gmail.com>
 <1203286456-26033-2-git-send-email-hjemli@gmail.com>
 <1203286456-26033-3-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 06:46:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQypM-0004Z3-B5
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 06:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbYBRFpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 00:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbYBRFpd
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 00:45:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35453 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbYBRFpd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 00:45:33 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C9A6E3700;
	Mon, 18 Feb 2008 00:45:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 DBE3636CF; Mon, 18 Feb 2008 00:45:25 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74232>

Lars Hjemli <hjemli@gmail.com> writes:

> Since .git can be a file refering to the real GIT_DIR, git-sh-setup needs
> to use 'git rev-parse --git-dir' to obtain the location of the git
> repository.

I wonder if this depend on your [1/5].  Isn't this actually a
simplification (removing 7 adding 5 lines) that applies to the
mainline already?  IOW, is there a downside of doing this
without any of the rest of the series?

> @@ -127,20 +127,18 @@ get_author_ident_from_commit () {
>  # if we require to be in a git repository.
>  if test -z "$NONGIT_OK"
>  then
> +	GIT_DIR=$(git rev-parse --git-dir) || {
> +		exit=$?
> +		echo >&2 "Failed to find a valid git directory."
> +		exit $exit

rev-parse --git-dir would have said "fatal: Not a git
repository" already.  Do we still need to say "Failed to
find..."?
