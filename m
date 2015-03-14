From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 02/16] list-files: make :(glob) pathspec default
Date: Sat, 14 Mar 2015 18:21:10 +0700
Message-ID: <CACsJy8DWe2rCzQivA7HZAkQ==s7OyxpP=UkvsxRzvZ4PtFRyJg@mail.gmail.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
 <1425896314-10941-3-git-send-email-pclouds@gmail.com> <xmqqwq2l2a70.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 12:21:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWk8Y-0005xp-0A
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 12:21:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbbCNLVm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Mar 2015 07:21:42 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37994 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbbCNLVl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Mar 2015 07:21:41 -0400
Received: by igbue6 with SMTP id ue6so5946314igb.1
        for <git@vger.kernel.org>; Sat, 14 Mar 2015 04:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=YV8cPP2rAt0wgIAKrYHhrXuKChpZgvXq0aKduY2yyTw=;
        b=aoiOnlJbc/eOUJyWiZYH37u79ykMlKquiSScGQFMqt6pmJDAGZIWnYaB+Ms7vnIB5y
         uW9KVDl7hRyy0i2WwLNFtuM7PAOPmk01+NkxDwpBar7SQW+pRjWQlchtfWXmp1T8oMuA
         zF439+PBrdwLarOActWhDbR7vlHmj6xY7JBzFMKn+p6vBCrnCVNMjg4FJse9J578sIIS
         scNgGvudsyg/TYriOyIe5RoWrO/sN9BcnAL4lCfxqNu2KF0Mhj8gf+bLHSc3IThQYVxI
         WzgqOxD4BeGCjJqhQX7j6sFfwxv0q4DIhlQlCZcZMwkdUsFfhlKlWc/XMRNsYBRy1FYw
         s6LA==
X-Received: by 10.107.15.155 with SMTP id 27mr74047778iop.49.1426332100400;
 Sat, 14 Mar 2015 04:21:40 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Sat, 14 Mar 2015 04:21:10 -0700 (PDT)
In-Reply-To: <xmqqwq2l2a70.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265445>

On Fri, Mar 13, 2015 at 4:10 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  builtin/list-files.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/builtin/list-files.c b/builtin/list-files.c
>> index ac33f13..b99f2b7 100644
>> --- a/builtin/list-files.c
>> +++ b/builtin/list-files.c
>> @@ -65,6 +65,8 @@ int cmd_list_files(int argc, const char **argv, co=
nst char *cmd_prefix)
>>  {
>>       struct string_list result =3D STRING_LIST_INIT_NODUP;
>>
>> +     setenv(GIT_GLOB_PATHSPECS_ENVIRONMENT, "1", 0);
>> +
>>       if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
>>               usage_with_options(ls_usage, ls_options);
>
> Yikes.
>
> I do not have enough info at this step in the series to judge if it
> is sensible to force the :(glob) interpretation as default, but is
> it something we would want to do commonly to flip the default per
> Git subcommand?

As this new 'ls' imitates the unix version, I try to hide this subtle
difference of git. Perhaps this is a premature move because we may
want to make :(glob) default for most commands at 3.0 or something,
except plumbing commands.

> If so, using the environment feels like a clunkyway to do that.
>
> How about a two-patch clean-up before this step?
>
>  (1) remove the handling of literal_global and friends that peek
>      into various environment variables from prefix_pathspec(),
>      which is a function that is repeatedly called for each pathspec
>      element given from the command line, and move that logic to
>      parse_pathspec(); pass necessary information down to
>      prefix_pathspec() as parameter(s);
>
>  (2) allow parse_pathspec() so that the caller can say "the default,
>      when there is no environment variable given by the end user to
>      tell us otherwise, is to :(glob)".
>

Sounds like a good thing to do anyway. Will do.
--=20
Duy
