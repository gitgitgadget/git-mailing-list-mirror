From: Junio C Hamano <junkio@cox.net>
Subject: Re: [QUESTION] Access to a huge GIT repository.
Date: Wed, 16 Nov 2005 12:35:05 -0800
Message-ID: <7vwtj85o1y.fsf@assigned-by-dhcp.cox.net>
References: <cda58cb80511160424j1acac7c6j@mail.gmail.com>
	<7vveys8n8q.fsf@assigned-by-dhcp.cox.net>
	<46a038f90511161201h54c5fa73l20b5dcf3b5c19399@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 21:36:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcTzt-0001iQ-I5
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 21:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbVKPUfJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 15:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbVKPUfJ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 15:35:09 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:36294 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030493AbVKPUfH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 15:35:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051116203430.KTLL20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Nov 2005 15:34:30 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90511161201h54c5fa73l20b5dcf3b5c19399@mail.gmail.com>
	(Martin Langhoff's message of "Thu, 17 Nov 2005 09:01:04 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12055>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> On 11/17/05, Junio C Hamano <junkio@cox.net> wrote:
>> The underlying network transfer program, 'git-clone-pack', can
>> be told to clone only specified branches.  If somebody is
>> interested, updating the 'git-clone' wrapper to use it should
>> not be too hard -- obviously this needs to be done for other
>> transports as well, though.
>
> cg-clone already does this.

Yes, but it can be improved.  It does fetch-pack for git native
transports, which means the receiving end expands the pack.  I
think we would either need to teach cg-clone to tell cg-fetch
that it is cloning and invoke git-clone-pack, or add an optional
"do not expand" option to git-fetch-pack (git-clone-pack always
keeps the downloaded pack unexpanded).  Huge pack transfer
spends long time on the downloader side unpacking the pack.

> If you just pull tagrefs and all the objects needed for them, chances
> are you'll get the whole repo anyway ;-)

Yes, that's why we changed ls-remote to report the magic ^{}
entries and it is used in cg-fetch::fetch_tags.
