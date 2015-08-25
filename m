From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v5] git-p4: Obey core.ignorecase when using P4 client specs.
Date: Tue, 25 Aug 2015 12:57:37 +0100
Message-ID: <CAE5ih7-o6eVF-z2GORxHa_TdDaXgexLpW3jctESTnL46Mfdo8w@mail.gmail.com>
References: <1440451805-85095-1-git-send-email-larsxschneider@gmail.com>
	<55DC111A.6090501@diamand.org>
	<55DC285D.9030500@web.de>
	<23CB37E8-9704-4A9D-8CAB-2812AD59394D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Tor Arvid Lund <torarvid@gmail.com>, ksaitoh560@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 13:57:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUCrG-00059z-Gb
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 13:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755496AbbHYL5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 07:57:39 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34780 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbbHYL5i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 07:57:38 -0400
Received: by obbfr1 with SMTP id fr1so139352095obb.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 04:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DufQYWtHogu6kT88Wh0ku7D6PE+9tiOJsCL1IMpsScA=;
        b=XAr8puQu6YWL4rl5Ys9lsHMtAfXGxVGW7uuZC8he/Vgh8kAzig6wdOn55sLxOf2s3o
         VGqpI6KH1AIy9AYmU8XcWZtHhSFTahOtXrsblx+v+9xuTsvPL+MZ+q8CJ+eA7Y9zSEnF
         svVhSBTG/uQR1bqoMgsuxNNZHe1TWjGCC1LU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=DufQYWtHogu6kT88Wh0ku7D6PE+9tiOJsCL1IMpsScA=;
        b=Ht3jHP66tMvzUdSx0OKsHYCCZukRGpdq92gAp74E0bGsCJpEG/Wva7ueyrk2nK/Rut
         9ybHXyk+9CI/RhglxHSS6eDg8dt9Olltj+6Fk1ym3nj2HaLWMzcKjYfJVW477VYxvCNj
         IJveaRBpbk+DCFujWYmmDQm2w0de6Qu01Ms/00adzAmWdka2h8lTSP980OxWZ2oXDy1j
         jPRwyjfWzV1bFmW52sReKTCqCVhQLJqdsgeMvU2AxAjX/O76v010OEsoqFtd6GDDsUiC
         eEx+Y91D3O+HPaKUFsvL95YBllFoJgZin63K7D0WZKSo4oum8S55tHChKkUB7Q/rRPsO
         K1Xw==
X-Gm-Message-State: ALoCoQl4xs60EOjHd19d0QoK9BUbpybCQ/QayHJIktrXbpsgNM20NKSSwlJcdPVJU4y5kY2BEDUc
X-Received: by 10.60.141.135 with SMTP id ro7mr25615974oeb.13.1440503857537;
 Tue, 25 Aug 2015 04:57:37 -0700 (PDT)
Received: by 10.60.162.5 with HTTP; Tue, 25 Aug 2015 04:57:37 -0700 (PDT)
In-Reply-To: <23CB37E8-9704-4A9D-8CAB-2812AD59394D@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276519>

 On 25/08/15 11:30, larsxschneider@gmail.com wrote:

> Unfortunately the command line option is not sufficient as the resulting paths are still messed up. I added the switch but it looks like as core.ignorecase does some additional magic on fast-import. You can see my changes here:
> https://github.com/larsxschneider/git/commit/b4399179ff542161c2c5b83c34c5b4901287ceb0
>
> You can also run the unit tests to see the results here:
> https://github.com/larsxschneider/git/tree/lars/fix-path-v5-with-command-switch
>
> The only way I could image to fix that is to request every path from P4 as shown in my PATCH v4. This would be slow and the change would be rather huge.

Yes, you're right - fast-import has special handling based on core.ignorecase.

There was a thread a while back saying that it shouldn't do this, and
instead should have a new --casefold option, which would make more
sense, but isn't the case at present.

http://www.spinics.net/lists/git/msg243264.html

> I am curious:
> I run all my P4 -> git migrations on a Linux box with EXT4 and core.ignorecase=True. I did not realize that this might cause trouble. What could happen and what should I look out for?

An obvious way it could go wrong would be if you had a a repo that
_did_ care about case (e.g. had Makefile and makefile in the same
directory) and you then tried to git-p4 clone a separate repo into a
different branch. In an ideal world, you would only use the
case-folding on the git-p4 based repo. I think while fast-import just
checks core.ignorecase, that's not possible.

So the choices are:

1. A new command-line option which would silently set core.ignorecase
2. Users just have to know to set core.ignorecase manually before
using git-p4 (i.e. Lars' patch v5)
3. Fix fast-import to take a --casefold option (but that's a much bigger change)

Luke
