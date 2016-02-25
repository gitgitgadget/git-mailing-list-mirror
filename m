From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] git: submodule honor -c credential.* from command line
Date: Wed, 24 Feb 2016 20:45:08 -0500
Message-ID: <20160225014507.GB31616@sigill.intra.peff.net>
References: <1456358352-28939-1-git-send-email-jacob.e.keller@intel.com>
 <CAPig+cROoc+Y-V_6hw6Hx4X9pFGmRjfhpzYGKhswwa=bA5b=+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 02:45:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYkzr-0002Q4-5R
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 02:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbcBYBpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 20:45:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:48720 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751270AbcBYBpL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 20:45:11 -0500
Received: (qmail 4937 invoked by uid 102); 25 Feb 2016 01:45:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 20:45:10 -0500
Received: (qmail 14141 invoked by uid 107); 25 Feb 2016 01:45:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 20:45:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2016 20:45:08 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cROoc+Y-V_6hw6Hx4X9pFGmRjfhpzYGKhswwa=bA5b=+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287309>

On Wed, Feb 24, 2016 at 07:27:23PM -0500, Eric Sunshine wrote:

> > diff --git a/git-submodule.sh b/git-submodule.sh
> > @@ -192,6 +192,16 @@ isnumber()
> > +# Sanitize the local git environment for use within a submodule. We
> > +# can't simply use clear_local_git_env since we want to preserve some
> > +# of the settings from GIT_CONFIG_PARAMETERS.
> > +sanitize_local_git_env()
> > +{
> > +       local sanitized_config = $(git submodule--helper sanitize-config)
> 
> Is 'local' a bashism? (Although, I see that 'local' is already being
> used in relative_path(); perhaps that ought to be cleaned up.)

It seems to have spread to Almquist shells like dash, but it's
definitely not in POSIX. That covers _most_ platforms these days, but
I'd guess would break on older ksh. We should probably avoid it.

For the curious, there's a very thorough discussion in the first answer
here:

  http://stackoverflow.com/questions/18597697/posix-compliant-way-to-scope-variables-to-a-function-in-a-shell-script

In this case, we know that we're doing the sanitizing in a subshell, so
I think just dropping "local" and clobbering the existing
$sanitized_config is fine.

-Peff
