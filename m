From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/2] i18n: Add extra -- to seperate gettext and message
Date: Mon, 4 Jun 2012 10:56:08 +0200
Message-ID: <CACBZZX5EGvJm0aqG5iVn7wnoqFATUqP4gbS-2tnAiLqeFQZifg@mail.gmail.com>
References: <1338764967-30103-1-git-send-email-worldhello.net@gmail.com> <1338764967-30103-2-git-send-email-worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 10:56:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbT5V-0000Xr-Pd
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 10:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756710Ab2FDI4b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jun 2012 04:56:31 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43185 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755572Ab2FDI43 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2012 04:56:29 -0400
Received: by obbtb18 with SMTP id tb18so6920956obb.19
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 01:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=cutaFcqs5zIFgNhb8jSRzi7o1PRcaDG43pcpsmA9dwY=;
        b=wO9uFCCH8YHJ99B1YV+iXvV2scXD8PObCs3D48h/WrZ9Vt4D/GwaB8nQObjWunQN+g
         gaTan//+YDLc/B87M2DPyriad72y98uF+xsM9dQ9KDIpJKeQ4V9Iphfa1i6dOh4qlZvd
         xmdF2Row9tA30iFs9wolGyg3hPSE2N0oViQFtTDY3aJFY3yKKnvXUdXSYYTsDpTISvX5
         uBk5BExzPvY6XrYJHpC+V3m5lsjzvrB3UwnBicApXGqTsejZxF+CNBPLyA8MEdx6z8JI
         fLT6Gim5rbAdwWNOH+lLb1liHq495RvZJ18kMQZDDEH2uhw8HOHd8L3wj/Ib3m+YG//a
         5CZw==
Received: by 10.60.30.194 with SMTP id u2mr11019871oeh.5.1338800189167; Mon,
 04 Jun 2012 01:56:29 -0700 (PDT)
Received: by 10.182.167.65 with HTTP; Mon, 4 Jun 2012 01:56:08 -0700 (PDT)
In-Reply-To: <1338764967-30103-2-git-send-email-worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199120>

On Mon, Jun 4, 2012 at 1:09 AM, Jiang Xin <worldhello.net@gmail.com> wr=
ote:
> In commit b9b9c22, =C3=86var addressed a issue when gettextized a mes=
sage
> started with "--", such as "--cached cannot be used with --files", th=
e
> first word in the message would be treated as an option of gettext, a=
nd
> might raise a bad option error.
>
> The solution =C3=86var provided is to add a extra "--" option between=
 gettext
> and the message. But Vincent fount out later that the extra "--" was
> extracted as gettext message by xgettext instead of the real message.
> See:
>
> =C2=A0* http://thread.gmane.org/gmane.comp.version-control.git/199042
>
> In order to fix this dilemma, we move the extra "--" option from gett=
ext
> to gettext wrapper (gettextln, and eval_gettext), and gettextize the
> message using the wrapper function instead of gettext itself.
>
> But for system with libintl's gettext.sh, eval_gettext and
> eval_gettextln won't have this fix.

I think a better solution to this is to just apply this patch:

- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die "$(gettext -- "-=
-cached cannot be used with --files")"
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die "$(gettext "the =
--cached option is incompatible
with the --files option")"

It's one message only, and this is due to a bug in the xgettext
extraction. I think changing the only message suffering from this
issue (or likely to suffer from it) beats a solution where starting a
message with -- only works for some of the xgettext
commands/functions.
