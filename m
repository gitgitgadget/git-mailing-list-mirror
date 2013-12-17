From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: I have end-of-lifed cvsps
Date: Tue, 17 Dec 2013 09:58:09 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20131217145809.GC15010@thyrsus.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com>
 <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com>
 <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <52B02DFF.5010408@gmail.com>
 <CALKQrgf3kuXRpbWmSp_nk8+zDFYNzkgV+dSBHaBbmUkxqjaDUA@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Dec 17 15:58:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vsw6B-0008I9-8Y
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 15:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625Ab3LQO6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 09:58:11 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:60901
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340Ab3LQO6K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 09:58:10 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 72927380868; Tue, 17 Dec 2013 09:58:09 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CALKQrgf3kuXRpbWmSp_nk8+zDFYNzkgV+dSBHaBbmUkxqjaDUA@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239389>

Johan Herland <johan@herland.net>:
> HOWEVER, this only solves the "cheap" half of the problem. The reason
> people want incremental CVS import, is to avoid having to repeatedly
> convert the ENTIRE CVS history. This means that the CVS exporter must
> learn to start from a given point in the CVS history (identified by
> the above mapping) and then quickly and efficiently convert only the
> "new stuff" without having to consult/convert the rest of the CVS
> history. THIS is the hard part of incremental import. And it is much
> harder for systems like CVS - where the starting point has a broken
> concept of history...

I know of *no* importer that solves what you call the "deep" part of
the problem.  cvsps didn't, cvs-fast-import doesn't, cvs2git doesn't.
All take the easy way out; parse the entire history, and limit what
is emitted in the output stage.

Actually, given what I know about delta-file parsing I'd say a "true"
incremental CVS exporter would be so hard that it's really not worth the
bother.  The problem is the delta-based history representation.
Trying to interpret that without building a complete set of history
states in the process (which is most of the work a whole-history
exporter does) would be brutally difficult - barely possible in
principle maybe, but I wouldn't care to try it.

It's much more practical to tune up a whole-history exporter so it's
acceptably fast, then do incremental dumping by suppressing part of
the conversion in the output stage. 

cvs-fast-export's benchmark repo is the history of GNU troff.  That's
3057 commits in 1549 master files; when I reran it just now the
whole-history conversion took 49 seconds.  That's 3.7K commits a
minute, which is plenty fast enough for anything smaller than (say)
one of the *BSD repositories.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
