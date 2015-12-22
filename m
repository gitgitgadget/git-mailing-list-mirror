From: Dave Borowitz <dborowitz@google.com>
Subject: Re: Building Git with HTTPS support: avoiding libcurl?
Date: Tue, 22 Dec 2015 09:08:00 -0800
Message-ID: <CAD0k6qT+s4e_7y1DxVTN63V0tO_xFv-9i-Fmq5O0SrpQAyAzVA@mail.gmail.com>
References: <1450798780.11255.22.camel@mad-scientist.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: paul@mad-scientist.net
X-From: git-owner@vger.kernel.org Tue Dec 22 18:10:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBQRo-0000Y9-SQ
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 18:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555AbbLVRIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 12:08:24 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36129 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755551AbbLVRIV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 12:08:21 -0500
Received: by mail-ig0-f171.google.com with SMTP id ph11so64533245igc.1
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 09:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6NoodgqzjuUvCwbK086GBv0rEFCZb0WPgD4IGxccDvw=;
        b=XkuZXtg3ejHpETgXC7QeZoehF39rqxV//r3Qrb3Zn1ZAqKboSlYW2kDfNKxH76d0IV
         LcBKnOEDWCu/+sqhKOjHwwt9J5ZmLbO9UE+D0sW0PJhkHyO1Dwn5jyRDLBIEAzNyR5VU
         kMRxM3SaUN12JD71y7ZPFeodP1EkDL361zjn4AtC6YYJRvqwyR9uxLodQijAohoL1hSH
         flJC4gwaJGkD60QimtXmpBsZ+cYqRZ7IGYTHtZplI1dT5lgsgZ6LWCu5kWDWAoKPd+9g
         DoDgWde6rrht2Lvfz/KO7hO9X6xLZwfCcpF3kwA2zx1YqN4RgDCqh8LwikQA+lEKQlrx
         Uz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=6NoodgqzjuUvCwbK086GBv0rEFCZb0WPgD4IGxccDvw=;
        b=Vi+tR5pnzTVSOr8AtMlFpOH56/HRbaiZwqg3ds8g783q7QDjzl65CiWeQt5dIkzIWc
         cofVyFXQ2tPjd3Gq1DyxTd7fpClduRH+xO1PjBLxptwJJaW6Ls5Aza4LimnlDdlY9pRZ
         YRXj/9ex+gWPME9OPRk7Dtlabd3cn/SBoH1vwmeUT6mUWtrrMQJEuOomINaZiYyb5eEZ
         vYgJs/rjmvYEzyrqSPFomId1Srtw/dczB41WFKbA3AVoaTG6K47vI61pAjLxYtJbyO1F
         PFrksoPIhEcZWRkM84LCnC20VqPN62yrlDk8YVJV4LPxA+DUjgfv6kj8miucLLiEvMmQ
         +3vQ==
X-Gm-Message-State: ALoCoQlQetcZgWLmkHGGxrOLG7kKFypMoblGINhC/dN/PiQy2Rtz/Znqy24h6XaO855yXnum72GoVZPRAlHnAY4KAquqcJskWXRfVwuarPTpZvkGYt14tXQ=
X-Received: by 10.50.97.39 with SMTP id dx7mr24589586igb.19.1450804100230;
 Tue, 22 Dec 2015 09:08:20 -0800 (PST)
Received: by 10.36.122.193 with HTTP; Tue, 22 Dec 2015 09:08:00 -0800 (PST)
In-Reply-To: <1450798780.11255.22.camel@mad-scientist.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282888>

On Tue, Dec 22, 2015 at 7:39 AM, Paul Smith <paul@mad-scientist.net> wrote:
> I'm trying to build Git (2.6.4) on GNU/Linux, but without any
> requirements (other than basic libc etc.) on the local system.  This
> works fine except for one thing: git-remote-https.
>
> In order to build this I need to have libcurl, but libcurl is a MONSTER
> library with an enormous number of prerequisites (see below).

Well, IIUC one of the reasons for Git's fork-everything strategy is to
avoid having to dynamically link the core git binary against large
libraries like libcurl, so the dependency size has been taken into
account at least in that sense.

> Just wondering if anyone has considered an alternative to libcurl; maybe
> I'm wrong but it seems to me that HTTPS support for Git would require
> only a tiny fraction of the libcurl features and maybe there's an
> alternative available which would be more targeted?
>
> I realize this is not a short-term thing in that there won't be an API
> compatible library that can just be dropped in.  This is more a forward
> -looking question.  For now I'm looking to see if I can rebuild libcurl
> myself without most of these dependencies such as Kerberos, LDAP, etc.
>
>
> $ ldd /usr/lib/x86_64-linux-gnu/libcurl.so.4
>         linux-vdso.so.1 =>  (0x00007fff37d81000)
>         libidn.so.11 => /usr/lib/x86_64-linux-gnu/libidn.so.11 (0x00007f682b921000)
>         librtmp.so.1 => /usr/lib/x86_64-linux-gnu/librtmp.so.1 (0x00007f682b704000)
>         libssl.so.1.0.0 => /lib/x86_64-linux-gnu/libssl.so.1.0.0 (0x00007f682b49a000)
>         libcrypto.so.1.0.0 => /lib/x86_64-linux-gnu/libcrypto.so.1.0.0 (0x00007f682b058000)
>         libgssapi_krb5.so.2 => /usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2 (0x00007f682ae0e000)
>         liblber-2.4.so.2 => /usr/lib/x86_64-linux-gnu/liblber-2.4.so.2 (0x00007f682abfe000)
>         libldap_r-2.4.so.2 => /usr/lib/x86_64-linux-gnu/libldap_r-2.4.so.2 (0x00007f682a9ac000)
>         libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007f682a792000)
>         libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f682a573000)
>         libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f682a1a9000)
>         libgnutls-deb0.so.28 => /usr/lib/x86_64-linux-gnu/libgnutls-deb0.so.28 (0x00007f6829e8d000)
>         libhogweed.so.4 => /usr/lib/x86_64-linux-gnu/libhogweed.so.4 (0x00007f6829c59000)
>         libnettle.so.6 => /usr/lib/x86_64-linux-gnu/libnettle.so.6 (0x00007f6829a23000)
>         libgmp.so.10 => /usr/lib/x86_64-linux-gnu/libgmp.so.10 (0x00007f68297a3000)
>         libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f682959e000)
>         libkrb5.so.3 => /usr/lib/x86_64-linux-gnu/libkrb5.so.3 (0x00007f68292cc000)
>         libk5crypto.so.3 => /usr/lib/x86_64-linux-gnu/libk5crypto.so.3 (0x00007f682909d000)
>         libcom_err.so.2 => /lib/x86_64-linux-gnu/libcom_err.so.2 (0x00007f6828e98000)
>         libkrb5support.so.0 => /usr/lib/x86_64-linux-gnu/libkrb5support.so.0 (0x00007f6828c8d000)
>         libresolv.so.2 => /lib/x86_64-linux-gnu/libresolv.so.2 (0x00007f6828a71000)
>         libsasl2.so.2 => /usr/lib/x86_64-linux-gnu/libsasl2.so.2 (0x00007f6828855000)
>         libgssapi.so.3 => /usr/lib/x86_64-linux-gnu/libgssapi.so.3 (0x00007f6828615000)
>         /lib64/ld-linux-x86-64.so.2 (0x0000559b03259000)
>         libp11-kit.so.0 => /usr/lib/x86_64-linux-gnu/libp11-kit.so.0 (0x00007f68283b0000)
>         libtasn1.so.6 => /usr/lib/x86_64-linux-gnu/libtasn1.so.6 (0x00007f682819c000)
>         libkeyutils.so.1 => /lib/x86_64-linux-gnu/libkeyutils.so.1 (0x00007f6827f98000)
>         libheimntlm.so.0 => /usr/lib/x86_64-linux-gnu/libheimntlm.so.0 (0x00007f6827d8e000)
>         libkrb5.so.26 => /usr/lib/x86_64-linux-gnu/libkrb5.so.26 (0x00007f6827b04000)
>         libasn1.so.8 => /usr/lib/x86_64-linux-gnu/libasn1.so.8 (0x00007f6827861000)
>         libhcrypto.so.4 => /usr/lib/x86_64-linux-gnu/libhcrypto.so.4 (0x00007f682762d000)
>         libroken.so.18 => /usr/lib/x86_64-linux-gnu/libroken.so.18 (0x00007f6827418000)
>         libffi.so.6 => /usr/lib/x86_64-linux-gnu/libffi.so.6 (0x00007f6827210000)
>         libwind.so.0 => /usr/lib/x86_64-linux-gnu/libwind.so.0 (0x00007f6826fe6000)
>         libheimbase.so.1 => /usr/lib/x86_64-linux-gnu/libheimbase.so.1 (0x00007f6826dd7000)
>         libhx509.so.5 => /usr/lib/x86_64-linux-gnu/libhx509.so.5 (0x00007f6826b8c000)
>         libsqlite3.so.0 => /usr/lib/x86_64-linux-gnu/libsqlite3.so.0 (0x00007f68268be000)
>         libcrypt.so.1 => /lib/x86_64-linux-gnu/libcrypt.so.1 (0x00007f6826686000)

Maybe half of those dependencies are crypto libraries, so even if you
managed to eliminate libcurl, you'd have a hard time supporting HTTPS
without them. Or maybe use something like boringssl instead?
