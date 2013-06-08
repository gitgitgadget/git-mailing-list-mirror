From: =?UTF-8?Q?Beno=C3=AEt_Person?= <benoit.person@ensimag.fr>
Subject: Re: [PATCH v2 02/22] git-remote-mediawiki: Use the Readonly module
 instead of the constant pragma
Date: Sat, 8 Jun 2013 10:51:12 +0200
Message-ID: <CAETqRCia1CqkaaHCFk=7mxVgmuN1VhBbGVs_oEaObUxwHZ33Zw@mail.gmail.com>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
	<1370641344-4253-3-git-send-email-celestin.matte@ensimag.fr>
	<20130608032324.GA20226@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?C=C3=A9lestin_Matte?= <celestin.matte@ensimag.fr>,
	git@vger.kernel.org, Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 08 10:51:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlEs5-0003SC-5c
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 10:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537Ab3FHIvQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 04:51:16 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:43972 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab3FHIvN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jun 2013 04:51:13 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so6086805iea.32
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 01:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=C7KC0WGEy/JxbiEcHaE5mj2r98eTdUZVpdQyFfq+g/U=;
        b=DB0uQZrWsGXFoGSMupkizWZRD/+2PYgT0VTrohIUBv86mKlQ2UtHBB7zv5bMMHPXlC
         8mi8Qs9TOmgpYgUs+SF2Z0luVkDnbWsHu1o4BGfRws7L0gn3I/zH5HSFhZs+cp32PP7o
         Rza3udcPkm0hxBNcN/NeZsLZ6Fo6LNM0hw3TWpn65RkEqCh2CrQTgZUmdW46p6suWG0a
         +Qi5/r6wGGLkV2OPuvkmmedtHoBmk+f5oOnm5sootEUdnHReqcqUcojg2ahuirZlZP3O
         JSsnwjSqx9lEXm9fOsNxJZ9ohibh9kax/+8cCNWi8i516obJRbiglXXwghNdzfiLZgsp
         uRug==
X-Received: by 10.50.176.228 with SMTP id cl4mr575253igc.7.1370681473085; Sat,
 08 Jun 2013 01:51:13 -0700 (PDT)
Received: by 10.42.79.148 with HTTP; Sat, 8 Jun 2013 01:51:12 -0700 (PDT)
In-Reply-To: <20130608032324.GA20226@sigill.intra.peff.net>
X-Google-Sender-Auth: bEEMQGlKE3E5JuBNbGDpn4oSEQo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226790>

The major drawback of using perl `constant` is the fact that they do
not interpolate like variables in most of the contexts (those who
automatically quotes barewords). Like said on Perl Monks here [1], you
have to do some "tricks" depending on the context in which you're
using the constant and that's not really "clean".

But maybe trading clean for another package is not worth it. I just
searched for alternatives way of doing it and none seems to be in the
core packages so maybe we should just drop this.

[1] http://www.perlmonks.org/?node_id=3D777711

On 8 June 2013 05:23, Jeff King <peff@peff.net> wrote:
> On Fri, Jun 07, 2013 at 11:42:03PM +0200, C=C3=A9lestin Matte wrote:
>
>> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/m=
w-to-git/git-remote-mediawiki.perl
>> index 4893442..e60793a 100755
>> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
>> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
>> @@ -26,21 +26,21 @@ use IPC::Open2;
>>  use Readonly;
>
> What does this series apply on top of? The existing version in "maste=
r"
> does not have "use Readonly" in it at all. The first version of your
> series introduced that line, but here it is shown as an existing line=
=2E
> Did you miss a commit when putting your patches together?
>
>>  # Mediawiki filenames can contain forward slashes. This variable de=
cides by which pattern they should be replaced
>> -use constant SLASH_REPLACEMENT =3D> "%2F";
>> +Readonly my $SLASH_REPLACEMENT =3D> "%2F";
>
> What advantage does this have over "use constant"? I do not mind
> following guidelines from perlcritic if they are a matter of style, b=
ut
> in this case there is a cost: we now depend on the "Readonly" module,
> which is not part of the standard distribution. I.e., users now have =
to
> deal with installing an extra dependency. Is it worth it?
>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
