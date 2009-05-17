From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix minor memory leak in init-db
Date: Sat, 16 May 2009 22:13:25 -0700
Message-ID: <7veiuojoqy.fsf@alter.siamese.dyndns.org>
References: <cd3664ac0905141522s3ad78411o9f015d2e7720c8b5@mail.gmail.com>
	<7vzldclt33.fsf@alter.siamese.dyndns.org>
	<cd3664ac0905162107t7ebca943p1722685a8484f08e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ammon Riley <ammon.riley@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 17 07:14:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5Yhn-0002b5-38
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 07:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbZEQFN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 01:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbZEQFNZ
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 01:13:25 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:59941 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbZEQFNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 01:13:25 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090517051326.JSY25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Sun, 17 May 2009 01:13:26 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id sVDR1b00Y4aMwMQ04VDRMF; Sun, 17 May 2009 01:13:25 -0400
X-Authority-Analysis: v=1.0 c=1 a=33oWOrx5OBEA:10 a=N3uJvN5w5gEA:10
 a=pGLkceISAAAA:8 a=ybZZDoGAAAAA:8 a=9bSUOe9v3YlQtj44FbMA:9
 a=osLYefChOvbkAi_cH7rbJIpsmDwA:4 a=MSl-tDqOz04A:10 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <cd3664ac0905162107t7ebca943p1722685a8484f08e@mail.gmail.com> (Ammon Riley's message of "Sat\, 16 May 2009 21\:07\:40 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119386>

Ammon Riley <ammon.riley@gmail.com> writes:

> On Sat, May 16, 2009 at 12:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Ammon Riley <ammon.riley@gmail.com> writes:
>>
>>> There was an xmalloc() for path, but I didn't see a corresponding free().
>>> Does it happen somewhere else that I'm not expecting?
>>
>> It implicitly happens in exit() in git.c:handle_internal_command()
>> after cmd_init_db() returns the control to it.
>
> Ah. Naturally. :)
>
> So if I were to write a long-lived application (such as a custom UI) that
> links to libgit, and bypasses those functions to call init_db() (and other
> functions) directly, all those implicit free-on-exit() turn into memory
> leaks.

Correct, and there are other much larger issues to worry about.

That's why there is a separate libgit2 effort in progress.
