From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git-svn parses --pretty=medium log output, fails when
 log.decorate is true
Date: Tue, 5 Oct 2010 14:02:14 -0400
Message-ID: <20101005180214.GA12861@sigill.intra.peff.net>
References: <1286273926.2364.6.camel@wpalmer.simply-domain>
 <20101005165830.GA13413@sigill.intra.peff.net>
 <4CAB6620.4000909@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Will Palmer <wmpalmer@gmail.com>,
	Eric Wong <normalperson@yhbt.net>, git <git@vger.kernel.org>
To: Mathias Lafeldt <misfire@debugon.org>
X-From: git-owner@vger.kernel.org Tue Oct 05 20:02:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Bq8-00047k-Q6
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 20:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873Ab0JESB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 14:01:56 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:36772 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821Ab0JESB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 14:01:56 -0400
Received: (qmail 2013 invoked by uid 111); 5 Oct 2010 18:01:55 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 05 Oct 2010 18:01:55 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Oct 2010 14:02:14 -0400
Content-Disposition: inline
In-Reply-To: <4CAB6620.4000909@debugon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158220>

On Tue, Oct 05, 2010 at 07:53:36PM +0200, Mathias Lafeldt wrote:

> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -1514,7 +1514,7 @@ sub cmt_sha2rev_batch {
> >  
> >  sub working_head_info {
> >  	my ($head, $refs) = @_;
> > -	my @args = ('log', '--no-color', '--first-parent', '--pretty=medium');
> > +	my @args = ('rev-list', '--first-parent', '--pretty=medium');
> >  	my ($fh, $ctx) = command_output_pipe(@args, $head);
> >  	my $hash;
> >  	my %max;
> 
> You're right. Using rev-list looks like a much cleaner solution.
> 
> In addition, I think we can replace the call to git-log in git_svn_log_cmd() too.

I don't think so. It uses diff options like "--raw --name-status" which
rev-list does not support. I think it is not buggy, though, as it uses
--format=raw.

-Peff
