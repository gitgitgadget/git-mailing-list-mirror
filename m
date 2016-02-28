From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 1/2] pull --rebase: add --[no-]autostash flag
Date: Sun, 28 Feb 2016 11:12:09 +0100
Message-ID: <vpq37sdnnye.fsf@anie.imag.fr>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<xmqqk2lqeyzv.fsf@gitster.mtv.corp.google.com>
	<CA+DCAeTJ=cTJzVO4ttgMT-Penh1=eVZtPYDQhcF4a4zueYrCAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 11:12:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZyL8-0007Qv-2W
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 11:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757283AbcB1KMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 05:12:24 -0500
Received: from mx1.imag.fr ([129.88.30.5]:55320 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757279AbcB1KMX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 05:12:23 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1SAC8gC003926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 28 Feb 2016 11:12:08 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1SAC9bL032378;
	Sun, 28 Feb 2016 11:12:09 +0100
In-Reply-To: <CA+DCAeTJ=cTJzVO4ttgMT-Penh1=eVZtPYDQhcF4a4zueYrCAA@mail.gmail.com>
	(Mehul Jain's message of "Sun, 28 Feb 2016 15:21:55 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 28 Feb 2016 11:12:09 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1SAC8gC003926
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457259131.65631@Hudhc4ONKdQKltAmocXNTQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287762>

Mehul Jain <mehul.jain2029@gmail.com> writes:

> If user uses "git pull --[no-]autostash" then two possible things can be done:
>
>            * Either "git pull" ignores "--[no-]autostash" and calls
>              underlying "git merge",
>              as merge stashes the untracked files by itself. Thus
>              ignoring --no-autostash
>              flag given by user.
>
>            * Or "git pull" dies with the following error:
>
>                     "--[no-]autostash is only valid when --rebase is used.
>                      Example: git pull --rebase --[no-]autostash"
>
> I suggest that the latter option should be used in this case as user should know
> that stashing is performed by "git merge" anyway

Not exactly. "git merge" doesn't do a stash, but it accepts to run if
local changes do not touch the same files as the merge. So, --autostash
is usually not needed for merge.

But I agree that erroring out is better. Silently accepting the option
and doing nothing with it would be confusing for users. This would mean
that "git pull --autostash" would work, but still sometimes show the error:

  error: Your local changes to the following files would be overwritten by merge:

The situation is different for command-line options and for config
variables: the config variable wasn't explicitly specified for each run
of "git pull", hence it's acceptable to ignore its value when we have
nothing to do with it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
