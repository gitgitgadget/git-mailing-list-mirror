From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] Compile fix for MSVC: Move poll.h out of sys-folder
Date: Fri, 18 Nov 2011 15:28:42 +0100
Message-ID: <CABPQNSaV-TyznoOsRNQPYEWZCz553cuPOdRsyRQSpzU8QngBZA@mail.gmail.com>
References: <1321624070-4246-1-git-send-email-vfr@lyx.org> <CABPQNSa+ZjAMSxpBTqGW7P=v-tJTW_jdx3MO=vCpzc-z_XdHTg@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, msysgit@googlegroups.com,
	j.sixt@viscovery.net
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Fri Nov 18 15:29:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRPRa-0004qs-Tv
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 15:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756415Ab1KRO30 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Nov 2011 09:29:26 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49037 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755940Ab1KRO30 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2011 09:29:26 -0500
Received: by ggnr5 with SMTP id r5so138914ggn.19
        for <git@vger.kernel.org>; Fri, 18 Nov 2011 06:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=/B10X6vs2m4UsEFmgl2IPR0aw0vtcDQWt+YIg7I/tps=;
        b=Fp13uL0YR5fTy7LnfXqfIFuOJ7mvS8VSLSHtPfLS2ZH1u3CBrXZYSXmK0k3kpwLnyj
         Und5L1ofGAYKl4fRUFt6tiGVN1MNZKYVUklzonFmTuB1merJdkUmJqpeClxEOoDnZhHc
         l95BxDuceN7wA7vj6FNlyzStQktLZ06c2dUgU=
Received: by 10.68.39.98 with SMTP id o2mr10051368pbk.119.1321626563072; Fri,
 18 Nov 2011 06:29:23 -0800 (PST)
Received: by 10.68.71.135 with HTTP; Fri, 18 Nov 2011 06:28:42 -0800 (PST)
In-Reply-To: <CABPQNSa+ZjAMSxpBTqGW7P=v-tJTW_jdx3MO=vCpzc-z_XdHTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185664>

On Fri, Nov 18, 2011 at 3:09 PM, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
> On Fri, Nov 18, 2011 at 2:47 PM, Vincent van Ravesteijn <vfr@lyx.org>=
 wrote:
>> In v1.7.7.1-432-g0f77dea (Oct 24 2011; Erik Faye-Lund; mingw: move
>> poll out of sys-folder) poll.h was moved out of the compat/win32/sys
>> folder. As the change in the Makefile also affects the MSVC build,
>> the same must be done for poll.h in compat/vcbuild/include/sys/poll.=
h.
>>
>> Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
>> ---
>> =A0compat/vcbuild/include/poll.h =A0 =A0 | =A0 =A01 +
>> =A0compat/vcbuild/include/sys/poll.h | =A0 =A01 -
>> =A02 files changed, 1 insertions(+), 1 deletions(-)
>> =A0create mode 100644 compat/vcbuild/include/poll.h
>> =A0delete mode 100644 compat/vcbuild/include/sys/poll.h
>>
>
> This looks strange to me. vcbuild/include/poll.h will only prevent th=
e
> correct header from being included, while compiling an linking agains=
t
> compat/win32/poll.[co]... That seems dangerous to me, because the
> interface might be declared differently.
>
> Instead, I think compat/vcbuild/include/poll.h should be removed, and
> _WIN32_WINNT set to a value below 0x600. That way the poll-stuff
> doesn't get pulled in by winsock2.h (as it's Vista and above only).
>
> This was already discussed in your "[PATCHv2] Compile fix for MSVC" t=
hread:
> http://mid.gmane.org/CABPQNSaCRRRpEQPG1Mb4DovkMdQSBhHTm-i7y5M4iT+ndHX=
4XA@mail.gmail.com
>
> Here's the patch that fixes it.

Johannes Schindelin was nice enough to create a commit based on my
e-mail, feel free to pick it up and submit it:

https://github.com/msysgit/git/commit/9ca803910f3625bf686699f6b0bf71a8c=
68bccae
