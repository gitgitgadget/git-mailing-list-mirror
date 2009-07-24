From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git repack: keep commits hidden by a graft
Date: Thu, 23 Jul 2009 22:04:38 -0700
Message-ID: <7veis6vfh5.fsf@alter.siamese.dyndns.org>
References: <cover.1248362827u.git.johannes.schindelin@gmx.de>
 <34dfd22bb99c7c466b6131876e8b52ac46f388aa.1248362827u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 24 07:07:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUD0A-0002OD-Sb
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 07:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbZGXFEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 01:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbZGXFEw
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 01:04:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43050 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbZGXFEv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 01:04:51 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C3277F2E4;
	Fri, 24 Jul 2009 01:04:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6CBDFF2E2; Fri, 24 Jul 2009
 01:04:39 -0400 (EDT)
In-Reply-To: <34dfd22bb99c7c466b6131876e8b52ac46f388aa.1248362827u.git.johannes.schindelin@gmx.de> (Johannes Schindelin's message of "Thu\, 23 Jul 2009 17\:33\:49 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 832354D4-780F-11DE-9193-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123899>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When you have grafts that pretend that a given commit has different
> parents than the ones recorded in the commit object, it is dangerous
> to let 'git repack' remove those hidden parents, as you can easily
> remove the graft and end up with a broken repository.
>
> So let's play it safe and keep those parent objects and everything
> that is reachable by them.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	Maybe we should not even bother documenting this option?

Why isn't it "--[no-]grafts-replace-parents"?

"--grafts-replace-parents=no" tempts users to say =never or =false, and
also suggests we might add settings with other semantics later, but I do
not think of any offhand.

As far as I can tell, what the updated code does when this option is in
effect is not "do not replace parents", but is "use both real parents and
grafted parents", which is the right thing to do (if we said "use only
the true parents", then parents reachable only through grafts will be lost
after repacking, which is not what we want).

It would probably make more sense to call it "--keep-real-parents"
or something.

Do we want to cull duplicated parents?  I do not think it matters in this
particular context of checking the reachability, but I am just double
checking if you thought about the issue.
