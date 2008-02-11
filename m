From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [DOC BUG] git tag uses GIT_COMMITTER_DATE, not GIT_AUTHOR_DATE
Date: Mon, 11 Feb 2008 01:09:27 -0800
Message-ID: <7vir0vamgo.fsf@gitster.siamese.dyndns.org>
References: <87ir0vc2gw.fsf@Astalo.kon.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kalle Olavi Niemitalo <kon@iki.fi>
X-From: git-owner@vger.kernel.org Mon Feb 11 10:11:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOUhC-0002lH-TM
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 10:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015AbYBKJJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 04:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754986AbYBKJJi
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 04:09:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44323 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754879AbYBKJJf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 04:09:35 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 303984809;
	Mon, 11 Feb 2008 04:09:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B7E34807;
	Mon, 11 Feb 2008 04:09:29 -0500 (EST)
In-Reply-To: <87ir0vc2gw.fsf@Astalo.kon.iki.fi> (Kalle Olavi Niemitalo's
	message of "Mon, 11 Feb 2008 10:38:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73488>

Kalle Olavi Niemitalo <kon@iki.fi> writes:

> In Git v1.5.4.1, Documentation/git-tag.txt advises:
>
>> To set the date used in future tag objects, set the environment
>> variable GIT_AUTHOR_DATE to one or more of the date and time.  The
>> date and time can be specified in a number of ways; the most common
>> is "YYYY-MM-DD HH:MM".
>
> But this does not work because git tag uses GIT_COMMITTER_DATE instead.
> In builtin-tag.c:
>
>> 	header_len = snprintf(header_buf, sizeof(header_buf),
>> 			  "object %s\n"
>> 			  "type %s\n"
>> 			  "tag %s\n"
>> 			  "tagger %s\n\n",
>> 			  sha1_to_hex(object),
>> 			  typename(type),
>> 			  tag,
>> 			  git_committer_info(IDENT_ERROR_ON_NO_NAME));
>
> i.e. it does not call git_author_info.
>
> The backdating section was added to git-tag.txt in 5040beff,
> and builtin-tag.c already used git_committer_info at that time.
> The older git-tag.sh used tagger=$(git-var GIT_COMMITTER_IDENT).
> Thus it seems the bug is in the documentation, not in the code.

Correct.  We've always used committer ident as far as I can
remember.
