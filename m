From: Stephen Bash <bash@genarts.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Tue, 19 Oct 2010 10:57:25 -0400 (EDT)
Message-ID: <28402633.527046.1287500245894.JavaMail.root@mail.hq.genarts.com>
References: <126B270C-AEB2-4632-A2CD-E8F2AAE20A62@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: David Michael Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 16:57:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8DdD-00042B-FK
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 16:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab0JSO5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 10:57:34 -0400
Received: from hq.genarts.com ([173.9.65.1]:11297 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752809Ab0JSO5d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 10:57:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 8E8AD1E26351;
	Tue, 19 Oct 2010 10:57:32 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O7DXawQ6kJOT; Tue, 19 Oct 2010 10:57:26 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id EED681E262EC;
	Tue, 19 Oct 2010 10:57:25 -0400 (EDT)
In-Reply-To: <126B270C-AEB2-4632-A2CD-E8F2AAE20A62@cordelta.com>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159333>

----- Original Message -----
> From: "David Michael Barr" <david.barr@cordelta.com>
> To: "Stephen Bash" <bash@genarts.com>
> Sent: Tuesday, October 19, 2010 10:28:03 AM
> Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial git-svn fetch)
> 
> So, I think there's two valuable nuggets per commit omitted at the
> moment in svn-fe.
> Firstly, the longest common root between all paths in the commit,
> which can be computed efficiently.
> Secondly, the copyfrom_rev and copyfrom_path for the copy operation
> that targets the common root.
> The second nugget can be noted while computing the first.
> From my reading of buildSVNTree.pl, these two nuggets drive the
> mapping logic.

Yep, they're the triggers, then the heuristics just filter out the noise SVN encourages because of light copies (or cruft from cvs2svn).

Just watch out for svn mv operations.  They produce a single commit with an Add (with copyfrom_* set) and a Delete.  So in the /project -> /trunk/project case, you're common path is /.  I didn't have that case, but I did have a /trunk cp-> /branches/tagName (oops!) mv-> /tags/tagName and a /trunk cp-> /branchName (oops!) mv-> /branches/branchName (honestly I much preferred the cases where the user deleted the wrong location and then created a new copy in the right place -- there are a ton of those which I didn't bother to capture the misstep in the middle).

Thanks,
Stephen
