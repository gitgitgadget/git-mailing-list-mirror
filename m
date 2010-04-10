From: Eric Raymond <esr@thyrsus.com>
Subject: Re: More git status --porcelain lossage
Date: Sat, 10 Apr 2010 18:57:04 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100410225704.GA4623@thyrsus.com>
References: <20100409190601.47B37475FEF@snark.thyrsus.com>
 <m3k4sfgmjc.fsf@localhost.localdomain>
 <20100410194154.GB28768@thyrsus.com>
 <201004102321.59263.jnareb@gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon <turner25@gmail.com>, Eric Raymond <esr@snark.thyrsus.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 00:57:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0jc2-0004zq-Fv
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 00:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386Ab0DJW5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 18:57:07 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:56510
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063Ab0DJW5G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 18:57:06 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 117D020CBBC; Sat, 10 Apr 2010 18:57:04 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <201004102321.59263.jnareb@gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144611>

Jakub Narebski <jnareb@gmail.com>:
> [JSON] is a bit chatty, but is to some extent self documenting.

Yes. But to my mind, the big win of JSON is that you can extend it without
breaking parsers looking for older versions - they just skip the new
fields and all is happy.

Jakub, you seem to know this, but other listmermbers may not: I've
recently re-engineered GPSD, a service daemon for watching geolocation
sensors, to report JSON objects up the socket to client apps.  The
benefits in clarity and extensibility of the protocol have been
*huge*.  Like, today I'm adding a reporting type for digital
compass/gyroscope sensors.

> The question is whether it should output well formed array of objects,
> or just list of objects not wrapped in array...

Yes, I know this dance.  Answer: one big JSON object, tagged by the
name of the output generator, and also *containing a version-stamp
field*.  Array of file status objects is another top-level member.

The point is: later, if we want to enrich the reporting format, we add
whatever fields we want and bump the version stamp.  Self-describing
goodness.  Python, Perl, JavaScript, and Emacs LISP clients win
especially big.  Slurping this into a native data structure is one
function call.

The more I think about this, the better I like it.
 
> What I am worrying about is correct handling of escaping, quoting,
> and non-ASCII characters in strings (the JSON-quoting and JSON-escapes
> are different than C escape codes, IIRC).  JSON rules are simple,
> but are different than C.

Yes. Perhaps there's some scope for reuse here after all.  GPSD has
well-tested code for uttering the JSON quote/escape conventions. 
The git project is welcome to it.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
