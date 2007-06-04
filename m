From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Show html help with git-help --html
Date: Mon, 04 Jun 2007 13:42:27 -0700
Message-ID: <7vvee3ih8s.fsf@assigned-by-dhcp.cox.net>
References: <20070602015341.GA26520@localhost.myhome.westell.com>
	<7vps4cjg1w.fsf@assigned-by-dhcp.cox.net>
	<fcaeb9bf0706040629k489d4818sa291725cbbeead79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 22:42:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvJO1-0003ll-2j
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 22:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758183AbXFDUma (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 16:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758168AbXFDUm3
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 16:42:29 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:56046 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758085AbXFDUm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 16:42:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070604204228.UUAA1540.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Mon, 4 Jun 2007 16:42:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7YiT1X00F1kojtg0000000; Mon, 04 Jun 2007 16:42:27 -0400
In-Reply-To: <fcaeb9bf0706040629k489d4818sa291725cbbeead79@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Mon, 4 Jun 2007 09:29:22 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49126>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On 6/4/07, Junio C Hamano <gitster@pobox.com> wrote:
>> > diff --git a/Documentation/config.txt b/Documentation/config.txt
>> > index 3d8f03d..2ec8545 100644
>> > --- a/Documentation/config.txt
>> > +++ b/Documentation/config.txt
>> > @@ -261,6 +261,18 @@ core.excludeFile::
>> > ...
>> > +core.htmlprogram::
>> > +     Specify the program used to open html help files when 'git-help'
>> > +     is called with option --html or core.help is other than 'man'.
>> > +     By default, xdg-open will be used.
>>
>> Is the program's calling convention something that needs to be
>> customizable for this to be useful?
>
> At first I thought xdg-open would be flexible enough for most Linux
> systems because it will choose the best browser you have. But I now
> recall that Git does not only run on Linux.  Will make it a parameter
> in config.mak.in

Actually that was not what I meant.  I thought we might need to
support something like:

	core.htmlprogram = grand-unified-help %b

for a program that knows where in the system the distribution
keeps help HTML files, and add prefix (/usr/share/html-help/,
perhaps) and suffix (obviously, .html) to the basename of the
command (e.g. "grand-unified-help git-rebase" ends up running
"lynx file:///usr/share/html-help/git-rebase.html"), or perhaps

	core.htmlprogram = firefox /usr/share/html-help/%f

and we substitute '%f' with "git-rebase.html".

>> ...
>> > +     if (prefixcmp(git_cmd, "git"))
>> > +             strcat(p,"git-");
>> > +     strcat(p,git_cmd);
>> > +     strcat(p,".html");
>> > +
>> > +     ret = system(p);
>>
>> This is sloppy in the presense of potentially unsafe characters...
>
> I personally think users will not shoot themselves with "git help
> --html ';rm -rf'" but again scripts can. Thank you for pointing out.
> Will add check for file existence before calling system().

File existence?  I am not sure what you mean by that, sorry.
