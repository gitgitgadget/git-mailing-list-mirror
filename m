From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Segfault with merge-tree on multiple Git versions
Date: Wed, 27 Mar 2013 13:04:01 -0700
Message-ID: <7vtxnwlidq.fsf@alter.siamese.dyndns.org>
References: <51531059.8000407@atechmedia.com>
 <7vsj3gn55b.fsf@alter.siamese.dyndns.org> <515331F2.3060703@atechmedia.com>
 <874nfw4t0r.fsf@59A2.org> <51533E8D.5050206@atechmedia.com>
 <87zjxo3b7b.fsf@59A2.org> <20130327194521.GQ2286@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jed Brown <jed@59A2.org>,
	Charlie Smurthwaite <charlie@atechmedia.com>,
	git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Mar 27 21:04:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKwaI-00059F-2O
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 21:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398Ab3C0UEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 16:04:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45117 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754369Ab3C0UEE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 16:04:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A50BFB8F3;
	Wed, 27 Mar 2013 16:04:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F3XcAVvew727NRAZNayaf/t2ZR0=; b=gnaINl
	AzMb60FalDpbWM1MxJ7yKuav0yszNCdkBTF/2h2amSd0v5q+YBqTkDTypb3tZGHq
	HBTGPqnZe++hS43fA2Nkx/lNn3VW/wkGGP3t/qaHz4ppIcsV17qrCx4Gz6Q8YBVv
	OWt/yq6E+3J/D0NxYzwFcDJYxn9DmkSQnl+z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tcb9dpUfVOZ0E0M1Zp2N9tfPt0yJT3FA
	i10N8KFCJilAgTixpfHjLsvo/rb0umeUT5jenKpWXNgJAKj+Pci0kXo8N0cdo+6/
	87zJBAVzlThaNeyizbt1L5sw8AIc1lOMFttUhSLLn6SdBevqv1vzDrnav/66jt1P
	63/XmZT1umE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9823EB8F2;
	Wed, 27 Mar 2013 16:04:03 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E56BBB8F1; Wed, 27 Mar 2013
 16:04:02 -0400 (EDT)
In-Reply-To: <20130327194521.GQ2286@serenity.lan> (John Keeping's message of
 "Wed, 27 Mar 2013 19:45:21 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 78BAB668-9719-11E2-8691-CDBF2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219319>

John Keeping <john@keeping.me.uk> writes:

> You could use a temporary index and do something like:
>
> 	rm -f TMP_INDEX
> 	GIT_INDEX_FILE=TMP_INDEX
> 	export GIT_INDEX_FILE
> 	git read-tree -m $base $ours $theirs &&
> 	git merge-index git-merge-one-file -a
>
> then inspect that with "git diff-index --cached $ours".

Good.

> Note that this will fail if there are conflicts and I don't know what
> git-merge-tree will do in that case.

I _think_ Charlies's use case is to detect trivial merges to tell
the requestee that a merge request can be done on site, so failing
is fine when there are conflicts.  merge-tree should report
conflicts as well.
