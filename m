From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git's database structure
Date: Tue, 4 Sep 2007 18:19:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709041816340.29009@reaper.quantumfyre.co.uk>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 19:19:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISc44-0006ng-R4
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 19:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834AbXIDRTk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 13:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754812AbXIDRTk
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 13:19:40 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:44301 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754792AbXIDRTj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2007 13:19:39 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 385337590FB
	for <git@vger.kernel.org>; Tue,  4 Sep 2007 18:19:38 +0100 (BST)
Received: (qmail 25889 invoked by uid 103); 4 Sep 2007 18:19:35 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91.2/4141. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.030642 secs); 04 Sep 2007 17:19:35 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 4 Sep 2007 18:19:35 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57619>

On Tue, 4 Sep 2007, Jon Smirl wrote:

> Let's back up a little bit from "Caclulating tree node".  What are the
> elements of git's data structures?
>
> Right now we have an index structure (tree nodes) integrated in to a
> base table. Integrating indexing into the data is not normally done in
> a database. Doing a normalization analysis like this may expose flaws
> in the way the data is structured. Of course we may also decide to
> leave everything the way it is.
>
> What about the special status of a rename? In the current model we
> effectively have three tables.
>
> commit - a set of all SHAs in the commit, previous commit, comment, author, etc
> blob - a file, permissions, etc.
> file names - name, SHA
>
> The file name table is encoded as an index and it has been
> intermingled with the commit table.
>
> Looking at this from a set theory angle brings up the question, do we
> really have three tables and file names are an independent variable
> from the blobs, or should file names be an attribute of the blob?

There isn't a one-to-one mapping of file names to blobs.  The blob only 
describes the contents of the file.  In the extreme case you could have 
one blob for every single file in your tree.  For example:

# git ls-tree -r HEAD
100644 blob 05303ef858aeeb01ca40590dd6fe65928096ee6c    bar/foo
100644 blob 05303ef858aeeb01ca40590dd6fe65928096ee6c    foo
100644 blob 05303ef858aeeb01ca40590dd6fe65928096ee6c    foo2
100644 blob 05303ef858aeeb01ca40590dd6fe65928096ee6c    foo3
100644 blob 05303ef858aeeb01ca40590dd6fe65928096ee6c    foo4
100644 blob 05303ef858aeeb01ca40590dd6fe65928096ee6c    foo5
100644 blob 05303ef858aeeb01ca40590dd6fe65928096ee6c    foo6

>
> How this gets structured in the db is an independent question about
> how renames get detected on a commit. The current scheme for detecting
> renames by comparing diffs is working fine. The question is, once we
> detect a rename how should it be stored?
>
> Ignoring the performance impacts and looking at the problem from the
> set theory view point, should:
> the pathnames be in their own table with a row for each alias
> the pathnames be stored as an attribute of the blob
>
> Both of these are the same information, we're just looking at how
> things are normalized.
>
>

-- 
Julian

  ---
"You shouldn't make my toaster angry."
-- Household security explained in "Johnny Quest"
