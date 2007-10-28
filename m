From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] push, send-pack: support pushing HEAD to real ref name
Date: Sun, 28 Oct 2007 13:58:19 -0700
Message-ID: <7v1wbfufbo.fsf@gitster.siamese.dyndns.org>
References: <119350380778-git-send-email-prohaska@zib.de>
	<11935038081211-git-send-email-prohaska@zib.de>
	<11935038081650-git-send-email-prohaska@zib.de>
	<1193503808519-git-send-email-prohaska@zib.de>
	<11935038083369-git-send-email-prohaska@zib.de>
	<11935038084055-git-send-email-prohaska@zib.de>
	<7vwst7wvdr.fsf@gitster.siamese.dyndns.org>
	<722152C5-299C-435E-B720-D2D331D16249@zib.de>
	<7vd4uzuu1g.fsf@gitster.siamese.dyndns.org>
	<7v7il7usyx.fsf@gitster.siamese.dyndns.org>
	<55CCFD12-C10F-46A6-8D65-544231DEBF3F@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 21:58:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImFDS-0005ri-6n
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 21:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbXJ1U6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 16:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbXJ1U6Z
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 16:58:25 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:38270 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbXJ1U6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 16:58:25 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8F3792EF;
	Sun, 28 Oct 2007 16:58:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0B9BE8FB2C;
	Sun, 28 Oct 2007 16:58:42 -0400 (EDT)
In-Reply-To: <55CCFD12-C10F-46A6-8D65-544231DEBF3F@zib.de> (Steffen Prohaska's
	message of "Sun, 28 Oct 2007 17:30:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62590>

Steffen Prohaska <prohaska@zib.de> writes:

> On Oct 28, 2007, at 5:03 PM, Junio C Hamano wrote:
> ...
>> An alternative, just to let me keep my nicer public image by
>> pretending to be constructive ;-)
>>
>> Introduce a configuration "remote.$name.push_default" whose
>> value can be a list of refs.  Teach the push command without
>> refspecs:
>>
>> 	$ git push
>> 	$ git push $remote
>>
>> to pretend as if the listed refspecs are given, instead of the
>> traditional "matching branches" behaviour.
>>
>> Then, introduce another option
>>
>> 	$ git push --matching
>> 	$ git push --matching $remote
>>
>> to override that configuration, if set, so that the user who
>> usually pushes only the selected branches can use the "matching
>> branches" behaviour when needed.
>>
>> Along with your earlier "git push $remote HEAD" patch, this will
>> allow you to say:
>>
>> 	[remote "origin"]
>>         	push_default = HEAD
>>
>> and your
>>
>> 	$ git push
>>
>> will push only the current branch.
>
> Sounds reasonable; but it is more work. I'm not starting to
> implement this today.

Take your time; nobody is in a hurry.

If somebody usually uses "matching" behaviour, i.e. without
remote.$name.push_default configuration, but wants to push only
the current branch as a one-shot operation, we can obviously use
"git push $remote HEAD".  But to be complete, it may make sense
to have another option

	$ git push --current

that lets you omit $remote (and default to the value configured
with branch.$name.remote).
