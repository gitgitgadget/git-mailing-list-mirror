From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 2/6] Gitweb: add support for minifying gitweb.css
Date: Wed, 14 Apr 2010 16:58:12 -0700
Message-ID: <7viq7tmvsb.fsf@alter.siamese.dyndns.org>
References: <4BB430C3.9030000@mailservices.uwaterloo.ca>
 <4BC4D3F0.5020107@hashpling.org> <201004140030.47222.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Charles Bailey <charles@hashpling.org>,
	Mark Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 01:58:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2CTW-00033H-PQ
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 01:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458Ab0DNX6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 19:58:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39824 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754965Ab0DNX6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 19:58:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B9ACFAAA40;
	Wed, 14 Apr 2010 19:58:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b7Hhj1LaJ0AfNS2Z5bTRTnXNp8Y=; b=MkMFmE
	sWXOb1ujK6sf9m1N3hijI81sqNOoag7HPv6m0Hvm5tyw9qG+rCoEGKgKpMppe3Z+
	lBNu3TOWJeV8tThPgueBRCLsOf/oxvX3gqBuXVLZjaPcnp3Pk+fRR9yGfIKkRb7J
	kGYthUIIsyCs4oPwnxc1zeuNV1xQIrqDUaCeo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gVsFpJgtLo1Ex8zT3nFXkOagWV5niVAe
	2NcKJMHoY6rdICQ8JMu1v0P1j+26RrnNFM3nZ3iZiKYaQTGb4MhJp/eBXDgOLzCy
	aJl4DnIHRe4yzcssx9OlggeGy5GBMKwGrSTZgLS++zUThxaplcJiCofVL4vh19VV
	RJtiPasNeG8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 73AF4AAA3C;
	Wed, 14 Apr 2010 19:58:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8377FAAA32; Wed, 14 Apr
 2010 19:58:13 -0400 (EDT)
In-Reply-To: <201004140030.47222.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed\, 14 Apr 2010 00\:30\:45 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 991E8DAC-4821-11DF-A3F5-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144925>

Jakub Narebski <jnareb@gmail.com> writes:

> On Tue, 13 April 2010, Charles Bailey wrote:
>> On 01/04/2010 06:36, Mark Rada wrote:
>> > @@ -84,13 +92,14 @@ endif
>> >
>> >   all:: gitweb.cgi
>> >
>> > +FILES = gitweb.cgi
>> >   ifdef JSMIN
>> > +FILES += gitweb.min.js
>> > +endif
>> > +ifdef CSSMIN
>> > +FILES += gitweb.min.css
>> > +endif
>> > +gitweb.cgi: gitweb.perl $(GITWEB_JS) $(GITWEB_CSS)
>
> GITWEB_JS and GITWEB_CSS were originally meant to be URI to file with
> gitweb JavaScript code and default gitweb stylesheet,... but during work
> on minification of JavaScript code and CSS file it somehow got confused
> to mean source path.

I am not touching instaweb part, but this would fix the build/clean side
of the things, no?

-- >8 --
gitweb: simplify gitweb.min.* generation and clean-up rules

GITWEB_CSS and GITWEB_JS are meant to be "what URI should the installed
cgi script use to refer to the stylesheet and JavaScript", never "this is
the name of the file we are building".

Lose incorrect assignment to them.

While we are at it, lose FILES that is used only for "clean" target in a
misguided way.  "make clean" should try to remove all the potential build
artifacts regardless of a minor configuration change.  Instead of trying
to remove only the build product "make clean" would have created if it
were run without "clean", explicitly list the three potential build
products for removal.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 gitweb/Makefile |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index ffee4bd..1787633 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -80,16 +80,7 @@ endif
 
 all:: gitweb.cgi
 
-FILES = gitweb.cgi
-ifdef JSMIN
-FILES += gitweb.min.js
-GITWEB_JS = gitweb.min.js
-endif
-ifdef CSSMIN
-FILES += gitweb.min.css
-GITWEB_CSS = gitweb.min.css
-endif
-gitweb.cgi: gitweb.perl $(GITWEB_JS) $(GITWEB_CSS)
+gitweb.cgi: gitweb.perl
 
 gitweb.cgi:
 	$(QUIET_GEN)$(RM) $@ $@+ && \
@@ -118,16 +109,18 @@ gitweb.cgi:
 	mv $@+ $@
 
 ifdef JSMIN
+all:: gitweb.min.js
 gitweb.min.js: gitweb.js
 	$(QUIET_GEN)$(JSMIN) <$< >$@
 endif # JSMIN
 
 ifdef CSSMIN
+all:: gitweb.min.css
 gitweb.min.css: gitweb.css
 	$(QUIET_GEN)$(CSSMIN) <$ >$@
 endif
 
 clean:
-	$(RM) $(FILES)
+	$(RM) gitweb.cgi gitweb.min.css gitweb.min.js
 
 .PHONY: all clean .FORCE-GIT-VERSION-FILE
