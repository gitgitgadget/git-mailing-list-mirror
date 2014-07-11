From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Bug] data loss with cyclic alternates
Date: Fri, 11 Jul 2014 09:01:40 -0700
Message-ID: <xmqqy4vz51gb.fsf@gitster.dls.corp.google.com>
References: <53BFB055.206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ephrim Khong <dr.khong@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 18:01:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5dGj-0002lS-5r
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 18:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691AbaGKQBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 12:01:49 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62074 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754145AbaGKQBs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 12:01:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 99A3425DD3;
	Fri, 11 Jul 2014 12:01:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IP1Jh0UXGvbozpuECuxlhtB+CVA=; b=hEocB/
	GoUtJVJCyK8yvVopJIw0Hadu99Q5aT9Od1umreLgIkC3j7jcIyoTH5DJo6WQ3NXj
	oPSKpqv1IqP2jOW2BhaNFj7fxNLbyHhKrkC36As29m66aIaq1EZuZR2gp7JVKo4T
	3gmD8nh0rMkKtmaXMXeZp5GioN1kc2y1ICFj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RwQSdBO2POpkklHOHEmb81PR9gFRttva
	GhmXemzMtsfUJEcVAQio5hVMM/enEE2v/9Di4fG0agPjAEZmUpau+AjWRSC+FD70
	cHNiETR/L630ctLcYO06O1pOC0MEA04vsjulaI5SSI5fwlwT83oPRwYZk8b8whnK
	3fVrG/04ap4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 89FBF25DD2;
	Fri, 11 Jul 2014 12:01:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DD0A525DC0;
	Fri, 11 Jul 2014 12:01:26 -0400 (EDT)
In-Reply-To: <53BFB055.206@gmail.com> (Ephrim Khong's message of "Fri, 11 Jul
	2014 11:37:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9D35E198-0914-11E4-B40A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253285>

Ephrim Khong <dr.khong@gmail.com> writes:

> git seems to have issues with alternates when cycles are present (repo
> A has B/objects as alternates, B has A/objects as alternates).

Yeah, don't do that.  A thinks "eh, the other guy must have it" and
B thinks the same.  In general, do not prune or gc a repository
other repositories borrow from, even if there is no cycle, because
the borrowee does not know anythning about objects that it itself no
longer needs but are still needed by its borrowers.
