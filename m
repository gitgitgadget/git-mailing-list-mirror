From: Junio C Hamano <gitster@pobox.com>
Subject: Re: sane, stable renames; when a commit should commit twice
Date: Sat, 22 Dec 2007 18:50:58 -0800
Message-ID: <7v4peaw2ct.fsf@gitster.siamese.dyndns.org>
References: <20071223020310.GA22450@freedbms.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Zenaan Harkness <zen@freedbms.net>
X-From: git-owner@vger.kernel.org Sun Dec 23 03:51:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6GwG-0006X0-4R
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 03:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbXLWCvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 21:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753395AbXLWCvK
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 21:51:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42175 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358AbXLWCvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 21:51:09 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AE887630;
	Sat, 22 Dec 2007 21:51:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 135DA762E;
	Sat, 22 Dec 2007 21:51:00 -0500 (EST)
In-Reply-To: <20071223020310.GA22450@freedbms.net> (Zenaan Harkness's message
	of "Sun, 23 Dec 2007 13:03:10 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69162>

Zenaan Harkness <zen@freedbms.net> writes:

> When should a commit, commit twice?
>
> When one or more git mv file renames/ moves are involved.
> ...
> Does this make sense?

Anything that feels right to you is right for _your_ project, so
asking that question does not add much value, but I would not
personally do that myself.  I may have pure rename commits that
move files around without changing any contents in my history,
but that is only because there happened to be no need to change
the contents in those commits, not because I followed an
artificial "a rename-only commit, followed by a commit that
edits" dogma you seem to be suggesting.

If I move file common.c to lib/common.c and common.h to
include/common.h, I would definitely NOT record that as two
events, if common.c used to include common.h.  My commit that
moves these two files will definitely contain edit to common.c
(now lib/common.c) that changes at least one line:

	-#include "common.h"
        +#include "../include/common.h"

in the same commit.  If you split this as two events, your first
"rename only" commit would not even build.
