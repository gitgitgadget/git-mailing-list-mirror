From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: Archiving tags/branches?
Date: Sun, 19 Oct 2008 23:14:30 -0700
Message-ID: <48FC21C6.90600@pcharlan.com>
References: <48F93F52.4070506@pcharlan.com> <ee77f5c20810171950j9ab85bfi6eddca167f86fda2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 15:29:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kro3P-0004kd-0y
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 08:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbYJTGOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 02:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbYJTGOc
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 02:14:32 -0400
Received: from lax-green-bigip-5.dreamhost.com ([208.113.200.5]:60993 "EHLO
	swarthymail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750769AbYJTGOb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Oct 2008 02:14:31 -0400
Received: from [192.168.0.2] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by swarthymail-a3.g.dreamhost.com (Postfix) with ESMTP id 992F77F01A;
	Sun, 19 Oct 2008 23:14:30 -0700 (PDT)
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <ee77f5c20810171950j9ab85bfi6eddca167f86fda2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98668>

David Symonds wrote:
> On Sat, Oct 18, 2008 at 12:43 PM, Pete Harlan <pgit@pcharlan.com>
> wrote:
>> Hi,
>> 
>> I'm looking for a way to manage an ever-growing list of tags.  I've
>> read some git docs, but am new to git and wonder if the below
>> method doesn't work or if there's a standard practice I haven't run
>> into.
>> 
>> Most of the tags in my repo are uninteresting to look at, but can't
>> be deleted.  (Code releases for the most part, or stalled topic
>> branches.) If I wanted to archive those, it looks like this would
>> work:
> 
> Is it really true that they can't be deleted? The only reason to
> avoid it might be for preventing Git's GC from cleaning them up, but
> if all your branches/tags are reachable via "interesting"
> branches/tags then you could just slap the tag name and SHA1 in a
> text file somewhere.
> 
> 
> Dave.

Thank you for your response.  The tags aren't reachable; they're
dead-end branches.

Our development history looks like this:

o---o---o---o---o---o---o---o---o---o---o---o---o---o master
 \                   \                   \
  o---o---o r1.0      o---o---o r1.1      o---o---o r1.2

with releases branched off the development line and stabilized during
QA.  Fixes into the release branches are cherry-picked out of master,
with no merges.

With a new release every few weeks, the tags pile up.

(There are workflows, such as git.git's, where the release tags form one
long line of development, and when we start using git we may use a
different workflow, but the above was our svn workflow, for the
obvious reason that svn doesn't understand merges.  We're going to
import hundreds of such branches in the conversion to git; most such
names are noise, but we don't want to lose the history.)

I would think a built-in feature for archiving refs would be useful to
other projects, even when the tags/branches are reachable and therefore
one could manually stash them in a file.  Getting the design right is
tricky because there are a lot of different ways to approach it, but the
idea seems generally useful to me.

One direction would be to support directory commands for tags, using
refs/tags and refs/branches as the root directories of trees.  (This was
the solution in svn, which naturally supports a hierarchy of branches.)
 Another would be to have a regexp for hiding tags/branches with a
certain pattern (e.g., leading '.').  What I'll probably do in the short
term is write an alias that lists the most recent 10 tags and use that
most of the time.

--Pete
