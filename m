From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] "git commit --dry-run" updates
Date: Mon, 17 Aug 2009 08:57:00 -0700
Message-ID: <7vljlixwkz.fsf@alter.siamese.dyndns.org>
References: <1250330803-22171-1-git-send-email-gitster@pobox.com>
 <200908171201.43343.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Aug 17 17:57:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md4aE-0001Bz-NK
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 17:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756361AbZHQP5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 11:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756324AbZHQP5H
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 11:57:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104AbZHQP5G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 11:57:06 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D83542CE43;
	Mon, 17 Aug 2009 11:57:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 86B032CE3F; Mon, 17 Aug 2009
 11:57:02 -0400 (EDT)
In-Reply-To: <200908171201.43343.trast@student.ethz.ch> (Thomas Rast's
 message of "Mon\, 17 Aug 2009 12\:01\:41 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9D2B7D4E-8B46-11DE-990E-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126198>

Thomas Rast <trast@student.ethz.ch> writes:

> If it's not too much work, it would be nice to somehow detect if -u
> can have any influence at all.  For example,
>
>   $ git status bar
>   # Not currently on any branch.
>   nothing to commit (use -u to show untracked files)
>
> is a bit misleading if 'bar' is tracked because adding a -u won't make
> any difference.

It is an issue shared with the original "git status".  Running

    git init
    >file
    git add file
    git commit -m initial
    git status -uno

will give the same "use -u to show" message.

The thing is, "use -u to show" is because you told git not to check if
there is any untracked file.  Whoever added -uno wanted not to run the
recursive read_directory() to find them.

The message says "you told me not to check about untracked files, so I can
not show you any, because I did not check; if you want, please use -u to
tell me to check so that I can show them to you".  

It is not about "we know that there are untracked files but you told me
not to show it, so I am not telling".  We simply do not know at the point
we give that message.  In other words, conditional removal of that message
is fundamentally incompatible with the use of -uno.
