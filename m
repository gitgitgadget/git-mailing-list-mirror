From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cc/cherry-pick-ff (Re: What's cooking in git.git (Mar 2010, #04;
 Tue, 16))
Date: Sat, 20 Mar 2010 07:20:03 -0700
Message-ID: <7v1vffqdm4.fsf@alter.siamese.dyndns.org>
References: <7vhbof4fof.fsf@alter.siamese.dyndns.org>
 <20100317095218.GA6961@progeny.tock>
 <7vwrxaubjy.fsf@alter.siamese.dyndns.org>
 <201003180138.56529.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Mar 20 15:20:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NszXN-0003ZD-UG
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 15:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522Ab0CTOUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 10:20:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54185 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034Ab0CTOUR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 10:20:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5338AA24B1;
	Sat, 20 Mar 2010 10:20:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ovjr4PSpMe1jDg1rfwdq7ieosVQ=; b=XluIEo
	0/RFFh+fe880K8FyuTGL8UT8dnEaNE/H4dghp702tCg5LC8tbPxlrhcfqRFoRD0T
	4AjIkaBdBp1+Uu6C6boZFDZvqIYh2hPJjOCxTgDh0IiDRD7/OGSrk12nFTk2tFeJ
	oxfYxhryvEMEokZg0FOaJADT5+z//wtl+i9PE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sO/B1ZVDTonZzA5lrq5uerklc8rHR52/
	/OPazOF3nwxKiuFIc8GRSr1C8h3l+3ShakRGEEFihHQIky5JfnZPX+Bfi1+1jLnO
	AlcAFuxk08pBqv2+cmpdV2z+UXrfSTrM6R3jYUBS2LPlysq4nOA0MLIHPX1iwZmo
	1Hl6awit6Eg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 03AA6A24B0;
	Sat, 20 Mar 2010 10:20:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF56EA24AE; Sat, 20 Mar
 2010 10:20:04 -0400 (EDT)
In-Reply-To: <201003180138.56529.chriscool@tuxfamily.org> (Christian Couder's
 message of "Thu\, 18 Mar 2010 01\:38\:56 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B1749C98-342B-11DF-A1B7-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142710>

Christian Couder <chriscool@tuxfamily.org> writes:

> ... if we implement "git cherry-pick A..B", and if many people 
> start to use it, then perhaps it will make sense for --ff to become the 
> default.

That doesn't make any sense to me.

Think why you are saying A..B, with an explicit "A".

It is because you know it is different from HEAD; otherwise you would have
done "git merge B"---slurp all changes between HEAD..B, which would be
equivalent to "cherry-pick --ff HEAD..B".

As an ingredient for use of scripts that do not want to check (even if
they could) if it is dealing with a corner case in which the commit a
change is being applied to happens to be the commit the change in question
is based on, being able to say --ff would make sense (as your patch series
showed, it helped to lose several lines from the rebase-i implementation).
The end user may not bother to count commits, and being able to ff earlier
parts of "rebase -i HEAD~20" when the first "edit" appears after many
"pick" would help (and that was why "rebase -i" internally had ff logic).

But running cherry-pick as the top-level operation is a conscious act of
"I want to replay the change done by that one", and it would be utterly
confusing if it fast-forwarded by default.  I agree with Jonathan that it
will never be default.
