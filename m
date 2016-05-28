From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [WIP-PATCH 0/2] send-email: refactor the email parser loop
Date: Sat, 28 May 2016 17:04:19 +0200
Message-ID: <vpq8tyujkb0.fsf@anie.imag.fr>
References: <20160527140104.11192-1-samuel.groot@grenoble-inp.org>
	<20160527201436.GA16547@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Samuel GROOT <samuel.groot@grenoble-inp.org>, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	gitster@pobox.com, aaron@schrab.com
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Sat May 28 17:04:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6fn1-0006Mt-2P
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 17:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979AbcE1PEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2016 11:04:31 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58413 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100AbcE1PEb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 11:04:31 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u4SF4Iam004706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 28 May 2016 17:04:18 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4SF4JaE031163;
	Sat, 28 May 2016 17:04:19 +0200
In-Reply-To: <20160527201436.GA16547@dcvr.yhbt.net> (Eric Wong's message of
	"Fri, 27 May 2016 20:14:36 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Sat, 28 May 2016 17:04:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4SF4Iam004706
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465052661.06506@AVJjsg8Nm9cF5BFkyFi+tw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295823>

Eric Wong <e@80x24.org> writes:

> Samuel GROOT <samuel.groot@grenoble-inp.org> wrote:
>
>>    (mbox) Adding cc: A<author@example.com>  from line 'Cc: A<author@example.com>, One<one@example.com>'
>>    (mbox) Adding cc: One<one@example.com>  from line 'Cc: A<author@example.com>, One<one@example.com>'
>> 
>> Though `git send-email` now outputs something like:
>> 
>>    (mbox) Adding cc: A<author@example.com>  from line 'Cc: A<author@example.com>'
>>    (mbox) Adding cc: One<one@example.com>  from line 'Cc: One<one@example.com>'
> I actually like neither, and would prefer something shorter:
>
>     (mbox) Adding cc: A <author@example.com> from Cc: header
>     (mbox) Adding cc: One <one@example.com> from Cc: header
>     (mbox) Adding cc: SoB <SoB@example.com> from Signed-off-by: trailer
>
> That way, there's no redundant addresses in each line and less
> likely to wrap.

I agree with this. Actually, I'd even say that the current output of
"git send-email" looks sloppy, and internal refactoring may be a good
opportunity to get it cleaner.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
