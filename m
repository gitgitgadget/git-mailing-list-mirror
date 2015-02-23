From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] option-strings: use OPT_PATH
Date: Mon, 23 Feb 2015 16:12:28 -0500
Message-ID: <20150223211228.GA6658@peff.net>
References: <cover.1424707497.git.git@drmicha.warpmail.net>
 <9030a1bb1e7a03eedfd65432fabf385f457419d6.1424707497.git.git@drmicha.warpmail.net>
 <20150223182653.GB19904@peff.net>
 <xmqqd250s5fi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 22:12:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQ0It-0007BH-QL
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 22:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbbBWVMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 16:12:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:52486 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751249AbbBWVMb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 16:12:31 -0500
Received: (qmail 3670 invoked by uid 102); 23 Feb 2015 21:12:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Feb 2015 15:12:31 -0600
Received: (qmail 27561 invoked by uid 107); 23 Feb 2015 21:12:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Feb 2015 16:12:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Feb 2015 16:12:28 -0500
Content-Disposition: inline
In-Reply-To: <xmqqd250s5fi.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264300>

On Mon, Feb 23, 2015 at 01:07:13PM -0800, Junio C Hamano wrote:

> >> -	OPT_STRING(0, "template", &option_template, N_("template-directory"),
> >> +	OPT_PATH(0, "template", &option_template, N_("template-directory"),
> >>  		   N_("directory from which templates will be used")),
> >>  	OPT_CALLBACK(0 , "reference", &option_reference, N_("repo"),
> >>  		     N_("reference repository"), &opt_parse_reference),
> >
> > I'm not sure if this one is doing anything. Clone cannot use SETUP_GIT
> > for obvious reasons, so we should have a NULL prefix here. But that also
> > means we should be doing the right thing already.
> 
> I somehow thought that OPT_FILENAME already used expand_user_path()
> but apparently it does not.  It may want to.
> 
> And then this change will start to matter, as a good enhancement.
> 
> Of course, if OPT_PATH() is introduced in such a way that the
> program that uses the API can ask for "existing" and/or "directory",
> 
>     git clone --template=existing-file $URL
>     git clone --template=no-such-directory $URL
> 
> can be diagnosed as an error without the program having to code very
> much.
> 
> So, I agree that this change does not do anything in the current
> codebase, but it goes in a right direction.

Oh, I agree that annotating the option with more meaning is not a bad
thing. It may help readability, and as you note, we may grow new
features on those annotations over time. I mostly just got tired of
writing things along those lines by the time I finished with the
OPT_FILENAME patch (I guess OPT_PATH is the one more likely to grow new
features, though).

The one exception here is the thing I mentioned in parse_archive_args:
that one can be controlled by a remote caller and we would not want to
leak any information about which files exist, where the user's home
directory is, etc.

-Peff
