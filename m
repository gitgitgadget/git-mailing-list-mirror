From: D Sundstrom <sunds@peapod.net>
Subject: Re: Simple commit mechanism for non-technical users
Date: Wed, 19 Aug 2009 09:40:43 -0500
Message-ID: <ef72456d0908190740h597320e2vaa01f86edf59579c@mail.gmail.com>
References: <ef72456d0908180905u18593b63tdc850b8552db30b9@mail.gmail.com>
	 <alpine.DEB.1.00.0908190940430.5594@intel-tinevez-2-302>
	 <20090819102036.GC28920@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 19 16:47:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdmRJ-0002jr-Aq
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 16:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbZHSOqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 10:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbZHSOqw
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 10:46:52 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:54022 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbZHSOqw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 10:46:52 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1485741qwh.37
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 07:46:53 -0700 (PDT)
Received: by 10.229.93.41 with SMTP id t41mr2832910qcm.81.1250692843325; Wed, 
	19 Aug 2009 07:40:43 -0700 (PDT)
In-Reply-To: <20090819102036.GC28920@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126547>

Thanks to all that responded.

It might help to frame things from Aunt Tillie's point of view.
Her workflow consists of editing office documents (word, powerblower, etc)
in collaboration with her peers.  They email these back and forth and
come up with whatever ad-hoc "version control" they think of at the
moment, such as file names, dates, verbal communication, etc.

I'm technical product manager and I need to coordinate reviews of
these documents as well as my release process.  I also face audits
and accreditation from my customers.

We previously chose and implemented GIT for our scm system based
on a number of considerations. Primarily we have distributed teams and
also there is a review and sign-off process before code is "blessed" into
our official repository.  For this, GIT fits well.

I'm going to put all the project artifacts into this repository, including
the aforementioned office documents.  They just get versioned as binary
blobs, which is fine for this application.  I just need to know which one
is current and maintain prior versions.

Aunt Tillie may someday appreciate our scm enough to install a client
on her machine and learn how to use it.  But that is a big jump from
the simple workflow she has today.  My thought is that I might get her
to upload this document to a SMB/CIFS or webdav file share, or use
a simple webapp, but that is about it for now.

My thought is to just have a process that watches for these files and
commits them as they arrive.  I wouldn't do any filename magic, I would
just train Aunt Tillie to use the same name every time.  If two people
step on each other's work, they tend learn from the experience and
coordinate amongst themselves the next time.  There are only a
few people touching any given document.

A wiki doesn't seem appropriate because we are dealing with office
documents rather than "wiki-like" content.  This is more of a
document management system, albeit a very simple one.

The Aunt Tillies are all on windows (XP or later).  The development
team is all over the map, windows, osx, linux.

-David


On Wed, Aug 19, 2009 at 5:20 AM, Jeff King<peff@peff.net> wrote:
> On Wed, Aug 19, 2009 at 09:49:50AM +0200, Johannes Schindelin wrote:
>
>> Then you have a bunch of people who do not want to care about learning
>> proper version control.
>>
>> This is what I would do: write a very simple .cgi (I'd use Perl for that),
>> which has a file upload button, takes the name as commit message (or maybe
>> adds a field where you can type in a commit message, but that might be
>> asking your bunch of Aunt Tillies too much), strips the "v3"-like suffixes
>> ($name =~ s/[-_ ]*v\d+(\.[A-Za-z0-9]{1,5})$/$1/;), set author and
>> committer information according to IP (and refuse if the IP is not in the
>> internal mapping) and commit.
>>
>> The whole script would probably not be larger than 50 lines, and require
>> Git to be installed on the server.
>>
>> The bigger problem is that your Aunt Tillies most likely would not love
>> gitweb, so you need a fancier interface.
>
> Actually, I think there is a technical problem here. You get Aunt
> Tillie's v3, but you don't necessarily know what it is based on. So if
> some other Aunt Tillie has submitted a v3 in the meantime, what do you
> do with her file? Commit on top? Try to guess where her v2 was, branch
> from there, and merge?
>
> If you commit on top, then you are potentially erasing the other
> person's work. If you do a merge, you are likely to get conflicts
> (especially because Aunt Tillie likes to use horrible binary formats)
> that _somebody_ will have to resolve.
>
> I guess you can throw each Tillie on their own branch and then let
> somebody clueful do the merging, but then you do not really have people
> working together.
>
> I think this is a fundamental issue. Most version control systems (and
> especially distributed ones) are about doing concurrent work and
> merging, and merging requires a bit of a clue. The Aunt Tillies of the
> world really need a locking system to manage concurrency.
>
> -Peff
>
