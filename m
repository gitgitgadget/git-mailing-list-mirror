From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] "best effort" checkout
Date: Thu, 29 May 2008 17:33:57 -0700
Message-ID: <7vabi8ocju.fsf@gitster.siamese.dyndns.org>
References: <1212020246-26480-1-git-send-email-gitster@pobox.com>
 <483F3B32.9000907@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Fri May 30 02:35:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1saG-0001Tz-8J
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 02:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164AbYE3AeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 20:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754951AbYE3AeM
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 20:34:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43933 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584AbYE3AeM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 20:34:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 768E6194F;
	Thu, 29 May 2008 20:34:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B3EF7194E; Thu, 29 May 2008 20:34:04 -0400 (EDT)
In-Reply-To: <483F3B32.9000907@verizon.net> (Mark Levedahl's message of "Thu,
 29 May 2008 19:24:34 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1D13BA82-2DE0-11DD-A1D7-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83261>

Mark Levedahl <mdl123@verizon.net> writes:

> Junio C Hamano wrote:
>> 	
>> [PATCH 1/5] "git checkout -- paths..." should error out when paths cannot be written
>> [PATCH 2/5] checkout: make reset_clean_to_new() not die by itself
>> [PATCH 3/5] checkout: consolidate reset_{to_new,clean_to_new|()
>> [PATCH 4/5] unpack_trees(): allow callers to differentiate worktree errors from merge errors
>> [PATCH 5/5] checkout: "best effort" checkout
>> [PATCH 6/5] NUL hack to create_file()
>
> This works! I've added these patches (pulled from pu) to my tree and
> rebuilt. The current results on Cygwin...

I hope you did not use 6/5.  My understanding is that your platform
natively supports it without that compatibility layer ;-)

> git>git checkout -f b71ce7f3f13ebd0e
> Previous HEAD position was 952538f... checkout: "best effort" checkout
> error: git-checkout-index: unable to create file t/t5100/nul (File exists)
> HEAD is now at b71ce7f... Merge 1.5.5.3 in
> git>git status
> # Not currently on any branch.
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #
> #   modified:   t/t5100/nul

Interesting breakage.

I expected to see "deleted" here.  I guess lstat("anything/nul") says "it
exists" everywhere, and that probably is why you are getting EEXIST.
