From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Mon, 6 May 2013 12:32:15 +0200
Message-ID: <87ip2wflg0.fsf@linux-k42r.v.cablecom.net>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
	<1367555502-4706-5-git-send-email-felipe.contreras@gmail.com>
	<87y5bw3q1s.fsf@hexa.v.cablecom.net>
	<CAMP44s1R9hAMZ=DQoPiTVi3+40NpADjVFU7tYovZA8W-PWEhhg@mail.gmail.com>
	<518785B3.3050606@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	<git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 06 12:32:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZIiU-0002hZ-5B
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 12:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827Ab3EFKcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 06:32:18 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:50657 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753767Ab3EFKcR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 06:32:17 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 6 May
 2013 12:32:15 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 6 May 2013 12:32:15 +0200
In-Reply-To: <518785B3.3050606@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 6 May 2013 12:28:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223439>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 05/03/2013 08:23 PM, Felipe Contreras wrote:
>> On Fri, May 3, 2013 at 12:56 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>>> How do we know that this doesn't break any users of fast-import?  Your
>>> comment isn't very reassuring:
>>>
>>>> the vast majority of them will never be used again
>>>
>>> So what's with the minority?
>> 
>> Actually I don't think there's any minority. If the client program
>> doesn't store blobs, the blob marks are not used anyway. So there's no
>> change.
>
> I haven't been following this conversation in detail, but your proposed
> change sounds like something that would break cvs2git [1].  Let me
> explain what cvs2git does and why:
>
> CVS stores all of the revisions of a single file in a single filename,v
> file in rcsfile(5) format.  The revisions are stored as deltas ordered
> so that a single revision can be reconstructed from a single serial read
> of the file.
>
> cvs2git reads each of these files once, reconstructing *all* of the
> revisions for a file in a single go.  It then pours them into a
> git-fast-import stream as blobs and sets a mark on each blob.
>
> Only much later in the conversion does it have enough information to
> reconstruct tree-wide commits.  At that time it outputs git-fast-import
> data (to a second file) defining the git commits and their ancestry.
> The contents are defined by referring to the marks of blobs from the
> first git-fast-import stream file.
>
> This strategy speeds up the conversion *enormously*.
>
> So if I understand correctly that you are proposing to stop allowing
> marks on blob objects to be set and/or referred to later, then I object
> vociferously.

The proposed patch wants to stop writing marks (in --export-marks) for
anything but commits.  Does cvs2git depend on that?  I.e., are you using
two separate fast-import processes for the blob and tree/commit phases
you describe above?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
