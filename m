From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFE] allow git bisect to figure out in which revision a bug was
 fixed
Date: Tue, 21 Jul 2009 13:40:29 -0700
Message-ID: <7vprbtbwhu.fsf@alter.siamese.dyndns.org>
References: <x49ocrdokp9.fsf@segfault.boston.devel.redhat.com>
 <7vfxcpdbsh.fsf@alter.siamese.dyndns.org>
 <20090721202848.GA3453@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Moyer <jmoyer@redhat.com>, git@vger.kernel.org
To: Josef Bacik <josef@redhat.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:40:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTM8i-000142-Hl
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755079AbZGUUkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754902AbZGUUkg
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:40:36 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36654 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377AbZGUUkf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:40:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 16837E27E;
	Tue, 21 Jul 2009 16:40:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 298B1E27C; Tue,
 21 Jul 2009 16:40:31 -0400 (EDT)
In-Reply-To: <20090721202848.GA3453@localhost.localdomain> (Josef Bacik's
 message of "Tue\, 21 Jul 2009 16\:28\:48 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BDB11670-7636-11DE-9A23-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123712>

Josef Bacik <josef@redhat.com> writes:

> On Tue, Jul 21, 2009 at 01:24:46PM -0700, Junio C Hamano wrote:
>> Jeff Moyer <jmoyer@redhat.com> writes:
>> 
>> > As a distro kernel grunt, I sometimes find myself in the situation of
>> > having to track down the commit that fixed a given problem so that I can
>> > backport it to an older kernel.  Sometimes I'm smart enough to figure it
>> > out myself, other times I'm not.  ;-)  It would be helpful if git bisect
>> > could help figure out in what commit a bug was fixed as opposed to
>> > introduced.  Is there any interest in implementing such a feature?
>> 
>> Doesn't that already exist?
>> 
>> You are hunting for an existence of the bug, so any commit that is buggy
>> (with respect to the bug you are interested in) is *GOOD*.  The tip of the
>> upstream is *BAD* in that it does not have your favourite bug anymore.
>> 
>> You bisect that history down, and will find the first *BAD* commit.
>> 
>> Now, why is that commit the procedure finds is *BAD*, again?  Yup, because
>> it does not have your favourite bug anymore.  And why is that so?
>> 
>> Because the commit fixed that bug.
>
> Sure, but as one who has used this procedure several times before, it is
> very error prone, on my side because I'm a big goober.  I have a
> tendancy to get my wires crossed and get dumped out at a commit that
> doesnt make sense (my latest attempt put me out at a merge commit).
> Sure its my fault for not being able to keep it straight, theres no
> arguing that, it still would be nice for there to be a way to remove as
> much human error from the process as possible.  Thanks,

There indeed was discussions along the line of adding "fixed" and "broken"
as synonyms to "bad" and "good".

I mildly suspect that it is a matter of opinion if such an addition would
make things better or more confusing, because the word "broken" feels more
strongly associated with "bad" than "good".

Perhaps "wanted" and "unwanted" makes a better pair of more neutral words?
In bisect, we do not want to judge commits' in absolute goodness scale.
It is all relative to what _you_ as the person who runs bisect want, and
in that sense the original terminology "good/bad" was suboptimal.
