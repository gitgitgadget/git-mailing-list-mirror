From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Re: git-mailinfo '-u' argument should be default.
Date: Wed, 10 Jan 2007 07:49:04 +0800
Message-ID: <1168386544.14763.407.camel@shinybook.infradead.org>
References: <1147452362.2794.452.camel@pmac.infradead.org>
	 <1168351405.14763.347.camel@shinybook.infradead.org>
	 <7vzm8skphz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 00:48:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Qhp-0006uR-Vw
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 00:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbXAIXsg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 9 Jan 2007 18:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbXAIXsg
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 18:48:36 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51111 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932564AbXAIXsf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 18:48:35 -0500
Received: from [222.72.90.51] (helo=[192.168.0.4])
	by pentafluge.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1H4Qhj-0006DL-9D; Tue, 09 Jan 2007 23:48:33 +0000
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzm8skphz.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36431>

On Tue, 2007-01-09 at 10:46 -0800, Junio C Hamano wrote:
> I do not think you would want to make '-n' in the third point
> sound so negative=20

No, I really _do_ want that.

> and make people on projects that chose to use
> legacy encoding for whatever reasons feel _dirty_.=20

=2E.. but not that, because it wasn't aimed at them.

>  If the natural language in project's log is limited and a legacy
> encoding is sufficient, and if all the participants agree on a
> legacy encoding to use...
(...for git's own purely internal storage format).

That's not the use case for the -n option. Their case is what the
i18n.commitencoding configuration option exists for.

Although having said that, I don't actually know _why_ we let them
override the default, since it's _internal_ to git. As long as git
itself is correctly doing the conversion on the way in and out, there's
no reason for them to care whether we use UTF-8, UCS-4, EBCDIC or some
other arbitrary encoding (as long as our encoding can represent anythin=
g
they choose to throw at us).

>  because tools other than git they need to
> use are more convenient with the legacy encoding rather than
> UTF-8,

That makes about as much sense to me as letting them configure git to
store objects uncompressed "because tools other than git are more
convenient without compression".=20

If our choice of _internal_ storage affects their other tools, then
either they're doing something very strange like poking at git objects
directly, or there's a bug in the git tools.

>  there is no need to give a lecture to them saying they
> should switch to UTF-8 and/or what they have been doing is
> sub-par -- it isn't.=20

If people, for whatever reason, want git to use a given legacy characte=
r
set for its storage format, they just have to set i18n.commitencoding.
Those people aren't being lecture. (Although perhaps they _should_ be;
either they're poking at things which shouldn't concern them, or they
should be _reporting_ bugs instead of just working round them.)

The only people who would want the -n option would be those who _want_
to intentionally throw away the character set encoding, and have one
commit=C2=B9 in EBCDIC, a second in UTF-8 and a third in BIG5 with no w=
ay of
telling which is which; each of them _labelled_ with the default
encoding for the repository, which is probably UTF-8.

--=20
dwmw2

=C2=B9 Actually it's worse than that -- with RFC2047 you can have multi=
ple=20
encodings within the same _line_ of text. Evolution at least will do th=
at;
it uses ISO8859-1 for any character it can, and falls back to UTF-8 for
other characters. Even within the same header. Importing with '-n' woul=
d
just throw away the charset information and use the raw bytes. Even jus=
t=20
importing the RFC2047-encoded text as-is would be better than that.
