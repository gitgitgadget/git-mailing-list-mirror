From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty: add format specifiers for short and raw date formats
Date: Wed, 07 Oct 2015 13:22:13 -0700
Message-ID: <xmqqmvvutone.fsf@gitster.mtv.corp.google.com>
References: <1444235305-8718-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Oct 07 22:22:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjvEK-0007OF-AA
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 22:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756041AbbJGUWQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Oct 2015 16:22:16 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35971 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842AbbJGUWP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 16:22:15 -0400
Received: by pablk4 with SMTP id lk4so30742657pab.3
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 13:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=3v7onAmIVGfltM7x0FQ3chbfwA5uet7pjpt8xFCrqCc=;
        b=TUKLuORCQOa6kTNcIkR8rCbPrFwdQQVpJjppXjLLWOUtf4t9MZJzHrIjU1Zjyhnn92
         zd6BceDt52e854rmUbdJKcZbLyBsPWdV9kt2j1/GfsuIk9x7v6xUhUJDq0lTBwWCIEH9
         58mqYInbxtl/HU0iw8RKfGXpRITsNJWT+j8leDoyMhD2GL0lWbr+heWlGgPJsCCnN7aV
         Cs8iISnbXQqIpGn7tg4yeO19MZ0lLNcC3RF9qwCGJ9EXg41DF0yafil0CqTzDjEc20BM
         7lI6M7LWG8PGzxblwohDR2tVQrJojXSaD8V4AFwLh0TFrOYnVX144x40LdwVMYwTgee5
         +QEg==
X-Received: by 10.68.68.167 with SMTP id x7mr3175310pbt.140.1444249334640;
        Wed, 07 Oct 2015 13:22:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c434:fdeb:15ec:325c])
        by smtp.gmail.com with ESMTPSA id be3sm41028104pbc.88.2015.10.07.13.22.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Oct 2015 13:22:13 -0700 (PDT)
In-Reply-To: <1444235305-8718-1-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Wed, 7 Oct 2015 18:28:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279195>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> @@ -120,6 +120,8 @@ The placeholders are:
>  - '%at': author date, UNIX timestamp
>  - '%ai': author date, ISO 8601-like format
>  - '%aI': author date, strict ISO 8601 format
> +- '%as': author date, short format
> +- '%aR': author date, raw format

Hmmm, are these two a good things the only ones that are missing?

It makes me wonder if it's time for us to move to a more extensible
format, e.g. "%aT(...)", in which 'T' stands for 'timestamp' and the
part in the parentheses can be any format string that is understood
by "log --date=3D<format>" [*1*].  Once we have something like that,
we can keep the existing ones for historical convenience, stop
adding new ones [*2*] and do not have to worry about these two
mechanisms going out of sync.

Also, "%at" is almost there as a replacement for "%aR"; what we are
missing really is "%aZ" for zone offset.  If we had "%aZ", we do not
need "%aR", as that is "%at %aZ".


[Footnote]

*1* Yes, and in longer term, we should really aim to unify the
    for-each-ref format and "--pretty=3Dformat:" format.  "%aT(...)"
    is probably a step in a wrong direction, and it should probably
    be more like "%(authordate:...)".

*2* Because we have "%ad", we _can_ stop adding new ones already.
