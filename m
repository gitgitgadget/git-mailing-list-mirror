From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Catch and handle git-commit failures in git-rebase --interactive
Date: Tue, 18 Dec 2007 23:03:59 -0800
Message-ID: <7vr6hjw4gw.fsf@gitster.siamese.dyndns.org>
References: <20071219064500.GB8915@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 19 08:04:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4syy-0007jP-BQ
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 08:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbXLSHEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 02:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbXLSHEV
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 02:04:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58197 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbXLSHEU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 02:04:20 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 71E056915;
	Wed, 19 Dec 2007 02:04:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D90846911;
	Wed, 19 Dec 2007 02:04:11 -0500 (EST)
In-Reply-To: <20071219064500.GB8915@spearce.org> (Shawn O. Pearce's message of
	"Wed, 19 Dec 2007 01:45:00 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68858>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>  Comments welcome.  This is on top of my 1/2 patch but we could
>  drop my 1/2 and rewrite this to not use --no-verify, but handle
>  the git-commit error correctly.
>
>  However that would force users to fix whitespace errors in later
>  patches in a series if they use -i, even though non-i wouldn't
>  require that sort of fix-up.  So I think we should do both patches
>  in the series.

I agree with both patches.

When one wants to use rebase to fix-up whitespace breakage in patches in
bulk, you can set apply.whitespace to "fix".  One bad side effect of
this is that if you usually have apply.whitespace set to "fix" (because
you need to accept a lot of patches but your contributers tend to give
crappy patches), you need to temporarily change the configuration while
rebasing if you do not want to preserve intentional whitespace breakages
(e.g. ones in test scripts).  This can be argued either a feature or a
misfeature.

But rebase -i breaking and squashing upon commit failure (including
pre-commit safety) cannot be called either feature nor misfeature --- it
is an outright bug.
