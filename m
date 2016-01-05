From: Mike McQuaid <mike@mikemcquaid.com>
Subject: Git 2.7.0 gitignore behaviour regression
Date: Tue, 5 Jan 2016 14:40:16 +0000
Message-ID: <4B0F686D-3DF9-4E5D-971D-DB106C6573FD@mikemcquaid.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 15:40:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGSmj-00033t-2s
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 15:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbcAEOkY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jan 2016 09:40:24 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35229 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbcAEOkT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jan 2016 09:40:19 -0500
Received: by mail-wm0-f51.google.com with SMTP id f206so25400407wmf.0
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 06:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mikemcquaid-com.20150623.gappssmtp.com; s=20150623;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=mJN5OqCK1p5PWIhzHfCZTyqNMfqzPb0b34Afl8Drpks=;
        b=kReHGTYsn8iVRTTBRP4etrfQJ+ur5XBaXoEEg7RWhv0bnXDQjzNBCdZ25IeIgvWuCi
         A1H2xcEHG21VtUGzEqczJJ6Idz/B8aJC/pDoD7m1nd8VdfePDO8/H85mtWfsHZIdQC74
         WEfNJVWH9Y1b/FsGrYaWX5v6Pj6P4BKMD3xYTB9YkbPwSQp2c4YCW/dHkkW5WtTW6vZN
         lXcAB8/yuoCMbxRp3Y7qRU4nlGr4Yts9yJ4wBfWyuEcjM+gIGvlY3CbGSFOp0ygeRiOX
         YcJ6KYvaCJWYsCjw5Meh8McXOoswDRjDNsgOenhwUf7MhACj04zeCUl+xKbDuT6jujSo
         KRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-type:content-transfer-encoding
         :subject:message-id:date:to:mime-version;
        bh=mJN5OqCK1p5PWIhzHfCZTyqNMfqzPb0b34Afl8Drpks=;
        b=fZxWagEVd0b1/9aPUZfDZYgzPrY+MXFSQpB6YxetK1M3NFm4FoCDDvN/WmnY+LnAj0
         1KmVR/8ztGb5cTTcQsSL7cx8TQ92kSIwVNS0gdZhSUtoq30UUXmABNdOjFl5TOMejVYu
         7SK0zZ68FclY66NizpF8A9jFnHA1IYpvj0AD7bApyMHiPPfyWhWOWKGNjmU1AU+53CjJ
         KXLX+6zpLcFl84VGj+tUd9O8pnPhEO++ptaLzHQy0w39fBXt+CTPimYUbitTSQDsI4a4
         M/CVE2E487EjsaNkrTx21yTCJxDvM6yMkZHjcY5WIPzqcZyjNb+Fb0t2UU5/wHwqUojw
         2fZQ==
X-Gm-Message-State: ALoCoQnrRZbJc+kF4QG/q1uvtuKhmvuJOmRraP45n1xVwAddR/2cJ2wXLZE693PMmGbx3vcnpfg1o1t+/Qaf7krhtIifpsCk1g==
X-Received: by 10.28.98.198 with SMTP id w189mr4265639wmb.39.1452004818396;
        Tue, 05 Jan 2016 06:40:18 -0800 (PST)
Received: from [10.0.0.14] (bcdc3f6a.skybroadband.com. [188.220.63.106])
        by smtp.gmail.com with ESMTPSA id w124sm3867392wmg.17.2016.01.05.06.40.17
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jan 2016 06:40:17 -0800 (PST)
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283378>

Hi folks,

=46irstly, thanks for all your hard work on Git. It makes my life much =
easier.

Homebrew has a series of convoluted .gitignore rules due to our special=
/weird use-case of wanting to ignore everything in a working directory =
except a select few files/directories. We experienced a bug with our .g=
itignore file for users using Git 2.7.0. This may well be a valid WONTF=
IX or intentional behaviour change but I wanted to flag it in case it w=
asn=E2=80=99t.

Here=E2=80=99s a minimal test case:

- Create an empty git repository in a directory with `git init`
- Create a directory named =E2=80=98a' containing a file named =E2=80=98=
b' with `mkdir a && touch a/b`
- Create a =E2=80=98gitignore=E2=80=99 file with the following contents=
:
```
*/
/a
!/a/*
```
- Run `git status --short`.

The output with Git 2.6.4 is:
```
?? .gitignore
```

The output with Git 2.7.0 is:
```
?? .gitignore
?? a/
```

Another minimal test case:

- Create an empty git repository in a directory with `git init`
- Create a directory named =E2=80=98a' containing a file named =E2=80=98=
b' with `mkdir a && touch a/b`
- Create a =E2=80=98gitignore=E2=80=99 file with the following contents=
:
```
*/
/a
!/a/
```
- Run `git status =E2=80=94short`.

The output with Git 2.6.4 is:
```
?? .gitignore
?? a/
```

The output with Git 2.7.0 is:
```
?? .gitignore
```

Let me know if you need any more information, thanks!

Mike McQuaid
http://mikemcquaid.com