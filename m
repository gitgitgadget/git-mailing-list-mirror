From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: git imap-send converting my patches to CRLF line endings?
Date: Fri, 17 Jun 2011 11:54:19 -0500
Message-ID: <tJkMDtbNwQ8q_53P87PeL5TSZPj2DgHxteCyO4IoGfk@cipher.nrlssc.navy.mil>
References: <BANLkTimXQQX_Fu0fgtWneF2cCLUZFhTaCg@mail.gmail.com> <20110617141450.GA12114@sigill.intra.peff.net> <BANLkTin1DAv0pZmZCcrtDyjrUD-ukO6MNQ@mail.gmail.com> <Svak9atXpisIKwqaYKGMzry3LEHEDPnWLLqFpfgP7IOuAVUdRy8brA@cipher.nrlssc.navy.mil> <Oe8m5NtYZicsi6Z4FtNIXAfsB9Q9XcHSsoAYmKdxQkoDVJOKykQTEg@cipher.nrlssc.navy.mil> <20110617155031.GA24009@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael Mc Donnell <michael@mcdonnell.dk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 17 18:54:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXcJa-00035t-GI
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 18:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757321Ab1FQQyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jun 2011 12:54:33 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:56415 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356Ab1FQQyc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2011 12:54:32 -0400
Received: by mail.nrlssc.navy.mil id p5HGsIEY013444; Fri, 17 Jun 2011 11:54:18 -0500
In-Reply-To: <20110617155031.GA24009@sigill.intra.peff.net>
X-OriginalArrivalTime: 17 Jun 2011 16:54:19.0456 (UTC) FILETIME=[33410400:01CC2D0F]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175956>

On 06/17/2011 10:50 AM, Jeff King wrote:
> On Fri, Jun 17, 2011 at 10:37:54AM -0500, Brandon Casey wrote:
> 
>>>> $ git format-patch --stdout --keep-subject --attach origin | git imap-send
>>
>> Wait a second.  You used --attach.
>>
>>>> 2. Open Gmail in Chrome.
>>>> 3. Open email in drafts folder.
>>>> 4. Click attachment download link
>>
>> Then you downloaded the attachment, which should be a _patch_.
> 
> Yeah, but if it is text/*,

It is.

> then according to rfc2046, it must be
> represented with CRLF as the line break. And especially if we are
> including it unencoded in a message, it is going to need CR's added.
> 
>>>> 5. Apply patch on a fresh branch with git apply.
>>
>> Well, scratch what I said before, you were correct in using
>> git apply.
>>
>> Shouldn't the attachment have it's content preserved exactly?  Maybe
>> the fault does belong to gmail.
> 
> Is it gmail's fault, or the browser's?  If gmail is handing back a
> text/* content-type, then my reading of rfc2046 is that it should have
> CRLF line breaks.  And it would be the browser's responsibility to
> convert to native line endings.  But that's the MIME spec, and was
> written with mail in mind; I don't know what's normal for HTTP in these
> situations. But if the problem is not "strip CR" but "convert to native
> line endings" (which I think it is), then how could gmail know the
> user's native line ending preference, anyway?

So it's the same issue of line ending ambiguity that affects patches
sent inline in the body of the email message.  What we really want
is the _original_ line ending, not necessarily the native line ending
of the platform, but since any text/* content returned from or sent
to the mail server must have CRLF line endings, it is impossible to
determine whether or not the original content really had LF line
endings or not.  Currently, mailsplit chooses to assume the original
line ending was LF, based on the assumption that that's the line
ending that most projects use.

There doesn't seem to be any advantage to using --attach then, over
just including the patch inline.  Maybe attachments should always be
base64 encoded?  I get the eerie feeling that this topic has already
been hashed to death.

-Brandon
