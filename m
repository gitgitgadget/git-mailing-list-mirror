From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v2 0/5] New hash table implementation
Date: Thu, 26 Sep 2013 16:38:12 +0200
Message-ID: <524446D4.3010006@gmail.com>
References: <522FAAC4.2080601@gmail.com> <52416058.90008@gmail.com> <CALUzUxqX=zgkQg84jYQABKa=Lq=7BUee6824H+Xfye4XBnUZqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 26 16:38:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPCht-0008L2-10
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 16:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211Ab3IZOiN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Sep 2013 10:38:13 -0400
Received: from mail-ee0-f41.google.com ([74.125.83.41]:58169 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab3IZOiM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 10:38:12 -0400
Received: by mail-ee0-f41.google.com with SMTP id d17so606444eek.0
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=NDKyjJ6VJpbb8nqd1/IewGSyX//DaDL+tVOYw3KGYIY=;
        b=ztKciN8FtPKJ/gCxqKbj0lBwbaLaY3qx/Jf5Kw8f8bGaKBe2yNpJGHXb/Wvyh2/YRR
         gwlbK+uwgGHGzjHgBxx5nTF1VrZ3MvvFGTtkW+Akxm+96dvP6fS9E1BCCaTRvpKFbs8D
         CVeZx9r9oBuB7H3HTWfRdjBa8W4jsKKPV0AOZuuKYQf1+GHKM0Z1h1vSCGE9ziserody
         48kigKWryTE7MplzJbjB/RkD+gap7TQbtQ0JsOqmgR6u8o7ae7sUTT/XpVNUCqpPTPGA
         ogXvY4sykEy5tUk+VevYDWQyoh2xaZh48YZusq+XMWEiHNMSdeR+gQ+yf0upRByZ0PmP
         z7WQ==
X-Received: by 10.15.74.197 with SMTP id j45mr1839905eey.40.1380206291456;
        Thu, 26 Sep 2013 07:38:11 -0700 (PDT)
Received: from [10.1.100.53] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id z12sm4733650eev.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 26 Sep 2013 07:38:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <CALUzUxqX=zgkQg84jYQABKa=Lq=7BUee6824H+Xfye4XBnUZqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235420>

Am 24.09.2013 13:16, schrieb Tay Ray Chuan:
> Hi Karsten,
>=20
> On Tue, Sep 24, 2013 at 5:50 PM, Karsten Blees <karsten.blees@gmail.c=
om> wrote:
>>
>>         |       add        |  get 100% hits  |    get 10% hits
>>         |  hash  | hashmap | hash  | hashmap |  hash   | hashmap
>> --------+--------+---------+-------+---------+---------+--------
>> FNV     | 14.815 |   2.345 | 3.059 |   1.642 |   4.085 |   0.976
>> FNV  x2 | 14.409 |   2.706 | 2.888 |   1.959 |   3.905 |   1.393
>> i       |  7.432 |   1.593 | 1.364 |   1.142 | 413.023 |   0.589
>> i    x2 |  9.169 |   1.866 | 1.427 |   1.163 |   0.757 |   0.670
>> i/10    |  1.800 |   1.555 | 5.365 |   6.465 |  32.918 |   1.052
>> i/10 x2 |  1.892 |   1.555 | 5.386 |   6.474 |   1.123 |   1.206
>>
>> Tests can be reproduced with 'time echo "perfhash[map] <method> 1000=
" | ./test-hashmap', see test-hashmap.c for definition of method flags.
>=20
> I'm not sure if I'm reading the numbers right, but they look impressi=
ve!
>=20

The numbers are for 100 million additions / lookups (1,000 rounds =E1 1=
00,000 entries). Considering everything else that happens in git, the h=
ash table performance should be insignificant, though.

> If it's not too much trouble, could you put together an API document,
> along the lines of Documentation/technical/api-hash.txt?

Yes, I had already planned to port the documentation to asciidoc. Altho=
ugh in my experience, API documentation in the header file tends to bet=
ter stay in sync with code changes (but this only makes real sense with=
 extraction tools such as doxygen).

> I could give
> a stab at replacing patience and histogram diff's hash implementation
> with yours.
>=20

Open addressing (i.e. distributing conflicting entries to other buckes)=
 *may* be faster *if* all data fits into the table (i.e. no pointers to=
 the data are used). Scanning such a table (without following pointers)=
 has very high locality and thus may benefit from accessing fewer CPU c=
ache lines. The patience implementation seems to fall into this categor=
y (although the entry struct is fairly large, and it also uses the *2 t=
rick to defeat bad hash codes (which wouldn't be necessary with chainin=
g)).

Both patience and histogram use preallocated, fixed-size hash tables, a=
nd thus won't benefit from faster inserts (the 'add' performance number=
s are for dynamically resized hash tables).

So, converting patience/histogram is probably not worth the trouble for=
 performance reasons alone. If it also simplifies the algorithms and/or=
 reduces memory usage - fine.

Ciao,
Karsten
