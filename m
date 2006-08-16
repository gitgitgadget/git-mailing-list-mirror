From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Compression and dictionaries
Date: Wed, 16 Aug 2006 10:43:30 -0400
Message-ID: <9e4733910608160743k22362dc4r4fa22c791707c73c@mail.gmail.com>
References: <9e4733910608150755q54757386n13c705b0043e8308@mail.gmail.com>
	 <20060816003712.32000.qmail@science.horizon.com>
	 <4b73d43f0608152243i15b37036x7aa50aa3afc2b02f@mail.gmail.com>
	 <9e4733910608152250h1bcb8bf5qebb29ef84b971abd@mail.gmail.com>
	 <Pine.LNX.4.63.0608160832320.28360@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060816065515.GB18778@spearce.org>
	 <Pine.LNX.4.63.0608160908070.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn Pearce" <spearce@spearce.org>,
	"John Rigby" <jcrigby@gmail.com>,
	"linux@horizon.com" <linux@horizon.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 16:44:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDMcN-0004rs-Cx
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 16:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWHPOnd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 10:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWHPOnd
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 10:43:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:32219 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751187AbWHPOnc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 10:43:32 -0400
Received: by nf-out-0910.google.com with SMTP id x30so725977nfb
        for <git@vger.kernel.org>; Wed, 16 Aug 2006 07:43:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qyotUprNQstCsOU8M4Kk1nt3olGon86RSGCreJ9WgHPwe35BDWkhgA2jM1yIA4UVQ295GP2v6pyaKsuizChrfNaqYe6gQyrbx5eUBGmDG1L3Ged8+cNHHFUD1R7LJp9Nh5N9vIrUNxI3qxodVdRWAiTN/f5CurtC2fyvAHQPVC8=
Received: by 10.49.8.4 with SMTP id l4mr785270nfi;
        Wed, 16 Aug 2006 07:43:30 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Wed, 16 Aug 2006 07:43:30 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608160908070.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25516>

On 8/16/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 16 Aug 2006, Shawn Pearce wrote:
>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > Hi,
> > >
> > > On Wed, 16 Aug 2006, Jon Smirl wrote:
> > >
> > > > On 8/16/06, John Rigby <jcrigby@gmail.com> wrote:
> > > > > Sorry if this is off topic, but could the dictionary be used to make
> > > > > git-grep alot faster?
> > > >
> > > > It would be almost instant.
> > >
> > > But only if you are not using a regular expression, but a single word.
> >
> > Yes and no.  If the inverted index contains terms broken by some
> > known pattern (e.g. break on word-type boundaries) and the regex
> > in question has constant sections (it should, otherwise it might
> > as well just be '.') then you can reduce your search space to a
> > fraction of the overall data by looking at the inverted index to
> > select likely terms, select the related revisions containing those
> > possible terms, then run the regex only on those revisions.
> >
> > Sure you would be possibly pulling out a number of false positives
> > but if the constant sequence(s) in the regex reduce your search
> > space to below 1/2 of the overall data that's probably a lot less
> > I/O and CPU required to complete the query, even if you have to
> > read the entire dictionary and apply each term in the dictionary
> > to the regex to look for those possible matches.
>
> So it would speed up the search, but no, in case of regular expressions,
> particularly any interesting one, the result would not be instantaneous.

Instant is a relative term. Google is instant compared to running grep
over 10TB of data. How long would that take, a month?

Shawn is correct, the inverted indexes are used to eliminate as many
files as possible. So the response time is a more of a function of how
many hits you have instead of how big the data set is. Of course if
you give it a pattern that matches everything it will just as slow as
grep. Give it a pattern that is only in one file and detectable by the
index and it will be very fast. If you are going to give it a bunch of
patterns that aren't in the index, then we need to adjust how the
index is built.

-- 
Jon Smirl
jonsmirl@gmail.com
