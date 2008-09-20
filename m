From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/14] Sparse checkout
Date: Sat, 20 Sep 2008 11:52:42 -0700
Message-ID: <7vvdwq3b0l.fsf@gitster.siamese.dyndns.org>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
 <m31vzen4v5.fsf@localhost.localdomain>
 <fcaeb9bf0809201033o1e9298a8ob135c68228b77218@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 20 20:54:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kh7bH-0006TP-9x
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 20:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181AbYITSwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 14:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753162AbYITSwy
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 14:52:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62080 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbYITSwx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 14:52:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 916FA63339;
	Sat, 20 Sep 2008 14:52:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 93A2A63337; Sat, 20 Sep 2008 14:52:45 -0400 (EDT)
In-Reply-To: <fcaeb9bf0809201033o1e9298a8ob135c68228b77218@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Sun, 21 Sep 2008 00:33:52 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 52651A1E-8745-11DD-B8E8-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96362>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On 9/20/08, Jakub Narebski <jnareb@gmail.com> wrote:
>>  >  - "git clone --path" => "git clone --narrow-path"
>>  >  - "git checkout --path" => "git checkout --reset-path"
>>
>> I am not sure about that change, especially the fact that git-clone
>>  and git-checkout use differently named options, because those options
>>  affect clone only as they affect the checkout part of the clone.  One
>>  would think that git-clone = git-init + git-remote add + git-fetch +
>>  git-checkout, and that git-clone would simply pass sparse checkout
>>  flags to git-checkout.
>>
>
> Johannes sixt said --path was too generic so I changed the name. Hmm..
> I did not think the same option name for git-checkout and git-clone
> was important, rather worry about people may misunderstand that it is
> "narrow clone" (do not fetch objects outside given paths for all
> history). Maybe "git clone --narrow-checkout" would be better.

Be it narrow or sparse, I would agree this round is better than too
generic sounding --path.  Whatever that "limited set of paths that are to
appear in the working tree" is called, it is a good idea to name options
to clarify what effect each option causes on that concept X.  So perhaps:

	--reset-X	resets the checkout set
        --widen-X	widens the checkout set
        --narrow-X	narrows the checkout set

is a good set of options to give "checkout".

You could argue that using "--reset-X" would be more consistent for clone,
but I think the "--reset-" part is redundant, because clone cannot
possibly say "add these" or "subtract those".  I.e. it can only establish
the initial set (which is "--reset-X").  Which leads me to suggest that it
would not be such a good idea to use the same option name for clone and
checkout

With s/X/sparse/, above would give a set of options that does not sound
too bad, I think.  It certainly is better than s/X/narrow/ which would
have a strong "Huh?" factor in "--narrow-narrow" one ;-)
