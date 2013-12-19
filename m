From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/12] Hard coded string length cleanup
Date: Fri, 20 Dec 2013 06:50:25 +0700
Message-ID: <CACsJy8Bb4+V1DEdEmRwj10Oozi8U430ZHDCj_UhnXZcaR-wQ=g@mail.gmail.com>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com> <52B38213.2070702@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Dec 20 00:51:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtnMu-000804-E1
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 00:51:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102Ab3LSXu6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Dec 2013 18:50:58 -0500
Received: from mail-qa0-f49.google.com ([209.85.216.49]:35702 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755875Ab3LSXu5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Dec 2013 18:50:57 -0500
Received: by mail-qa0-f49.google.com with SMTP id ii20so2085945qab.8
        for <git@vger.kernel.org>; Thu, 19 Dec 2013 15:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ckEAovJs/RYhrkgXF66CLqkJ0fDPX5FAF+TRtyzQDFk=;
        b=tern3j5Z/bVsXEddLlkNUJiCHlvY0wTt7ILCvNEgyV9K8vyepIUl1l4wkX/QjJy5wB
         tDHjZbqLf01iP1hjfWtYxBfTVht42i45jUH3Bhu+DDBaacAiaxIm5NDZJCWs5r4Mb1Qy
         OO4OD9QI3qy3Ze9jV8gO9fLDVGTrJcKbbmxVBDe/x3qwPb3wauBUGib5dKH54QCvl8qM
         BqSIvfVKRc7e17Sb0MxpSVQIITwnDS/RdGqKzYMQBUN/M6BYgbuUwKaDv5Bz5JPZ+Ax/
         8208Lw4Dhfqode6njd+LZVFo4miCdPxRclv7H9y3CX/J7ahaKlUEVmfXa55fOJX0oq9S
         Uadw==
X-Received: by 10.224.51.7 with SMTP id b7mr8534137qag.74.1387497056762; Thu,
 19 Dec 2013 15:50:56 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Thu, 19 Dec 2013 15:50:25 -0800 (PST)
In-Reply-To: <52B38213.2070702@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239558>

On Fri, Dec 20, 2013 at 6:32 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
> Seeing that skip_prefix_defval is mostly used in the form
> skip_prefix_defval(foo, prefix, foo) I wonder if it makes sense to
> first change skip_prefix to return the full string instead of NULL
> if the prefix is not matched.  Would the resulting function cover
> most use cases?  And would it still be easily usable?

That was skip_prefix_gently() that I forgot to replace in a commit
message, before I turned it into _defval variant. The reason for
_defval is it could be use to chain expression together without adding
temporary variables, e.g.

-       if (starts_with(line->buf, ">From") && isspace(line->buf[5])) {
+       if (isspace(*skip_prefix_defval(line->buf, ">From", "NOSPACE"))=
) {

Without _defval, one would need to do if ((p =3D skip_prefix(..)) &&
isspace(*p)). I'm not entirely sure this is a good thing though as it
could make it a bit harder to read.
--=20
Duy
