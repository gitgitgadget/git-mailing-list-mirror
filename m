From: Alan Hourihane <alanh@fairlite.co.uk>
Subject: Re: new platform & S_IFGITLINK problem
Date: Sun, 02 May 2010 10:39:29 +0100
Message-ID: <1272793169.13488.1315.camel@jetpack.demon.co.uk>
References: <1272756555.13488.1314.camel@jetpack.demon.co.uk>
	 <7vfx2b2ft5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 02 11:39:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8VeE-0007go-NQ
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 11:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756198Ab0EBJjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 05:39:33 -0400
Received: from fairlite.demon.co.uk ([80.176.228.186]:33045 "EHLO
	fairlite.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755911Ab0EBJjc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 05:39:32 -0400
Received: from localhost (unknown [127.0.0.1])
	by fairlite.demon.co.uk (Postfix) with ESMTP id 78C78223F54;
	Sun,  2 May 2010 09:39:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at demon.co.uk
Received: from fairlite.demon.co.uk ([127.0.0.1])
	by localhost (server.demon.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IgV+HM8V6pGh; Sun,  2 May 2010 10:39:29 +0100 (BST)
Received: from [192.168.0.226] (unknown [192.168.0.226])
	by fairlite.demon.co.uk (Postfix) with ESMTP id DEB6E221AF6;
	Sun,  2 May 2010 10:39:29 +0100 (BST)
In-Reply-To: <7vfx2b2ft5.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.26.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146155>

On Sat, 2010-05-01 at 19:33 -0700, Junio C Hamano wrote:
> Alan Hourihane <alanh@fairlite.co.uk> writes:
> 
> > Just joined as I'm compiling git on a new platform and wondered if
> > someone can help solve a problem with the definition of S_IFGITLINK.
> 
> Yikes.  The current codebase pretty much assumes that IFREG is 0100000,
> IFDIR 0040000, and IFLNK 0120000, and the bits read from "struct stat" and
> the mode bits we store in the index and tree objects are interchangeable.
> 
> Yes, that assumption is a gross POSIX violation but we so far haven't seen
> any platform that matters in real life that assigns the IFMT bits
> differently.
> 
> We would need to:
> 
>  (1) rename S_IFGITLINK to GIT_S_IFMODULE;
> 
>  (2) define GIT_S_IF{REG,DIR,LNK} as 0100000, 0040000, and 0120000;
> 
>  (3) write MODE_SYSTEM_TO_GIT() macro to convert from S_IF{REG,DIR,LNK} we
>      read from struct stat to the "canonical" GIT_S_IF{REG,DIR,LNK}
>      values; and
> 
>  (4) change all the code that read mode from struct stat and use it to
>      first use MODE_SYSTEM_TO_GIT().
> 
> Currently 'git grep -e "S_IF[A-Z]" -e "struct stat"' reports around 250
> hits, so it is not infeasible amount of work, but it is not a trivial and
> mechanical replacement, either.  I or somebody need to set aside a block
> of time to do this clean-up and audit the result.
> 
> Thanks for a report.

No problem. Thanks for taking the challenge and sorting it out.

Let me know if there's anywhere I can help, test, or debug.

Thanks again!

Alan.
