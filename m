From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH jk/pkt-line-cleanup] t5700-clone-reference: send trace
 to fd 2, not 3, to please Windows git
Date: Wed, 20 Mar 2013 12:30:47 +0100
Message-ID: <51499DE7.2030404@viscovery.net>
References: <5149724C.3060105@viscovery.net> <20130320093313.GA9482@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 20 12:31:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIHEl-0003d9-Mi
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 12:31:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551Ab3CTLaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 07:30:52 -0400
Received: from so.liwest.at ([212.33.55.24]:41724 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932334Ab3CTLav (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 07:30:51 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UIHEF-0008HU-NN; Wed, 20 Mar 2013 12:30:47 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 761B21660F;
	Wed, 20 Mar 2013 12:30:47 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <20130320093313.GA9482@sigill.intra.peff.net>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218585>

Am 3/20/2013 10:33, schrieb Jeff King:
> On Wed, Mar 20, 2013 at 09:24:44AM +0100, Johannes Sixt wrote:
> 
>> From: Johannes Sixt <j6t@kdbg.org>
>>
>> Two tests use GIT_TRACE=3 to dump debugging information of git. On
>> Windows, however, bash is unable to set up file descriptor 3 correctly
>> for its child process, so that git reports "Bad file descriptor" on
>> every trace attempt. The 'git clone' test succeeds nevertheless because
>> an empty trace file remains, and there is only a check for the
>> absence of a particular line. But the 'git fetch' process ultimately
>> hangs (the dynamics that lead to this surprising result have not been
>> investigated).
>>
>> Since we do not otherwise use stderr in the test cases, divert the
>> trace dump to stderr.
> 
> I think that is OK, but I'm curious why this is a problem _now_, and not
> with the code prior to 97a83fa8. The old GIT_DEBUG_SEND_PACK was also
> just calling write() to descriptor 3.

Before this change, both affected commands completed and the trace file
was empty. Notice that in both test cases we only check for the absence of
certain lines, which is naturally true for an empty file, so that the
tests pass.

With the updated code, 'git fetch' hung, which is how I noticed the
problem. As I said, I didn't investigate where and why this happens.

>>  This fixes a regression introduced in 
> 
> ...in 97a83fa8, I assume.

Yes, correct. (Sorry, I got distracted while I looked up the commit.)

-- Hannes
