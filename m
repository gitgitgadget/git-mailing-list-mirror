From: Jeff King <peff@peff.net>
Subject: Re: contrib/credential/netrc/git-credential-netrc: Use of
 uninitialized value in string
Date: Tue, 3 Sep 2013 13:35:44 -0400
Message-ID: <20130903173543.GC1050@sigill.intra.peff.net>
References: <CALWbr2ynAvevTxFd3duAfFzgv0DCGTDxFUaniW-8hM+eoLiOEw@mail.gmail.com>
 <xmqqr4dfhjmg.fsf@gitster.dls.corp.google.com>
 <20130827200550.GA17443@sigill.intra.peff.net>
 <87k3iyhqu5.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 19:35:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGuW6-0007lu-R3
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 19:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757760Ab3ICRfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 13:35:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:56974 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755089Ab3ICRfq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 13:35:46 -0400
Received: (qmail 17614 invoked by uid 102); 3 Sep 2013 17:35:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Sep 2013 12:35:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Sep 2013 13:35:44 -0400
Content-Disposition: inline
In-Reply-To: <87k3iyhqu5.fsf@lifelogs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233751>

On Tue, Sep 03, 2013 at 11:23:14AM -0400, Ted Zlatanov wrote:

> Yes, you're right.  Something like the following (untested) could work
> and does the wildcards, which I will make into a proper patch and test
> if it looks OK to you.
> 
> Ted
> 
> diff --git a/contrib/credential/netrc/git-credential-netrc b/contrib/credential/netrc/git-credential-netrc
> index 6c51c43..13e537b 100755
> --- a/contrib/credential/netrc/git-credential-netrc
> +++ b/contrib/credential/netrc/git-credential-netrc
> @@ -369,7 +369,10 @@ sub find_netrc_entry {
>         {
>                 my $entry_text = join ', ', map { "$_=$entry->{$_}" } keys %$entry;
>                 foreach my $check (sort keys %$query) {
> -                       if (defined $query->{$check}) {
> +                       if (!defined $entry->{$check}) {
> +                              log_debug("OK: entry has no $check token, so any value satisfies check $check");
> +                       }
> +                       elsif (defined $query->{$check}) {
>                                 log_debug("compare %s [%s] to [%s] (entry: %s)",
>                                           $check,
>                                           $entry->{$check},

Yeah, that makes sense to me (and is basically what the credential-cache
and credential-store helpers do internally). Thanks for working on this.

-Peff
