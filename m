From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-sh-i18n: detect and avoid broken gettext(1) implementation
Date: Fri, 20 Jan 2012 15:02:40 +0100
Message-ID: <CALxABCYgYT=K0CRJKFOJAeB2wb=vRbwd--YEQtvofA5fmq_t-A@mail.gmail.com>
References: <CALxABCZWBtgX736Acoy-CCAz8RJb0EKnHf+7g72dOdVS+BOhSw@mail.gmail.com>
 <1327063775-28420-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 15:03:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoF3c-00077F-N6
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 15:03:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804Ab2ATODE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jan 2012 09:03:04 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:45211 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751570Ab2ATODD convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 09:03:03 -0500
Received: by obcva7 with SMTP id va7so744673obc.19
        for <git@vger.kernel.org>; Fri, 20 Jan 2012 06:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=cG+iUE+v9e9wIhloKvfSDMseDFdpMt/SCBuDipdB89U=;
        b=diWCe4IxldMElK4asI5zBsDpUdRT2bawPAQS1dbmXW6V4yUrxeSkRXsGbVmXHSPZkl
         IEauW+LRK0X5hmAKR9QyqPnQ7FI5WiitRPkk1qoczXCPkJUR4z8Z79WlDKpR+awnpZLW
         cejSxS20Uk/0cdPchi+QDkoGjVf6uoPePJ+iI=
Received: by 10.182.38.4 with SMTP id c4mr9648359obk.23.1327068181723; Fri, 20
 Jan 2012 06:03:01 -0800 (PST)
Received: by 10.182.226.41 with HTTP; Fri, 20 Jan 2012 06:02:40 -0800 (PST)
In-Reply-To: <1327063775-28420-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188878>

On Fri, Jan 20, 2012 at 13:49, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> Even though we can load gettext.sh the gettext(1) and eval_gettext
> functions it provides might be completely broken. This reportedly
> happens on some Cygwin installations where we can load gettext.sh, bu=
t
> gettext and eval_gettext both return exit code 127 and no output.
>
> The reason we're trying to load gettext.sh (or the equivalent Solaris
> implementation) at all is so we don't have to provide our own fallbac=
k
> implementation if the OS already has one installed, but because we
> didn't test whether it actually worked under GNU gettext we might end
> up with broken functions.
>
> Change the detection in git-sh-i18n so that it tests that the output
> of "gettext test" produces "test", on Solaris we already test that
> "gettext -h" produces "-h", so we were already guarded against the
> same sort of failure there.
>
> Reported-by: Alex Riesen <raa.lkml@gmail.com>
> ---
> Here's a minimal patch to git-sh-i18n that should make things work on
> Cygwin and any other platforms with broken gettext functions while
> also using the OS-provided functions if they work.

=46WIW, I confirm it works (which is quite obvious).

Just for giggles, I even risked running the tests and, of course, crash=
ed
that piece of junk with broken Cygwin installation.
Please don't ask me to do that again :) restarting it is PITA as well.

Just for future reference to all poor Cygwin users:

I also left NO_GETTEXT in the config.mak. This, BTW, explains why git
works, while gettext binary does not: one .dll dependency less.
