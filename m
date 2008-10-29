From: "J. Longman" <longman@xiplink.com>
Subject: Re: jgit as a jira plugin
Date: Wed, 29 Oct 2008 19:49:47 -0400
Message-ID: <D7D18CE8-BDBD-430A-BCB6-D1BEFD21C949@xiplink.com>
References: <5915DAE3-7BDF-4296-9DB3-6FBEE504A317@xiplink.com> <20081029230816.GA31926@spearce.org>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 30 00:51:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvKoY-00010o-TN
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 00:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768AbYJ2Xtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 19:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754706AbYJ2Xtt
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 19:49:49 -0400
Received: from smtp232.iad.emailsrvr.com ([207.97.245.232]:43272 "EHLO
	smtp232.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523AbYJ2Xtt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 19:49:49 -0400
Received: from relay13.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay13.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 4C2B449177B;
	Wed, 29 Oct 2008 19:49:48 -0400 (EDT)
Received: by relay13.relay.iad.mlsrvr.com (Authenticated sender: jlongman-AT-xiplink.com) with ESMTP id 301D749165C;
	Wed, 29 Oct 2008 19:49:48 -0400 (EDT)
In-Reply-To: <20081029230816.GA31926@spearce.org>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99438>


On 29-Oct-08, at 7:08 PM, Shawn O. Pearce wrote:
> "J. Longman" <longman@xiplink.com> wrote:
>> 2) I'd like to find out the jgit way to achieve the equivalent of  
>> 'svn
>> update'.  I understand that fetch can do this but being new to git, I
>> don't really understand quite what I need yet.  The goal is to have  
>> git
>> the latest commits from the origin before indexing.
> Use a Transport instance to execute a default fetch (no args) on say
> the "remote" origin.  That will download the objects to the local
> database, but it won't update a working directory.  But I'm not sure
> you would care about the working directory in the backend of Jira.

Basically I stole the pgm.Fetch code:

Transport tn = Transport.open(repository, "origin");
final FetchResult r;
List<RefSpec> toget = new ArrayList<RefSpec>();
try {
	r = tn.fetch(new TextProgressMonitor(), toget);
} finally {
	tn.close();
}

Can I assume that this enough to update the database?  If so I think  
I'm doing what you're suggesting.  After this (and not shown) is some  
logging code taken from Fetch, which results in the following:

 From /Users/longman/workspace2/work/../masterRepo/
     131dcf5..078d43f  master     -> origin/master

but there doesn't appear to be any specific mention of the incoming  
changes.

>> Thanks for jgit - it took me a day or two to wrap my head around  
>> getting
>> the list of files changed in a commit but otherwise its great to have
>> something that can be integrated into jira.
> Yea, about that, we wanted to write more tutorials on the API...  ;-)


Well, the egit does provide some examples, just there's another API  
involved which can be confusing.  The code in the jira git plugin the  
key classes are GitManagerImpl and RevisionIndexer, but the  
RevisionIndexer has some Lucene (text search engine) API mixed-in.  
Plus I'm still even learning about git much less the jgit api so I  
can't vouch for quality or correctness ;-).  I could snip some code  
out and send it to you off-list for inclusion in the wiki maybe.

later, j

--
J. Longman
longman@xiplink.com

The information transmitted is intended only for the person or entity to
which it is addressed and may contain confidential and/or privileged
material.  If you have received this in error, please contact the sender
and delete this communication and any copy immediately.  Thank you.
