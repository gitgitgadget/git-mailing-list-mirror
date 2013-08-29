From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: The gitweb author initials feature from a36817b doesn't work with
 i18n names
Date: Thu, 29 Aug 2013 16:44:42 +0200
Message-ID: <CANQwDwcyV7N6xPxaYFUnRQptVabwkd_mFconZPGDm9iGS3LArA@mail.gmail.com>
References: <CACBZZX4i-Tu1G07e9=5DYFjY9EtRGO8gLJf71d5aLeaE-cj-8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 16:45:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF3TH-0000zX-B5
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 16:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590Ab3H2OpH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Aug 2013 10:45:07 -0400
Received: from mail-qa0-f43.google.com ([209.85.216.43]:53260 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436Ab3H2OpD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Aug 2013 10:45:03 -0400
Received: by mail-qa0-f43.google.com with SMTP id bv4so1222806qab.9
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 07:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=QpJbok7AMxcH+HPOHUqWnuL+pxetGS6O0RB28XRV6OA=;
        b=RzxWvjE/5S0UEBwQqRZKnLM7794kUpvrACaNq1GNsvoT5UzXQl0JNnbF42Smx5yPyE
         iTFJzxQEw1NqLq9Sdkh9NJ579I2DSZp2zEYNnQS9R0Hg1hVMUIK7lEbOEcM0kQEOaVtK
         AV4cDf+73H702u4ytiCRww7Ey4PEFRzCfyvkGDOxjOiBHy6OTJB+Uxs23dR1vMVvpvru
         rWYITvYQEArD+mW/px8pOmclPm6Ww72V0Oe0+92D28GaEqOlU0MEHMDW9KaYsHRCVN1s
         B3ZSyT8WNnNv58RpFl1fS6MX20Bq9U3PRaF7f/PlRu+ULi+FmHhaVyvBfNIBhA1CaOqj
         TLOw==
X-Received: by 10.224.62.15 with SMTP id v15mr2248831qah.94.1377787502612;
 Thu, 29 Aug 2013 07:45:02 -0700 (PDT)
Received: by 10.49.83.134 with HTTP; Thu, 29 Aug 2013 07:44:42 -0700 (PDT)
In-Reply-To: <CACBZZX4i-Tu1G07e9=5DYFjY9EtRGO8gLJf71d5aLeaE-cj-8w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233266>

[=C3=86var, sorry for duplication but I accidentally send HTML email; s=
tupid Gmail]

On Thu, Aug 29, 2013 at 4:26 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> The @author_initials feature Jakub added in a36817b claims to use a
> i18n regexp (/\b([[:upper:]])\B/g), but in Perl this doesn't actually
> do anything unless the string being matched against has the UTF8 flag=
=2E
>
> So as a result it abbreviates me to "AB" not "=C3=86AB".
[...]

Thanks for catching this, and for an analysis.

> Jakub, do you see a reason not to just apply this:
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index f429f75..29b3fb5 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -6631,6 +6631,7 @@ sub git_blame_common {
>                         $hash_base, '--', $file_name
>                         or die_error(500, "Open git-blame --porcelain=
 failed");
>         }
> +       binmode $fd, ":utf8";
>
>         # incremental blame data returns early
>         if ($format eq 'data') {
>
> I haven't gotten an env where I can test gitweb running, but that
> looks like it should work to me.

Unfortunetly I cannot check this either, but it looks obviously correct=
=2E
ACK.

--=20
Jakub Narebski
