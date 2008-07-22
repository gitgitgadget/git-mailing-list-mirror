From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status in clean working dir
Date: Mon, 21 Jul 2008 19:40:28 -0700
Message-ID: <7vtzeir68z.fsf@gitster.siamese.dyndns.org>
References: <0ttzeirft8.wl%bremner@pivot.cs.unb.ca>
 <7vy73ur6pz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Bremner <bremner@unb.ca>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 22 04:41:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL7on-0005J4-Vu
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 04:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577AbYGVCki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 22:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbYGVCki
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 22:40:38 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49557 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbYGVCki (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 22:40:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C426636007;
	Mon, 21 Jul 2008 22:40:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9F7DD36003; Mon, 21 Jul 2008 22:40:30 -0400 (EDT)
In-Reply-To: <7vy73ur6pz.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 21 Jul 2008 19:30:16 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8F5C5640-5797-11DD-B48C-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89427>

Junio C Hamano <gitster@pobox.com> writes:

>> git status -a 
>>
>> exits with 0
>> ...
>
> Try "git status -a >/dev/null" or "git --no-pager status -a".
>
> I think this is an instance of the c8af1de (make git-status use a pager,
> 2008-04-23) stupidity raising its ugly head again.
>
> Do people mind reverting that patch?

Actually, the situation is now even worse than I originally thought
especially with Jeff's pager.<cmd> patch on 'master' recently.  For
example, you can screw yourself quite badly by forcing diff-files used in
the scripts you run to page, defeating --exit-code option.  Which means

 (1) It hurts?  Don't do it then; but

 (2) Then why are we even allowing to configure the plumbing to page?

Should we maintain a table of commands that we allow paging to be
customized, and ignore pager.<cmd> for commands that are not in the list?

Which codepath should issue error messages when the user tries to break
the system by saying "pager.diff-files = true"?
