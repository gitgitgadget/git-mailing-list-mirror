From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/5] add valgrind support in test scripts
Date: Wed, 22 Oct 2008 17:14:52 -0700
Message-ID: <7v7i80tber.fsf@gitster.siamese.dyndns.org>
References: <20081022202810.GA4439@coredump.intra.peff.net>
 <20081022202915.GA4547@coredump.intra.peff.net>
 <alpine.DEB.1.00.0810230008430.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 23 02:16:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsnsM-00032K-F5
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 02:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbYJWAPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 20:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752689AbYJWAPE
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 20:15:04 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451AbYJWAPC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 20:15:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 04E0C8EE77;
	Wed, 22 Oct 2008 20:15:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 669C38EE72; Wed, 22 Oct 2008 20:14:54 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0810230008430.22125@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Thu, 23 Oct 2008 00:13:47 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A20960F0-A097-11DD-B2C6-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98931>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Wed, 22 Oct 2008, Jeff King wrote:
>
>> diff --git a/Makefile b/Makefile
>> index d6f3695..68f0172 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1343,7 +1345,12 @@ all:: $(TEST_PROGRAMS)
>>  
>>  export NO_SVN_TESTS
>>  
>> -test: all
>> +valgrind-setup: $(patsubst %.sh,%,$(VALGRIND_SH))
>> +	rm -rf t/valgrind/bin
>> +	mkdir t/valgrind/bin
>> +	for i in git $(PROGRAMS); do cp test-valgrind t/valgrind/bin/$$i; done
>
> I wonder if it would not be better to scrap the t/valgrind/ directory and 
> regenerate it everytime you run a test manually; I'd use "ln" instead of 
> "cp", and also parse command-list.txt to catch really all of them (even if 
> a dashed form is used for a builtin by mistake).

Going one step further, I wonder if this approach can also be used to
catch such a mistake.  Install a dashed form that records the fact that it
was called when it shouldn't, and by whom.
