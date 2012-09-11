From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-describe: introduce --first-parent
Date: Tue, 11 Sep 2012 09:41:34 -0700
Message-ID: <7voblcikap.fsf@alter.siamese.dyndns.org>
References: <cover.1347370970.git.git@drmicha.warpmail.net>
 <b5a771de4f84b6f6ae82b736c834d105aa98f87f.1347370970.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 11 18:41:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBTWz-0006rk-Uy
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 18:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758088Ab2IKQli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 12:41:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33342 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754845Ab2IKQlh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 12:41:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E7CC7899;
	Tue, 11 Sep 2012 12:41:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jf/pfsu/EmsM+xwRrd9Emog3HZs=; b=U49kLk
	AFDBHh1kz8DyMjaZHhBnVFXj9vqSX0jX/G0cERO36XAdRbmlaNuNx2sffrJlKsGz
	fmg1TMt1/Kihq57k1xpQEepjbiXg5TgBIWM6FRvZKzr7WQ7K6CVC4oM97cjrZq5V
	9Bv2IHsBELwWbu2mPY9TxmB0wDyG/P62hxIiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wr6UxZfhupJTZYO+bNh5NmPyCZt1Mh+0
	wg+2ERCbjszhlIH9wRe454fwJNBGFPCNtB5HlaYpGI+Xb5Gbra1ow7AMd1tzvEq7
	JeXUp47AWV3m3zk0MSbhAscMjBQZKMryss5OJAndpPV57XJ66Q8IOb63giDEuB+/
	iZY1B33avE4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AE417898;
	Tue, 11 Sep 2012 12:41:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 861F6788E; Tue, 11 Sep 2012
 12:41:35 -0400 (EDT)
In-Reply-To: <b5a771de4f84b6f6ae82b736c834d105aa98f87f.1347370970.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue, 11 Sep 2012 15:51:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8CE8FD3C-FC2F-11E1-8B72-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205247>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> so that git-describe searches first-parent history only when looking for

Please make sure your first paragraph of the log message start with
a full sentence, not an incomplete tail part of a sentence as if the
title of the commit were repeated in front of it.

> a named commit. This is useful for describing commits by tags on their
> "main" (first-parent) branch; for example, on git.git:

This is useful only when the history does not have fast-forward
merges from a sideline; otherwise it will produce unexpected
results, no?

> git describe 22ffc39
> v1.7.2.3-223-g22ffc39
>
> git describe --first-parent 22ffc39
> v1.7.2-104-g22ffc39

The output is wrong in that 22ffc39 is v1.7.2-336-g22ffc39, not 104.
Putting an arbitrary number that can change depending on how the
traversal went will close the door to possible follow-up work on the
recent sha1-name-more series (0958a24^2, most importantly aa1dec9e)
to prolong the shelf-life of describe output by filtering candidate
commits with reachability from the tag and the number of commits
from the tag.

In any case, it is not clear to me if this is a useful example to
help readers of this commit to understand why this new feature is
useful.  22ffc39 was created to mark that the work done for 1.7.2.x
maintenance track back then were all contained in the 'master' by
merging 'maint' when it was pointing at v1.7.2.3.  Saying the commit
is newer than v1.7.2.3 gives more information than it is newer than
v1.7.2, as by convention v1.7.2 must be older than v1.7.2.3, no?
