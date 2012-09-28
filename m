From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] completion: fix args of run_completion() test helper
Date: Fri, 28 Sep 2012 15:30:08 -0400
Message-ID: <20120928193008.GA3912@sigill.intra.peff.net>
References: <20120928100530.GL10144@goldbirke>
 <1348826975-2225-1-git-send-email-szeder@ira.uka.de>
 <1348826975-2225-2-git-send-email-szeder@ira.uka.de>
 <7vehlmm3ca.fsf@alter.siamese.dyndns.org>
 <20120928183840.GB10719@goldbirke>
 <7vzk4aj6ik.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 21:30:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THgGW-0005Dm-Cf
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 21:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031257Ab2I1TaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 15:30:12 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33819 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030245Ab2I1TaK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 15:30:10 -0400
Received: (qmail 17861 invoked by uid 107); 28 Sep 2012 19:30:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Sep 2012 15:30:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Sep 2012 15:30:08 -0400
Content-Disposition: inline
In-Reply-To: <7vzk4aj6ik.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206602>

On Fri, Sep 28, 2012 at 12:23:47PM -0700, Junio C Hamano wrote:

> >> > @@ -57,7 +57,7 @@ run_completion ()
> >> >  test_completion ()
> >> >  {
> >> >  	test $# -gt 1 && echo "$2" > expected
> >> > -	run_completion "$@" &&
> >> > +	run_completion $1 &&
> >> >  	test_cmp expected out
> >> >  }
> >> 
> >> I can understand the other three hunks, but this one is fishy.
> >> Shouldn't "$1" be inside a pair of dq?  I.e.
> >> 
> >> 	+	run_completion "$1" &&
> >
> > No.  $1 holds all words on the command line.  If it was between a pair
> > of dq, then the whole command line would be passed to the completion
> > script as a single word.
> 
> And these "words" can be split at $IFS boundaries without any
> issues?  IOW, nobody would ever want to make words array in the
> run_completion function to ['git' 'foo bar' 'baz']?

It might be simpler to just convert test_completion into the
test_completion_long I added in my series; the latter takes the expected
output on stdin, leaving the actual arguments free to represent the real
command-line. E.g., your example would become:

  test_completion git "foo bar" baz <<-\EOF
  ... expected output ...
  EOF

-Peff
