From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug with .gitattributes diff and embedded NUL
Date: Tue, 18 Dec 2007 22:40:15 -0800
Message-ID: <7vve6vw5kg.fsf@gitster.siamese.dyndns.org>
References: <4768A70F.8020904@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
X-From: git-owner@vger.kernel.org Wed Dec 19 07:40:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4sbv-00039I-RP
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 07:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbXLSGkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 01:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbXLSGkc
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 01:40:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56988 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbXLSGkb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 01:40:31 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D0B1961B5;
	Wed, 19 Dec 2007 01:40:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5660D61B3;
	Wed, 19 Dec 2007 01:40:22 -0500 (EST)
In-Reply-To: <4768A70F.8020904@byu.net> (Eric Blake's message of "Tue, 18 Dec
	2007 22:07:27 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68855>

Eric Blake <ebb9@byu.net> writes:

> Looking closer at .dotest/0001, the diff is indeed invalid, containing the
> single line

That is not a bug in diff but actually in bug in non-merge form of
rebase, which reuses "format patch as if we are sending it out in
e-mail, and apply that on top of a different commit as if we are
accepting that e-mail" machinery.  That dataflow loses NUL.  Fixing
rebase not to reuse the e-mailed patch dataflow is on my to-do list, but
has been slipping.

So, no, I do not think GIT_EXTERNAL_DIFF would help, as the problem is
not diff generation.

I think you can use "rebase -m" to work this issue around.
