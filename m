From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 v2] run-command (Windows): Run dashless "git <cmd>"
 (solves part of problem with system_path)
Date: Mon, 28 Jul 2008 22:42:29 -0700
Message-ID: <7v4p69meka.fsf@gitster.siamese.dyndns.org>
References: <BF5B7CBE-ACA8-4D81-8FC0-8A7901205854@zib.de>
 <1217308647-23673-1-git-send-email-prohaska@zib.de>
 <20080729052459.GC11947@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 07:43:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNhzr-0001J5-EK
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 07:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbYG2Fmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 01:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753436AbYG2Fmj
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 01:42:39 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56820 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbYG2Fmi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 01:42:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E203141F87;
	Tue, 29 Jul 2008 01:42:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7D65E41F84; Tue, 29 Jul 2008 01:42:31 -0400 (EDT)
In-Reply-To: <20080729052459.GC11947@spearce.org> (Shawn O. Pearce's message
 of "Mon, 28 Jul 2008 22:24:59 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 26F1FFF2-5D31-11DD-9FCC-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90580>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> This feels wrong to me.  fast-import probably won't be adversly
> impacted by not being able to read /etc/gitconfig, unless the user
> has set something like core.deltaBaseCacheLimit and is doing an
> incremental import.  But other non-builtins may be impacted.
>
> It feels like we're fixing this in the wrong place.  If the issue
> is we don't find our installation directory correctly, we should
> find our installation directory correctly, not work around it by
> calling builtins through the git wrapper.
>
> Though I can see where it may be a good idea to at some point
> in the future (git 1.7?) stop creating the redundant builtin
> links under libexec/git-core.

I agree; that is why I already applied Steffen's original patch with quite
a different justification from the updated one:

commit b048b9a803f48d88595877271b53bf9ec400e4ba
Author: Steffen Prohaska <prohaska@zib.de>
Date:   Mon Jul 28 07:50:28 2008 +0200

    run-command (Windows): Run dashless "git <cmd>"
    
    We prefer running the dashless form, and POSIX side already does so; we
    should use it in MinGW's start_command(), too.
    
    Signed-off-by: Steffen Prohaska <prohaska@zib.de>
    Acked-by: Johannes Sixt <johannes.sixt@telecom.at>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
