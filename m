From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Make git send-email accept $EDITOR with arguments
Date: Fri, 21 Dec 2007 13:17:57 -0800
Message-ID: <7vd4sz4uii.fsf@gitster.siamese.dyndns.org>
References: <20071220203211.GA12296@bit.office.eurotux.com>
	<1198237002-21470-1-git-send-email-hendeby@isy.liu.se>
	<20071221133412.GA15198@sigill.intra.peff.net>
	<476BDA5F.4070306@isy.liu.se>
	<20071221192359.GA10660@coredump.intra.peff.net>
	<476C2B2E.1080801@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, luciano@eurotux.com,
	git@vger.kernel.org, gitster@pobox.com
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Fri Dec 21 22:18:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5pGS-0003wf-OM
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 22:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757570AbXLUVSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 16:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757533AbXLUVSP
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 16:18:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50871 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757027AbXLUVSO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 16:18:14 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AFBAA5451;
	Fri, 21 Dec 2007 16:18:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 15FB4544D;
	Fri, 21 Dec 2007 16:18:03 -0500 (EST)
In-Reply-To: <476C2B2E.1080801@isy.liu.se> (Gustaf Hendeby's message of "Fri,
	21 Dec 2007 22:07:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69093>

Gustaf Hendeby <hendeby@isy.liu.se> writes:

> On 2007-12-21 20:23, Jeff King wrote:
> 
>> I am fine with using the shell. Though keep in mind that the two
>> solutions will behave differently with
>> 
>>   EDITOR='foo; bar'
>> 
>> That is, system("$editor $message") will actually invoke the shell,
>> whereas system(split(/ /, $editor), $message) will _just_ split on
>> whitespace. We should do whatever is consistent with the rest of the git
>> commands (off the top of my head, I don't know).

Personally, I think EDITOR='foo; bar' is a user shooting his
foot off which we do not care about.

> A quick look at the proposed solution to the similar problem with git
> commit, using code now in git tag, it seems it uses a split like
> solution, though taking " and ' quoting into consideration.

I think the easiest to read and compatible way is:

	system('sh', '-c', '$0 $@', $editor, $filename)
