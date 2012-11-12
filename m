From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: "git imap-send" with HTML preformatting broken for multipart messages
Date: Mon, 12 Nov 2012 09:43:13 +0100
Message-ID: <50A0B6A1.80101@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git discussion list <git@vger.kernel.org>,
	Jeremy White <jwhite@codeweavers.com>,
	Mike McCormack <mike@codeweavers.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 09:43:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXpcC-0007j7-Kb
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 09:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413Ab2KLInS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 03:43:18 -0500
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:45910 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750852Ab2KLInS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Nov 2012 03:43:18 -0500
X-AuditID: 1207440e-b7f036d0000008b5-97-50a0b6a5c1cf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 49.45.02229.5A6B0A05; Mon, 12 Nov 2012 03:43:17 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qAC8hE39001034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 12 Nov 2012 03:43:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsUixO6iqLt024IAg0k3JS26rnQzWVw+OZfR
	4s6TVnYHZo8vVxuZPD5vkgtgiuK2SUosKQvOTM/Tt0vgzth+9ChbwR/Oio8rJzA1ME7k6GLk
	5JAQMJG4PGUfK4QtJnHh3nq2LkYuDiGBy4wS/+ecZ4ZwjjNJ9PaeA6viFdCUWL/oGRuIzSKg
	KrFv0Xcwm01AV2JRTzMTiC0qECaxZs8hJoh6QYmTM5+wgAwSEehllFh97jxYQljAT2LCx2Xs
	IDazgI7Eu74HzBC2vMT2t3OYJzDyzkLSPwtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm
	5aUW6Rrr5WaW6KWmlG5ihIQb3w7G9vUyhxgFOBiVeHg3OiwIEGJNLCuuzD3EKMnBpCTKK7sZ
	KMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEd5oIUI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEk
	NTs1tSC1CCYrw8GhJMG7YytQo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoyuKL
	gXEGkuIB2jsXpJ23uCAxFygK0XqK0Zjj6Ju5Dxk5PjbOe8goxJKXn5cqJc47HaRUAKQ0ozQP
	bhEs0bxiFAf6W5j3BkgVDzBJwc17BbSKCWhV45E5IKtKEhFSUg2MbcrmW7xe73Pf6H3lGe+N
	CC8rP5n7LfLXyz4oX7D3rHxwy3XV24BpU6rEe/mfPraXXhvkV7JqScLU7TEv5Nr2bWJrPxQl
	5X369ad8noDpTcfMl/ZX312+PLzGPmP+G+4CHxez5u3iL457RTpZ+p6NnTV/uZ7Z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209471>

I just noticed that "git imap-send" with imap.preformattedHTML turned on
is broken for multipart messages.  The problem is that "git imap-send"
embeds *everything* after the main email header in <pre></pre> and
HTML-escapes it, instead of splitting out the email parts and quoting
their bodies individually.

Ironically, the "git imap-send" manpage specifically lists the typical
usage as

    git format-patch --signoff --stdout --attach origin | git imap-send

which is broken if imap.preformattedHTML is set.

It seems to me that rather than fix "git imap-send" (which would require
it to become more complicated), it would be better to teach "git
format-patch" how to do preformatting and restrict "git imap-send" to
sending messages verbatim to an IMAP server.  Moving the functionality
to "git format-patch" would also make it possible to create preformatted
emails to be used with other transports.

Oh, and, by the way, "git imap-send" is utterly untested by the test
suite.  The fact that it is intrinsically hard to test without lots of
extra infrastructure is another argument for making it as stupid as
possible.

I don't plan to work on this.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
