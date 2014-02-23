From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Sun, 23 Feb 2014 09:44:14 +0700
Message-ID: <CACsJy8Aas3tRoDp9LQw7Nwf6+S3QnvwA7h7s-sHVY+1yFKhTYg@mail.gmail.com>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <5110BD18.3080608@alum.mit.edu> <20130205083327.GA4931@elie.Belkin>
 <5110DF1D.8010505@alum.mit.edu> <CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com>
 <7v4nhpckwd.fsf@alter.siamese.dyndns.org> <CACBZZX6xLvuMEhPnfYLj8W9pMLwdoS7Zb+mTtn+3DanJPiWfXw@mail.gmail.com>
 <7vmwvh9e3p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 23 03:45:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHP4F-0001FI-9N
	for gcvg-git-2@plane.gmane.org; Sun, 23 Feb 2014 03:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbaBWCos convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Feb 2014 21:44:48 -0500
Received: from mail-qa0-f54.google.com ([209.85.216.54]:52185 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbaBWCor convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Feb 2014 21:44:47 -0500
Received: by mail-qa0-f54.google.com with SMTP id i13so5042013qae.13
        for <git@vger.kernel.org>; Sat, 22 Feb 2014 18:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5qXusaYTasvHuv2UEQ4WzrVbjNkU3qFfrXHbOMRBJDI=;
        b=UYbpm2zFV/QvIc7TLPrSnn3OIeo6he5SlkiPbIYwt44jIesa1uLY0Pj7Mb6CagAXIs
         RAUAw2YlNCU9e2sAJRy9JPQxphLVtXfTbaMLPbSnreEnq5OMMpzdU30tX3XrNazNQ1FR
         9Dwf/AhjKoWb7RLART71wMu5u6S+4Z6o5UZUr/mCBGHn+9pxvAISN74x/qk+Xtl4J1rv
         wSUloZ3KXy+MExgi2KJSXDL9Pv2doZho35C0KJfi0vqhWi/MB3vn5i+qNSnVph4W2iO8
         SbyCRsZQLFVFcU2ViIhVNvDMO8S5kX6EtZD8LQDXawFiy0vJxKRImI+UcCEkufJ1mTjo
         8IkQ==
X-Received: by 10.224.26.71 with SMTP id d7mr20794642qac.89.1393123484407;
 Sat, 22 Feb 2014 18:44:44 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Sat, 22 Feb 2014 18:44:14 -0800 (PST)
In-Reply-To: <7vmwvh9e3p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242534>

(Digging up an old thread about initial refs listing in git protocol)

On Thu, Feb 7, 2013 at 7:12 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I think there's a simpler way to do this, which is that:
>>
>>  * New clients supporting v2 of the protocol send some piece of data
>>    that would break old servers.
>>
>>  * If that fails the new client goes "oh jeeze, I guess it's an old
>>    server", and try again with the old protocol.
>>
>>  * The client then saves a date (or the version the server gave us)
>>    indicating that it tried the new protocol on that remote, tries
>>    again sometime later.
>
> For that to work, the new server needs to wait for the client to
> speak first.  How would that server handle old clients who expect to
> be spoken first?  Wait with a read timeout (no timeout is the right
> timeout for everybody)?

I think the client always speaks first when it asks for a remote
service. Earlier in this thread you described the new protocol
upload-pack-2. Why can't it be a new service "upload-pack-2" in
git-daemon?

So new client will try requesting "upload-pack-2" service with client
capability advertisement before ref listing. Old servers do not
recognize this service and disconnect so the new client falls back to
the good old "upload-pack" (one more round trip though, but you could
configure new client to use old protocol for certain "old" hosts).
Similar thing happens for ssh transport. "upload-pack" service is
always there for old clients.
--=20
Duy
