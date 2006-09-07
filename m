From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Add git-archive
Date: Thu, 07 Sep 2006 00:19:16 -0700
Message-ID: <7v1wqo400b.fsf@assigned-by-dhcp.cox.net>
References: <cda58cb80609050516v699338b9y57fd54f50c66e49e@mail.gmail.com>
	<7vfyf6ce29.fsf@assigned-by-dhcp.cox.net>
	<44FED12E.7010409@innova-card.com>
	<7vac5c7jty.fsf@assigned-by-dhcp.cox.net>
	<cda58cb80609062332p356bd26bw852e31211c43d1ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 09:19:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLEAK-0004c5-AG
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 09:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWIGHTJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 03:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWIGHTJ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 03:19:09 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:36274 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750874AbWIGHTG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 03:19:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060907071905.LDJH2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 Sep 2006 03:19:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KKJx1V0041kojtg0000000
	Thu, 07 Sep 2006 03:18:58 -0400
To: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80609062332p356bd26bw852e31211c43d1ac@mail.gmail.com>
	(Franck Bui-Huu's message of "Thu, 7 Sep 2006 08:32:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26609>

"Franck Bui-Huu" <vagabon.xyz@gmail.com> writes:

> sorry I wasn't clear. My point was that the structure need to be
> 'mallocated'. Which funtion allocate it doesn't matter, we will need
> to free it later. That's what I tried to avoid with the alternative I
> sent you in my previous email. Do you think we could use it ?

I do not think allocation and free matter much, but if you want
to do it that way, enumerating all the possible struct in one
place is fine by me for this application.  After all we are not
defining a plug-in architecture that lets others to write their
archive backends and load them without recompiling git-archive
binary.

>> >>> +static int run_remote_archiver(struct archiver_struct *ar, int argc,
>> >>> +                          const char **argv)
>> >>> +{
>> >>> +   char *url, buf[1024];
>> >>> +   pid_t pid;
>> >>> +   int fd[2];
>> >>> +   int len, rv;
>> >>> +
>> >>> +   sprintf(buf, "git-upload-%s", ar->name);
>> >>
>> >> Are you calling git-upload-{tar,zip,rar,...} here?
>> >
>> > yes. Actually git-upload-{tar,zip,...} commands are going to be
>> > removed, but git-daemon know them as a daemon service.
>>
>> That would break "git-archive --remove=ssh://site/repo treeish"
>> wouldn't it?
>
> Yes. But couldn't we make some alias like:
>...
> These alias would be internal to git (always defined)

You _could_ work things around by building special cases into
the system, but I would rather avoid doing that unless
necessary.

Is there a reason that "git-upload-archive --format=tar" is not
desirable at this point of the code?
