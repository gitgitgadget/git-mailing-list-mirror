From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3] help: always suggest common-cmds if prefix of cmd
Date: Mon, 29 Nov 2010 12:20:35 +0100
Message-ID: <AANLkTin34AfYnFY5e9B1cuyckfLXU2=qXFciFaaNGt9f@mail.gmail.com>
References: <AANLkTinKDqykfuV5=oHav9PRehDtJZct_q=zm7p8PAeo@mail.gmail.com>
 <1290787239-4508-1-git-send-email-kusmabite@gmail.com> <7voc9bpqj2.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ziade.tarek@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 12:21:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN1n9-0007dV-To
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 12:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332Ab0K2LU6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Nov 2010 06:20:58 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62813 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914Ab0K2LU5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Nov 2010 06:20:57 -0500
Received: by bwz15 with SMTP id 15so3776033bwz.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 03:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=s6T3huUkACk07bbSdOkUXRLLsMx7Jv3+xftE0B3+Gxk=;
        b=ugtvG8nOSv/7TCEdqeGr4H9cb/GvD3U0C6pmQnpD5oZgEMhgrDahtFsGBDKgVhc3b+
         wNmzylU9WpOT0cEVVy/bVmv1DeyrBpC2YNTI+FmDx4kxoqiON0cxbFAJEChD5/9kpyLV
         N9nB95WIVzA5lHx9I4YYTgbz1tf2AwBkRM2XA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=Jln2VcsrrvmyE1MRBvx8+CEjjx0ScE+rAuQcUY9Kca86oj5gtXxwEg5PzUETa4SaKk
         mQDJUVxicO7rd/dgt0wtTvSNKTRCZYaQijYZsfhmtbHhQvyzC5N4I0/wyFHEfEVHP435
         eJwZBXzADUPlN8+ytnOEw1WRyGPj0pfts3Lqg=
Received: by 10.204.118.209 with SMTP id w17mr4576193bkq.107.1291029656358;
 Mon, 29 Nov 2010 03:20:56 -0800 (PST)
Received: by 10.204.33.73 with HTTP; Mon, 29 Nov 2010 03:20:35 -0800 (PST)
In-Reply-To: <7voc9bpqj2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162383>

Sorry for the late reply, I've been out sick.

On Sat, Nov 27, 2010 at 1:18 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> @@ -320,9 +321,16 @@ const char *help_unknown_cmd(const char *cmd)
>> =A0 =A0 =A0 uniq(&main_cmds);
>>
>> =A0 =A0 =A0 /* This reuses cmdname->len for similarity index */
>> - =A0 =A0 for (i =3D 0; i < main_cmds.cnt; ++i)
>> - =A0 =A0 =A0 =A0 =A0 =A0 main_cmds.names[i]->len =3D
>> + =A0 =A0 for (i =3D 0; i < main_cmds.cnt; ++i) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 main_cmds.names[i]->len =3D 1 +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 levenshtein(cmd, main_cm=
ds.names[i]->name, 0, 2, 1, 4);
>> + =A0 =A0 =A0 =A0 =A0 =A0 for (n =3D 0; n < ARRAY_SIZE(common_cmds);=
 ++n) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(main_cmds.name=
s[i]->name,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 common_cmds[n].nam=
e) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !prefixcmp(main_cm=
ds.names[i]->name, cmd))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 main_cmds.=
names[i]->len =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>
> This is an error codepath so performance would not matter much, but t=
his
> is doing it in an unnecessarily slow way, no? =A0At this point, both =
arrays
> are sorted the same way, so we should be able to walk common_cmds[]
> alongside the main_cmds.names[] (see below).
>

I like it, thanks!

>> + =A0 =A0 if (n < main_cmds.cnt) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 best_similarity =3D main_cmds.names[n++]->=
len;
>> + =A0 =A0 =A0 =A0 =A0 =A0 while (n < main_cmds.cnt &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0best_similarity =3D=3D main=
_cmds.names[n]->len)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ++n;
>> + =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 best_similarity =3D 0;
>
> Think about what does this case _means_... The end user input was so
> ambiguous that it prefix matched all the common commands! =A0Is it re=
ally
> similar enough?
>
> Note that most of the time main_cmds[] has more than what common_cmds=
[]
> has, and because prefix match is done only against common_cmds[],
> "everything is a prefix-match" never happens. =A0You might want to ma=
rk it
> as a BUG(), but someday we may change the rules to give 0 to non comm=
on
> commands with prefix match under some condition, so thinking these ra=
re
> corner cases through would defend ourselves from future gotchas.
>
> How about doing it this way instead? =A0Isn't it more readable?
>

Yes, this is better. But:

> diff --git a/help.c b/help.c
> index 7f4928e..7654f1b 100644
> --- a/help.c
> +++ b/help.c
> @@ -3,6 +3,7 @@
> =A0#include "exec_cmd.h"
> =A0#include "levenshtein.h"
> =A0#include "help.h"
> +#include "common-cmds.h"
>
> =A0/* most GUI terminals set COLUMNS (although some don't export it) =
*/
> =A0static int term_columns(void)
> @@ -298,7 +299,8 @@ static void add_cmd_list(struct cmdnames *cmds, s=
truct cmdnames *old)
> =A0}
>
> =A0/* An empirically derived magic number */
> -#define SIMILAR_ENOUGH(x) ((x) < 6)
> +#define SIMILARITY_FLOOR 7
> +#define SIMILAR_ENOUGH(x) ((x) < SIMILARITY_FLOOR)
>
> =A0const char *help_unknown_cmd(const char *cmd)
> =A0{
> @@ -319,10 +321,28 @@ const char *help_unknown_cmd(const char *cmd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(main_cmds.names), cmdname_compare);
> =A0 =A0 =A0 =A0uniq(&main_cmds);
>
> - =A0 =A0 =A0 /* This reuses cmdname->len for similarity index */
> - =A0 =A0 =A0 for (i =3D 0; i < main_cmds.cnt; ++i)
> + =A0 =A0 =A0 /* This abuses cmdname->len for levenshtein distance */
> + =A0 =A0 =A0 for (i =3D 0, n =3D 0; i < main_cmds.cnt; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int cmp =3D 0; /* avoid compiler stupid=
ity */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *candidate =3D main_cmds.nam=
es[i]->name;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Does the candidate appear in common_=
cmds list? */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (n < ARRAY_SIZE(common_cmds) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(cmp =3D strcmp(common_c=
mds[n].name, candidate)) < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 n++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((n < ARRAY_SIZE(common_cmds)) && !c=
mp) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Yes, this is one of =
the common commands */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 n++; /* use the entry f=
rom common_cmds[] */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!prefixcmp(candidat=
e, cmd)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Give=
 prefix match a very good score */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 main_cm=
ds.names[i]->len =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continu=
e;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0main_cmds.names[i]->len =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 levenshtein(cmd, main_c=
mds.names[i]->name, 0, 2, 1, 4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 levenshtein(cmd, candid=
ate, 0, 2, 1, 4) + 1;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0qsort(main_cmds.names, main_cmds.cnt,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(*main_cmds.names), levenshtein_comp=
are);
> @@ -330,10 +350,21 @@ const char *help_unknown_cmd(const char *cmd)
> =A0 =A0 =A0 =A0if (!main_cmds.cnt)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die ("Uh oh. Your system reports no Gi=
t commands at all.");
>
> - =A0 =A0 =A0 best_similarity =3D main_cmds.names[0]->len;
> - =A0 =A0 =A0 n =3D 1;
> - =A0 =A0 =A0 while (n < main_cmds.cnt && best_similarity =3D=3D main=
_cmds.names[n]->len)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ++n;
> + =A0 =A0 =A0 /* skip and count prefix matches */
> + =A0 =A0 =A0 for (n =3D 0; n < main_cmds.cnt && !main_cmds.names[n]-=
>len; n++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ; /* still counting */
> +
> + =A0 =A0 =A0 if (main_cmds.cnt <=3D n) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* prefix matches with everything? that=
 is too ambiguous */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 best_similarity =3D SIMILARITY_FLOOR + =
1;

=46or this code-path to trigger we would have to be able to prefix-matc=
h
every common command AND every "main command" must be included in
common commands. At the same time. The only possible way to
prefix-match all commands is if they all start with the same letter.
Do you really think this is a situation we could ever end up in? Every
git command being a common-command, starting with the same letter?

This is basically unreachable code. Perhaps it'd be even clearer just t=
o die:

if (main_cmds.cnt <=3D n)
	die("Prefix-matched everyting, what's going on?");


> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* count all the most similar ones */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (best_similarity =3D main_cmds.name=
s[n++]->len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(n < main_cmds.cnt &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 best_similarity =3D=3D main=
_cmds.names[n]->len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0n++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ; /* still counting */
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0if (autocorrect && n =3D=3D 1 && SIMILAR_ENOUGH(best_s=
imilarity)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *assumed =3D main_cmds.name=
s[0]->name;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0main_cmds.names[0] =3D NULL;
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
