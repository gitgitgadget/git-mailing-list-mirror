From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] launch_editor(): allow spaces in the filename
Date: Mon, 10 Mar 2008 14:48:36 -0700
Message-ID: <7vabl6i72j.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803102140280.3975@racer.site>
 <7vejaii7c5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zeng.Shixin@gmail.com, theevancarroll@gmail.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 10 22:50:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYpsZ-0006c4-N4
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 22:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbYCJVsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 17:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbYCJVsu
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 17:48:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50971 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbYCJVst (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 17:48:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 128EC2C55;
	Mon, 10 Mar 2008 17:48:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 569BA2C51; Mon, 10 Mar 2008 17:48:41 -0400 (EDT)
In-Reply-To: <7vejaii7c5.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 10 Mar 2008 14:42:50 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76761>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> ...
>> This fixes
>>
>> 	git config core.editor "c:/Program Files/What/Ever.exe"
>>
>
> Having sent a few messages about shell quoting, it makes me wonder if this
> was done very deliberately in the first place, so that you can do things
> like:
>
> 	git config core.editor "emacs -nw"
>
> Blame followed by list archive hunting around that timeperiod would tell.

I'll let others look for the bug report and user request from the list
archive, but the pertinent commit is 5e2de4f9 (Fix $EDITOR regression
introduced by rewrite in C.):

    When git-tag and git-commit launches the editor, they used to
    honor EDITOR="editor -options args..." but recent rewrite in C
    insisted on $EDITOR to be the path to the editor executable.
    
    This restores the older behaviour.
    
In other words, your example is a user error and your patch is a
regression.

I guess the right way to do that would be:

	git config core.editor '"c:/Program Files/What/Ever.exe"'

but I do not do windows, so this is obviously untested.
