From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] read-tree -m -u: avoid getting confused by intermediate symlinks.
Date: Fri, 11 May 2007 10:10:53 -0700
Message-ID: <7vwszfb80y.fsf@assigned-by-dhcp.cox.net>
References: <7vveezde8b.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0705110708y7e3a9024p9e117e2da84ae916@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 19:11:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmYdw-0003hG-IL
	for gcvg-git@gmane.org; Fri, 11 May 2007 19:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759560AbXEKRKz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 13:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759602AbXEKRKz
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 13:10:55 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:59440 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759560AbXEKRKy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 13:10:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070511171055.WOIW6556.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 13:10:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xtAt1W00f1kojtg0000000; Fri, 11 May 2007 13:10:54 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46966>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 5/11/07, Junio C Hamano <junkio@cox.net> wrote:
>> @@ -268,6 +268,8 @@ static void unlink_entry(char *name)
>>  {
>>         char *cp, *prev;
>>
>> +       if (has_symlink_leading_path(name))
>> +               return;
>
> This can slow down the unlink case quiet considerably.
> Maybe the symlink paths can be cached?

Yes it can, and probably doable.

This is called once per each path that disappears from the
result, relative to the current tree.  The number of calls to
this function is potentially quite large.
