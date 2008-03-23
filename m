From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [RFC] add Message-ID field to log on git-am operation
Date: Sun, 23 Mar 2008 11:32:08 -0700
Message-ID: <7v4pax70lz.fsf@gitster.siamese.dyndns.org>
References: <1206136805-20115-1-git-send-email-agladkov@parallels.com>
 <7v4payilkp.fsf@gitster.siamese.dyndns.org> <20080323171621.GA3886@atn.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anton Gladkov <agladkov@parallels.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 19:33:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdV0D-0000aa-1x
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 19:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273AbYCWScW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 14:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754027AbYCWScW
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 14:32:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224AbYCWScV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 14:32:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0BEC81316;
	Sun, 23 Mar 2008 14:32:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 63F6F1315; Sun, 23 Mar 2008 14:32:15 -0400 (EDT)
In-Reply-To: <20080323171621.GA3886@atn.sw.ru> (Anton Gladkov's message of
 "Sun, 23 Mar 2008 20:16:21 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77938>

Anton Gladkov <agladkov@parallels.com> writes:

> On Sat, Mar 22, 2008 at 12:51:34PM -0700, Junio C Hamano wrote:
> ...
>> Wouldn't it work equally well to use applypatch-msg hook?  Use your
>> updated mailinfo to parse necessary information out of the incoming
>> message, and add Message-ID: to the commit log messsage, perhaps at the
>> end, in that hook?
>
> applypatch-msg hook executed on message applying, after that there could be
> useful to test applied patch, so it is not the place for notification sending.

And nobody suggested to send anything from the hook.

As I understood from your e-mail without proposed commit log message, your
assumed workflow was:

	receive mail
        "git am" it
	test rewrite amend whatever you want to convince yourself that
         the received patch was Ok
        push the result out
        pushed-into repository has a hook to send notification,
         by picking up the Message-ID from the commit object

The only thing you need was that the message-id information is available
somewhere in the commit object.  I objected to your patch that puts it in
the commit object header and suggested it be placed in the commit log
message.  You can implement such custom commit munging to add an extra
Message-ID: line inside the hook.  You do not have to send out e-mail nor
anything from it.
