From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH RFC] cherry: support --abbrev option
Date: Mon, 15 Mar 2010 23:30:45 +0100
Message-ID: <40aa078e1003151530y19f10bf1l852a0e5230b11cb6@mail.gmail.com>
References: <1268668999-4188-1-git-send-email-kusmabite@gmail.com>
	 <4B9E69A4.2080304@lsrfire.ath.cx>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Mar 15 23:30:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrIoH-0005Xq-7D
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 23:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936972Ab0COWas convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 18:30:48 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:51386 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936949Ab0COWaq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 18:30:46 -0400
Received: by wwe15 with SMTP id 15so230890wwe.19
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 15:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DHlKZpkuqDTKXTFemd1WYwkyH4xWSz6/kd6LQ0cvcr8=;
        b=R4klfAUlZAicleXQ8/nHfYOm9YWyVmDyrhSubwhvKjk4GGKP9lgkTOjWA999WbktOJ
         zR8Gpa950hIT/kSmOEfcZDDhbTE5mrCRS0BhCboBZ4hXdy9TeCM4ufMFQGSSAvsXbXbZ
         PuKWu4y5yhyJjTDkFU+DvxTn0mDGHyK+gG6+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=qXnhVE5n/6FQGbuLIaV8v2JyRu2JXdUamoD+lt6G4SrIOrxJnS8sg6vg5J1A/DBv7w
         TXXpdktINz2Togtoorl+denkVrn+54/ZoWymEo2pr7KTLbk+eJunBXHhNASywOUxwIM8
         0TJia69KLQe75inPA//Ik+DOlNxD0Xhu3XzFE=
Received: by 10.216.87.83 with SMTP id x61mr2356262wee.7.1268692245366; Mon, 
	15 Mar 2010 15:30:45 -0700 (PDT)
In-Reply-To: <4B9E69A4.2080304@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142265>

On Mon, Mar 15, 2010 at 6:08 PM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 15.03.2010 17:03, schrieb Erik Faye-Lund:
>> Switch to parse-options API while we're at it.
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>> ---
>>
>> I sometimes find it useful to look at the commit-subject together wi=
th
>> the SHA-1s. Using --abbrev increases the chance that the lines fits =
on
>> an 80 character wide terminal, making the output easier to read.
>>
>> =A0builtin/log.c | =A0 40 ++++++++++++++++++++++------------------
>> =A01 files changed, 22 insertions(+), 18 deletions(-)
>>
>> diff --git a/builtin/log.c b/builtin/log.c
>> index b70d0f7..020d618 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -1286,8 +1286,11 @@ static int add_pending_commit(const char *arg=
, struct rev_info *revs, int flags)
>> =A0 =A0 =A0 return -1;
>> =A0}
>>
>> -static const char cherry_usage[] =3D
>> -"git cherry [-v] [<upstream> [<head> [<limit>]]]";
>> +static const char * const cherry_usage[] =3D {
>> + =A0 =A0 "git cherry [-v] [<upstream> [<head> [<limit>]]]",
>> + =A0 =A0 NULL
>> +};
>> +
>> =A0int cmd_cherry(int argc, const char **argv, const char *prefix)
>> =A0{
>> =A0 =A0 =A0 struct rev_info revs;
>> @@ -1298,26 +1301,26 @@ int cmd_cherry(int argc, const char **argv, =
const char *prefix)
>> =A0 =A0 =A0 const char *upstream;
>> =A0 =A0 =A0 const char *head =3D "HEAD";
>> =A0 =A0 =A0 const char *limit =3D NULL;
>> - =A0 =A0 int verbose =3D 0;
>> + =A0 =A0 int verbose =3D 0, abbrev =3D 40;
>>
>> - =A0 =A0 if (argc > 1 && !strcmp(argv[1], "-v")) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 verbose =3D 1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 argc--;
>> - =A0 =A0 =A0 =A0 =A0 =A0 argv++;
>> - =A0 =A0 }
>> + =A0 =A0 struct option options[] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 OPT__ABBREV(&abbrev),
>> + =A0 =A0 =A0 =A0 =A0 =A0 OPT__VERBOSE(&verbose),
>> + =A0 =A0 =A0 =A0 =A0 =A0 OPT_END()
>> + =A0 =A0 };
>
> If I use --no-abbrev, do I get 0 or 40 hash chars? =A0I didn't actual=
ly
> test it, but I suspect an "if (!abbrev) abbrev =3D 40;" is needed som=
ewhere.
>

"abbrev" is initialized to 40 when declared, so you get the same
behavior as before by default.

>> - =A0 =A0 if (argc > 1 && !strcmp(argv[1], "-h"))
>> - =A0 =A0 =A0 =A0 =A0 =A0 usage(cherry_usage);
>> + =A0 =A0 argc =3D parse_options(argc, argv, prefix, options, cherry=
_usage,
>> + =A0 =A0 =A0 =A0 PARSE_OPT_KEEP_UNKNOWN);
>
> Why do you use PARSE_OPT_KEEP_UNKNOWN here? I think the old option
> parsing code lazily relied on invalid options being found out by
> add_pending_commit() later. We can be lazy again by leaving invalid
> option handling to parse_options(); sure, it changes the error messag=
e,
> but for the better.

Actually, It's a mistake, thanks for pointing it out :)

Yeah, I think your suggestion is better. Corrected.

--=20
Erik "kusma" Faye-Lund
