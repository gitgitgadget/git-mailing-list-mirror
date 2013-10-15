From: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
Subject: Re: [PATCH v3] diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible.
Date: Tue, 15 Oct 2013 12:46:11 +0300
Message-ID: <09553ADF-AE8C-460C-AC7B-1B4C26F6F6B2@gmail.com>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com> <A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com> <660A536D-9993-4B81-B6FF-A113F9111570@gmail.com> <CACsJy8Cg5M8dHSMW+giwYB2016jZhryyxET0kxkLDX7xk=B47w@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 15 11:47:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VW1Dt-0003PD-3P
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 11:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758288Ab3JOJrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Oct 2013 05:47:25 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:34734 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758206Ab3JOJrY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Oct 2013 05:47:24 -0400
Received: by mail-lb0-f173.google.com with SMTP id o14so6520110lbi.4
        for <git@vger.kernel.org>; Tue, 15 Oct 2013 02:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to;
        bh=rbZLLrlrfeL3vdY9y36RihETrOQuy11F7hI+rEQshPI=;
        b=0feiLKQb19P1SRXNDMEVK1Sdb6oelFEYsd6Csx5fEnSslbAXBdnS0y+E4pJwUW08QP
         rEafXIlLPeezWioabulaV87raCy95nztVSrb+6LkAF6aypry8Q+1zETQ1XppufJqAOTj
         JEQYcOkGZV+ut7sIevunqO/yVkuyE8OFVVdwfBlGje8GyJQ2B4I4fmW39E8AUt8Vx0pd
         iVieg/PeT7iRM96YUdY3IlrKOV0PwcYRkUqnfKfx4My3EKanqN4gzi0UBTy2QWQaO99a
         PKHw45LSFnbaqGk9jorbeIdIDNSAAFRMs+3h5ia85V4FUhjG+z5vakKBTSa2PSEEAGTI
         NJXw==
X-Received: by 10.112.190.1 with SMTP id gm1mr10214887lbc.30.1381830443148;
        Tue, 15 Oct 2013 02:47:23 -0700 (PDT)
Received: from [10.128.134.109] (fsgw.f-secure.com. [193.110.108.33])
        by mx.google.com with ESMTPSA id ur6sm46884786lbc.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 02:47:22 -0700 (PDT)
In-Reply-To: <CACsJy8Cg5M8dHSMW+giwYB2016jZhryyxET0kxkLDX7xk=B47w@mail.gmail.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236171>

Hello Duy

Thank you very much your suggestion.
As you suggested, I tried to reuse intermediate result of pprint_rename=
(), instead of
parsing the output again.
I just posted the new patch as "PATCH v4"

Thanks !

---
Tsuneo Yoshioka (=E5=90=89=E5=B2=A1 =E6=81=92=E5=A4=AB)
yoshiokatsuneo@gmail.com




On Oct 14, 2013, at 10:04 PM, Duy Nguyen <pclouds@gmail.com> wrote:

> On Sun, Oct 13, 2013 at 3:48 AM, Yoshioka Tsuneo
> <yoshiokatsuneo@gmail.com> wrote:
>> "git diff -M --stat" can detect rename and show renamed file name li=
ke
>> "foofoofoo =3D> barbarbar", but if destination filename is long the =
line
>> is shortened like "...barbarbar" so there is no way to know whether =
the
>> file is renamed or existed in the source commit.
>> This commit makes it visible like "...foo =3D> ...bar".
>>=20
>> Signed-off-by: Tsuneo Yoshioka <yoshiokatsuneo@gmail.com>
>> ---
>> diff.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++-----=
--
>> 1 file changed, 51 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/diff.c b/diff.c
>> index a04a34d..3aeaf3e 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -1643,13 +1643,57 @@ static void show_stats(struct diffstat_t *da=
ta, struct diff_options *options)
>>                len =3D name_width;
>>                name_len =3D strlen(name);
>>                if (name_width < name_len) {
>> -                       char *slash;
>> -                       prefix =3D "...";
>> -                       len -=3D 3;
>> -                       name +=3D name_len - len;
>> -                       slash =3D strchr(name, '/');
>> -                       if (slash)
>> -                               name =3D slash;
>> +                       char *arrow =3D strstr(name, " =3D> ");
>> +                       if (arrow) {
>=20
> This looks iffy. What if " =3D> " is part of the path name?
> file->is_renamed would be a more reliable sign. In that case I think
> you just need an ellipsis version of pprint_rename() (i.e. drop the
> result of previous pprint_rename() on the floor and create a new
> string with "..." and " =3D> " in your pprint_ellipsis_rename or
> something)
>=20
>> +                               int prefix_len =3D (name_width - 4) =
/ 2;
>> +                               int f_omit;
>> +                               int f_brace =3D 0;
>> +                               char *pre_arrow =3D alloca(name_widt=
h + 10);
>> +                               char *post_arrow =3D arrow + 4;
>> +                               char *prefix_buf =3D alloca(name_wid=
th + 10);
>> +                               char *pre_arrow_slash =3D NULL;
>> +
>> +                               if (arrow - name < prefix_len) {
>> +                                       prefix_len =3D (int)(arrow -=
 name);
>> +                                       f_omit =3D 0;
>> +                               } else {
>> +                                       prefix_len -=3D 3;
>> +                                       f_omit =3D 1;
>> +                                       if (name[0] =3D=3D '{') {
>> +                                               prefix_len -=3D 1;
>> +                                               f_brace =3D 1;
>> +                                       }
>> +                               }
>> +                               prefix_len =3D ((prefix_len >=3D 0) =
? prefix_len : 0);
>> +                               strncpy(pre_arrow, arrow - prefix_le=
n, prefix_len);
>> +                               pre_arrow[prefix_len] =3D '\0';
>> +                               pre_arrow_slash =3D strchr(pre_arrow=
, '/');
>> +                               if (f_omit && pre_arrow_slash)
>> +                                       pre_arrow =3D pre_arrow_slas=
h;
>> +                               sprintf(prefix_buf, "%s%s%s =3D> ", =
(f_brace ? "{" : ""), (f_omit ? "..." : ""), pre_arrow);
>> +                               prefix =3D prefix_buf;
>> +
>> +                               if (strlen(post_arrow) > name_width =
- strlen(prefix)) {
>> +                                       char *post_arrow_slash =3D N=
ULL;
>> +
>> +                                       post_arrow +=3D strlen(post_=
arrow) - (name_width - strlen(prefix) - 3);
>> +                                       strcat(prefix_buf, "...");
>> +                                       post_arrow_slash =3D strchr(=
post_arrow, '/');
>> +                                       if (post_arrow_slash)
>> +                                               post_arrow =3D post_=
arrow_slash;
>> +                                       name =3D post_arrow;
>> +                                       name_len =3D (int) (name_wid=
th - strlen(prefix));
>> +                               }
>> +                               len -=3D strlen(prefix);
>> +                       } else {
>> +                               char *slash =3D NULL;
>> +                               prefix =3D "...";
>> +                               len -=3D 3;
>> +                               name +=3D name_len - len;
>> +                               slash =3D strchr(name, '/');
>> +                               if (slash)
>> +                                       name =3D slash;
>> +                       }
>>                }
>>=20
>>                if (file->is_binary) {
>> --
>> 1.8.4.475.g867697c
>>=20
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20
> --=20
> Duy
