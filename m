From: James Vega <vega.james@gmail.com>
Subject: Re: git-apply fails on creating a new file, with both -p and
 --directory specified
Date: Tue, 8 Dec 2009 01:49:44 -0500
Message-ID: <20091208064944.GM14401@jamessan.com>
References: <20091123194523.GZ15966@cl.cam.ac.uk>
 <7vws1e3ma1.fsf@alter.siamese.dyndns.org>
 <loom.20091207T222449-752@post.gmane.org>
 <7vk4wyqigf.fsf@alter.siamese.dyndns.org>
 <7v3a3mqhhd.fsf@alter.siamese.dyndns.org>
 <20091208054724.GA21347@coredump.intra.peff.net>
 <20091208060109.GB9951@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 08 07:55:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHtz3-0006VX-AY
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 07:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbZLHGz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 01:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbZLHGz3
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 01:55:29 -0500
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:47204
	"EHLO QMTA06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752883AbZLHGz2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Dec 2009 01:55:28 -0500
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Dec 2009 01:55:28 EST
Received: from OMTA07.westchester.pa.mail.comcast.net ([76.96.62.59])
	by QMTA06.westchester.pa.mail.comcast.net with comcast
	id EWpi1d0021GhbT856Wpl3T; Tue, 08 Dec 2009 06:49:45 +0000
Received: from debil.jamessan.com ([98.216.49.10])
	by OMTA07.westchester.pa.mail.comcast.net with comcast
	id EWpl1d0020DBqmy3TWplr5; Tue, 08 Dec 2009 06:49:45 +0000
Received: by debil.jamessan.com (Postfix, from userid 1000)
	id 2166EA1AFA; Tue,  8 Dec 2009 01:49:44 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20091208060109.GB9951@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134824>

On Tue, Dec 08, 2009 at 01:01:09AM -0500, Jeff King wrote:
> On Tue, Dec 08, 2009 at 12:47:24AM -0500, Jeff King wrote:
> 
> > There is a slightly different approach we could take, too: keep the
> > "deletion" hunk as a first-class hunk, and just meld the content hunk's
> > output into it. Then both cases would get the "Stage deletion" question
> > instead of the "Stage this hunk" you get now for non-empty files (which
> > just happens to trigger a deletion due to the headers).
> 
> BTW, the code for this is the much smaller change below. If you prefer
> that, I can squash in the test and write up an appropriate commit
> message.
> 
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 35f4ef1..02e97b9 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1217,7 +1217,11 @@ sub patch_update_file {
>  	if (@{$mode->{TEXT}}) {
>  		unshift @hunk, $mode;
>  	}
> -	if (@{$deletion->{TEXT}} && !@hunk) {
> +	if (@{$deletion->{TEXT}}) {
> +		foreach my $hunk (@hunk) {
> +			push @{$deletion->{TEXT}}, @{$hunk->{TEXT}};
> +			push @{$deletion->{DISPLAY}}, @{$hunk->{DISPLAY}};
> +		}
>  		@hunk = ($deletion);
>  	}
>  

Thanks for the quick patches.  This was similar to what I was working on, but
cleaner than what I had.  Works well for me.

-- 
James
GPG Key: 1024D/61326D40 2003-09-02 James Vega <vega.james@gmail.com>
