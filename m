From: David Lang <david.lang@digitalinsight.com>
Subject: Re: Git for redundant mail servers
Date: Sun, 24 Apr 2005 00:45:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0504240028540.32437@qynat.qvtvafvgr.pbz>
References: <1114238562.3419.29.camel@localhost.localdomain><2cfc403205042301243841fe0c@mail.gmail.com><Pine.LNX.4.62.0504232159030.32287@qynat.qvtvafvgr.pbz>
 <1114322071.3419.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: jon@zeta.org.au, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 09:42:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPbkp-0001IE-8p
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 09:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbVDXHq5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 03:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVDXHq5
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 03:46:57 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:28847 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262284AbVDXHqw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 03:46:52 -0400
Received: from atlims01.diginsite.com by warden2.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Sun, 24 Apr 2005 00:41:45 -0700
Received: by atlexc02.diginsite.com with Internet Mail Service (5.5.2653.19)
	id <JRMQZRAL>; Sun, 24 Apr 2005 03:45:43 -0400
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id J2V6XWB2; Sun, 24 Apr 2005 00:45:19 -0700
To: David Woodhouse <dwmw2@infradead.org>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <1114322071.3419.68.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 24 Apr 2005, David Woodhouse wrote:

> Date: Sun, 24 Apr 2005 15:54:30 +1000
> From: David Woodhouse <dwmw2@infradead.org>
> To: David Lang <david.lang@digitalinsight.com>
> Cc: jon@zeta.org.au, git@vger.kernel.org
> Subject: Re: Git for redundant mail servers
> 
> On Sat, 2005-04-23 at 22:12 -0700, David Lang wrote:
>> 1. when a new message arrives it gets given a numeric messageid, this
>> message id is not supposed to change without fairly drastic things
>> happening (the server telling all clients to forget everything they know
>> about the status of the mailbox). this requires syncronization between
>> servers if both are receiving messages.
>
> Yeah, that's the most interesting part. One option would be to require
> quorum before a server is allowed to add to a mailbox -- but that would
> render the thing unsuitable for _intentional_ offline use, where you
> want to be able to move mails from one folder to another on your laptop
> while it's disconnected.

IMAP defines an offline mode, I haven't looked at it, but it would have to 
deal with this in some way.

> Since it should be relatively rare for 'competing' commits to occur
> during periods of disconnection, I suspect that the solution doesn't
> have to be particularly efficient. I'm not sure I'd really want to
> change UIDVALIDITY if it happened, but perhaps we could simply remove
> _all_ the affected UIDs, and assign new UIDs to the same mails.
>
> In practice, it's far more important that for us to ensure that an
> existing UID _never_ refers to a different mail, than it is to make sure
> that a given mail always keeps the same UID.

good point.

there are two things that will cause competing commits of full mail 
messages.

1. new mail arriving from the Net (probably via SMTP/LMTP

2. Client actions

2a. direct posting of messages (most common for FCC folders)

2b. copying of messages between folders

2c. flag changes

2d. expunging messages

>> 2. git effectivly stores snapshots of things and you deduce the changes by
>> comparing the snapshots. for things like flags changing this is a
>> relativly inefficiant way to replicate changes (although if one server is
>> offline for a while it could be a firly efficiant way to do the merge)
>
> We don't have to stick _precisely_ to Maildir -- but flag changes are
> just a rename in Maildir, leaving the mail object entirely intact while
> changing only the tree. That isn't _so_ bad; but yes, it could probably
> be done a little better than just "Maildir in git".

I'm familiar with Cyrus which has a similar concept of mail storage, but 
I'm only vaguely familar with maildir (I don't know all the details of how 
it does things)

the key question to answer is are you trying to just replicate maildir 
underneith the normal programs that use it?, or are you trying to have a 
replicated mailserver and are willing to modify the software as well as 
fiddle with the storage?

if you are after the first then you have to do everything at the 
filesystem level, if you are after the second it's amuch easier job, but 
you need to think carefully up front to decide what capabilities you need 
the software to have and pick the right software to start modifying.

David Lang


-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
