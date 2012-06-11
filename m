From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git repository name-guessing corner case
Date: Mon, 11 Jun 2012 13:09:45 -0700
Message-ID: <7vwr3d625y.fsf@alter.siamese.dyndns.org>
References: <1339442931056-7561236.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joseph Chiu <joechiu@joechiu.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 22:09:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeAvx-0006j7-7I
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 22:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab2FKUJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 16:09:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55760 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885Ab2FKUJs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 16:09:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E5BB808B;
	Mon, 11 Jun 2012 16:09:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D5VGnyvsUcBaiXxmv+4Jrle+aR0=; b=AwFcgV
	pOh5oqlVFvG6R5JRAOvOiCfDw3rlkmcTSVFKRzZ4vtuV1O8bBesdlyXG9NcJPK0d
	gFKJ8tIklN0QjOZxn81zy6nWbxF7wV4SmtY+zOlst0Zk0aotfKOmEkLGIidYFPpL
	J3kQ7qXnIno+vWFuJ2YxH87ApWEfRCXiEonzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KfA12Lm2gAnUMDkbsko/QjWQLpys73TQ
	YIEz9clxS9bFPTM3ZT6gmZLcGVTznGXcwLswPWz5dU530kcqduBav33of+RvcgMF
	5JMekCJnQoPMSDNUpBp6gjziazUw7AhpVOAO/pp+bWjfodUjWHIz6IX7h2fcnIQi
	674L7OyD+/s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 756FB808A;
	Mon, 11 Jun 2012 16:09:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0BD0A8089; Mon, 11 Jun 2012
 16:09:46 -0400 (EDT)
In-Reply-To: <1339442931056-7561236.post@n2.nabble.com> (Joseph Chiu's
 message of "Mon, 11 Jun 2012 12:28:51 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 646BE6F6-B401-11E1-B490-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199715>

Joseph Chiu <joechiu@joechiu.com> writes:

> On the south machine, I first accidentally created the repo wizard.git.git
> (note the double .git), with ...

We have updated the logic around this area with b3256eb (standardize
and improve lookup rules for external local repos, 2012-02-02), and
this is part of v1.7.9.2 and later releases.  The rule used to be
(1) check with "/.git" appended, to cover the case where you access
a repository with a working tree attached, (2) check with ".git"
appended, and then (3) check without anything appended. It was very
error prone to cause exactly the above kind of gotchas.

The updated rule checks with "/.git" first andthe next possibility
that is checked is the given name without modification, so if you
have both wizard.git and wizard.git.git (with or without working
tree):

        accessing with this name ... will find this repository
        wizard                       wizard.git
        wizard.git                   wizard.git
        wizard.git.git               wizard.git.git

which should be much saner.
