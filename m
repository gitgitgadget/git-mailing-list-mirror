From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Disable dumb HTTP fallback with GIT_CURL_FALLBACK=0
Date: Fri, 21 Sep 2012 07:19:50 -0700
Message-ID: <CAJo=hJs=Zm4BPm94-sNWDUNkg2vAReSsTmKnDVw+xOU9NWcfUQ@mail.gmail.com>
References: <1348109753-32388-1-git-send-email-spearce@spearce.org>
 <20120920034804.GA32313@sigill.intra.peff.net> <CAJo=hJvXtSBO3QEzhZCFfhk9OF_e0B10k8tjCUWMHZvGKt599Q@mail.gmail.com>
 <20120920172408.GC18655@sigill.intra.peff.net> <CAJo=hJvyEtTDVJ6+Gv1kgqs1=UQEVbLaSFMEmUmCX-JWRCrDxA@mail.gmail.com>
 <20120921052606.GA9659@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 21 16:20:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF45g-0004XI-AT
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 16:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530Ab2IUOUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 10:20:13 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:65071 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab2IUOUM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 10:20:12 -0400
Received: by qaas11 with SMTP id s11so1277235qaa.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 07:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CifgO2qpLnrSyY7zHDGCwyoCXccY5zFU2Lok2rNXwkA=;
        b=G0z3QxZICHSddgI4mOpiDCnj05UFlmBSRLZCfsZSpPsXVJBh3aLR3uyeHZbMvT546P
         D8dCr+/emL1Scsuyw3165TOcD8gf9zM+MYIaICLxVS8a9qtiPC7nAKt7uFW1xxyeD8Ym
         8P5IKQ2t4Ic+YNkzm+Oy1medYS9tVaA54wKm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=CifgO2qpLnrSyY7zHDGCwyoCXccY5zFU2Lok2rNXwkA=;
        b=JfgLXrCPkwNXHFfIKM5yVAjkrmn3rLF/jcpv/JlkIs5anVfS7Ay57TVdQkmDIeciVN
         7dgRmaJgAk7TmXE54CC8wxAn0F9iGYdU4k1BLh5h4P27VjZQozEx9c6qPkx+nXYvEYw8
         5tXmT3EtF4l4PHjZWXNNMZCoLvo8KvO7fDibLR0qF2AM9zqSn+y3ZgJ5SKBcfZ+onYP3
         AQe/G7QRdlklgWSg5BfRmCwG/og/TG8R9uSwBqbw/1XeBPw6OArL8Q/HcEakDaLzQpZf
         2qrWxZNaFkk+qVjsaokydhT1NQyC5bmb+MbcaTs/FuMFVcjg9TWdaQspcGUTKNOGJcVX
         0hsg==
Received: by 10.224.175.204 with SMTP id bb12mr12722830qab.14.1348237210973;
 Fri, 21 Sep 2012 07:20:10 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Fri, 21 Sep 2012 07:19:50 -0700 (PDT)
In-Reply-To: <20120921052606.GA9659@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQkEwlpbQn4+r5MFpqZxybcoKtFTWg7H+SzS900EcMSheNu5v0yS/DCH8UxCcJYvbwfUhvw+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206123>

On Thu, Sep 20, 2012 at 10:26 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Sep 20, 2012 at 04:05:03PM -0700, Shawn O. Pearce wrote:
>
>> But right now I am seeing failures in libcurl's SSL connection that
>> may also be causing the smart connection failures. For example this
>> trace, where libcurl was just not able to connect to respond to the
>> 401 with a password. I suspect what is happening is the SSL session
>> dropped out of cache on our servers, and libcurl couldn't reuse the
>> existing SSL session. Instead of discarding the bad session and
>> retrying, Git aborts. I'm willing to bet modern browsers just discard
>> the bad session and start a new one, because clients can't assume the
>> remote server will be able to remember their session forever.
>
> That's something I haven't seen. But then, I don't usually see the
> client side; I just see the fallback dumb fetch in our logs, and
> have occasionally followed up.

I hadn't seen this either until I deleted the fallback code from
remote-curl.c and ran git ls-remote in a while true loop for 6 hours.
Its obviously happening though.

> Is there a long pause while the user is typing their password?

No. The password comes off a credential helper that has access to it
from a credential store. There is very little lag here, under 100 ms.

>> * SSL re-using session ID
>> * Unknown SSL protocol error in connection to android.googlesource.com:443
>> * Expire cleared
>> * Closing connection #0
>> error: Unknown SSL protocol error in connection to
>> android.googlesource.com:443  while accessing
>> https://android.googlesource.com/a/platform/tools/build/info/refs?service=git-upload-pack
>> fatal: HTTP request failed
>
> You could try turning off CURLOPT_SSL_SESSIONID_CACHE and seeing if that
> improves it. Of course, it is probably hard to reproduce, so it would be
> tough to know if that helped or not. It would also be nice if you could
> dump more information on the error from the ssl library (I typically
> build curl against openssl; I wonder if it could be related to using
> gnutls or something).

This is OpenSSL, because I also always build against OpenSSL.  :-)

I'll try the CURLOPT_SSL_SESSIONID_CACHE today. It is hard to
reproduce, so not producing it doesn't necessarily mean it isn't still
there.
