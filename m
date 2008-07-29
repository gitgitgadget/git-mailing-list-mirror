From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT 1.6.0-rc1
Date: Tue, 29 Jul 2008 15:03:44 -0700
Message-ID: <7vmyk0bb5r.fsf@gitster.siamese.dyndns.org>
References: <7vy73myim5.fsf@gitster.siamese.dyndns.org>
 <20080728063838.GB4234@blimp.local>
 <7vwsj6tsm3.fsf@gitster.siamese.dyndns.org>
 <20080728213727.GA3721@blimp.local>
 <7vr69dky93.fsf@gitster.siamese.dyndns.org>
 <7v4p69jefb.fsf@gitster.siamese.dyndns.org>
 <7vljzlhyt8.fsf@gitster.siamese.dyndns.org>
 <20080729211745.GA3879@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 00:05:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNxJO-0002nl-Cu
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 00:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbYG2WDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 18:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753637AbYG2WDx
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 18:03:53 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40320 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332AbYG2WDx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 18:03:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D1CE1414A5;
	Tue, 29 Jul 2008 18:03:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D8BDD414A4; Tue, 29 Jul 2008 18:03:48 -0400 (EDT)
In-Reply-To: <20080729211745.GA3879@blimp.local> (Alex Riesen's message of
 "Tue, 29 Jul 2008 23:17:45 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3A8B63C6-5DBA-11DD-A212-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90689>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Tue, Jul 29, 2008 10:36:19 +0200:
>> Junio C Hamano <gitster@pobox.com> writes:
>> >
>> > Ok, I took a deeper look at the codepaths involved.  Although it does work
>> > around the issue, I do not think your patch alone is the "correct" one in
>> > the longer term.
>
> Thought so. I just didn't know the code around
>
>> > It needs a bit of explanation, and the explanation won't be exactly
>> > "plain, small and short", unfortunately.
>> 
>> Alex, I ran the full test with this, but only on Linux boxes; obviously
>> not on any flavor of Windows.  I think it is correct, and the "first line
>> of defence" fix is the same as your patch, so I'd assume it would work for
>> you as well.  But extra eyeballs are always appreciated.
>
> Well, it works on Cygwin too. And I had my eyeballs on the code
> (wondered first if it will cause more fs accesses than before: it
> will, in the racy check. Which is correct, AFAICT)

I thought racy check won't even trigger for gitlinks, no?

ce_modified_check_fs() has 3 call sites:

 - the call site in ie_match_stat() is protected with is_racy_timestamp()
   that is always false for gitlinks;

 - the call site in ie_modified() we just took care of in the current
   thread;

 - the other call site is in ce_smudge_racily_clean_entry(), which is
   called from write_index() but it also is protected with
   is_racy_timestamp() that is always false for gitlinks.

 
