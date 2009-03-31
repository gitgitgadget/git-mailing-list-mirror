From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git reflog expire --all" very slow
Date: Mon, 30 Mar 2009 22:57:59 -0700
Message-ID: <7vmyb26xp4.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0903301803190.4093@localhost.localdomain>
 <7vk5668g55.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0903302154000.4093@localhost.localdomain>
 <7vy6um6z9m.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0903302239040.4093@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 07:59:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoX0h-0002VA-8W
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 07:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755378AbZCaF6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 01:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755137AbZCaF6M
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 01:58:12 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51789 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575AbZCaF6L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 01:58:11 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 00F1DA550;
	Tue, 31 Mar 2009 01:58:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2EAADA54C; Tue,
 31 Mar 2009 01:58:03 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0903302239040.4093@localhost.localdomain>
 (Linus Torvalds's message of "Mon, 30 Mar 2009 22:42:50 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E8857458-1DB8-11DE-8A42-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115223>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 30 Mar 2009, Junio C Hamano wrote:
>> 
>> I do have a lot of reflog entries kept around, as my main repository has
>> these:
>> 
>>         [gc]
>>                 reflogexpire = '2005-01-01 00:00:00 +0000'
>>                 reflogexpireunreachable = '2005-01-01 00:00:00 +0000'
>
> I think that actually _hides_ the problem. You'll never have anything at 
> all that triggers that
>
> 	if (timestamp < cb->cmd->expire_unreachable) {
>
> because your "expire_unreachable" timestamp is already very old (== small 
> value), so 'timestamp' will _not_ be older (smaller value) than that.
>
> I dunno. As mentioned, I don't really understand why we'd want to save 
> some of those reflog entries at all in the first place, so I'm probably 
> missing something.
>
> If we've asked for reflog entries past a certain age to be expired, why do 
> when then look at the details of those reflog entries and only expire them 
> under certain circumstances? Just expire them, and get rid of the 
> 'unreachable' part.

I know.  My test repository does not have them.  I only quoted them to
tell you that I have a lot of entries to play with.
