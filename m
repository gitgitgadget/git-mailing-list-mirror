From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] help: always suggest common-cmds if prefix of cmd
Date: Wed, 24 Nov 2010 21:20:45 +0100
Message-ID: <AANLkTi=nxcODCvQ6hmaQe=q38e=bF7cRHWrRaFr+zen6@mail.gmail.com>
References: <AANLkTina0tnOEE2+17W03pFPqg37Btss0HYBeW+pOEgn@mail.gmail.com>
 <1290539473-2420-1-git-send-email-kusmabite@gmail.com> <7v1v6atsbd.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ziade.tarek@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 21:21:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLLq6-0006PN-GV
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 21:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600Ab0KXUVI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Nov 2010 15:21:08 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46292 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278Ab0KXUVH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Nov 2010 15:21:07 -0500
Received: by fxm13 with SMTP id 13so127728fxm.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 12:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=bAT4g8iHqOUw9J3LglfVU2qJdqSu62Q4ybER5n0Jvz0=;
        b=rJbE9//FqZfEo/Zsl7EGu/Bzri+hSd4qAraVU2Ivfp/2YY22DWkUHOfVEZ+M4UU+ac
         kQPveyYvt8BjPIMfCjz1emT76Ll9Z39YIAr4DqeRAbK8vwJjTMsMb/NPZTIOaJWSwDTB
         5NB2gUwMwMn27TQweqECTyxeau0K+d2FRXMVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=tKzpKsRW1DpGTJlVOr2uQH7L5xkXd6utqpIAlj72lElZW15dXUpnPJ79qS044P24RO
         wx0/NRpyB7ypox1Z1Fxo84pxRlmc1Z5D0B//nlE1+L7Dwv6e18XNp8Mi7O2rscH1rqcw
         sbFDqZ19uJiE0RaQOW5I/iMvMnIbkAPa98Ed0=
Received: by 10.223.100.15 with SMTP id w15mr6482142fan.121.1290630065193;
 Wed, 24 Nov 2010 12:21:05 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Wed, 24 Nov 2010 12:20:45 -0800 (PST)
In-Reply-To: <7v1v6atsbd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162080>

On Wed, Nov 24, 2010 at 8:49 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> @@ -320,9 +321,16 @@ const char *help_unknown_cmd(const char *cmd)
>> =A0 =A0 =A0 uniq(&main_cmds);
>>
>> =A0 =A0 =A0 /* This reuses cmdname->len for similarity index */
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
> So main_cmds.names[]->len (which is not "len" anymore at this point b=
ut is
> just a "score") gets levenshtein distance (i.e. a smaller number indi=
cates
> cmd is more likely to be a typo of it), and in addition ->len =3D=3D =
0 is "it
> is prefix". =A0Overall, the smaller the score, the likelier the match=
=2E
>

Correct. This was already the case, though. I just reserved len =3D 0 a=
s
"this is a prefix of the entered command".

>> @@ -330,9 +338,12 @@ const char *help_unknown_cmd(const char *cmd)
>> =A0 =A0 =A0 if (!main_cmds.cnt)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 die ("Uh oh. Your system reports no Git =
commands at all.");
>>
>> - =A0 =A0 best_similarity =3D main_cmds.names[0]->len;
>> - =A0 =A0 n =3D 1;
>> - =A0 =A0 while (n < main_cmds.cnt && best_similarity =3D=3D main_cm=
ds.names[n]->len)
>> + =A0 =A0 n =3D 0;
>> + =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 best_similarity =3D main_cmds.names[n++]->=
len;
>> + =A0 =A0 } while (!best_similarity);
>
> At this point, main_cmds.names[] is sorted by the above score (smalle=
r to
> larger), and first you skip all the "prefix" ones that score 0.
>
> This relies on the fact that there is at least one entry with non-zer=
o
> score, which in practice is true, but without even a comment? =A0I fe=
el
> dirty.
>

Ah, yes. This needs clearer code badly. I'll see what I can cook up.

> The score of the first non-prefix entry is in best_similarity and tha=
t
> entry is at main_cmds.names[n-1] at this point. =A0You haven't checke=
d
> main_cmds.names[n] yet...
>
>> + =A0 =A0 n++;
>
> ... but you increment n to skip that entry without even looking, and =
then
> go on to ...
>

This is a bug, thanks for spotting it. It was intended to be the same
as "i =3D 1" in the old version, but I didn't think about it being
increased in the previous loop as well, silly me.

>> + =A0 =A0 while (n < main_cmds.cnt && best_similarity >=3D main_cmds=
=2Enames[n]->len)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ++n;
>
> You skip the entries with the same similarity as the closest typo,
> presumably to point n to the first entry that is irrelevant (i.e. 0 t=
hru n
> but not including n are candidates).
>
> Your rewrite of the loop makes it very hard to read and spot bugs, I
> think.
>

Indeed. What about this intra-diff? Hopefully it's a bit clearer, as
it's closer to the original, just reusing the same logic for the new
similar loop... Also makes the final diff smaller, which is nice.

diff --git a/help.c b/help.c
index dc76a62..d02a019 100644
--- a/help.c
+++ b/help.c
@@ -339,11 +339,10 @@ const char *help_unknown_cmd(const char *cmd)
 		die ("Uh oh. Your system reports no Git commands at all.");

 	n =3D 0;
-	do {
-		best_similarity =3D main_cmds.names[n++]->len;
-	} while (!best_similarity);
-	n++;
-	while (n < main_cmds.cnt && best_similarity >=3D main_cmds.names[n]->=
len)
+	while (n < main_cmds.cnt && !main_cmds.names[n]->len)
+		++n;
+	best_similarity =3D main_cmds.names[n++]->len;
+	while (n < main_cmds.cnt && best_similarity =3D=3D main_cmds.names[n]=
->len)
 		++n;
 	if (autocorrect && n =3D=3D 1 && SIMILAR_ENOUGH(best_similarity)) {
 		const char *assumed =3D main_cmds.names[0]->name;
