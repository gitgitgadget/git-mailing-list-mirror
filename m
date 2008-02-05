From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rebase -i and --whitespace, was Re: [PATCH] git-rebase.sh: Update USAGE string (No. 1)
Date: Tue, 05 Feb 2008 15:43:30 -0800
Message-ID: <7vir137yvx.fsf@gitster.siamese.dyndns.org>
References: <m3lk6161jo.fsf@localhost.localdomain>
	<200802041113.m14BDLMl004301@mi1.bluebottle.com>
	<alpine.LSU.1.00.0802041505230.7372@racer.site>
	<200802041642.52088.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?44GX44KJ?= =?utf-8?B?44GE44GX44Gq44Gq44GT?= 
	<nanako3@bluebottle.com>, Jari Aalto <jari.aalto@cante.net>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 01:35:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMYFl-00019u-O8
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 01:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761079AbYBFAeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 19:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760912AbYBFAef
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 19:34:35 -0500
Received: from lollipop.listbox.com ([208.210.124.78]:59229 "EHLO
	lollipop.listbox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760887AbYBFAe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 19:34:27 -0500
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by lollipop.listbox.com (Postfix) with ESMTP id 11F2B457FF4
	for <git@vger.kernel.org>; Tue,  5 Feb 2008 18:46:40 -0500 (EST)
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 15869193B43;
	Tue,  5 Feb 2008 18:44:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 3B57B193ABD;
	Tue,  5 Feb 2008 18:43:54 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72729>

Jakub Narebski <jnareb@gmail.com> writes:

> So it means that synopsis should, instead of current (pre-patch)
>
> 'git-rebase' [-i | --interactive] [-v | --verbose] [-m | --merge]
>         [-C<n>] [ --whitespace=<option>] [-p | --preserve-merges]
>         [--onto <newbase>] <upstream> [<branch>]
>
> should read
>
> 'git-rebase' [-v | --verbose]  [-p | --preserve-merges]
>         [{-i | --interactive} | [-C<n>] [ --whitespace=<option>] [-m | --merge]]
>         [--onto <newbase>] <upstream> [<branch>]
>
> or perhaps even separated into interactive / non-interactive merge?

I think the reality is:

 * -i ignores the lack of -m (i.e. do not use the slow "merge");

 * Rebase with -m cannot use -C<n> and --whitespace (hence -i
   because it forces -m);

 * -p is only meaningful when using -m;

Three possible courses of actions are:

 (1) fix merge codepath (this is involved --- we would need to
     teach xdl_merge() to honor --whitespace={warn|error|fix}
     and -C<n>); or

 (2) fix -i so that it does not force -m; or

 (3) adjust the description to reality.

Obviously the easiest would be to document the behaviour as-is,
but I suspect (2) would be the best practical solution if we
wanted to have any improvement compared to the current
situation.
