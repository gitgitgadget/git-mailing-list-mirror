From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule.sh - Remove trailing / from URL if found
Date: Thu, 21 Aug 2008 11:00:47 -0700
Message-ID: <7vej4ii6y8.fsf@gitster.siamese.dyndns.org>
References: <7vpro4tjkw.fsf@gitster.siamese.dyndns.org>
 <1219280847-872-1-git-send-email-mlevedahl@gmail.com>
 <7vfxozkpzi.fsf@gitster.siamese.dyndns.org>
 <30e4a070808210504l1dd6b491l1d66dcd96a238ebc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Mark Levedahl" <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 20:04:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWETw-0007Ew-9g
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 20:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145AbYHUSAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 14:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753077AbYHUSAz
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 14:00:55 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43069 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbYHUSAy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 14:00:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 943DB6290B;
	Thu, 21 Aug 2008 14:00:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 81A3A62908; Thu, 21 Aug 2008 14:00:49 -0400 (EDT)
In-Reply-To: <30e4a070808210504l1dd6b491l1d66dcd96a238ebc@mail.gmail.com>
 (Mark Levedahl's message of "Thu, 21 Aug 2008 08:04:34 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 18BAC6EE-6FAB-11DD-8DFD-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93184>

"Mark Levedahl" <mlevedahl@gmail.com> writes:

> The problem I'm trying to fix is that a number of folks have
> superprojects checked out where the recorded origin URL has a trailing
> /, and a submodule has its origin in a directory sitting right next to
> the superproject on the server. Thus, we have:
>
>    superproject url = server:/public/super
>    submodoule url = server:/public/sub1
>
> However, in the checked out superproject's .git/config
> [remote "origin"]
>    url = server:/public/super/
>
> and for similar reasons, the submodule has its URL recorded in .gitmodules as
> [submodule "sub"]
>    path = submodule1
>    url = ../sub1/
>
> resolve_relative_url gets the submodule's recorded url as $1, which
> the caller retrieved from .gitmodules, and retrieves the superprojects
> origin from .git/config. So in this case resolve_relative_url has
> that:
>    url = ../sub1/
>    remoteurl = server:/public/super/
>
> So, without any patch, resolve_relative_url computes the submodule's URL as:
>    server:/public/super/sub1/
>
> with the first patch as:
>    server:/public/super/sub1
>
> and with the second as
>    server:/public/sub1
> rather than
>    server:/public/sub1
>
> So, the second patch I sent is the one that fixes the above problem,
> and I have to say I now forget what the confused state of .gitmodules
> + .git/config I found on one machine that lead to the first patch as
> being a correct fix.
>
> In summary, it is essential that resolve_relative_url strip the
> trailing / from the superproject's url before starting, while it is
> nice but not necessary if it assures that the result does not contain
> a trailing /.

Well, that is a description worth having in the proposed commit log
message, isn't it?
