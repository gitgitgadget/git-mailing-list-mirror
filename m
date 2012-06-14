From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/5] transport: unify ipv4 and ipv6 code paths
Date: Thu, 14 Jun 2012 00:02:03 -0500
Message-ID: <20120614050203.GE27586@burratino>
References: <20120308124857.GA7666@burratino>
 <CABPQNSb9EGOgHb7NtsEtDh2QkjkHYn7YemYsa8Yaqyuce-aDMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Eric Wong <normalperson@yhbt.net>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 07:02:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf2CF-00058b-0a
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 07:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375Ab2FNFCK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jun 2012 01:02:10 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54013 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818Ab2FNFCI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jun 2012 01:02:08 -0400
Received: by yenl2 with SMTP id l2so613944yen.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 22:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=K6eHtDg9Dva+WQ26lB2DN0XtB7aU0bV1KwhFmgjRqEU=;
        b=wq3+rck5gAIALQW+DKixN4gN5GQX1HkD6rY5gXL+I34AyFHMFnUYbOv8w9PPZvW2vv
         m3qAlpihy5Y+M8e7Nzk6Ax80Yn95aLtd3xFkfXlCO4pZ6LLDWiXkL/MNLBe+NKuNdGck
         lMvPeJWEW4PcWVc4R5LZxsPwjGR7HipQsx1K1HFHNR/Z1ARUzjlN6w+Jbezhm1M8FyhR
         BhH5cNI2EzxXrNN7iF5ZGy3fvS3In/ROpd/hMIXWJ0q3XRt3GypbSTDHGN8kbv305e0n
         7Wr4hRH9ZazE/WIn248Yqi6qNH9OdaIC6VNsLL3VSnonVh/DXY3OS0VG0DR5Pd+LdFTo
         72Ag==
Received: by 10.236.187.2 with SMTP id x2mr521448yhm.42.1339650127784;
        Wed, 13 Jun 2012 22:02:07 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id z42sm16901142yhd.1.2012.06.13.22.02.06
        (version=SSLv3 cipher=OTHER);
        Wed, 13 Jun 2012 22:02:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CABPQNSb9EGOgHb7NtsEtDh2QkjkHYn7YemYsa8Yaqyuce-aDMw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199968>

Erik Faye-Lund wrote:
> On Thu, Mar 8, 2012 at 1:48 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:

>> Patch 4 is the heart of the series. =C2=A0It provides an interface s=
imilar
>> to getaddrinfo that can be implemented on top of either gethostbynam=
e
>> or getaddrinfo and puts each implementation in a separate file. =C2=A0=
This
>> way, callers can just use the common API and they do not need to hav=
e
>> two copies of their code, one for each host resolution API.
[...]
> What happened to this series?

It seemed nice in principle, but if I understood correctly then the
API was too complicated for anyone but me to like it.  Instead of an
interface similar to getaddrinfo, it would probably be better to
implement an interface _identical_ to getaddrinfo for the the subset
of functionality that git uses.

See [1] for example for proof that that's possible.

I would make some different choices from Russ if doing it myself ---
e.g., I would want to unconditionally use

	#define getaddrinfo git_getaddrinfo

when NO_IPV6 is set so testing these code paths would be as simple as
enabling NO_IPV6, even on systems that also provide the modern API in
libc.

Hoping that clarifies,
Jonathan

[1] http://git.eyrie.org/?p=3Ddevel/rra-c-util.git;a=3Dtree;f=3Dportabl=
e
