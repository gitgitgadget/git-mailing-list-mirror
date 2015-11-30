From: Owen Jacobson <ojacobson@heroku.com>
Subject: Detecting pushes originating from shallow clones?
Date: Mon, 30 Nov 2015 17:27:31 -0500
Message-ID: <147913FA-1158-40BE-8365-B90E3CBD79C7@heroku.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: multipart/signed; boundary="Apple-Mail=_B7C498DC-37A1-43D1-AD62-B44FD12163E4"; protocol="application/pgp-signature"; micalg=pgp-sha512
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 23:27:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3Wv6-0007b6-Dg
	for gcvg-git-2@plane.gmane.org; Mon, 30 Nov 2015 23:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895AbbK3W1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2015 17:27:36 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33422 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbbK3W1f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 17:27:35 -0500
Received: by igcmv3 with SMTP id mv3so81166827igc.0
        for <git@vger.kernel.org>; Mon, 30 Nov 2015 14:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heroku-com.20150623.gappssmtp.com; s=20150623;
        h=from:content-type:subject:date:message-id:to:mime-version;
        bh=y1sLM0kr71cm7qIdBLa0TQ34RGKtW5taqE7g9UTtX94=;
        b=zivodRIKdptAm9U3Cnxw+mlvBVGmD9/6dRj5reaSXhnz3fPsYB7C2zZKxj72sK5FNp
         yc4ia7QtsGqU/pcjzhV16HMJbiYZfw6eyr4VohxWBjqSWaC26xtm4IXM8NIByu49LPJ1
         iz3aYqrvS88xqL/2IQSs2xqRAQ8pRzSmgA1S615UFHMlKwckIXQtB9RjwFJc+PIP5Dou
         lcP8wECd5T7JPf4FgWpdekKJyZVHTJGrJAlVwYvY7zf+/E1fhwe24V9pztPOBuflmNLf
         uoXmJvCO4IoaYShMWNFUca+TmJXMhJimTv9CLTGHxT39qRsVDqi2f4IKKw+EAudNAppU
         UP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-type:subject:date:message-id:to
         :mime-version;
        bh=y1sLM0kr71cm7qIdBLa0TQ34RGKtW5taqE7g9UTtX94=;
        b=XMdHnf2oRi9ar1VxilbEEoualcFVQZsN3TMj7s3rtmrBA4dLIdn8x6sERhqOdOxFl1
         kY81s6O2V2Az5uD18HtZO8g3q+M8JKDikqpw2jYqGHQHKhOpdZs34a9ARSd1h02jt7O9
         S15ydpC4bSogme9ePVAQgFYiL4B3W1e/G9MGLDGyzTFCgXYR2aqU3njGGu3N6K/ew+Ac
         no2WVdeL5V5iFrySsPWAbzd/7uBfIYjo1haLd7mJup4MerbJQ950ogW1yuJwQxV4u0Vc
         h4sMkKvxqSdkxpXD+5pqxppIVvajvk8yXExD9aCbDlBMsOERuVfGBP29mfoQVOKOxdSS
         2jqQ==
X-Gm-Message-State: ALoCoQkF/Zc2s3EejLuPZEn7w/YzKUi8M5BglMhdvMlHleN8sH161SEfXJjJ4VZomlhaKBAU8htJ
X-Received: by 10.50.30.233 with SMTP id v9mr24922306igh.5.1448922454738;
        Mon, 30 Nov 2015 14:27:34 -0800 (PST)
Received: from [10.0.180.115] (69-165-253-231.cable.teksavvy.com. [69.165.253.231])
        by smtp.gmail.com with ESMTPSA id yr7sm8665797igb.12.2015.11.30.14.27.33
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Nov 2015 14:27:33 -0800 (PST)
X-Google-Original-From: Owen Jacobson <owen@heroku.com>
X-Pgp-Agent: GPGMail 2.5.2
X-Mailer: Apple Mail (2.2104)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281821>


--Apple-Mail=_B7C498DC-37A1-43D1-AD62-B44FD12163E4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi folks,

Here at Heroku, we ingest code from users by supplying them with a Git =
server they can `git push` into. Occasionally, users will attempt to =
push to us from a shallow clone, which causes numerous problems for us =
and, often, for our users (incomplete repositories, gaps in history, =
failed builds, and a host of other problems). We=E2=80=99ve been =
investigating what we can do to give these users clearer advice on how =
to fix the problem.

Within the constraints that

* we cannot control which version of Git our users have installed, and
* we run Git v1.9.1, obtained from the Ubuntu 14.04 LTS .deb =
repositories

what can we do in an update/pre-receive hook to detect that an incoming =
push originates from a shallow repository and reject it?

Right now, the best strategy we have is to observe whether

    git rev-list OLD NEW

fails, and if it does fail, whether the stderr output includes the =
phrase "revision walk setup failed=E2=80=9D. This feels like a fairly =
weak fix, so I thought I=E2=80=99d see if anyone here has a better idea.

Thanks,

-o


--Apple-Mail=_B7C498DC-37A1-43D1-AD62-B44FD12163E4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJWXM1UAAoJEAnOjZoiyXdEoi4P/0nc9ELbU2yZzvxCuT/FgIyE
Ka3nMSOUQ/GXVy0wFrNmozQZNLppL2WyRtJQNJ/nlJQt3JkWYVbr9dhoUi+I60rH
4JWG6Iox/N8if5frJZ5AUAD86r2SpU9BSmJl/NpcQFE3Tbn31iVqu/W1dQ+q7gy6
5Kjn5k6BLk9/KbSDHM7p97JSwUWh30zApdY0BQR3wlYtyvGCsg+tBsDeRjGvoSjE
D7F9dOW8/36qgE9VD1JI0MicE1gWCl7ulyfctbmhu7I/wXP1Re5z4aiOwYPgkwXY
W8FdvfDYyRH0Mfr/M4ohk5Aj86Dp6U/yozrTaL5/BXxNIQ9xxUgNEW3NumA2+OkP
E1ZHsqhqvUWESik+M3gNAyjhVsZwA1txtL0P5h3csZOIzpdUmD9o17CSmeQ+yj6s
6mIQ/PQA+8ONl/cuNpQr2tDILOLgl2MuSgvGU4UCQ01FYFSGLpO2UAfJjk7PcmbD
k9vzzGNAyiElJ16n+6k08IWXo+M6FCA5PEzcifr7+gy7VN9jM3V49sUHNuJyZYb/
zKdvYRakGK5NysTXp+lu5zAiTH7Y88JAj/dhKvmPHzyUWC/TXlCL2mVw6yoswixX
tOrgrOJMvBDlWfM5IbA9BQ3QJiMA9TWi+8AdcWPT1U3xN3nWmbIZGbIlmopeG0r4
tvcFg5Pic87itOHHfR4h
=cGA0
-----END PGP SIGNATURE-----

--Apple-Mail=_B7C498DC-37A1-43D1-AD62-B44FD12163E4--
