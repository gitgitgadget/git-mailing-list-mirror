From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule: Remove duplicate entries during merge
 with conflict
Date: Thu, 17 Mar 2011 11:47:12 -0700
Message-ID: <7v1v254ma7.fsf@alter.siamese.dyndns.org>
References: <4D81C1AA.5010008@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: devel-git@morey-chaisemartin.com
X-From: git-owner@vger.kernel.org Thu Mar 17 19:47:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0IEH-00080e-L1
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 19:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173Ab1CQSrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 14:47:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58820 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754962Ab1CQSrU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 14:47:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 22EC831A8;
	Thu, 17 Mar 2011 14:48:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sp2NWc368A2JNVFPIwzODfAUAZ8=; b=L9G6Wo
	BAwlOkdL6Vloi7iD4AoVJEhXpEjYq2Cso2udM/Ij1e1NdSGyIjYWPiMN+5tvzvB3
	vUyAkRbIy8t13fHULmlJKvpIse2mQCb5YpAYKH9aS6tqLQqGKf06WssEm4YXR1TM
	Mh2Xfy/Hg81KdCtYmeij93GfeElOHMkU2gYK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wkXpk66rKV09e/SEaVsH3T/lUcA4gx1u
	z5IxQhasFeaw8gB5BAISrU34kMjktCCPjPS88Va3BwRKu+mkRlZSNRV00rwdi2GB
	nJPxyjUkGmhlv5DEOi9a+CRfMs/mwbwBwfPKsdAM73k8+DkgxYWzTvUxWvXSwLv4
	vz/TUf6qHrU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 00AFF319F;
	Thu, 17 Mar 2011 14:48:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 28C61319A; Thu, 17 Mar 2011
 14:48:46 -0400 (EDT)
In-Reply-To: <4D81C1AA.5010008@morey-chaisemartin.com> (Nicolas
 Morey-Chaisemartin's message of "Thu, 17 Mar 2011 09:09:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32A06B54-50C7-11E0-A6BD-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169256>

Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com> writes:

> During a merge with conflict on a submodule, the submodule appears 3
> times in git ls-files (stage 1,2,3) which causes the submodule to be
> used 3 times in git submodule update or status command.  This patch
> filters the results of git ls-files and only shows submodule in stage 0
> or 1 thus removing the duplicates.

That is a wrong thing to do.  What if both sides added a submodule at the
same directory after forked from an ancestor that did not have it?  You
will have only stage #2 and stage #3, no?
