From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Fri, 20 Sep 2013 08:21:04 +0200
Message-ID: <024f85fe-96e9-4201-8b3a-2e15c9da53e8@email.android.com>
References: <523094F0.9000509@gmail.com> <20130911182921.GE4326@google.com> <20130911191620.GB24251@sigill.intra.peff.net> <CAA01CsrN+VLw4WQmObvh72_MoH1Lyh9dQbizJcVhqyJoRyms-Q@mail.gmail.com> <CAPc5daVt4Q9twub5KyOQqZHx9CwOnkuwA97sXV44fF2j1e5HVg@mail.gmail.com> <CAA01CspCWFMGxXs9M3A1mtTctiUCCeJ9pJjHt=auMjhHHJU3Dg@mail.gmail.com> <20130919211659.GB16556@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junio@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 20 08:21:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMu5x-0006XK-0S
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 08:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764Ab3ITGVV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Sep 2013 02:21:21 -0400
Received: from mail-ea0-f177.google.com ([209.85.215.177]:59143 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266Ab3ITGVU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 02:21:20 -0400
Received: by mail-ea0-f177.google.com with SMTP id f15so3497eak.22
        for <git@vger.kernel.org>; Thu, 19 Sep 2013 23:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=DqjUzhEyQjCleKVGYIjNYUOVqwleOnmzrofZz4AnxNE=;
        b=R4ag0Q+Vy1dISRtKl0WgrAjUPgDOrAULV8CbNuYW+aAPks3jjuRwe9q0GriNjr2xZV
         lcKEgugRiiXGRJgcIoJX4aK14tkXSBCs04yAaxu0CniqzWr5sAXE6ku8ONAUAYma8Q8i
         zKHE7SXGm6zNYkTfckLr+WOWsoJhAeWposT2BmsEh0xuINceGmhkguLwWQgRer3/tHcG
         RINuy1o/9BxDo0AxbYxS367jbM5tZPJg0EoTdVBPHV1R431HymAhPx7zcHco7ca4ulOx
         OOLuBWeGJXGIj0isC/2sy5ST8sp8ePFOiZzHaI/Q5UBKpFUAZYvvN4Dcawb9di5naQOI
         VdOQ==
X-Received: by 10.15.111.132 with SMTP id cj4mr948587eeb.56.1379658079511;
        Thu, 19 Sep 2013 23:21:19 -0700 (PDT)
Received: from [100.98.118.35] ([46.77.124.35])
        by mx.google.com with ESMTPSA id r48sm16629282eev.14.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 19 Sep 2013 23:21:19 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <20130919211659.GB16556@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235060>

Jeff King <peff@peff.net> napisa=C5=82:
>On Thu, Sep 19, 2013 at 11:47:51AM +0200, Piotr Krukowiecki wrote:
>
>> >> > it still ends up as a single function call). The downside is
>that it has
>> >> > to be remembered at each site that uses strcasecmp, but we do
>not use
>> >> > pointers to standard library functions very often.
>> >>
>> >> Is it possible to add a test which fails if wrapper is not used?
>> >
>> > No test needed for this, as compilation or linkage will fail, I
>think.
>>=20
>> But only when someone compiles on MinGW, no?
>
>Yeah. I think a more clear way to phrase the question would be: is
>there
>some trick we can use to booby-trap strcasecmp as a function pointer s=
o
>that it fails to compile even on systems where it would otherwise work=
?
>
>I can't think off-hand of a way to do so using preprocessor tricks, an=
d
>even if we could, I suspect the result would end up quite ugly.=20

What I meant was: can we add a test (in t/) which greps git source code=
 and fails if it finds strcasecmp string?=20

It could count number of strcasecmp and expect to find only 1 or exclud=
e  known location of the wrapper.=20


--=20
Piotr Krukowiecki=20
