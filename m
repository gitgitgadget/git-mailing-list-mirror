From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] submodule: Search for merges only at end of
 recursive merge
Date: Fri, 26 Aug 2011 12:04:32 -0700
Message-ID: <7vr548c7un.fsf@alter.siamese.dyndns.org>
References: <074f22629c034dba738b7241c78229db7f9159ec.1314275112.git.brad.king@kitware.com> <03300e44101092641810b34086738a151e01d8ee.1314368109.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Fri Aug 26 21:04:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx1hn-00039g-IO
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 21:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601Ab1HZTEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 15:04:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40293 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753597Ab1HZTEe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 15:04:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 307444338;
	Fri, 26 Aug 2011 15:04:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5LwAH8s29YqgotnS7/FbBN0zUfQ=; b=GYatNt
	SWJjgFnHmF5g/DG1Rao6GdITl+hPuCz5M860kq9qxhLxft0C1fV7HvVro9aqaQuI
	7ww+wg1GInLc0PxcDjlaGv5YVRKaUWGIH/qU4QzzTci3u1AMwafiG/wkak5EGIcS
	312DOKCmFdmDNTjKLz4PsrEKlmNwv2z4DjeUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H1NAP1+i9uTnl8VvsEQHoOQr9sZp4bWA
	jY2pXUxiOjYkRA3no25d69+wpZnG1OeFQCjnSTpneN7BESY7QgchKjvjxZo+I4LT
	03+KQw3615P1xSaU2ctaAEek9MbBnCtgJ691sigenwN1VR2r5SzA1EbmOdoD+EyH
	0Zd9XnRXAw8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27D334337;
	Fri, 26 Aug 2011 15:04:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97F554336; Fri, 26 Aug 2011
 15:04:33 -0400 (EDT)
In-Reply-To: <03300e44101092641810b34086738a151e01d8ee.1314368109.git.brad.king@kitware.com> (Brad King's message of "Fri, 26 Aug 2011 10:18:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C0B3678-D016-11E0-AB25-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180191>

This is a knee-jerk reaction without thinking things thoroughly through,
but wouldn't it make more sense to do this by conditionally calling
merge_submodule() when !o->call_depth, leaving the callee oblivious to
what is in the "merge_options" structure? That way, you do not have to
touch submodule.c at all, I would think.

After all, merge_submodule() should be usable in a future merge strategy
that is different from recursive and has no notion of call_depth.
