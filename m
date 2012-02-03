From: Bart Trojanowski <bart@jukie.ca>
Subject: [1.7.9] usage regression when merging annotated tag objects
Date: Fri, 3 Feb 2012 18:08:06 -0500
Message-ID: <CADeLxZTsq1M5oEb1u5Oqfxq3dYXL6E_uN9bXaTqaOZiA0fgdJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 00:08:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtSEn-0006i6-7l
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 00:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650Ab2BCXII convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 18:08:08 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:49457 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754475Ab2BCXIH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 18:08:07 -0500
Received: by obcva7 with SMTP id va7so4858051obc.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 15:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jukie.ca; s=google;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=LSvyM4yqLTNWWvMqLbsfvZtWsGprvtGCa5V2S0ZJrDk=;
        b=DnwDitoTycxKWAzlET2FshWgCcACrd6S3Q6KzCB7728ZYgm0tVHYg1rN61/XqY/un+
         9pwq4SJKnuUENFysUsXssSdSizRzYmZ4KIhGDL7z8ArT1EJFgj/mh93Nrodi9nL37EG4
         /RJdj3Mxy6h/WNHtj5pzJimElgcSX6K4VP+eQ=
Received: by 10.182.47.41 with SMTP id a9mr8311412obn.43.1328310486732; Fri,
 03 Feb 2012 15:08:06 -0800 (PST)
Received: by 10.60.4.4 with HTTP; Fri, 3 Feb 2012 15:08:06 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189825>

I recently started using git 1.7.9. =A0Earlier today GregKH released a =
stable
kernel update and I tried my tried and true procedure using 'git merge
--ff-only v3.2.3'. =A0I was a bit surprised with the results.

There are two tags I am toying with...

69bade0 is v3.2.3
3499d64 is v3.2.2

And here is where we start...

$ git describe
v3.2.2

$ git merge-base v3.2.2 v3.2.3 | xargs git describe
v3.2.2

(it is thus eligible for a fast-forward)

=46inally, the strangeness...

$ git merge --ff-only v3.2.3
fatal: Not possible to fast-forward, aborting.

$ git merge --ff-only v3.2.3~
Updating 3499d64..7b171c5
=46ast-forward
=2E..

$ git merge --ff-only v3.2.3
fatal: Not possible to fast-forward, aborting.

After talking to Junio, he pointed out that "merging tag objects gained=
 new
meanings in 1.7.9".

I am not sure if my confusion will be shared by others and if --ff-only
needs a clarification. =A0Perhaps --ff-only should just continue to wor=
k as
it did before, and fast-forward from tag to tag.

Cheers,
-Bart
