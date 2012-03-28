From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-subtree Next Round Ready
Date: Wed, 28 Mar 2012 15:45:36 -0700
Message-ID: <7vobrgs5tb.fsf@alter.siamese.dyndns.org>
References: <87398we3ox.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Thu Mar 29 00:46:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD1d6-0002oW-Ay
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 00:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933399Ab2C1WqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 18:46:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55224 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758926Ab2C1Wpj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 18:45:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8305B7E7A;
	Wed, 28 Mar 2012 18:45:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0Hb37ILa7XFbjWToicuE4cC/+bQ=; b=jQ1RUA
	nVzch4r5Pb5ApmSvJtDGtcO1IF+P7Gf7geqo+muNJfHZ05me7/7TNgJeO7AFc+iz
	DBNxcnHli8HsBMy/DkjuySQM1BK8dDP/Pmih9Y7j6GqshgX4x4ue5ftWP58w0GFH
	A/WuPt4NkfRYBcSqYtB7Yga2t/UdUN+HKcsaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y5fIw3bF0j6dH5j9IyWtRjoh1CVi2F9G
	UzqtQ0VJKFj4Mb4yxAiskaFMRV8jpZQU8dbGm414zzBgtDHVdm9aMXuOtwR8w7/G
	FyEoB+xWewECLeWe0WWT07OqFh/lBTwXayfQDOll/pd/NOfBCYabZWsthSF8/Xdq
	+dGWpXjp+IM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7998C7E79;
	Wed, 28 Mar 2012 18:45:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C99FD7E78; Wed, 28 Mar 2012
 18:45:37 -0400 (EDT)
In-Reply-To: <87398we3ox.fsf@smith.obbligato.org> (greened@obbligato.org's
 message of "Sun, 25 Mar 2012 17:06:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BCF01D0C-7927-11E1-9789-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194213>

greened@obbligato.org writes:

> There are three branches.  master is the usual.  "subtree-latest" is my
> version of git-subtree cleaned up for upstreaming into contrib/.  This
> is the pure git-subtree history, ready to be subtree merged.
> "subtree-integrated" is a version of upstream git.git with
> subtree-latest merged as a subtree (done via git-subtree!).

I do not see the point of your subtree branch, especially after 1f30551
(Set TEST_DIRECTORY, 2012-03-20) where it starts depending on files
outside its top-level directory. At that point, the tree ceases to be
viable as a standalone project.

I think it would make more sense, from the history viewpoint, to:

 - Stop the history of the "subtree" branch at commit d3a04e0 (Use Test
   Harness, 2012-01-29);

 - Create "for-upstream" branch that is a fork of 1.7.10 (when tagged);

 - On "for-upstream" branch, add all the files from d3a04e0 (Use Test
   Harness, 2012-01-29) to contrib/subtree, and record it as a merge
   between 1.7.10 and d3a04e0 (you can use subtree merge for this); and
   finally

 - Replay the commits between d3a04e0 and the tip of your current
   "subtree" branch on top of "for-upstream".

And then have me pull the "for-upstream" branch.

Further development after that point can continue in-tree just like any
other contrib subsystems like "completion/" and "fast-import/git-p4".
