From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT 1.6.0-rc1
Date: Tue, 29 Jul 2008 23:15:41 -0700
Message-ID: <7vprov99te.fsf@gitster.siamese.dyndns.org>
References: <7vy73myim5.fsf@gitster.siamese.dyndns.org>
 <20080728063838.GB4234@blimp.local>
 <7vwsj6tsm3.fsf@gitster.siamese.dyndns.org>
 <20080728213727.GA3721@blimp.local>
 <7vr69dky93.fsf@gitster.siamese.dyndns.org>
 <7v4p69jefb.fsf@gitster.siamese.dyndns.org>
 <7vljzlhyt8.fsf@gitster.siamese.dyndns.org>
 <20080729211745.GA3879@blimp.local>
 <7vmyk0bb5r.fsf@gitster.siamese.dyndns.org>
 <20080730061012.GA4437@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 08:16:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO4zR-0004K1-Or
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 08:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbYG3GPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 02:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752719AbYG3GPt
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 02:15:49 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59593 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbYG3GPs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 02:15:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AE5F742D6F;
	Wed, 30 Jul 2008 02:15:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E118842D6E; Wed, 30 Jul 2008 02:15:43 -0400 (EDT)
In-Reply-To: <20080730061012.GA4437@blimp.local> (Alex Riesen's message of
 "Wed, 30 Jul 2008 08:10:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F32DF742-5DFE-11DD-9159-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90751>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Wed, Jul 30, 2008 00:03:44 +0200:
>> Alex Riesen <raa.lkml@gmail.com> writes:
>> >> Alex, I ran the full test with this, but only on Linux boxes; obviously
>> >> not on any flavor of Windows.  I think it is correct, and the "first line
>> >> of defence" fix is the same as your patch, so I'd assume it would work for
>> >> you as well.  But extra eyeballs are always appreciated.
>> >
>> > Well, it works on Cygwin too. And I had my eyeballs on the code
>> > (wondered first if it will cause more fs accesses than before: it
>> > will, in the racy check. Which is correct, AFAICT)
>> 
>> I thought racy check won't even trigger for gitlinks, no?
>> 
>
> I didn't know. But now, come to think of it, there wouldn't be much
> point - the gitlinks are always compared by content, aren't they?
>
>> ce_modified_check_fs() has 3 call sites:
>> 
>>  - the call site in ie_match_stat() is protected with is_racy_timestamp()
>>    that is always false for gitlinks;
>> 
>>  - the call site in ie_modified() we just took care of in the current
>>    thread;
>> 
>>  - the other call site is in ce_smudge_racily_clean_entry(), which is
>>    called from write_index() but it also is protected with
>>    is_racy_timestamp() that is always false for gitlinks.
>
> So, the change in ce_modified_check_fs is not really needed, because
> the gitlink case is never executed?

That's what I meant by "futureproofing".
