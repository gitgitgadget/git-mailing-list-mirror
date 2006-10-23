From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 14:54:02 +0200
Message-ID: <200610231454.06355.jnareb@gmail.com>
References: <45357CC3.4040507@utoronto.ca> <200610222206.13973.jnareb@gmail.com> <1161604564.22276.173.camel@zepto.home.zettazebra.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "Matthew D. Fuller" <fullermd@over-yonder.net>,
	Andreas Ericsson <ae@op5.se>,
	Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 14:54:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbzJX-0008Jx-8l
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 14:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbWJWMxy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 08:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbWJWMxy
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 08:53:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:22857 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751948AbWJWMxx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 08:53:53 -0400
Received: by ug-out-1314.google.com with SMTP id o38so1231772ugd
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 05:53:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ugoMx7xjA2bnPmr6bh4T/6tliVhZ8OCUsw2on9jZFTKYuqo4UJiDSfksXrN4JCFW5E8nmbsYIoC9UTVVP1e5Qv6OJ4ZLwsq1QLJtEU/YqfvZnubrd+HEAgmxm3aQ9fSPEo3gpERqHaDT8OTvctn+lR53Q40HfRwdUA/rk2Q/T38=
Received: by 10.66.220.17 with SMTP id s17mr7250202ugg;
        Mon, 23 Oct 2006 05:53:51 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id h1sm879981ugf.2006.10.23.05.53.50;
        Mon, 23 Oct 2006 05:53:51 -0700 (PDT)
To: David Clymer <david@zettazebra.com>
User-Agent: KMail/1.9.3
In-Reply-To: <1161604564.22276.173.camel@zepto.home.zettazebra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29831>

On Mon, Oct 23, 2006 David Clymer wrote:
> On Sun, 2006-10-22 at 22:06 +0200, Jakub Narebski wrote:
>> David Clymer wrote:

>>> 2. bzr does not support fully distributed development because revnos
>>> "don't work" as stated in #1.
>>
>> Bazaar is biased towards centralized/star-topology development if we
>> want to use revnos. In fully distributed configuration there is no
>> "simple namespace".
> 
> So revnos aren't globally meaningful in fully distributed settings. So
> what? I don't see how this translates into bias. There is a lot of
> functionality provided by bazaar that doesn't really apply to my use
> case, but it doesn't mean that it is indicative of some bias in bazaar.

First, bzr is biased towards using revnos: bzr commands uses revnos
by default to provide revision (you have to use revid: prefix/operator
to use revision identifiers), bzr commands outputs revids only when
requested, examples of usage uses revision numbers.

In order to use revnos as _global_ identifiers in distributed development,
you need central "branch", mainline, to provide those revnos. You have
either to have access to this "revno server" and refer to revisions by
"revno server" URL and revision number, or designate one branch as holding
revision numbers ("revno server") and preserve revnos on "revno server"
by using bzr "merge", while copying revnos when fetching by using bzr "pull"
for leaf branches. In short: for revnos to be global identifiers you need
star-topology.

Even if you use revnos only locally, you need to know which revisions are
"yours", i.e. beside branch as DAG of history of given revision you need
"ordered series of revisions" (to quote Bazaar-NG wiki Glossary), or path
through this diagram from given revision to one of the roots (initial,
parentless revisions). Because bzr does that by preserving mentioned path
as first-parent path (treating first parent specially), i.e. storing local
information in a DAG (which is shared), to preserve revnos you need to
use "merge" instead of "pull", which means that you get empty-merge in
clearly fast-forward case. This means "local changes bias", which some
might take as not being fully distributed.

Sidenote 1: Why Bazaar-NG tries to store "branch as ordered series
of revisions"/"branch as path through revisions DAG" in DAG instead
of storing it separately (like reflog stores history of tip of branch,
which is roughly equivalent of "branch as path" in bzr). It needs
some kind of cache of mapping from revno to the revision itself anyway
(unless performance doesn't matter for bzr developers ;-)! All what
left is to propagate this mapping on "pull"...

Sidenote 2: "Fringe" developer using default git configuration of
'origin' branch tracking 'master' branch in cloned (mainline) repo,
and 'master' branch on which he/she does his/her own work, who committed
at least single revision on his/her 'master' branch, and whose changes
are never pulled and if they get into mainline repo it is using "side"
channel like git-enchanced patches sent to project mailing list,
will see the picture similar to the bzr branch which uses "merge".


The whole discussion about validity of revision numbers started
with "simple namespace" feature in SCM comparison matrix on Bazaar-NG
wiki...
-- 
Jakub Narebski
Poland
