From: "Liam Healy" <lnp@healy.washington.dc.us>
Subject: Re: Stitching together two split segments from svn
Date: Thu, 24 Jul 2008 22:41:14 -0400
Message-ID: <654935030807241941p620201a2q21bb4513cd21225d@mail.gmail.com>
References: <654935030807241633g763e622br4feb8b4e23ee64e2@mail.gmail.com>
	 <m3ljzqvo6i.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 04:42:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMDG7-0002pb-NV
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 04:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbYGYClR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 22:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752425AbYGYClR
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 22:41:17 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:63942 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbYGYClQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 22:41:16 -0400
Received: by an-out-0708.google.com with SMTP id d40so685469and.103
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 19:41:15 -0700 (PDT)
Received: by 10.100.252.17 with SMTP id z17mr1881464anh.87.1216953674867;
        Thu, 24 Jul 2008 19:41:14 -0700 (PDT)
Received: by 10.100.163.6 with HTTP; Thu, 24 Jul 2008 19:41:14 -0700 (PDT)
In-Reply-To: <m3ljzqvo6i.fsf@localhost.localdomain>
Content-Disposition: inline
X-Google-Sender-Auth: eb6d68b728adeae2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89994>

Jakub,

Thanks for the advice -- this did exactly what I wanted.

For anyone else wanting to do this: one thing that threw me for a
while was that .git/info/grafts does not accept an abbreviated SHA,
the full 40 hex digits is needed.  I would see "bad graft data" from
gitk with no other explanation.  There is very little documentation
that I could find on the grafts file; the best I could find was in the
man page for git-filter branch,
http://www.kernel.org/pub/software/scm/git/docs/git-filter-branch.html.

Liam

On Thu, Jul 24, 2008 at 7:48 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> "Liam Healy" <lnp@healy.washington.dc.us> writes:
>
>> I have a project whose history is stored in two separate svn
>> repositories.  The first repository I kept privately during initial
>> development, the second started when I posted it publicly and does not
>> have the history of the first.  I am trying to reunite them under git.
>>  The development of the first was linear, so after using git svn, the
>> history looks like:
>>
>>  a - b - ... - c - d = HEAD (old repository)
>>
>> and the second has one branch "ffa":
>>
>> (new repository)
>>  T - d - e - ... - f - g - h - ... - j   master
>>                       \
>>                        k - l - .... - m  ffa
>>
>> Note that T is the "trunk" initial commit on the svn repo that has no
>> files.  The second commit d is identical to the HEAD of old, as
>> verified by git diff.
>> However, when I remote add these two into a single repository, they
>> show up as two detached chains, with no connection between them.  I
>> thought git rebase would reconnect them.  However, when I do that on
>> each branch (master and ffa), I get the following:
>>
>>  a - b - ... - c - d - e - ... - f - g - h - ... - j   master
>>                       \
>>                        e - ... -f - g - k - l - .... - m  ffa
>>
>> instead of what I would like
>>
>>  a - b - ... - c - d - e - ... - f - g - h - ... - j   master
>>                                      \
>>                                       k - l - .... - m  ffa
>>
>> That is to say, those commits from the new repository that have a
>> common history for the two branches are duplicated.  The commits are
>> listed separately and have different SHA IDs, but they are clearly the
>> same commits (same comments, same svn version number).  Is there any
>> way to do what I want?  Really, all I want to do is change the parent
>> of "e" to be the HEAD of the old repository.
>
> If this is initial import, and not published anywhere, the simplest (I
> think) solution would be to use grafts file (.git/info/grafts) to
> change parent of 'k' from 'g' in ffa to 'g' in master, by adding the
> line with:
>
>  <sha1 of 'k'> <sha1 of 'g' on master>
>
> to .git/info/grafts.  Then examine history if everything is now all
> right (for example using gitk), and if everything is O.K. run
> git-filter-branch.
>
> See documentation for details.
>
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
>
