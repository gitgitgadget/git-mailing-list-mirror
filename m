From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] fsck: HEAD is part of refs
Date: Sat, 31 Jan 2009 16:53:12 -0800
Message-ID: <7v3aez3rlz.fsf@gitster.siamese.dyndns.org>
References: <49814BA4.6030705@zytor.com>
 <7vfxj1eqh6.fsf@gitster.siamese.dyndns.org> <49822944.8000103@zytor.com>
 <20090129223529.GB1465@elte.hu> <20090129224357.GA18471@elte.hu>
 <498231EA.3030801@zytor.com> <7vvdrxd8jz.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0901291512260.3054@localhost.localdomain>
 <7veiylb1in.fsf_-_@gitster.siamese.dyndns.org> <4982C7FA.20107@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sun Feb 01 01:54:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTQbq-0003pk-0k
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 01:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbZBAAxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 19:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbZBAAxX
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 19:53:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44704 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbZBAAxX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 19:53:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7D5D72A2EE;
	Sat, 31 Jan 2009 19:53:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 361F82A2EB; Sat,
 31 Jan 2009 19:53:14 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B85DEC1A-EFFA-11DD-A4ED-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107954>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
>> By default we looked at all refs but not HEAD.  The only thing that
>> made fsck not lose sight of comments that are only reachable from a
>> detached HEAD was the reflog for the HEAD.
>> 
>> This fixes it, with a new test.
> [...]
>> +test_expect_success setup '
>> +	test_commit A &&
>> +	git checkout HEAD^0 &&
>> +	test_commit B &&
>> +	git reflog expire --expire=now --all
>> +'
>> +
>> +test_expect_success 'HEAD is part of refs' '
>> +	test 0 = $(git fsck | wc -l)
>
> I'm scratching my head over this. This test succeeds even without the
> change... (Tested with a34a9db.)

You are right.  I forgot that test_commit creates an extra tag.  By adding

	git tag -d B &&

after "test_commit B &&", you would expose the issue in the existing code.
