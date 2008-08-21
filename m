From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule.sh - Remove trailing / from URL if found
Date: Wed, 20 Aug 2008 20:26:41 -0700
Message-ID: <7vfxozkpzi.fsf@gitster.siamese.dyndns.org>
References: <7vpro4tjkw.fsf@gitster.siamese.dyndns.org>
 <1219280847-872-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 05:28:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW0qv-0001wc-BC
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 05:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759048AbYHUD0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 23:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759006AbYHUD0w
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 23:26:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38365 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759268AbYHUD0v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 23:26:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C43166196D;
	Wed, 20 Aug 2008 23:26:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E6F1A6196C; Wed, 20 Aug 2008 23:26:43 -0400 (EDT)
In-Reply-To: <1219280847-872-1-git-send-email-mlevedahl@gmail.com> (Mark
 Levedahl's message of "Wed, 20 Aug 2008 21:07:27 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FBFFB8E0-6F30-11DD-A447-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93105>

Mark Levedahl <mlevedahl@gmail.com> writes:

> git clone does not complain if a trailing '/' is included in the origin
> URL, but doing so causes resolution of a submodule's URL relative to the
> superproject to fail. Trailing /'s are likely when cloning locally using
> tab-completion, so the slash may appear in either superproject or
> submodule URL. So, ignore the trailing slash if it already exists in
> the superproject's URL, and don't record one for the submodule (which
> could itself have submodules...).
>
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  git-submodule.sh |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Hmm.  I was sort of hoping to hear "Junio you idiot you do not know what
you are talking about --- your example of using ".." as relative won't
happen because of such and such reasons; trust me I know what is going on
in the vicinity of this code."

And after looking at the callsites of the shell function, I think the
original can never pass ".." (there are case statements to pass only $url
that match "./*" or "../*"), so I think both your original and this
version are safe as long as the part that match the trailing "/*" is
sane.

So I'll queue your first patch, as it is slightly shorter ;-)

Thanks.
