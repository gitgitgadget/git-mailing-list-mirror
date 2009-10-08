From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] git-send-email.perl: Fold long header lines to 78 chars
Date: Wed, 07 Oct 2009 22:28:10 -0700
Message-ID: <1254979690.2056.103.camel@Joe-Laptop.home>
References: <1254759898.1799.449.camel@Joe-Laptop.home>
	 <7vd44yo4uz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 07:30:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mvlac-0008TN-2Z
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 07:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbZJHF2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 01:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753071AbZJHF2s
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 01:28:48 -0400
Received: from mail.perches.com ([173.55.12.10]:2000 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752917AbZJHF2r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 01:28:47 -0400
Received: from [192.168.1.152] (new-host.home [192.168.1.152])
	by mail.perches.com (Postfix) with ESMTP id 94D6E24368;
	Wed,  7 Oct 2009 22:28:00 -0700 (PDT)
In-Reply-To: <7vd44yo4uz.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129674>

On Wed, 2009-10-07 at 22:02 -0700, Junio C Hamano wrote:
> Joe Perches <joe@perches.com> writes:
> > Some MTAs reject or filter long header lines which can
> > be generated if the cc list is only a few entries.
> > Fold long header lines to 78 chars to be more rfc compliant.
> >
> > -	my $cc = join(", ", unique_email_list(@cc));

It's probably better/simpler to not use fold_header and
just do the same join as "my $to"

	my $cc = join(",\n\t", unique_email_list(@cc));

> >  		if ($smtp_server !~ m#^/#) {
> >  			print "Server: $smtp_server\n";
> >  			print "MAIL FROM:<$raw_from>\n";
> > -			print "RCPT TO:".join(',',(map { "<$_>" } @recipients))."\n";
> > +			print fold_header("RCPT TO:", ",", map { "<$_>" } @recipients)."\n";
> I do not think this hunk is correct.
> Shouldn't we be rather repeating "RCPT TO: " for each recipient, as
> RFC2821 4.1.1.3 says (this is an issue with the original code)?

Looks like you're right.

Want a new patch or will you fix both issues?

I suggest using the same join as "To:" for "Cc:" and
multiple single line "RCPT TO:"s.
