From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] checkout: do not switch branch during a rebase unless -f
 is given
Date: Tue, 28 Sep 2010 15:47:50 +1000
Message-ID: <AANLkTin19PREB3B68s+ejsgtXwe3CBxZF-caCvRp4UXv@mail.gmail.com>
References: <1285649564-24737-1-git-send-email-pclouds@gmail.com>
	<1285649702-24773-1-git-send-email-pclouds@gmail.com>
	<AANLkTinUudOXmhKW-+rkcpzb-VNnSBLZwGZcjrS6UdMu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 07:50:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0T4p-0002Ma-Pi
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 07:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910Ab0I1Frw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 01:47:52 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59016 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222Ab0I1Frv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 01:47:51 -0400
Received: by wyb28 with SMTP id 28so4627825wyb.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 22:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vIr0W+5VqblL/t99MdHn2gtCFN/aKht7JzJur8zNaPI=;
        b=PNdjYSDkhzV2crqt+dEY6WPZ86+qCnS+ljf33w5GXd5aFt0/cbPtgYVEvcI58fHUSr
         FhbCcgsY0QA3aoC7dSH9slxzLG74tBofAVh+gWCmma+ZAR2Eu2mJvVtIhXX6NXi1j8Nk
         P+vWDSKBJynfUAdbyxkOOTX8dD8z8WmcqPf9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rvMB+zAvaCNauZbO8ENGEkcBzs2/dvbSUWfTrvAV2tcuv64Lt7QiEXpYVa2QOyFu8u
         3BGricsks1ZKUoYAtHU8/WhUcQf7IPJfTbFbclswtoG8Ucx5eo8wdUryLdt+GZjIE7np
         +vhx9tbvL7rtMLl3vWaahxE+3wFFTtGVyKQic=
Received: by 10.216.93.73 with SMTP id k51mr7294397wef.8.1285652870440; Mon,
 27 Sep 2010 22:47:50 -0700 (PDT)
Received: by 10.216.153.195 with HTTP; Mon, 27 Sep 2010 22:47:50 -0700 (PDT)
In-Reply-To: <AANLkTinUudOXmhKW-+rkcpzb-VNnSBLZwGZcjrS6UdMu@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157390>

2010/9/28 Jonathan Nieder <jrnieder@gmail.com>:
> (+cc: Fr=C3=A9d=C3=A9ric, Dscho, Christian)
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> It does not make much sense to switch branch when you are in a middl=
e
>> of a rebase. Sometimes you might want to switch away for a moment th=
en
>> back with "git checkout - ". But I find myself so many times switchi=
ng
>> away then forget that I was rebasing something.
>>
>> Avoid doing that by default. Users can use -f if they really want to=
=2E
>
> Nice! But I worry is that scripts that use "git checkout" porcelain
> during a rebase would be broken.

Right. I used git-rebase from my installation, the new "git checkout"
from worktree and missed that as a result.

> Even rebase --interactive uses checkout from time to time:
>
> =C2=A0- for preserving merges
> =C2=A0- to move to the correct branch in response to "git rebase -i
> <upstream> <branch>"
> =C2=A0- to move to the target in "git rebase -i --onto <new base> <up=
stream>"
>
> Unfortunately I do not have any good advice. Would it make sense to
>
> =C2=A0- first, change these call sites in git to use checkout -f
> =C2=A0- teach checkout to warn (without erroring out) to give people =
time
> to change their scripts
> =C2=A0- warn loudly about the upcoming change in the release notes
> =C2=A0- later, change checkout to error out when -f is not supplied
>
> or am I being too paranoid?

No. But I don't like the idea of making scripts use "checkout -f". My
intention was to stop users from doing that, not scripts. Putting "-f"
everywhere might have more negative side effects.

Maybe adding "--porcelain" to checkout first, updating scripts to use
it, then only check for rebase/bisect/am when --porcelain is missing.
--=20
Duy
