From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git.c option parsing
Date: Mon, 17 Dec 2007 00:48:23 -0800
Message-ID: <7vsl21aeqw.fsf@gitster.siamese.dyndns.org>
References: <1197631424-52586-1-git-send-email-win@wincent.com>
	<1197631424-52586-2-git-send-email-win@wincent.com>
	<7vejdml92c.fsf@gitster.siamese.dyndns.org>
	<F6F3247E-4E71-4977-9626-F0571278E1E6@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 09:48:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Beh-0000u7-Vx
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 09:48:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180AbXLQIse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 03:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752804AbXLQIsd
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 03:48:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60653 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbXLQIsd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 03:48:33 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EAB88185F;
	Mon, 17 Dec 2007 03:48:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 737E1185E;
	Mon, 17 Dec 2007 03:48:25 -0500 (EST)
In-Reply-To: <F6F3247E-4E71-4977-9626-F0571278E1E6@wincent.com> (Wincent
	Colaiuta's message of "Mon, 17 Dec 2007 09:27:12 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68521>

Wincent Colaiuta <win@wincent.com> writes:

> Of course, the above plan will only work for builtins, not for  
> scripts. An additional step would be needed to enable scripts to  
> handle these options; perhaps teaching "git rev-parse" something...

As long as special options stay special and we make a rule not to allow
any subcommand to assign its own meaning to them, the git wrapper can
lookahead and reorder, when seeing a command line:

	git scripted-command --special

into

	git --special scripted-command

And that approach would work well for built-ins as well, I would
imagine.

There is one minor detail, though.  There could be an option-parameter
that is literally --special.  E.g.

	git grep -e --no-paginate

should not be reordered to

	git --no-paginate grep -e
