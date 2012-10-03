From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: upload-pack is slow with lots of refs
Date: Wed, 3 Oct 2012 20:06:03 +0700
Message-ID: <CACsJy8DgM7ncbT8seUMLoPj=j8hFHCP6SvsDHu4P-YN2xfiNHg@mail.gmail.com>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 15:07:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJOfD-0004em-D6
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 15:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057Ab2JCNGf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2012 09:06:35 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:51347 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755052Ab2JCNGe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Oct 2012 09:06:34 -0400
Received: by qaas11 with SMTP id s11so1440807qaa.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 06:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=p5IcDOhIEsIrRWl5Idvg3GJXOJYvUrHmqXWoAmeFY3E=;
        b=BTXt+/71jc7S02m1o/pe5r3boQJ7h1n9waMfu/hfpA7yz8XCw53Bzp52HccI36GKyU
         iSuXDQe7haXkeLzGi2u0Hp9sjkoFiQEXbGeeHFB2svOa7a2xzJqsftti/6kzhiW8Kb80
         NRPd/3oYGMjSVvLmbUQypzz2R51ZNu4QPaD98lS6nmfsrvgO9KA2fRmzG0Pxygf6sj9z
         LkD7u7cEJTKtLATFZvadHG1YVXVY5RMgCLqQ7+aOVbQVSFVtANDPD5nRDsQPCKwzYu+L
         5XIu0hJZ+/QUfRRINcE0c+BAIwjTe5Aav+8xBzWmqJ8ZbX6cjlLrN5G4o01e5UQmVAie
         WieQ==
Received: by 10.229.201.198 with SMTP id fb6mr759678qcb.129.1349269593898;
 Wed, 03 Oct 2012 06:06:33 -0700 (PDT)
Received: by 10.49.72.201 with HTTP; Wed, 3 Oct 2012 06:06:03 -0700 (PDT)
In-Reply-To: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206889>

On Wed, Oct 3, 2012 at 7:36 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> I'm creating a system where a lot of remotes constantly fetch from a
> central repository for deployment purposes, but I've noticed that eve=
n
> with a remote.$name.fetch configuration to only get certain refs a
> "git fetch" will still call git-upload pack which will provide a list
> of all references.
>
> This is being done against a repository with tens of thousands of ref=
s
> (it has a tag for each deployment), so it ends up burning a lot of CP=
U
> time on the uploader/receiver side.

If all refs are packed, will it still burn lots of CPU on server side?

> Has there been any work on extending the protocol so that the client
> tells the server what refs it's interested in?

It'll be a new protocol, not an extension for git protocol. Ref
advertising is step 1. Capababilities are advertised much later. The
client has to time to tell the server what protocol version it likes
to use for step 1. (I looked at this protcol extension from a
different angle. I wanted to compress the ref list for git protocol.
But git over http compresses well so I don't care much.)

On that git-over-http, I don't know, maybe git client can send
something as http headers, which are recognized by the server end, to
negotiate interested ref patterns?
--=20
Duy
