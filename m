From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] format-patch: introduce format.outputDirectory
 configuration
Date: Fri, 19 Jun 2015 00:14:38 -0400
Message-ID: <20150619041437.GA26001@peff.net>
References: <1434626280-4610-1-git-send-email-kuleshovmail@gmail.com>
 <xmqq616ley7y.fsf@gitster.dls.corp.google.com>
 <20150618195751.GA14550@peff.net>
 <xmqqoakceq8s.fsf@gitster.dls.corp.google.com>
 <xmqqk2v0eq75.fsf@gitster.dls.corp.google.com>
 <20150618201323.GB14550@peff.net>
 <20150618202205.GA16517@peff.net>
 <xmqqd20sd70j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 06:14:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5nhV-0002Nm-NT
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 06:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbbFSEOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 00:14:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:48593 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751384AbbFSEOk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 00:14:40 -0400
Received: (qmail 20660 invoked by uid 102); 19 Jun 2015 04:14:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Jun 2015 23:14:40 -0500
Received: (qmail 11809 invoked by uid 107); 19 Jun 2015 04:14:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Jun 2015 00:14:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Jun 2015 00:14:38 -0400
Content-Disposition: inline
In-Reply-To: <xmqqd20sd70j.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272099>

On Thu, Jun 18, 2015 at 02:46:36PM -0700, Junio C Hamano wrote:

> > If I were designing from scratch, I would consider making "-o -" output
> > to stdout, and letting it override a previous "-o" (or vice versa). We
> > could still do that (and make "--stdout" an alias for that), but I don't
> > know if it is worth the trouble (it does change the behavior for anybody
> > who wanted a directory called "-", but IMHO it is more likely to save
> > somebody a headache than create one).
> 
> I agree with "later -o should override an earlier one", but I do not
> necessarily agree with "'-o -' should be --stdout", for a simple
> reason that "-o foo" is not "--stdout >foo".

Good point. At any rate, that was all in my "designing from scratch"
hypothetical, so it is doubly not worth considering.

> Perhaps something like this to replace builtin/ part of Alexander's
> patch?
> [...]
> @@ -1337,6 +1342,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		die (_("--subject-prefix and -k are mutually exclusive."));
>  	rev.preserve_subject = keep_subject;
>  
> +	if (!output_directory && !use_stdout)
> +		output_directory = config_output_directory;
> +

Yeah, I think that is the sanest way to do it given the constraints.

-Peff
