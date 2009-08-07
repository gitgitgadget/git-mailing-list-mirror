From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make 'submodule update' honor the 'update' setting in
 .gitmodules.
Date: Fri, 07 Aug 2009 14:54:53 -0700
Message-ID: <7veirns30y.fsf@alter.siamese.dyndns.org>
References: <1249530977-17501-1-git-send-email-foldr@codedgers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mikhail Glushenkov <foldr@codedgers.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 23:55:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZXOz-0002TU-RY
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 23:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbZHGVy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 17:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbZHGVy6
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 17:54:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48736 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbZHGVy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 17:54:57 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 24B3D2181;
	Fri,  7 Aug 2009 17:54:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 70D602180; Fri,  7 Aug
 2009 17:54:55 -0400 (EDT)
In-Reply-To: <1249530977-17501-1-git-send-email-foldr@codedgers.com> (Mikhail
 Glushenkov's message of "Thu\,  6 Aug 2009 05\:56\:17 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F2E52868-839C-11DE-AEEB-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125230>

Mikhail Glushenkov <foldr@codedgers.com> writes:

> Make the 'submodule update' command honor the 'submodule.$path.update' setting
> in .gitmodules unless this setting is overridden in '.git/config' or with
> --rebase/--merge options.

I haven't been involved in recent updates to "git submodule", but the
change in this patch feels somewhat wrong.

The contents of in-tree .gitmodules are meant to be consulted to only
prime the settings in .git/config, and after that they are never used
without user's explicit concent (e.g. "sync").  At least that is the way I
understand how the current "git submodule" command is designed.

This change actively breaks the pattern.  It makes sense to set up values
for "submodule.*.update" when the defaults suggested by the project are
copied out of .gitmodules to prime .git/config upon "submodule init", but
not at runtime in "update" command like this.

I am puzzled.  What problem are you trying to solve?

"submodule init" seems to already copy "update" setting from .gitmodules
to .git/config.  At least, it seems to have a code to try to do so.

Perhaps you would want to (1) add the "submodule.*.update" to the set of
configurations to be copied upon "sync", not just URL? and (2) add a way
to allow users to inspect how values in .git/config and .gitmodules are
different, and update .git/config with selected values, possibly in an
interactive manner?
