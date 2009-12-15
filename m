From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/7] reset: do not accept a mixed reset in a .git dir
Date: Tue, 15 Dec 2009 12:25:24 -0800
Message-ID: <7vk4woyogb.fsf@alter.siamese.dyndns.org>
References: <20091212042042.3930.54783.chriscool@tuxfamily.org>
 <20091212043259.3930.98779.chriscool@tuxfamily.org>
 <7vtyvvn9wx.fsf@alter.siamese.dyndns.org>
 <200912152041.36194.chriscool@tuxfamily.org>
 <7vskbcyot5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Dec 15 21:25:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKdxy-0006Ym-V2
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 21:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932802AbZLOUZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 15:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755429AbZLOUZu
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 15:25:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33880 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755425AbZLOUZt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 15:25:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 73ECEA71AD;
	Tue, 15 Dec 2009 15:25:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u7Lh5MoFlOSbprUqPUuaHW/ilQg=; b=Mxq3H9
	0ItIZj1VaLOeL51OBodYPkDwxfDkPrHTn9IpoxAnDvkiPGTEuOSSexAE2Xg2Yu+t
	Ap1Sl7+8afVCPKLu9u7wFiNVgh3RM8ap4JPK1/cIq3lhSsiXfJhWYPodomu9ko1J
	ZxZYnUAW6YPEZUEhb0Q4k2BO7qbiPmuPYc0Kc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MrGRD3bB5nJmbNVAMQMZm367ILh7XwIo
	nFCNmGyB0HGR0Ey7QpIJ+fGnhTjKrlxIIsOmNNfgJd1RCrUShB8pHk3H201ZV+tn
	TpIYmHNDLvDwuwhf5jLUW8D2Y48p/KeF8YiLMvi08Zz6C5v+XtwRy9sewjO43Mkq
	dpVhHz+inRc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CF4CFA71A9;
	Tue, 15 Dec 2009 15:25:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D484CA71A5; Tue, 15 Dec 2009
 15:25:25 -0500 (EST)
In-Reply-To: <7vskbcyot5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 15 Dec 2009 12\:17\:42 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0236A22A-E9B8-11DE-B32D-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135299>

Junio C Hamano <gitster@pobox.com> writes:

>> The reason is that after the next patch, it will not fail in a bare 
>> repository,...
>
> That sounds as if you want to change the definition of what the expected
> behaviour is early, because you want to claim a regression you will later
> introduce is not a regression.  I hope that is not the case.

Hmm...

By "after the next patch, it will not fail in a bare repository",
did you mean "if the next patch blindly replaced an external call to
read-tree with an internal call to unpack_trees(), it will change the
behaviour, and we will end up allowing '--mixed in bare'.  To prevent it
from happening, cmd_reset() should check that condition upfront"?

Then you were not trying to hide regressions (which makes me happier).
But then doesn't the change belong to the next patch, not this one?
