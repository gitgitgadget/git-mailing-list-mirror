Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2D52FB0B4
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894017; cv=none; b=Gs76n7lRm9Np1UDKW3eEX5lVtsXagE+VnYIn/vMvGQMTaC7OX59b34izd7uL0gRo7G3tPs2D9KQSL2GlO+rjuGFktgx956EFPSSxSeAZIdblFTj7nlBWe52RjVIbrynf/Jm2bbKrRryIuSRXJ3vMq6jB+YSkF5iVG54J1Lv/oxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894017; c=relaxed/simple;
	bh=ob+rI+rG2sk00VopvfhlfqrB42SwS+mjV/GK+fWj0nw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mKCLxedxWqRHcvppPCxkpWd8s4coWhwNPFTFXzP70/r+R1b94X49lfUYjiYF/VFAYLgOJoBfpBohm5EM7a2DgEN5qAmmUBtR33NrRQ1qvZpV+uCOjrwO51sdESHA4dqS9yuUoHmZ/VqTkCaVbCRBkgv8G8XYfwP3b+6LlOTV7Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=a8LtkMhJ; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="a8LtkMhJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767894012; x=1768498812; i=tboegi@web.de;
	bh=rZ8uHECcwrNVTcy78utj0abAfQ93M/k/zGyvJ4RNwIo=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=a8LtkMhJngCsDmS13ioyUoU9Z64Rc91EwACez1w0jFbhWeO131S0Oj3UloBXkjxE
	 y+xnCFA8Kqxz/6IHXkeUddwmacNZx1lywt5e8Bllkc0JRLpY5CluOZZheo1I+L+X5
	 m29jHLRgsIcWF/I/vs5WvC/buVquNaCgwrxbzw+eVK7bSnrHg63qGifm/esBYg4VP
	 eyk6aHug5AF7E+dxqkL0iPchm/dSTCH/bMfEcqT09mDYT6XACeztVmBX2macr1EJ3
	 Sdqtob0OzuWF69GIuNdZ9stFQKk58k9YCJKj/Xt2Q4mX7Aki+2zy1LyDDAhJYwYdk
	 OWtZZuqKzoDiSVkfIw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from susi ([81.224.105.209]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLifk-1vMEaC3JfU-00JET9; Thu, 08
 Jan 2026 18:40:12 +0100
From: tboegi@web.de
To: tboegi@web.de,
	git@vger.kernel.org,
	l.s.r@web.de
Subject: [PATCH v1 1/2] utf8.c: Prepare workaround for iconv under macOS 14/15
Date: Thu,  8 Jan 2026 18:40:11 +0100
Message-ID: <20260108174011.471692-1-tboegi@web.de>
X-Mailer: git-send-email 2.50.0.rc0.46.g7014b55638.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L8cW6ukjcf+fhXWW+wZkZKLr+dl4a+O2W/l8gcD688Jzm4RHmnu
 Q+UvE0B3dkzC7XlHqWmsupvIq16PB+tKu6P0a1j5Al7BiMQMq3He+r/ylTUdrP4EDb/XNKS
 zda/xSULidJTaDIVLh219ksHOxQMM69X+Vr01VZYPx6XC6LMZw4wqDZUDrbvIDCgDJigANF
 Q/jBdRMBHWviIr63G0kYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s/z5SlisttI=;E+xCi+iz0DydvTK0tUpgpApELe+
 qKo7UvQKJryVGKp5MGgQeNfwqKTNYIdOQ87QnfbYopan2GfwMuiW0QDIS8xjUWnClDdJBzIfQ
 kv4vcitTiNbil8okGB+RwIVXg4Z6VPdEZM3VLkeAIYkjadURsJCc8l9d69teP+C4YujnHyZLb
 6KJNWjHMBzvatxe/8cSfGmpX8bCNF9kI8RVv3X9GOwUjawUKA4EJg22YLdH9YbAnLUEjbMs1D
 SGTb9+6pLdlQOcp11xkCtSVeJGh/zpzhH1M68Y0jwDMLbZo9pO8e8NgeUFUH4o/anfIPEhOdw
 t4UdbBqIJZsuKSaR7rBb0ICctGjxmwUH66v+PRqdug6BL5maBrKr0zpAP2P7cV1FbtlCVD4kZ
 +2oLowykfAoA6EG+R3rwD64jzXPPUpOu60WzA7EDdSc8KSzVm2Qa/GuL+DhNzGyWADg+BJj7E
 XeQk2ivLejQiHtvpq5Rq+udyp337W2iLB+LSB1LOrcBTkHhl3arDRebJ9TMxwVaIjPcosBb5Y
 9c5tfJ3sPtj5Cs/2y9vys/Yd6v4yTpmZadkTxelgXycSzWehB5gJCQpRQ3r9rXavLDEwhyMpY
 VrS6xPkTEy7autmV9BhB5MLKvbCd99/hdROo1hfPBJGxw71c1ymY7ucZlnCab9Rd8ma12nnQs
 WgS4JtVl8nOJmTwRCLt4qrRuJboMYsFGKNu00HCTVaAcwfkFgVfkBLJBOiIS3gPTf75opMQYJ
 woWS+K8A+/TfsOXE2SKXAXcKTKhKyEvqie6VZQxW5S4TCfmNiZ6ZwZacVBpmEUa9mlQvilnsZ
 PZTsq3ILzUCqp8bdvdkCLpPkbjNckFyeWsGFRNgx3BZHayhPaUSNZ2tPiQ65+AOPUyP8/IF7x
 WNoUZDy4aPXnqgglppAPp6OcpYylg1Hk70b8/wHEVYlx9cJEmzw34rPo++CVssjo0aZIe9trq
 9laeeM49kMb8WdKP41Af+AKWwSzpXCskXNayaqkb9c79FvZ+zUT4JouliizEFfkonx3MGaaHx
 cBFQn/jZCXDwjldFdvyozUJSGbIqRDNYioZN23i8B4Qt95iX0abRMehBz0HA1gvRVEkQGaGNT
 js7Rwtt0tPDZrKOjsZo6n21PhgOTO7N08MomsRl4Y3h5/pmeCLDe9WAyLcopwsMPHdiSXrF1z
 Ksb8zXiAk6sCY6MVJTWoFNfaZlb3uMVnrzhxyZD84d32X+XKn9PGbA+7IrPiDxhej5cfZUnnn
 g91a3uglptxAE7MlxGZBE6Rqkx2FSmU1z6aJZqBk0JS7rg1o6sylwoTI+saWdo8Eabpm9iQeH
 1fFHrsa6B8gB1WM3DALnREGR+yvyNpXadJqDNjv4AYuFz9pxSRJd+UxxFOOXOT3qHqc2Q2+zt
 hQAfxTBkdWDtTkjhMOkT4R26EtKRzzIkEcbEpYaQrUdklqi7GT4fCI6dM1wVQfbZL5xU5YDbI
 X07yUTXyrCC/JFeyq+t2RYtXsvvo/C550MbIg+GRMxomu9XXgGAuwoK81AJhyD1GZnRRzA4af
 CelP2EQdaEEu1ZFblxaAESsUix2giIjTL3M+tZuBgdNhTe9ZYFBRD8ZZ53+v+Z+xKg1wb3cdF
 dFLytVV9vLP78GgRmvD0rKkXpm/3IIqj4WMSd0FHhAmIstSj7IN7sAmoenCP+5V6rgrvBZbb0
 fJzdgzzcasRewwtgFNeukoVaN85xcXBNJ56fe1aiDEbwAc8kYgDzusBKqmlP2n/ttP5Cs9rnc
 BCE8PFnBwKEZFjaFGAHS7Q4RzSEYU+Tk4vVySi1/PYj6Be0O/CnpGya0k9IIP9ixCbTjytw9o
 N+GigplPodQQD75e1wJsZ4/1687xQAaEyByy3bDw10OnZrurTBpVVzofaPz0/OKsY1vol1ugM
 Rf1xniu60p8NDE7XHq8NaIIAWeZAhjepGQL7Mlkt4LZ5DhiUcw0r5vYL6ff4Bwnj6tLuQnL7a
 59YgFuGhYz//SW2WCQxu68RGHZFgvvGZV2HAxtjndL2deVTC3CU+uy/9fY3BHoT9dIFDvHqpz
 DmNFE/2zZrxbqAPTA4srqUSxStv8mgH7nhfveLcJvyK0nDj5U8oYUGEvEppUpTfcioXhoQdq4
 fsNVITy/m2zTUW7NMJl/341HaXAsPlqNGWRasq9J3M5XQ5jQdRfgPamyCKI74rV2cUFAJuZfU
 pOUsSBstkhku74dB6BdtgwXvJlgEVN8nB+RQVcltXq1smJBTc/R/0+znPfM6LILCLiZvxkJsK
 7Ul2NaFh1deL0BzN+uXDQC0MKnOgTn9d8sXi3za04K8bbX2qQzNKSegkenzVc/fr0SaJQz1oE
 xZfxDGWALZJnGewqSWRq1x5SPi0PU76h4SMIv/E23d27UeAEDcWgEXN5jm45lS2Bgbn1nB2Qi
 Uc9i4MsiSvK9jFeS75eDH6m9XJDfBHanEl+6HR0yy4vB8ZYo7nG7eEZnueHcWYvSo1/pG7zp7
 3jff8WAPrNRLUyItF2t0kAkUT9VpT45Jy1KXqd1OnmXya4USe3meEJgHNPrYlzsPbBe7HZ/DI
 LswLcxrhU7hL4t68DHlgzzm9HoYtaxRYhCcxCD2xUB5M+hSrmfKs8dHcgd+nfRjVyh2fvAfDh
 zDSa7qhSYkbFbOL2eeIdvvnh9JNB2XUUQMQ5BUPITF+W2U8sWP359b4O1yp8tV1yPOt0B8xqE
 8JjhYq16ALI7slI/ML8wuFFfF3Tn1XHbyOhNLro3j/lVWRK95xqjvE9GrPwwlCuVcGzC/HhPZ
 eXL4TqA1hsTspXnZeYPhblPFXzDvUWsvC4I/Hc/sB4/28HctyuAzlhI/hcmi7WPUX0Gpqzf/l
 VTGA2ED1hce/jh/RIlxEkfVHFNOnzJSvf4vPJSsoaBfzmXZkLSZzHvz8Ym7lv/a7r+hm0k6ut
 SgpT+3vqru/rRNoDoqgG63L8BakUtW9pTHrbJMX4bZYT3eZLS0Ztd8bndjVaBZ1D+VEcZygQH
 lvooMmJZQpN1HOvjPzaALGvdTzKr8RAcLo7XkC5lsMOKX1UEqig5hEMYZ7lHHij1rZ/dijn3k
 fnTcuwpY4iopqCur1kAo3KsXyqcKcOs+IUaY9bwhA94jABlPn/CJPnRKTtWbh73A0s6+sK9ZK
 SfZ1iL/XrFZPFKSLJTo29AzvRyQa0q5+zzKuOxor/zfwdSm7lqWg3u7tzs4pd4/YIrZNIpcbt
 vbspyX5smE6+kzaPZdgR5nY+Tdno/XDdSMNrNkb42WC+zQ87JnI8lwGsKnnzapFrqMNaL9onW
 8mNJTELRExKhA1TVzAqRSs4LOFywInohtBRX+emtG55gw9ZqVLvhO8drp3jcpzuuj71xhrC4T
 9HNDU4wu6Ql3i2ca9Ul9M8yDtO6wzktb6KtRpCwXltXJJfS/WFqAI2FR90+OX0U8t0JWEZJ2o
 W945L+wYhYGUbl7HoNUilQRKHRvvFS3ARXDNSB0buo6sIPtc9o3iX/t+RocetJ+z7cN+UdGEU
 R55IOVT4D0uP9MHixdkXvpAVW+bBkIlrMLgkzqagGqEcpxavinMCsWfHuoLelyDWy7jaZxzOH
 YOvMMaF/A+Y4ptObIREABvrO6ixoKqyH3OyehDe4qE5kTu5SC/xo2n0EO8mb4s7DwcLnxUWIY
 kGm2PgqalHGJNG5COToTwrhW/dVPy5wyRcjQSlGn3728Dc5hkb6QpHhPVFi985EyIEeCbD6b/
 wi0KHkwmDnmPvxljx1Y/FdlGLWrUlIhFjmPwX/MZ1slNPiTh1C1e9aQLK2qq3VPRe/ULmG2ES
 N0DE/6W2bQJyQEIXLx9s/FuruVQCrKGFmw8/+tPXoiOIkgbDlFiarv0GwHXqOLl+Kn+cOWMfL
 T2Hmozbw9XP3ocqIZuMGRBAIwbS4usBfF7E/FCqeJi0pKr7Da2dxm2hDCw1DJJkthhLZmLDJe
 TqnwsLda5pHSDlI5VGkVKzhFkOUEBy0Qt+5zcTQg9MB8i9ecEvRGBg7mnySJBDvc2Hb1C3HTi
 edE3Yz57qicqmOzpO560Fs2SW6QyUGilMAmbR+OWziMGxqTqRAusMmnlmyHv2uOHrmbbCs5xb
 HQVsN82Pkv7OAuPmCuf4/jbo7dTHU/t5klqHU3XFOq/LygMAbMpxdb+tLGfRehP4nTuzBCLsS
 o+pDkNCRBK2A39fjQqcGjV+rLZL1svwwTvCTWDR62oPEZ/m7sH+0PqpAqY6BziCD3HHZvbgn0
 rLoywRXZTSWWGvtr+uEj/mS1L22yvAZnvPAP/H7rVtCStfA2EQ1oY52rbg0wJpbSIERWT8X/5
 GhWasZ5jXpo6dbb81RJvTWmy9OpDyNUFQVp3HJHM9D9KTAKQqEF2e7eerIotZt3wFfQyTSHpz
 BZjrDfuFUeatOgRfPaqv4rmjCJpOYF1I1Azr5i+H8Ikjy5fo01sGybQwvpXYq4H/ZE6/GoeUu
 mCnC2s3xnA4kRC4gQe/3XTA6xLGpWOxAZC6EKc5r7WB0cVx6n0vJAQdbEKUUaUoHquOhUA7MF
 uKkFV79bbBdg/ayk+jEFw4/s68zGMKb9QhNW+GImHqUelblcwnBhz828o3h83hxuhPz5YyrkH
 mD9BmfmnqvMH1AcZeRjlyoDc+sRvaEKWyPt91+FqyFAPjEelhqKLA2VVywtsIF9DXXgo7N5sW
 SZ0IjlXk0V7TrrUfjrXYgbpvFBM+Ra1MIakVBeZkS46tvbYNulZPuzYOk69cWsMjM1NApeLC5
 jwSRhQtMpKVltFovkiEjIwaYo+z6OwSS7D1v7+Y8pnWcA+oBMqGCXPXdWmOh2gfcyQ6zy/ehJ
 1SCSr/0abzNLkQ5YotTZbmKnQXDWlGDbexCWtk4birzluDCK4dwh9L2EiAVQF+cyaER6+o27I
 dXbrBRF83EWhVZ36TpcKdwy9pqbytEpBF2HOv+mGD7OI1wKG8nuxxfx68mKqiUHEMVEnuDX7H
 4eJfp/cew9XGc4qTxomzacPiWXpFEQ7wmOEUdh5zCgmenYpA8MqzoUDe0T2nQ2rrLyCQKm8fj
 sc9ArTErY9WkWl/Q6BhDjsYEdzxhyftS8Nci+FtwWN1f8zHaNT+NUOEj996EdAWOcHlKRvxIW
 aCFBnQa8KtJviMGl6goDgNFZjh6K8IS0seAbQTc92iHia1ldLdD7jDmbvdRNsTtQ2sRSZHzRc
 urjaqui4e9dC/w77czBuu+0nD0QGoEv4KDX4bdtpMn5xVI8ljS7hNrDbzsJL72Jm5+RXmbX2M
 tWyjkF02N88PmDgC6RlmzIX3IHwG5HH9Ynz1/NLo83FJ6EffQNub6wbpmjlk8wAkSoPs0xnk=

From: Torsten B=C3=B6gershausen <tboegi@web.de>

MacOS14 (Sonoma) has started to ship an iconv library with bugs.
The same bugs exists even in MacOS 15 (Sequoia)

A bug report running the Git test suite says:

three tests of t3900 fail on macOS 26.1 for me:

  not ok 17 - ISO-2022-JP should be shown in UTF-8 now
  not ok 25 - ISO-2022-JP should be shown in UTF-8 now
  not ok 38 - commit --fixup into ISO-2022-JP from UTF-8

Here's the verbose output of the first one:

=2D---- snip! -----
expecting success of 3900.17 'ISO-2022-JP should be shown in UTF-8 now':
                compare_with ISO-2022-JP "$TEST_DIRECTORY"/t3900/2-UTF-8.t=
xt

=2D-- /Users/x/src/git/t/t3900/2-UTF-8.txt 2024-10-01 19:43:24.605230684 +=
0000
+++ current     2025-12-08 21:52:45.786161909 +0000
@@ -1,4 +1,4 @@
 =E3=81=AF=E3=82=8C=E3=81=B2=E3=81=BB=E3=81=B5

 =E3=81=97=E3=81=A6=E3=81=84=E3=82=8B=E3=81=AE=E3=81=8C=E3=80=81=E3=81=84=
=E3=82=8B=E3=81=AE=E3=81=A7=E3=80=82
-=E6=BF=B1=E6=B5=9C=E3=81=BB=E3=82=8C=E3=81=B7=E3=82=8A=E3=81=BD=E3=82=8C=
=E3=81=BE=E3=81=B3=E3=81=90=E3=82=8A=E3=82=8D=E3=81=B8=E3=80=82
+=E6=BF=B1=E6=B5=9C=E3=81=BB=E3=82=8C=E3=81=B7=E3=82=8A=E3=81=BD=E3=82=8C=
=E3=81=BE=E3=81=B3$0$j$m$X!#
not ok 17 - ISO-2022-JP should be shown in UTF-8 now
1..17
=2D---- snap! -----

compare_with runs git show to display a commit message, which in this
case here was encoded using ISO-2022-JP and is supposed to be reencoded
to UTF-8, but git show only does that half-way -- the "$0$j$m$X!#" part
is from the original ISO-2022-JP representation.

That botched conversion is done by utf8.c::reencode_string_iconv().  It
calls iconv(3) to do the actual work, initially with an output buffer of
the same size as the input.  If the output needs more space the function
enlarges the buffer and calls iconv(3) again.

iconv(3) won't tell us how much space it needs, but it will report what
part it already managed to convert, so we can increase the buffer and
continue from there.  ISO-2022-JP has escape codes for switching between
character sets, so it's a stateful encoding.  I guess the iconv(3) on my
machine forgets the state at the end of part one and then messes up part
two.

[end of citation]

Working around the buggy iconv shipped with the OS can be done in
two  ways:
a) Link Git against a different version of iconv
b) Improve the handling when iconv needs a larger output buffer

a) is already done by default when either Fink [1] or MacPorts [2]
   or Homebrew [3] is installed.
b) is implemented here, in case that no fixed iconv is available:
   When the output buffer is too short, increase it (as before)
   and start from scratch (this is new).

This workound needs to be enabled with
'#define ICONV_RESTART_RESET'
and a makefile knob will be added in the next commit

Suggested-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>

[1] https://www.finkproject.org/
[2] https://www.macports.org/
[3] https://brew.sh/

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 utf8.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/utf8.c b/utf8.c
index 35a0251939..96460cc414 100644
=2D-- a/utf8.c
+++ b/utf8.c
@@ -515,6 +515,19 @@ char *reencode_string_iconv(const char *in, size_t in=
sz, iconv_t conv,
 			out =3D xrealloc(out, outalloc);
 			outpos =3D out + sofar;
 			outsz =3D outalloc - sofar - 1;
+#ifdef ICONV_RESTART_RESET
+			/*
+			 * If iconv(3) messes up piecemeal conversions
+			 * then restore the original pointers, sizes,
+			 * and converter state, then retry converting
+			 * the full string using the reallocated buffer.
+			 */
+			insz +=3D cp - (iconv_ibp)in; /* Restore insz */
+			cp =3D (iconv_ibp)in;         /* original start value */
+			outpos =3D out + bom_len;     /* original start value */
+			outsz =3D outalloc - bom_len - 1; /* new len */
+			iconv(conv, NULL, NULL, NULL, NULL); /* reset iconv machinery */
+#endif
 		}
 		else {
 			*outpos =3D '\0';
=2D-=20
2.50.0.rc0.46.g7014b55638.dirty

