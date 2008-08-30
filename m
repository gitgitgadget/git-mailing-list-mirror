From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Reuse cmdname->len to store pre-calculated similarity
 indexes
Date: Sat, 30 Aug 2008 10:26:17 -0700
Message-ID: <7vprnqifd2.fsf@gitster.siamese.dyndns.org>
References: <20080828171533.GA6024@blimp.local>
 <20080828212722.GF6439@steel.home>
 <7vsksm1pmd.fsf@gitster.siamese.dyndns.org>
 <81b0412b0808300944p29199600ie95c65404b6cb380@mail.gmail.com>
 <20080830171331.GA26932@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 19:27:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZUEY-0007Lm-6Z
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 19:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbYH3R01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 13:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753141AbYH3R01
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 13:26:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52016 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbYH3R00 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 13:26:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AC8D65AC19;
	Sat, 30 Aug 2008 13:26:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 06CA05AC17; Sat, 30 Aug 2008 13:26:18 -0400 (EDT)
In-Reply-To: <20080830171331.GA26932@steel.home> (Alex Riesen's message of
 "Sat, 30 Aug 2008 19:13:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C417F0FC-76B8-11DD-9737-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94392>

Alex Riesen <raa.lkml@gmail.com> writes:

> To avoid doing that while sorting
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>
> Alex Riesen, Sat, Aug 30, 2008 18:44:15 +0200:
>> 2008/8/30 Junio C Hamano <gitster@pobox.com>:
>> > I wonder if it makes sense to give an otherwise unused "score" member to
>> 
>> Hmm, it is a _non-existing_ member of cmdname, isn't it?
>> 
>> > the "struct cmdname", compute the distance only once per each command, and
>> > use that as the sort key (alternatively you can have a separate int[N]
>> > array to store similarity values for each item in the cmdnames list, only
>> > used inside this codepath).
>> 
>> I think I'll take the struct cmdname->len over.

I think you do not need the file-scope static levenshtein_cmd anymore with
this change, if you make similarity() take two command names.  No?

Please reroll the whole f66dd34 (git wrapper: DWIM mistyped commands,
2008-08-28), as it is not part of any solid integration branch yet.

You might also want to update the commit log message to talk about the
"len" reuse hack, but you already have in-code comment which might be
sufficient.
