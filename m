From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/5] push: update remote tags only with force
Date: Wed, 14 Nov 2012 05:22:11 -0800
Message-ID: <7v390ccoak.fsf@alter.siamese.dyndns.org>
References: <1352693288-7396-1-git-send-email-chris@rorvick.com>
 <7v4nktdwtp.fsf@alter.siamese.dyndns.org>
 <CAEUsAPYvrR6WsVWCvwoEWA21gzL6Sib0sTyx-c_2tH=8ni69yQ@mail.gmail.com>
 <CAEUsAPZtF-L5J_g1L5d44BKveoAnJ81PatX94fFS4FM=iW33KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 14:22:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYcvG-0007Xq-V9
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 14:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422857Ab2KNNWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 08:22:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34320 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422829Ab2KNNWO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 08:22:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7707D6270;
	Wed, 14 Nov 2012 08:22:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=53F84K5JI7HWDmPB3JzEii7Jlps=; b=w7v94a
	9R1OADyRqrhQoUQAOGrfp3F357RpsW2I8YzzAg4r+G7Y7Ki27mI+bMoQslo26h+V
	W47EMIM2AmVuueCvyJLrpo509B9pYEdwpxB8obmAdTV9leXGmofxQPawMHNu9fUK
	2ziprDVPukliFGCv1hMgi7ntI2JgNM1zRfsac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KFJnBpNJNhoWeVaFdexJeJBVupdR6rZ9
	dFRsuoIqgBsDHrDnSoSIR3I60MtKN3wYXJeE+7Ct4KdGSvdkC8gy1noeLLd21Wd1
	nyuo6y4kwbeVkjeUJFop5FaNEgoYOnIyNCq4UhQD36E165/mvWQlovSx+P24U7Zq
	JP1VsInHTf4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63EDD626F;
	Wed, 14 Nov 2012 08:22:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEA38626E; Wed, 14 Nov 2012
 08:22:12 -0500 (EST)
In-Reply-To: <CAEUsAPZtF-L5J_g1L5d44BKveoAnJ81PatX94fFS4FM=iW33KA@mail.gmail.com> (Chris
 Rorvick's message of "Wed, 14 Nov 2012 00:29:14 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D0AA538-2E5E-11E2-BDB2-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209715>

Chris Rorvick <chris@rorvick.com> writes:

>> "Do not update, only add new" may be a good feature, but at the same
>> time I have this suspicion that its usefulness may not necessarily
>> be limited to refs/tags/* hierarchy.
>>
>> I dunno.
>
> Are you suggesting allowing forwards for just refs/heads/*?

No, it is a nonsense to unconditionally forbid fast-forwards to refs
outside refs/heads/ hierarchy.

I was imagining a more general feature to allow the *user* to ask
Git not to fast-forward some refs (not limited to refs/tags/) during
a push.

If such a general feature were in place, you can think of your patch
as automatically making the user to ask Git not to fast-forward refs
in refs/tags/, which would be a mere special case of it.

And I was wondering if such a general feature makes sense.
