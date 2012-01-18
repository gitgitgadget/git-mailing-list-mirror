From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] i18n: disable i18n for shell scripts if NO_GETTEXT defined
Date: Wed, 18 Jan 2012 16:22:23 +0100
Message-ID: <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 16:22:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnXLe-00040W-Bj
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 16:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757883Ab2ARPWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 10:22:46 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:36255 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757786Ab2ARPWp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2012 10:22:45 -0500
Received: by lahc1 with SMTP id c1so2279251lah.19
        for <git@vger.kernel.org>; Wed, 18 Jan 2012 07:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RkcDRe23ehrXe2fh9mmKBneTaggAY+KbpA3tPWfl8ts=;
        b=aMmiGWUW60XEc7N3AuQCh4hAwLP50pHiSak7Fd6CUFLSoCV1H1DixxcDaGdfV6wUwi
         Hc1ccVfwMwCdZHP7t/ulVNJ/Y1r8pzoPvh5kmPrFPzvErWmIpVSzTdjmAtxFUXDfglOF
         opBDrSiKAYsKMC0ocrzfQcX77pXGrLlboo/z4=
Received: by 10.152.114.103 with SMTP id jf7mr10786161lab.22.1326900164248;
 Wed, 18 Jan 2012 07:22:44 -0800 (PST)
Received: by 10.112.38.4 with HTTP; Wed, 18 Jan 2012 07:22:23 -0800 (PST)
In-Reply-To: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188749>

On Tue, Jan 17, 2012 at 14:42, Alex Riesen <raa.lkml@gmail.com> wrote:
> Otherwise the i18n is used in the scripts even with NO_GETTEXT set.
> It is very unexpected.

So the reason it's like that is that I was assuming that gettext.sh
wouldn't be FUBAR anywhere, but the translations shouldn't kick in
since we haven't installed them during "make install".

But I wonder if this negatively affects some systems, now we now:

 * Don't use gettext.sh, which means that we're using our fallback
   shell function instead of the binary gettext(1), which is probably
   faster.

 * Use our own eval_gettext() instead of using the system one, which
   uses the GNU binary which is more likely to be in the FS cache
   already since other programs are probably using it.

Which is why I didn't do something like this to begin with.
