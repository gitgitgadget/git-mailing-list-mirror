From: Junio C Hamano <gitster@pobox.com>
Subject: [RFH] "git reset --hard" broken???
Date: Mon, 01 Jul 2013 14:28:52 -0700
Message-ID: <7vli5qezqj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 01 23:29:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utlee-0002pu-Fo
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 23:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755090Ab3GAV2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 17:28:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60257 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754873Ab3GAV2z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 17:28:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 613BA2DD6E;
	Mon,  1 Jul 2013 21:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Y
	ZhtNbwyX+YQ9F7K8AwD8RbxUNg=; b=lDFcaSWReOSJktAq0cOKUMEEe6BRzkvHt
	FgcDWEq/kbvU9GWpPwM8vtMMtaDnzhjp+/yqAHWwwpQG3X7fATCGTtNniiIeqHAO
	4V/AneHwfuiZp5DEnNH+XWMnm9HQT1UKxfaTn5jpKPkhZEOlJ1/ZqJinyLwz3MLw
	Nxjc+/qH80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=T0K
	56dvkX0FBaaTCed+hKHJeReaQgnYCv2YFuFrYYYQJ3ywqqs2YLxcv0jhtbYT90fq
	AOxcQV3az7Qo4PNHdNBBdFEJ2B+lRdem0wscxnrXulDeF04OrSm1wzlo9hiXvEO8
	EGYgqROEknCxOHpL104MbV4ePtp/BQDT+XvxmdyI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57CA22DD6D;
	Mon,  1 Jul 2013 21:28:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD8072DD6A;
	Mon,  1 Jul 2013 21:28:53 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3AC487AE-E295-11E2-A94E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229328>

I have no time to dig this down, but I just noticed this by accident:

	$ make
        $ cd t
        $ sh ./t7011-skip-worktree-reading.sh -d
        $ cd trash*.t7011*
        $ git reset --hard HEAD
        error: Entry '1' not uptodate. Cannot merge.
	fatal: Could not reset index file to revision 'HEAD'.

which looks quite bogus.  "reset --hard" is meant to be the last
resort "no matter what, please match the working tree to the commit"
and should not ever error out with "not uptodate Cannot merge"
message.

Interestingly, you can do this to work it around, though:

        $ cd t
        $ sh ./t7011-skip-worktree-reading.sh -d
        $ cd trash*.t7011*
	$ git reset
        $ git reset --hard HEAD
        HEAD is now at .... init
