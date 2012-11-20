From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: Failure to extra stable@vger.kernel.org addresses
Date: Tue, 20 Nov 2012 12:59:42 +0100
Message-ID: <20121120115942.GA6132@shrek.podlesie.net>
References: <20121119095747.GA13552@arwen.pp.htv.fi>
 <20121119151845.GA29678@shrek.podlesie.net>
 <7vk3thxuj2.fsf@alter.siamese.dyndns.org>
 <20121119225838.GA23412@shrek.podlesie.net>
 <CAMP44s0f0zYa1FVf9RhNuwYJbkQ7zPwgJ6=ty3c5knjo5a2TNw@mail.gmail.com>
 <7vlidxuowf.fsf@alter.siamese.dyndns.org>
 <20121120073100.GB7206@shrek.podlesie.net>
 <20121120075628.GA7159@shrek.podlesie.net>
 <CAMP44s38gTB_3Ao1rFZgMo2EAuiNb+h88-qRFcQPRMJNxo3CAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Felipe Balbi <balbi@ti.com>,
	git@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 13:00:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TamUi-00032W-FA
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 13:00:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181Ab2KTL7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 06:59:46 -0500
Received: from [93.179.225.50] ([93.179.225.50]:43561 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752616Ab2KTL7q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 06:59:46 -0500
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id 2528763D; Tue, 20 Nov 2012 12:59:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAMP44s38gTB_3Ao1rFZgMo2EAuiNb+h88-qRFcQPRMJNxo3CAQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210095>

On Tue, Nov 20, 2012 at 11:28:39AM +0100, Felipe Contreras wrote:
> On Tue, Nov 20, 2012 at 8:56 AM, Krzysztof Mazur <krzysiek@podlesie.net> wrote:
> 
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -925,8 +925,11 @@ sub quote_subject {
> >  sub sanitize_address {
> >         my ($recipient) = @_;
> >
> > +       my $local_part_regexp = qr/[^<>"\s@]+/;
> > +       my $domain_regexp = qr/[^.<>"\s@]+(?:\.[^.<>"\s@]+)+/;
> > +
> >         # remove garbage after email address
> > -       $recipient =~ s/(.*>).*$/$1/;
> > +       $recipient =~ s/^(.*?<$local_part_regexp\@$domain_regexp>).*/$1/;
> 
> I don't think all that extra complexity is warranted, to me
> s/(.*?>)(.*)$/$1/ is just fine.
> 

Yeah, it's a little bit too complex, but "s/(.*?>)(.*)$/$1/"
causes small regression - '>' character is no longer allowed
in "phrase" before "<email address>". Maybe the initial version,
that removes everything after last '>' is better? In this case '>'
is not allowed in garbage after email.

Krzysiek
