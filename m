From: "Robert Anderson" <rwa000@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 17:08:57 -0700
Message-ID: <9af502e50806271708p7979ae65k61b71be90efff2c4@mail.gmail.com>
References: <g43jlg$54g$1@ger.gmane.org> <-8386235276716376372@unknownmsgid>
	 <9af502e50806271555j3cd06ecau122b11217f612217@mail.gmail.com>
	 <7viqvuo4hq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Jeske" <jeske@willowmail.com>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 02:10:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCO1B-00058H-Hg
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 02:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762662AbYF1AJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 20:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbYF1AJA
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 20:09:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:23421 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610AbYF1AI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 20:08:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so346843fgg.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 17:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=PhTZ3Ki61OeRirRdLgWLEpiUSYfyvKzh2LkdnigMA14=;
        b=nhBntTuk14dsQXvuf7e9T5ZZoF5OIo9hwz1dvoLRM1XZSFw5qvvdcfYetNzTm4BGZO
         U8uiyHeGagy+Dl5Sbe6x+YZyiQEtKakLLoasQzq5NREd4881iGx0YlOMuYTeQhhwJXV5
         zNaPHQH0/D5X755SqFmJNf2d/+wpNpdwwk5P0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=WGVs/TnLasZslKr3GZKmWyTx4KUAOXzz/HuKDEZ+7YD9JpyH1clsynNpXqbTbiHuzK
         1YEnIE3Sdnxnh0D04WYt2uGhIcqwvjvkRMuAtu1/QpRlvSnV8fHUgxLAaPWmjsxR2cId
         VxZ287bpwYeCnhjmJJFiXzyi/+nTLkGuRpKCQ=
Received: by 10.86.87.13 with SMTP id k13mr2669714fgb.38.1214611737395;
        Fri, 27 Jun 2008 17:08:57 -0700 (PDT)
Received: by 10.86.4.6 with HTTP; Fri, 27 Jun 2008 17:08:57 -0700 (PDT)
In-Reply-To: <7viqvuo4hq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86685>

On Fri, Jun 27, 2008 at 4:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Robert Anderson" <rwa000@gmail.com> writes:
>
>> There are good reasons for desiring a workflow that does not routinely
>> change history as part of the usual workflow.  Maybe there are clones
>> of your repo.  Maybe as part of your workflow discipline you do not
>> want HEAD states that cannot be pushed to public, because you don't
>> want to manually keep track of when it is ok and when it is not ok to
>> push HEAD to public, since git cannot tell you this.
>
> Surely you can arrange that.  You keep track of what you pushed out, and
> you refrain from rebasing beyond that point.

First, the constraint of achieving this workflow when there are clones
of the repo in question removes any need for additional rationales.

That being said...

In the existing model which is being suggested as a way to get the
desired workflow, there are two distinct classes of commits:  commits
that are "for real", and commits that are "temporary", that are being
used as some kind of workspace for orthogonalizing a set of changes,
which will eventually be replaced by "for real" commits.  Yet git has
no metadata to distinguish these two types of commits.  When only "for
real" commits exist, I can push HEAD.  When "temporary" commits exist,
I cannot, or insidious problems will ensue.  This metadata concerning
"for real" or "temporary" commits is only maintained manually in the
developer's head.  But, this is the sort of thing that computers are
for, and should not be the burden of the developer to maintain this
information in his mental cache, especially when the price of making
an error can be quite high.  It would be very easy to forget that you
intended to do more work on your last N commits, and push HEAD because
somebody asks you to make sure you've pushed your latest work.  Your
tools should prevent this kind of scenario.  Git cannot, because it
doesn't know what you intend when you "commit" because two different
ideas are being conflated with "commit" in this model.

In my proposed model, there is a clear distinction, kept track of by
git, not the developer, between changes which are in the "temporary
workspace" which is still being worked on, and changes which are "for
real", that can be shared, either through a push to a public repo or
if there are clones of my repo.  They become "for real" when they are
committed.  That's the purpose of a "commit" in this workflow.  To
bless a change as ready for viewing by others, even if you do not want
to make it available yet (by a push to a public repo).  I can walk
away from a working tree for six months, come back, and there can be
no confusion about which changes were "temporary" and possibly in need
of revision, and which changes are blessed as ready for public
consumption.  If I come back to a branch on which there are several
commits which have not been pushed yet, how do I know which are
"temporary" and which are "for real" commits?  I cannot.  It is
impossible.  The information is not there.

But, all of this is moot when you consider the simple case of a repo
which has been cloned, on which you'd like to make partial commits,
and test the committed state before doing so.

Thanks,
Bob
