From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 0/2] upload-archive security issues
Date: Tue, 15 Nov 2011 23:01:09 +0100
Message-ID: <CABPQNSZ71==pQvH9nTQ3rD6c1RJiLmkA+k_9KS=T45cQb+PTLA@mail.gmail.com>
References: <20111115214159.GA20457@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 15 23:01:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQR4k-000067-MG
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 23:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571Ab1KOWBv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Nov 2011 17:01:51 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:34206 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932535Ab1KOWBu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2011 17:01:50 -0500
Received: by pzk36 with SMTP id 36so16846939pzk.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 14:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=yhujBeBohjnE8a5Lzply+R1atSFjkqeLBE/WX96p4a0=;
        b=lfhDWCVmiC8jGveTGKnEmV9rVl2dickfD8uWNjBz14mDBfP3cMSs2w3ycqU18+Qbuv
         8MX73Hlzy4DBbZaMnSdrhdL4XnrWmIVzxjP3xY+6942ao+A3HfjRhoZibcnqzX6y+z54
         UTHkDMwFADiuUVVbdx11Uy1tdVKvRX94WTC9c=
Received: by 10.68.72.104 with SMTP id c8mr62857083pbv.34.1321394510054; Tue,
 15 Nov 2011 14:01:50 -0800 (PST)
Received: by 10.68.71.135 with HTTP; Tue, 15 Nov 2011 14:01:09 -0800 (PST)
In-Reply-To: <20111115214159.GA20457@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185493>

On Tue, Nov 15, 2011 at 10:42 PM, Jeff King <peff@peff.net> wrote:
> Looking at Erik's c09cd77e again, there are some serious security
> problems, in that we are too lenient with what gets passed to
> git-archive, which is not hardened to accept random client arguments.
> That lets a client do all sorts of nasty things like running arbitrar=
y
> code.
>
> These patches fix it by making cmd_archive handle the remote-request
> flag better. An alternative would be to pass only known-good options
> through upload-archive. That might be more future-proof, but also
> involves upload-archive knowing about the innards of write_archive an=
d
> its options. =A0See also the comments in patch 2/2 for another altern=
ative
> fix.
>
> =A0[1/2]: archive: don't allow negation of --remote-request
> =A0[2/2]: archive: limit ourselves during remote requests

Yikes! Perhaps the whole deal of rewriting the code to take explicit
file descriptors (and/or dup-bonanza) would have been the better
choice after all?

=46or the record: I would be fine with c09cd77e simply being reverted
for this release, and having a better version applied in the near
future. Windows support for upload-archive is not worth the risk of
slipping in a remote code execution bug...

>
> And yes, I feel like a moron for not noticing these problems during m=
y
> initial review.

Not only did you fail to spot them, you actually wrote that part of the=
 code ;)

http://article.gmane.org/gmane.comp.version-control.git/178098

(I don't mean to shift blame over to you, I'm the one who should have
spent more time thinking about this as this was "my" series)
