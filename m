From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: I have end-of-lifed cvsps
Date: Tue, 17 Dec 2013 09:07:46 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20131217140746.GB15010@thyrsus.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com>
 <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com>
 <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <52B02DFF.5010408@gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 17 15:07:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsvJQ-0006yM-Bm
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 15:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896Ab3LQOHs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Dec 2013 09:07:48 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:60444
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361Ab3LQOHs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 09:07:48 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id B5889380558; Tue, 17 Dec 2013 09:07:46 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <52B02DFF.5010408@gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239388>

Jakub Nar=C4=99bski <jnareb@gmail.com>:
> I wonder if we can add support for incremental import once, for all
> VCS supporting fast-export, in one place, namely at the remote-helper=
=2E

Something in the pipeline - either the helper or the exporter - needs t=
o
have an equivalent of vc-fast-export's and cvsps's -i option, which
omits all commits before a specified time and generates cookies like
"from refs/heads/master^0" before each branch root in the incremental
dump.

This could be done in the wrapper, but only if the wrapper itself
includes an import-stream parser, interprets the output from the
exporter program, and re-emits it.  Having done similar things
myself in reposurgeon, I advise against this strategy; it would
introduce a level of complexity to the wrapper that doesn't belong
there, and make the exporter+wrapper comnination harder to verify.

=46ortunately, incremental dump is trivial to implement in the output
stage of an exporter if you have access to the exporter source code.
I've done it in two different exporters.  cvs-fast-export now has a
regression test for this case

> I don't know details, so I don't know if it is possible; certainly
> unstable fast-export output would be a problem, unless some tricks
> are used (like remembering mappings between versions).

About such tricks I can only say "That way lies madness".  The present
Perl wrapper is buggy because it's over-complex.  The replacement wrapp=
er
should do *less*, not more.

Stable output and incremental dump are reasonable things to demand of
your supported exporters.  cvs-fast-export has incremental dump
unconditionally, and stability relative to every CVS implementation
since 2004.
--=20
		<a href=3D"http://www.catb.org/~esr/">Eric S. Raymond</a>
