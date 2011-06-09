From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/8] teach remote-testgit to import non-HEAD refs
Date: Wed, 8 Jun 2011 20:17:23 -0400
Message-ID: <20110609001723.GB19715@sigill.intra.peff.net>
References: <20110607171838.GA21685@sigill.intra.peff.net>
 <20110607172052.GD22111@sigill.intra.peff.net>
 <7vipsf29la.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 02:18:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUSxH-0006DZ-HU
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 02:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246Ab1FIAR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 20:17:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40574
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890Ab1FIAR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 20:17:27 -0400
Received: (qmail 5909 invoked by uid 107); 9 Jun 2011 00:17:34 -0000
Received: from 99-189-169-83.lightspeed.snjsca.sbcglobal.net (HELO sigill.intra.peff.net) (99.189.169.83)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jun 2011 20:17:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jun 2011 20:17:23 -0400
Content-Disposition: inline
In-Reply-To: <7vipsf29la.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175476>

On Wed, Jun 08, 2011 at 04:21:21PM -0700, Junio C Hamano wrote:

> > diff --git a/git_remote_helpers/git/exporter.py b/git_remote_helpers/git/exporter.py
> > index f40f9d6..1855c6a 100644
> > --- a/git_remote_helpers/git/exporter.py
> > +++ b/git_remote_helpers/git/exporter.py
> > @@ -15,7 +15,7 @@ class GitExporter(object):
> >  
> >          self.repo = repo
> >  
> > -    def export_repo(self, base):
> > +    def export_repo(self, base, refs = ["HEAD"]):
> 
> This seems like an accident waiting to happen, even though it is Ok with
> the current code (because this method does not modify refs in any way), to
> specify a mutable object as the default value for an optional parameter.

Yeah, I didn't realize that python assigns default values by reference,
unlike other languages (this is actually the first python I've ever
written).

At any rate, I think this patch is obsoleted by Sverre's new series
(though I haven't read it in detail yet).

> >          sys.stdout.flush()
> >  
> >          args = ["git", "--git-dir=" + self.repo.gitpath, "fast-export", "--export-marks=" + path]
> > +	args.extend(refs)
> >  
> >          if os.path.exists(path):
> >              args.append("--import-marks=" + path)
> 
> Hmm, am I looking at the right version of this file?
> 
> I see args.append("HEAD") after this --import-marks in the existing code,
> which this patch does not remove.

Ugh, yeah. I missed that "HEAD". So this version is buggy in that it
exports everything you asked for, _plus_ HEAD. Which isn't a problem in
practice, but it's inefficient. That "HEAD" should definitely go away.

I'll check for it in Sverre's series and make sure he did it right. :)

-Peff
