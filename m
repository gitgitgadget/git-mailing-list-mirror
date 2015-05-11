From: Trevor Saunders <tbsaunde@tbsaunde.org>
Subject: Re: [PATCH] bisect: print abbrev sha1 for first bad commit
Date: Mon, 11 May 2015 14:17:19 -0400
Message-ID: <20150511181719.GB18112@tsaunders-iceball.corp.tor1.mozilla.com>
References: <1431128763-28453-1-git-send-email-tbsaunde@tbsaunde.org>
 <CAGZ79kYjES6DXmvQdmXLAXrKMGrnvQ-vqJuHQU2QxVC4+6M0aA@mail.gmail.com>
 <20150509014152.GA31119@tsaunders-iceball.corp.tor1.mozilla.com>
 <20150509040704.GA31428@peff.net>
 <20150510231110.GA25157@tsaunders-iceball.corp.tor1.mozilla.com>
 <20150511011009.GA21830@peff.net>
 <xmqqmw1bg2dd.fsf@gitster.dls.corp.google.com>
 <CAP8UFD1Aq54dWvxo5JTP4Fqy5u-qhA0LAm3vRrw9=jYg3o_F+g@mail.gmail.com>
 <xmqqfv73f420.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 20:17:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrsGn-0005mi-It
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 20:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225AbbEKSRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 14:17:32 -0400
Received: from tbsaunde.org ([66.228.47.254]:43732 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbbEKSRb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 14:17:31 -0400
Received: from tsaunders-iceball.corp.tor1.mozilla.com (unknown [66.207.208.102])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id 3757AC07C;
	Mon, 11 May 2015 18:17:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqfv73f420.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268813>

On Mon, May 11, 2015 at 09:54:15AM -0700, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> 
> > On Mon, May 11, 2015 at 6:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Jeff King <peff@peff.net> writes:
> >>
> >>> I'd argue for simply never showing the diff (dropping the "opt.diff = 1"
> >>> line from bisect.c:show_diff_tree), but that is mostly my personal
> >>> opinion.
> >>
> >> Yeah, I think that is sensible. It may even be OK to just give a
> >> "log --oneline".
> >
> > Or maybe we could let the user configure the diff options or even the
> > command used when the first bad commit is found?
> 
> That is a separate discussion.  I do not mind but I doubt many
> people would use it (I was tempted to say "doubt anybody would", but
> then was reminded how many people use Git, and toned it down), as
> long as we have a good default.  And I thought that this discussion
> was about coming up with a good-enough default.

agreed

> To be bluntly honest, I think the current one is sufficient as a
> good-enough default.  The first thing I would do after seeing that
> message is to either "git checkout <commit-object-name>" or "git
> show <commit-object-name>", and the current full 40-hex output gives
> me an easier mouse-double-click target than the proposed abbreviated
> one, so in that sense the original proposal may even be a usability
> regression.

I think printing the full 40 chars once is reasonable, but twice in 2
lines seems a bit excessive.  I was thinking of changing the format to
be

the first bad commit is
$(git log -1 <bad sha1>)

> It is tempting to say that the output can be eliminated by always
> checking out the first-bad-commit (i.e. only when the last answer
> that led to the first-bad decision was "good", do a "git checkout"
> of that bad commit), but in a project where a branch switching is
> not instantaneous, that might be problematic (unless the first step
> the user would have done is to check it out anyway, of course).

Well,  if you just finished bisecting you are probably on a commit close
to the first bad one so it probably will be fast.  However I don't
really like that idea because what I generally want to do is read the
patch so having the hash printed so I can copy it and run git show -p
$hash or something is nice.  Though I guess if the first bad commit is
checked out you can just skip the copy paste and use HEAD.

Trev
