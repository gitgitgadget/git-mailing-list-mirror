From: Pete Wyckoff <pw@padd.com>
Subject: Re: [RFC/PATCH 2/8 v3] git_remote_helpers: fix input when running
 under Python 3
Date: Wed, 16 Jan 2013 19:29:55 -0500
Message-ID: <20130117002955.GB15517@padd.com>
References: <20130113161724.GK4574@serenity.lan>
 <50F38E12.6090207@alum.mit.edu>
 <20130114094721.GQ4574@serenity.lan>
 <20130115194809.GU4574@serenity.lan>
 <7vbocq2mri.fsf@alter.siamese.dyndns.org>
 <20130115215412.GX4574@serenity.lan>
 <7vy5fu14sy.fsf@alter.siamese.dyndns.org>
 <20130115224049.GZ4574@serenity.lan>
 <20130116000316.GA26999@padd.com>
 <20130116094418.GA9089@river>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jan 17 01:30:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvdN5-0007bZ-Ay
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 01:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757477Ab3AQA37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 19:29:59 -0500
Received: from honk.padd.com ([74.3.171.149]:41706 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756878Ab3AQA36 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 19:29:58 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id 5C54C20B7;
	Wed, 16 Jan 2013 16:29:57 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 23C702B95E; Wed, 16 Jan 2013 19:29:55 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20130116094418.GA9089@river>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213830>

john@keeping.me.uk wrote on Wed, 16 Jan 2013 09:45 +0000:
> On Tue, Jan 15, 2013 at 07:03:16PM -0500, Pete Wyckoff wrote:
> > I'd suggest for this Python conundrum using byte-string literals, e.g.:
> > 
> >         lines = check_output(args).strip().split(b'\n')
> > 	value, name = line.split(b' ')
> > 	name = name.strip(b'commit\t')
> > 
> > Essentially identical to what you have, but avoids naming "utf-8" as
> > the encoding.  It instead relies on Python's interpretation of
> > ASCII characters in string context, which is exactly what C does.
> 
> The problem is that AFAICT the byte-string prefix is only available in
> Python 2.7 and later (compare [1] and [2]).  I think we need this more
> convoluted code if we want to keep supporting Python 2.6 (although
> perhaps 'ascii' would be a better choice than 'utf-8').
> 
> [1] http://docs.python.org/2.6/reference/lexical_analysis.html#literals
> [2] http://docs.python.org/2.7/reference/lexical_analysis.html#literals

Drat.  The b'' syntax seems to work on 2.6.8, in spite of
the docs, but certainly isn't in 2.5.

I think you had hit on the best compromise with encoding,
but maybe ascii is a little less presumptuous than utf-8,
and more indicative of the encoding assumption.

		-- Pete
