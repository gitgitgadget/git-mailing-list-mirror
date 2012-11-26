From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: [PATCH 5/5] git-send-email: allow edit invalid email address
Date: Tue, 27 Nov 2012 00:33:37 +0100
Message-ID: <20121126233337.GA31100@shrek.podlesie.net>
References: <7v8v9vrgc9.fsf@alter.siamese.dyndns.org>
 <1353607932-10436-1-git-send-email-krzysiek@podlesie.net>
 <1353607932-10436-5-git-send-email-krzysiek@podlesie.net>
 <7vobikthpp.fsf@alter.siamese.dyndns.org>
 <20121126173318.GA12101@shrek.podlesie.net>
 <7vhaocotsd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Felipe Balbi <balbi@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 00:33:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td8BX-000597-K8
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 00:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757409Ab2KZXdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 18:33:41 -0500
Received: from [93.179.225.50] ([93.179.225.50]:37094 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756408Ab2KZXdk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 18:33:40 -0500
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id 8566E638; Tue, 27 Nov 2012 00:33:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vhaocotsd.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210516>

On Mon, Nov 26, 2012 at 02:58:58PM -0800, Junio C Hamano wrote:
> Krzysztof Mazur <krzysiek@podlesie.net> writes:
> 
> >> Not having this new code inside "elsif (/^e/) { }" feels somewhat
> >> sloppy, even though it is not *too* bad.  Also do we know this
> >
> > ok, I will fix that.
> >
> >> function will never be used for addresses other than recipients' (I
> >> gave a cursory look to see what is done to the $sender and it does
> >> not seem to go through this function, tho)?
> >
> > Yes, this function is called only from validate_address_just()
> > to filter @initial_to, @initial_cc, @bcc_list as early as possible,
> > and filter @to and @cc added in each email.
> 
> Thanks; when merged to 'pu', this series seems to break t9001.  I'll
> push the result out with breakages but could you take a look?
> 

Sorry, I tested final version only on an ancient perl 5.8.8 and it really
worked there. The third patch is broken:

diff --git a/git-send-email.perl b/git-send-email.perl
index 9996735..f3bbc16 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1472,7 +1472,7 @@ sub unique_email_list {
 	my @emails;
 
 	foreach my $entry (@_) {
-		my $clean = extract_valid_address_or_die($entry))
+		my $clean = extract_valid_address_or_die($entry);
 		$seen{$clean} ||= 0;
 		next if $seen{$clean}++;
 		push @emails, $entry;

Krzysiek
