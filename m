From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log --decorate: do not leak "commit" color into the next item
Date: Fri, 20 Feb 2015 15:06:39 -0800
Message-ID: <xmqqwq3cxjwg.fsf@gitster.dls.corp.google.com>
References: <xmqqzj8b0w6t.fsf@gitster.dls.corp.google.com>
	<xmqqpp9628tl.fsf@gitster.dls.corp.google.com>
	<20150218230728.GA17302@peff.net>
	<xmqqvbixzsnv.fsf@gitster.dls.corp.google.com>
	<20150220014230.GA16124@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 21 00:06:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOwel-0004zE-8J
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 00:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789AbbBTXGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 18:06:43 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55096 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754555AbbBTXGm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 18:06:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 60AD63A426;
	Fri, 20 Feb 2015 18:06:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8A6Io5Z/4eMkV5244KQ3ZoJ1QHU=; b=MJ9GEu
	fuBdRxAZs8EQQKsdl28ZeTMSOsengeqAQNofqiad+XlN1y0RuM+us1NwJkc7PCR7
	rsN2sYcT2pZ+rFQk7DgnRxnimhuohvFBaD4aLy5vhSR+qRPJ+F6kRzDNju6Noxa+
	8eVsN73T2Wx1NB2+i2bM7qxxdsHjZDgLuGzts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vifafd7Fj/b/ouG2vBBhu/Kd/NiShN51
	J2q6Gny8sZNmU8RcmGzXHN6PUMpRXi9oZtBro6sn+I25RpNqkWjr8sRE6Rzv8Y7v
	obyFcoIfJbBRFmPXTV6AIDCZ/I6qCLF9/6EnqxxBQ910wE2tWGp+OimrUdgIo1WU
	C4vtHmbF0rc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 57A453A424;
	Fri, 20 Feb 2015 18:06:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 97EB23A423;
	Fri, 20 Feb 2015 18:06:40 -0500 (EST)
In-Reply-To: <20150220014230.GA16124@peff.net> (Jeff King's message of "Thu,
	19 Feb 2015 20:42:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 21149306-B955-11E4-8BC8-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264195>

Jeff King <peff@peff.net> writes:

> I'd agree it is worth a mention in the log (and possibly release notes),
> but I don't think it is worth polluting the documentation forever
> (though explaining that we never inherit might be worth doing, and that
> is perhaps what you meant).

Yes, I do not know how well the attached will render, but something
along the lines of this patch is what I had in mind.

-- >8 --
Subject: config.txt: spell out how certain typed values are written

Many variables have values that are not arbitrary strings and there
are ways to spell these values of certain types.  The way to spell
colors was described in a section for color.branch.<slot> and other
variables refered to that section, which was technically wrong, but
was a bit awkward.

I didn't attempt to de-dup descriptions for boolean and integer
valued variables in this change, but somebody may want to read
the existing descriptions of these variables over and drop them
as necessary.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 58 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 097fdd4..171287e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -126,6 +126,45 @@ Example
 		path = foo ; expand "foo" relative to the current file
 		path = ~/foo ; expand "foo" in your $HOME directory
 
+Values
+~~~~~~
+
+Values of many variables are treated as a simple string, but there
+are variables that take values of specific types and there are rules
+as to how to spell them.
+
+boolean::
+	When a variable is said to take a boolean value, many
+	synonyms are accepted for 'true' and 'false'.
+	true;; Boolean true can be spelled as `yes`, `on`, `true`,
+	    or `1`.  Also, a variable defined without `= <value>`
+	    is taken as true.
+	false;; Boolean false can be spelled as `no`, `off`,
+	    `false`, or `0`.
+
+integer::
+	The value for many variables that specify various sizes can
+	be suffixed with `k`, `M`,... to mean "scale the number by
+	1024", "by 1024x1024", etc.
+
+color::
+	The value for a variables that takes a color is a list of
+	colors (at most two) and attributes (at most one), separated
+	by spaces.  The colors accepted are `normal`, `black`,
+	`red`, `green`, `yellow`, `blue`, `magenta`, `cyan` and
+	`white`; the attributes are `bold`, `dim`, `ul`, `blink` and
+	`reverse`.  The first color given is the foreground; the
+	second is the background.  The position of the attribute, if
+	any, doesn't matter.
++
+The attributes are meant to be reset at the beginning of each item
+in the colored output, so setting color.decorate.branch to `black`
+will paint that branch name in a plain `black`, even if the previous
+thing on the same output line (e.g. opening parenthesis before the
+list of branch names in `log --decorate` output) is set to be painted
+with `bold` or some other attribute.
+
+
 Variables
 ~~~~~~~~~
 
@@ -817,14 +856,6 @@ color.branch.<slot>::
 	`remote` (a remote-tracking branch in refs/remotes/),
 	`upstream` (upstream tracking branch), `plain` (other
 	refs).
-+
-The value for these configuration variables is a list of colors (at most
-two) and attributes (at most one), separated by spaces.  The colors
-accepted are `normal`, `black`, `red`, `green`, `yellow`, `blue`,
-`magenta`, `cyan` and `white`; the attributes are `bold`, `dim`, `ul`,
-`blink` and `reverse`.  The first color given is the foreground; the
-second is the background.  The position of the attribute, if any,
-doesn't matter.
 
 color.diff::
 	Whether to use ANSI escape sequences to add color to patches.
@@ -844,8 +875,7 @@ color.diff.<slot>::
 	of `plain` (context text), `meta` (metainformation), `frag`
 	(hunk header), 'func' (function in hunk header), `old` (removed lines),
 	`new` (added lines), `commit` (commit headers), or `whitespace`
-	(highlighting whitespace errors). The values of these variables may be
-	specified as in color.branch.<slot>.
+	(highlighting whitespace errors).
 
 color.decorate.<slot>::
 	Use customized color for 'git log --decorate' output.  `<slot>` is one
@@ -878,8 +908,6 @@ color.grep.<slot>::
 	separators between fields on a line (`:`, `-`, and `=`)
 	and between hunks (`--`)
 --
-+
-The values of these variables may be specified as in color.branch.<slot>.
 
 color.interactive::
 	When set to `always`, always use colors for interactive prompts
@@ -892,8 +920,7 @@ color.interactive.<slot>::
 	Use customized color for 'git add --interactive' and 'git clean
 	--interactive' output. `<slot>` may be `prompt`, `header`, `help`
 	or `error`, for four distinct types of normal output from
-	interactive commands.  The values of these variables may be
-	specified as in color.branch.<slot>.
+	interactive commands.
 
 color.pager::
 	A boolean to enable/disable colored output when the pager is in
@@ -919,8 +946,7 @@ color.status.<slot>::
 	`untracked` (files which are not tracked by Git),
 	`branch` (the current branch), or
 	`nobranch` (the color the 'no branch' warning is shown in, defaulting
-	to red). The values of these variables may be specified as in
-	color.branch.<slot>.
+	to red).
 
 color.ui::
 	This variable determines the default value for variables such
