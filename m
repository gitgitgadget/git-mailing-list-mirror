From: Jeff King <peff@peff.net>
Subject: Re: Efficient parsing of `status -z` output
Date: Tue, 10 Mar 2015 01:41:47 -0400
Message-ID: <20150310054146.GA3216@peff.net>
References: <CAMJduDuxBDoJ9_ETY8FCRoANf+taAS7-1acf5CFRGXDFyL72Rg@mail.gmail.com>
 <xmqqlhj7sy7l.fsf@gitster.dls.corp.google.com>
 <CAMJduDvDO4GesL+eru3h1YHrbF5hFmyycX3f4ADQOo+VnD7GDg@mail.gmail.com>
 <20150309061920.GB27128@peff.net>
 <20150309064939.GA30819@peff.net>
 <CAMJduDvuBF6KwLjmnxmMgfeSYfO6uDVfnkF=VTLTr8t8qowb0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthew Rothenberg <mrothenberg@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 06:41:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVCvV-0003FF-4J
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 06:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbbCJFlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 01:41:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:59525 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751186AbbCJFlv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 01:41:51 -0400
Received: (qmail 1169 invoked by uid 102); 10 Mar 2015 05:41:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Mar 2015 00:41:51 -0500
Received: (qmail 15451 invoked by uid 107); 10 Mar 2015 05:41:59 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Mar 2015 01:41:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Mar 2015 01:41:47 -0400
Content-Disposition: inline
In-Reply-To: <CAMJduDvuBF6KwLjmnxmMgfeSYfO6uDVfnkF=VTLTr8t8qowb0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265208>

On Mon, Mar 09, 2015 at 07:40:43PM -0400, Matthew Rothenberg wrote:

> On Mon, Mar 9, 2015 at 2:49 AM, Jeff King <peff@peff.net> wrote:
> >   $ git init
> >   $ seq 1 1000 >file && git add file && git commit -m base
> >   $ mv file other
> >   $ echo foo >file
> >   $ git add .
> >   $ git status --short
> >   M  file
> >   C  file -> other
> 
> Fantastic, I am able to replicate with these steps and will build
> tests around this case.
> 
> For future proofing, from the documentation for git status is appears
> the other two codes I would want to check for in addition to 'C '
> (which this test cases generates) may be 'CM' and 'CD'? And all of
> those should always have the additional PATH2 column present?

Yes, you can trivially make CM and CD by changing or deleting "other" in
the example above. I don't think you can ever have 'C' or 'R' in the
second column; we don't do renames on working tree changes, since a
"new" file there is simply untracked.

-Peff
