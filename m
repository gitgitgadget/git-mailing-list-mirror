From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: git should not use a default user.email config value
Date: Fri, 9 Aug 2013 15:30:17 -0500
Message-ID: <CAMP44s1SxSd-cM_P-JL2+skB6mDmar_QwFv9mYp5BrXUKTz61w@mail.gmail.com>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
	<20130809194214.GV14690@google.com>
	<Pine.BSM.4.64L.1308091956060.28970@herc.mirbsd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Thorsten Glaser <tg@mirbsd.de>
X-From: git-owner@vger.kernel.org Fri Aug 09 22:30:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7tKK-000310-6x
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 22:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030833Ab3HIUaU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Aug 2013 16:30:20 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:42805 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030827Ab3HIUaT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Aug 2013 16:30:19 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so3496462lbf.4
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 13:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=4kZvVvLz+f1ZwQ87EMM0c8Nkh3u9gZdcja+3E9IabPY=;
        b=M7GxLcdva1r8m69PmK1dYQbC8o6Gp2ogmji9wSXDe0547tcV0hD7N9W8dvfNTad4/U
         tdf5uwXI96Fu/oGDvdK7aAXaDiLj1Vw1hCyWVIIkjhPKZC4+xbHSm7QqMtkYBhASiz6K
         jJhIIKVRUpMeiUtN+eXCLjyvjlFYHkGK3lCGjK7mciITo8aSBorWn78J6uJzbOYjuOc6
         CzuXReTXKckir1oGw4rk3tt2DcQGxYV+abeTLC6j+D2faAq1YIYHKTsD/DlMWNz3hts8
         NP2LnwV5pYhYgG4j8eGb0Nfgi5uDImItR8dTw3mKfVkJRem87dEb14I+iDLyAlxz3YTj
         vmvg==
X-Received: by 10.152.9.233 with SMTP id d9mr6625119lab.33.1376080217785; Fri,
 09 Aug 2013 13:30:17 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Fri, 9 Aug 2013 13:30:17 -0700 (PDT)
In-Reply-To: <Pine.BSM.4.64L.1308091956060.28970@herc.mirbsd.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232027>

On Fri, Aug 9, 2013 at 3:00 PM, Thorsten Glaser <tg@mirbsd.de> wrote:
> Jonathan Nieder dixit:

>>I wonder if it's too gentle and long to get the point across.  Would
>>something the following (including the guesses in the message for
>>easier copy-pasting) help?
>
> Definitely not. It needs to fail hard if user.email is not set,
> i.e. refuse to accept the commit.

Completely agree, and I argued this point some time ago.

>>is set and not set.  Git already notices the cases where the guessed
>>email address ends with ".(none)" and errors out, and it could make
>>sense to be more aggressive.
>
> The guessed addresses are like 'denge@pc-bn-041.lan.tarent.de'
> instead of 'd.enge@tarent.de' which is the correct Kolab address
> (this information can be publicly accessed since the project I
> noticed it in is on our public FusionForge instance, so I don=E2=80=99=
t
> think sharing specifics is bad here, but please don=E2=80=99t hammer =
our
> poor trainee with spam now). So they=E2=80=99re a =E2=80=9Ccorrect=E2=
=80=9D unix username
> at a correct FQDN (which, thanks to split-horizon, even would
> work internally, except there=E2=80=99s of course no MTA set up) and
> won=E2=80=99t be caught by *.(none) matches.

This is how to implement that:

=46rom f1feaa05ce3772d8006078c4aeabcbd55b52d58e Mon Sep 17 00:00:00 200=
1
=46rom: Felipe Contreras 2nd <felipe.contreras+2@gmail.com>
Date: Tue, 13 Nov 2012 07:33:12 +0100
Subject: [PATCH] ident: don't allow implicit email addresses

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 ident.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ident.c b/ident.c
index 1c123e6..85fc729 100644
--- a/ident.c
+++ b/ident.c
@@ -301,9 +301,9 @@ const char *fmt_ident(const char *name, const char =
*email,
 	}

 	if (strict && email =3D=3D git_default_email.buf &&
-	    strstr(email, "(none)")) {
+		!(user_ident_explicitly_given & IDENT_MAIL_GIVEN)) {
 		fputs(env_hint, stderr);
-		die("unable to auto-detect email address (got '%s')", email);
+		die("no explicit email address");
 	}

 	if (want_date) {
--=20
1.8.3.267.gbb4989f


--=20
=46elipe Contreras
