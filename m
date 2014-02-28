From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Rewrite git-compat-util.h:skip_prefix() as a loop
Date: Fri, 28 Feb 2014 01:17:25 -0500
Message-ID: <20140228061725.GD32556@sigill.intra.peff.net>
References: <1393503197-29669-1-git-send-email-sunheehnus@gmail.com>
 <xmqqd2i8z6um.fsf@gitster.dls.corp.google.com>
 <87k3cg47o6.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Sun He <sunheehnus@gmail.com>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Feb 28 07:17:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJGlI-0008Jh-6U
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 07:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbaB1GR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 01:17:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:58484 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750740AbaB1GR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 01:17:27 -0500
Received: (qmail 8844 invoked by uid 102); 28 Feb 2014 06:17:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Feb 2014 00:17:27 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Feb 2014 01:17:25 -0500
Content-Disposition: inline
In-Reply-To: <87k3cg47o6.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242888>

On Thu, Feb 27, 2014 at 09:33:45PM +0100, David Kastrup wrote:

> >> diff --git a/git-compat-util.h b/git-compat-util.h
> >> index cbd86c3..4daa6cf 100644
> >> --- a/git-compat-util.h
> >> +++ b/git-compat-util.h
> >> @@ -357,8 +357,8 @@ extern int suffixcmp(const char *str, const char *suffix);
> >>  
> >>  static inline const char *skip_prefix(const char *str, const char *prefix)
> >>  {
> >> -	size_t len = strlen(prefix);
> >> -	return strncmp(str, prefix, len) ? NULL : str + len;
> >> +    while( *prefix != '\0' && *str++ == *prefix++ );
> >> +    return *prefix == '\0' ? str : NULL;
> >
> > Documentation/CodingGuidelines?
> 
> Mostly relevant for tabification here, not helping much otherwise.  In
> particular, does not contain the advice "empty statements should appear
> on a line of their own" which would help with readability here.

Also whitespace in the "while", which I could not find mentioned in
CodingGuidelines either. Maybe:

-- >8 --
Subject: [PATCH] CodingGuidelines: mention C whitespace rules

We are fairly consistent about these, so most are covered by
"follow existing style", but it doesn't hurt to be explicit.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/CodingGuidelines | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index ef67b53..ed432a8 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -126,6 +126,17 @@ For C programs:
    "char * string".  This makes it easier to understand code
    like "char *string, c;".
 
+ - Use whitespace around operators and keywords, but not inside
+   parentheses and not around functions. So:
+
+        while (condition)
+		func(bar + 1);
+
+   and not:
+
+        while( condition )
+		func (bar+1);
+
  - We avoid using braces unnecessarily.  I.e.
 
 	if (bla) {
-- 
1.8.5.2.500.g8060133
