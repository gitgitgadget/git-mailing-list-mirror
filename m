From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Find the size of git push in pre-receive hook
Date: Fri, 04 Nov 2011 11:01:29 -0700
Message-ID: <7vaa8bdax2.fsf@alter.siamese.dyndns.org>
References: <1320398420796-6962141.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: manigandans <etc.mani@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 04 19:01:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMO5B-00065M-3f
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 19:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756063Ab1KDSBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 14:01:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49976 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755187Ab1KDSBc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 14:01:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 120DB6C2F;
	Fri,  4 Nov 2011 14:01:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XsU5Ey3+GU6TabFedAchF3dCzTc=; b=kezdqP
	ymxacP3MN1oDI90PqOPh13PcovrlRu4J82S+9TVHGqdmWPY1WA98lIDCSluxlkM+
	Ku2O7xtrzfnL40LYuOhp/Qlh0sUlIK4ViQ0jtwxGe7NmqtYpWelCM4+X1/wtXHpr
	30eAzxgQXKAnfrOgsldBV8RZAisIaSgMxulQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MSWOqV8rlALGKrYnwX7ctt3KgoxAhFio
	r5uyzcDDQqXo7gXacvKzcNkHLmlTZFBZDP2mgnPugcT7iPTd8v2+e4WRknCi69IC
	V00ekCmkuK43zPhcoHndMpomAUbhYqYvoB8g3KpFDtTMe0lFN7lLAg1l4Sk+9AfA
	gUcekm26/4E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09CCF6C2E;
	Fri,  4 Nov 2011 14:01:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E4086C2C; Fri,  4 Nov 2011
 14:01:30 -0400 (EDT)
In-Reply-To: <1320398420796-6962141.post@n2.nabble.com> (manigandans's
 message of "Fri, 4 Nov 2011 02:20:20 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06177164-070F-11E1-B94D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184793>

manigandans <etc.mani@gmail.com> writes:

> I want to restrict the size of the push on the git remote repository. How
> can I find the size of the push in pre-receive hook?

You don't.

What are you trying to solve?

The thing is, by the time pre-receive-hook is run, the packs have already
been transferred to the destination. Otherwise pre-receive-hook cannot do
its primary task of inspecting the history the push is trying to update
the refs with and allow or deny the ref updates.

Presumably you could run "git rev-list --objects" between the values of
refs before and after the proposed updates, sum up their sizes and reject
the push when the push adds too much data for your liking, and the next gc
will clean things up, but if your goal is to cap the maximum disk quota
including the transient use during the time pre-receive-hook is run, it
would not help.
