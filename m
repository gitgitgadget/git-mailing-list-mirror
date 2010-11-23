From: Scott Chacon <schacon@gmail.com>
Subject: Re: disabling PROPFIND when using smart http
Date: Tue, 23 Nov 2010 09:31:24 -0800
Message-ID: <AANLkTikoGS4X8YbNgLT=Akx5RBj2d4Uybdx5QnJ+CWNo@mail.gmail.com>
References: <AANLkTikwqtPDDk6i0nMKJiXn5cc3DmTGYp0==daX96yd@mail.gmail.com>
	<20101123161018.GB10420@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Nov 23 18:31:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKwiN-0003bQ-3Y
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 18:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755890Ab0KWRb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 12:31:29 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43105 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755780Ab0KWRb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 12:31:26 -0500
Received: by ewy5 with SMTP id 5so2584583ewy.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 09:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=xd87S4zxw6X0SwBMZq1YA2X+tIm+hkx7ucQm1rK9UA0=;
        b=r8p4uiH9f08Al/dNFf9k/CxYG+KfttkjSWPqEuyuGYGIZsFZkZvybkEQejTXItEqNr
         yZQLLO2Kz+9L0JAwHfNwjdl95wq0iscOiEgQzVHp3USO9F2Sjy6dqz0h9ZXJD+TCCCBt
         FNfB9fwdcD/iy9/68xuJYmc1+M4SNTl4sdX70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=TBiSRYMqPMyWQ5tkuip4IweE+hDTiBw6yr9bmEa1hF8pXq3F4n1laaLQRSmbg5tQb0
         VLozXn3QHhUU5009TIsVAu5sLtJjjDv4IY4EhBdBEjR0hypr8yn8zW+QE1zaH4qXfPl6
         WE93biTw4LV77GBedFVPvutoXEnPUY6JidEXU=
Received: by 10.14.37.10 with SMTP id x10mr5929241eea.6.1290533485007; Tue, 23
 Nov 2010 09:31:25 -0800 (PST)
Received: by 10.14.119.197 with HTTP; Tue, 23 Nov 2010 09:31:24 -0800 (PST)
In-Reply-To: <20101123161018.GB10420@LK-Perkele-V2.elisa-laajakaista.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161987>

Hey,

On Tue, Nov 23, 2010 at 8:10 AM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> Apparently pusher is falling back to dumb WebDAV push for some
> reason. And then failing because server does not support it
> or isn't configured apporiately for it.

Yes, the client will fall back to 'dumb' HTTP stuff if the server does
not respond properly to the initial /info/refs GET call.  I believe
it's something like if the client asks for

/info/refs?service=git-upload-pack

and the server does not respond with the first line being:

# service=git-upload-pack

or the Content-Type header being:

application/x-git-upload-pack-advertisement

I believe either of those being absent will cause the client to think
that it's not a smart server, so it falls back to the DAV based push.
If you let us know what the curl output before that point was, or what
your apache config looks like, we might be able to help figure out
what's wrong with the server.

I got these DAV fallbacks all the time when my proxy wasn't letting
the /info/refs calls through to Apache properly.

Scott
