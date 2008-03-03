From: Nicolas Pitre <nico@cam.org>
Subject: Re: git fetch: where are the downloaded objects stored?
Date: Mon, 03 Mar 2008 13:07:25 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0803031307110.2899@xanadu.home>
References: <4d8e3fd30803030440s7239c83cj8bf69401dd76bad@mail.gmail.com>
 <vpqskz82bm3.fsf@bauges.imag.fr>
 <4d8e3fd30803030633nf6266d5qab0df4ba4c539e0b@mail.gmail.com>
 <vpq63w325px.fsf@bauges.imag.fr>
 <4d8e3fd30803030740i18ca8db1y681b4f10797f8c83@mail.gmail.com>
 <alpine.LFD.1.00.0803031057140.2899@xanadu.home>
 <4d8e3fd30803030851n498953c4u7e7a109b91b9da11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 19:09:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWF57-0006ZU-2l
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 19:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894AbYCCSH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 13:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbYCCSH1
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 13:07:27 -0500
Received: from relais.videotron.ca ([24.201.245.36]:39528 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbYCCSH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 13:07:26 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JX600FDQ2CDGQ30@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 03 Mar 2008 13:07:26 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <4d8e3fd30803030851n498953c4u7e7a109b91b9da11@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75958>

On Mon, 3 Mar 2008, Paolo Ciarrocchi wrote:

> On Mon, Mar 3, 2008 at 5:29 PM, Nicolas Pitre <nico@cam.org> wrote:
> > If you have reflog enabled (it should be by default) then a good thing
> > to remember is the @{1} notation.  For example, if the fetch updated the
> > origin/master branch, then origin/master@{1} is what your origin/master
> > was before being updated.  To see the difference between the previous
> > and the current state of origin/master, you can do:
> >
> >        git diff origin/master@{1}..origin/master
> >
> > Or to see the list of new commits:
> >
> >        git log origin/master@{1}..origin/master
> >
> >        git log -p origin/master@{1}..origin/master
> >
> > Etc.
> 
> Very nice, I didn't find in the documentation.
> I'll read again the documents and if needed, I'll propose some new text.

I found the reflog notation burried in git-rev-parse.txt.  Maybe some 
example usage could be added to more frequently used commands.

> > This notation is a bit obnoxious and the re were suggestions about
> > addind the equivalent origin/master@{1..} but that didn't materialize
> > yet.
> 
> Mybe it's just me but wouldn't be very nice to have a simple command
> to look at what data have been used for updating the currente branch?
> i.e.
> git fetch
> git diff -- fetch (which is an alias of git diff
> origin/master@{1}..origin/master)

You still think in terms of "data used to update a branch".  There is no 
such direct relation between the fetched data (objects) and the updated 
branch heads.  What you do when listing the commits found between 
origin/master@{1} and origin/master@{0} (or simply origin/master wich 
is equivalent to origin/master@{0}) does not necessarily correspond to 
the data you received during the fetch.  For example, it is possible 
that half of those commits were already part of another branch in your 
repository, hence the fetch operation won't download them again.  Still, 
the origin/master branch now has acquired them all which wasn't the case 
before.  To really _see_ the actually received data during a fetch 
requires internal Git knowledge and digging in the pack directory -- 
there is no (need for any) UI for that.

> And how about a repository which have reflogs disabled?

Well, just re-enable them.  ;-)

Since they're on by default, if you turned them off then you surely know 
what you're doing and why.


Nicolas
