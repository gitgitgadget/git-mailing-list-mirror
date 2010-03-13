From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Bug: failed octopus merge does not create MERGE_HEAD
Date: Sat, 13 Mar 2010 12:52:51 -0800
Message-ID: <7vr5no7xlo.fsf@alter.siamese.dyndns.org>
References: <1268402835-12992-1-git-send-email-sojkam1@fel.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michal Sojka <sojkam1@fel.cvut.cz>
X-From: git-owner@vger.kernel.org Sat Mar 13 21:53:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqYKW-0003C8-DW
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 21:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935689Ab0CMUw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 15:52:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46713 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932413Ab0CMUw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 15:52:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D7F7A1BE8;
	Sat, 13 Mar 2010 15:52:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=TrT6zWn8RIRp6Ln1y5bC0kqiED0=; b=dbiGAbSZihWFnUcRATihcCU
	Q2dppF4GoKzW2ymRfSar0MCo7GGG41VlhX6xq0Do9ZlOaww9shlikr3RzBQqgc16
	nEMivYyjK2mzCdyA8v+cpyWEwYzYlID8edMRWk1Amy1Vo9BMpFDAY3EV2GWM6AP3
	cK8an1N7f/K0PClE38q0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=iXQrxm1spheu5lOOQw5KODTkAIv/jn5qrBRBXRmb0JzMZJJ5v
	2GmThweGy5GgvBFvfuK3a42/iGQ9hhiM20YRe5ltFu/pKrkL/IH5IFZfdYs3pMsw
	H1kpik2VyMKtntzoXV1RWLfTolRMlovYjDutug641oRHcSQtm2qRoDGY5M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A6BEA1BE6;
	Sat, 13 Mar 2010 15:52:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DBAF4A1BE5; Sat, 13 Mar
 2010 15:52:52 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 660D9CB2-2EE2-11DF-877A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142105>

Hmm.

When it detects conflicts, and refuses to make a merge, the octopus
backend says "should not be doing an octopus".  As far as I can tell,
MERGE_HEAD is useful only when resolving conflicts, and the octopus
strongly discourages recording anything but the simplest conflict-free
merges.  That makes me think that not writing the file out would be the
more correct thing to do.

One possibility I can think of is that we try to prevent user mistakes by
checking the existence of MERGE_HEAD (i.e. "can't do this, you are still
during a merge"), and not writing MERGE_HEAD in this case, but still
potentially leaving the index unmerged, may allow some operations that we
should prevent from being invoked to proceed.  Is that the issue you are
trying to address?  Or is there something else?  Why do you want to have
MERGE_HEAD?
