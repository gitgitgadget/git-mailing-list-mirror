From: Eric Raymond <esr@thyrsus.com>
Subject: Re: git status --porcelain is a mess that needs fixing
Date: Sat, 10 Apr 2010 10:43:34 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100410144334.GB23959@thyrsus.com>
References: <20100409184608.C7C61475FEF@snark.thyrsus.com>
 <20100410040959.GA11977@coredump.intra.peff.net>
 <9c7e1f33b7ec0dab68a92aa8f067989e@212.159.54.234>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Eric Raymond <esr@snark.thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat Apr 10 16:43:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0buN-0001xr-Ub
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 16:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760Ab0DJOnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 10:43:35 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:39217
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab0DJOne (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 10:43:34 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 2F1AA20CBBC; Sat, 10 Apr 2010 10:43:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <9c7e1f33b7ec0dab68a92aa8f067989e@212.159.54.234>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144551>

Julian Phillips <julian@quantumfyre.co.uk>:
> On Sat, 10 Apr 2010 00:09:59 -0400, Jeff King <peff@peff.net> wrote:
> > Your parser is already broken if you are calling split, as the filenames
> > may contain spaces (and will be quoted in that case, and you need to
> > unmangle). You should use "-z".
> > 
> > You will probably then realize that the "-z" format looks like:
> > 
> >   XY file1\0file2\0
> > 
> > which still sucks. It would be more friendly as:
> > 
> >   XY\0file1\0file2\0
> > 
> > So you could split on "\0". But even with that, you can't just blindly
> > split, as the column and record separators are the same, and you might
> > have one or two filenames.
> 
> Not true.  If the second form was used, then you _can_ split on \0.  It
> will tokenise the data for you, and then you consume ether two or three
> tokens depending on the status flags.  So it would make the parsing
> simpler.  But to make it even easier, how about adding a -Z that makes the
> output format "XY\0file1\0[file2]\0" (i.e. always three tokens per record,
> with the third token being empty if there is no second filename)?  Though
> if future expandability was wanted you could end each record with \0\0 and
> then parsing would be a two stages of split on \0\0 for records and then
> split on \0 for entries?  The is already precedence for the -z option to
> change the output format, so a second similar switch should be ok?  Then
> the updated documentation could recommend --porcelain -Z for new users
> without affecting old ones.

+1

-Z could fix some of the other issues, as well, like use of space
as a flag character.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
