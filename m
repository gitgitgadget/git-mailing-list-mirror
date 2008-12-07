From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checking action of git-pull
Date: Sun, 07 Dec 2008 02:51:13 -0800
Message-ID: <7vprk4cl7i.fsf@gitster.siamese.dyndns.org>
References: <dac45060812070023h7f6a6c86ve2e4ba9f1773f03f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Mark Ryden" <markryde@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 07 11:54:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9HHU-0004IH-LX
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 11:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbYLGKvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 05:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753296AbYLGKvW
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 05:51:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51399 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279AbYLGKvV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 05:51:21 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5C9D6184F0;
	Sun,  7 Dec 2008 05:51:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1B7CA184EF; Sun, 
 7 Dec 2008 05:51:15 -0500 (EST)
In-Reply-To: <dac45060812070023h7f6a6c86ve2e4ba9f1773f03f@mail.gmail.com>
 (Mark Ryden's message of "Sun, 7 Dec 2008 10:23:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FAB474BE-C44C-11DD-A58A-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102494>

"Mark Ryden" <markryde@gmail.com> writes:

> Hello,
>   I am working against a git repository which is updated at non regular
> intervals; sometimes it takes a day and sometimes a week or two.
>
> I have a script in crontab which runs daily which tries "git pull" of
> this repository.
>
> I want write a bash script which echoes yhe  result of this git pull
> to a log file in such
> a way that in case that any files were pulled, a short message
> saying "files were pulled at date ddmmyyyy" will be added to a log file.
> In case that there there were no changes, a message saying
> "Already up-to-date (ddmmyyyy) will be added to a log file.
>
> How can it be done ?
> can I test somehow the return value of git pull in a bash script for
> these two different
> cases?

You know that a no-op pull does not update HEAD and a successful pull
does.  So your script would do something like:

	#!/bin/sh

        original_head=$(git rev-parse HEAD) || exit
        git pull origin || exit
        updated_head=$(git rev-parse HEAD) || exit
        if test "$updated_head" = "$original_head"
        then
        	echo Upstream is idling
	else
        	echo These new commits were brought in
                git shortlog $original_head..$updated_head
	fi
