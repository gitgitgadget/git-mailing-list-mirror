From: Junio C Hamano <junkio@cox.net>
Subject: Re: Clueless bisect error message
Date: Wed, 11 Oct 2006 00:22:34 -0700
Message-ID: <7vpsczuxj9.fsf@assigned-by-dhcp.cox.net>
References: <fcaeb9bf0610110008g642da719pb17f7f52169097e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 09:22:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXYQJ-000273-PE
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 09:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWJKHWg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 03:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWJKHWg
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 03:22:36 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:33423 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932420AbWJKHWg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 03:22:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061011072235.FROV13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Oct 2006 03:22:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YvNe1V0051kojtg0000000
	Wed, 11 Oct 2006 03:22:38 -0400
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
In-Reply-To: <fcaeb9bf0610110008g642da719pb17f7f52169097e2@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Wed, 11 Oct 2006 14:08:11 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28697>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> $ git bisect start
> won't bisect on seeked tree
>
> It complained because .git/head-name contained 't' which had been
> deleted before. git-bisect reset works. However I'd request git-bisect
> to inform more useful messages. At first, I was completely stunned:
> "what is a seeked tree? how can I fix that?"

Interesting.  There is certainly something clueless but I am not
sure if it is git-bisect.

Other git-core tools never create $GIT_DIR/head-name unless
bisect is in effect, and you end your bisect session by doing
"bisect reset" (otherwise there is no easy way to get back to
your original branch head).  How did head-name got 't' in it,
and how was branch 't' removed?

If the answer to the first question is because earlier you
created a temporary branch 't' to run a bisect, and the answer
to the latter is because you ended your bisect session by saying
"git checkout -f someotherbranch && git branch -D t", then we
should be able to fix that by removing head-name upon branch
switching with "git checkout".

By looking at commit 810255f, however, I suspect that fix would
break Cogito.  The wording of the message actually comes from
Cogito nomenclature.
