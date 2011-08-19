From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] git-send-email: Add AUTH LOGIN support
Date: Thu, 18 Aug 2011 18:16:25 -0700
Message-ID: <1313716585.11178.2.camel@Joe-Laptop>
References: <c1be0c3bd05779897fdc92907fe65d84c88ac72b.1312591104.git.joe@perches.com>
	 <7vzkjn16n6.fsf@alter.siamese.dyndns.org>
	 <1312608114.6419.18.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Graham Barr <gbarr@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 03:16:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuDhJ-0002Bw-7v
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 03:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995Ab1HSBQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 21:16:27 -0400
Received: from wondertoys-mx.wondertoys.net ([206.117.179.246]:51413 "EHLO
	labridge.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752830Ab1HSBQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 21:16:27 -0400
Received: from [173.60.85.8] (account joe@perches.com HELO [192.168.1.156])
  by labridge.com (CommuniGate Pro SMTP 5.0.14)
  with ESMTPA id 18035055; Thu, 18 Aug 2011 18:16:26 -0700
In-Reply-To: <1312608114.6419.18.camel@Joe-Laptop>
X-Mailer: Evolution 2.32.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179668>

On Fri, 2011-08-05 at 22:21 -0700, Joe Perches wrote:
> On Fri, 2011-08-05 at 21:54 -0700, Junio C Hamano wrote:
> > Joe Perches <joe@perches.com> writes:
> > > The current perl Net::SMTP support will not use AUTH LOGIN
> > > when other authentication options are available.
> > Even after reading this excuse,...
> > > +			if (defined $smtp_auth && $smtp_auth =~ /^login$/i) {
> > > +
> > > +			    $smtp->datasend("AUTH LOGIN\n");
> > > +			    $smtp->response();
> > > +			    $smtp->datasend(encode_base64("$smtp_authuser"));
> > > +			    $smtp->response();
> > > +			    $smtp->datasend(encode_base64("$smtp_authpass"));
> > > +			    $smtp->response();
> > > +
> > > +			} else {
> > > +
> > > +			    $auth ||= $smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
> > > +			}
> > ... this makes me feel dirty X-(. Not the desire to force "AUTH LOGIN",
> > but the implementation to hand-roll the protocol exchange.
> > I'd rather want to know _why_ Net::SMTP does not support it in the first
> > place, and what it does for "other authentication options" that are
> > available. Does it try them in turn until it finds the one that works? Why
> > doesn't it fall back on "AUTH LOGIN" then?
> > Specifically, if there is a reason to avoid this plaintext authentication
> > method when other options are _available_ (which presumably would be the
> > reason why Net::SMTP chooses not to support it), and if there is a reason
> > on the user's side to _force_ this method even when people who wrote
> > Net::SMTP does not recommend it be used, wouldn't it be natural to expect
> > that there should be a way to configure the connection to use it, without
> > resorting to coding the protocol exchange by hand line this?
> 
> I needed something now.
> 
> You are right but I believe it would take too long
> to get updates to Net::SMTP in place. Doing this
> admitted ugliness in git-send-email works for me and
> seems to me to be appropriate for now.
> 
> I looked, there isn't a method to force a particular
> AUTH type documented.  I also didn't care to rewrite
> Net::SMTP right now.  This "works for me"...
> 
> > It probably is not as simple as installing Authen::SASL::*::LOGIN, but
> > still...

I think my patch should be applied until Net::SMTP is updated.
