From: Junio C Hamano <gitster@pobox.com>
Subject: [Bug?] "am --abort" broken?
Date: Wed, 12 Jun 2013 15:38:02 -0700
Message-ID: <7vsj0nymyd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 13 00:38:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmtgK-0000Ql-Fw
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 00:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757639Ab3FLWiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 18:38:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63087 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755220Ab3FLWiP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 18:38:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11952279B6;
	Wed, 12 Jun 2013 22:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=B
	iWt1yZT0vrfAldQi9bIK6LiUDw=; b=n8yTVaPW0FTYQBTKHpFQoLIqjYZgdRX72
	kKLpYXVWynwiaasZ3dlFWHByCoJ8ypHFSbxUeKTRLz0BjAs0bWXLQhUwaHzimEsQ
	v+w/CqI7WfZ9RgKHQFEZHj6mLUlAaIxAhrgMeZd49yyf3XNQwJn7j6tSMB5ypWFt
	L3QKUu2ChE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=U4UNe5ELq6gi1rJwswnJXSuCUkyPir52J2mHClHkQC3FuNrBGairyfa4
	9RYclIZv9hmfWa2t+P/4Gpsocs2knABMgpWLy8FF66l0OXXf88dTlFDdWuWGOxGh
	GKf6CR5rKPhDFxdRYzd4AB/PW6gAcYDDLofu1bUSkYKdyWRU0WU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06087279B5;
	Wed, 12 Jun 2013 22:38:14 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CAC4279B4;
	Wed, 12 Jun 2013 22:38:13 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C446D9BC-D3B0-11E2-9894-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227688>

This is somewhat minor but will confuse people who do not know how
to manually recover from.  Start "am" without giving an input file
by mistake:

    $ git am ;# no input file
    ^C

At this point, you are still in "am" session; completion will tell
you that you are in a middle of "am/rebase".  A more recent way to
get out of this is to use "am --abort", but you get this:

    $ git am --abort
    Resolve operation not in progress, we are not resuming.

"git am" from 'maint' will help you get out of it, or you can do it
the old fashioned way:

    $ rm -fr .git/rebase-apply

I think this is a recent breakage after merging the topic to add
"rebase --autostash", but I haven't looked into it yet.
