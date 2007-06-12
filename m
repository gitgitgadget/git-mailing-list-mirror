From: Junio C Hamano <gitster@pobox.com>
Subject: Re: That improved git-gui blame viewer..
Date: Tue, 12 Jun 2007 12:14:16 -0700
Message-ID: <7v645thto7.fsf@assigned-by-dhcp.pobox.com>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org>
	<20070611064203.GG6073@spearce.org>
	<alpine.LFD.0.98.0706110826590.14121@woody.linux-foundation.org>
	<7vveduqxxr.fsf@assigned-by-dhcp.pobox.com>
	<e5bfff550706112316j42c7c8e8uf8383de990ca9707@mail.gmail.com>
	<7vbqflll55.fsf@assigned-by-dhcp.pobox.com>
	<e5bfff550706120427g7ad9d38bpc34d9ea284ace693@mail.gmail.com>
	<20070612135303.GT6073@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 21:14:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyBoy-0005n2-KE
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 21:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbXFLTOS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 15:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbXFLTOS
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 15:14:18 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:33638 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbXFLTOR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 15:14:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070612191415.KLRQ4247.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 12 Jun 2007 15:14:15 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AjEG1X0031kojtg0000000; Tue, 12 Jun 2007 15:14:16 -0400
In-Reply-To: <20070612135303.GT6073@spearce.org> (Shawn O. Pearce's message of
	"Tue, 12 Jun 2007 09:53:03 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49991>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Marco Costalba <mcostalba@gmail.com> wrote:
>> On 6/12/07, Junio C Hamano <gitster@pobox.com> wrote:
>> >
>> > (1) Are you emulating CVS-like "a file has an identity, and we
>> >     follow its changes" model?  How does it handle file split,
>> >     merge, and code movement in general?
>> >
>> 
>> It uses 'git rev-list HEAD -- <path>' to get the list of revisions
>> that modified a path,
>
> So apparently yes, qgit is emulating CVS.  And yet much better things
> exist (git-blame).

I would not use the word "better", as it depends on what you are
looking for.

>> I really would like to keep it like that because it is the way 'git'
>> works, and I would feel uncomfortable in filtering out git results, it
>> seems quite fragile to me.
>
> Its not "the way git works".  Its just one way of looking at the data
> in the object database.  And its not as accurate or as interesting
> as what git-blame does.

Again, I would not say "accurate".

The way Marco describes is a perfectly valid way to satisfy
expectations of people migrating from CVS.  It's more faithful
reproduction of CVS annotate behaviour.  In a sense, git-blame
does too much, but that is exactly why these "accurate and
interesting" behaviours are optional.

>> This means that file splits, merges, renames etc.. are handled as much
>> as they are handled in git. IOW *if* 'git rev-list HEAD -- <path>'
>> returns a list of revisions taking in account all of the above, so it
>> will, automatically, do qgit.
>> 
>> BTW _currentlly_ git-rev-list does not do that.
>
> And it may never do it.

Oh, I can guarantee you that git-rev-list will never ever do
that.  It is to traverse revisions while simplifying with path
limiters, and path limiters by definition will not look inside
contents.  Think of it as asking "Had my project consisted of
only arch/i386 and include/asm-i386 directories, what would the
history be".

However, adding a new option to "git log" so that you can say
'git log --single-follow=$this_file_at_the_tip $branch' is a
separate matter.  I think it is a sensible thing to do.  But
even if we do that, I think --single-follow should limit itself
to the rename following of "diff -M/-C" style.  It is insane to
include another path only because the result did copy&paste only
a handful lines out of during its history.
