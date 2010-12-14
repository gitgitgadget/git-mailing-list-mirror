From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 11/19] tree_entry_interesting: support depth limit
Date: Tue, 14 Dec 2010 21:44:48 +0700
Message-ID: <AANLkTikkU1h3vYDGpf4h8-9-sSWeYqtnZh1ZfB3NU3Db@mail.gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
 <1292233616-27692-12-git-send-email-pclouds@gmail.com> <7vwrnd1r2s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 15:45:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSW85-0005lY-BS
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 15:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756832Ab0LNOpU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Dec 2010 09:45:20 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54471 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756678Ab0LNOpT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 09:45:19 -0500
Received: by wyb28 with SMTP id 28so534212wyb.19
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 06:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=236Ek4nX52xZBYVmxWCTG1EMPjXaQs361QrbPH07Mv4=;
        b=TvNx85696MG4U0Z+CxszmjGPO/wMkcz5N2Xul3rQjr73z45za+REJMTSE0+7bWEnkm
         D5XhyBXQdOQXq19g013vc5RmaS/BRjDQ1olSGA2KCqn9wMhEdZeJEkh9gEsAQpr4gdN0
         SG5sthGTuW3ncwaa5oMG2hV/rdldT3FAqnphI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BwnAp2Fjk0HubyBo1GlUm2FIhK2ExGRGwK19ygumDIXeLjzvn23TN2J8fG3TdqH1Kj
         QkdSJuR17rOaoDL3Wfrg04aAWENlXPeSuEvKpLcUFc1C9RZ/7G5Y5Xwm49ti90CDaXKb
         +ySymujQcuUwPxwOcDHvBTO4bSWFebgW2BI6Y=
Received: by 10.216.30.144 with SMTP id k16mr4869025wea.19.1292337918140; Tue,
 14 Dec 2010 06:45:18 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Tue, 14 Dec 2010 06:44:48 -0800 (PST)
In-Reply-To: <7vwrnd1r2s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163651>

2010/12/14 Junio C Hamano <gitster@pobox.com>:
>> +int within_depth(const char *name, int namelen,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 int depth, int max_depth)
>> +{
>> + =C2=A0 =C2=A0 const char *cp =3D name, *cpe =3D name + namelen;
>> +
>> + =C2=A0 =C2=A0 while (cp < cpe) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*cp++ !=3D '/')
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 continue;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 depth++;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (depth > max_depth)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return 0;
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 return 1;
>> +}
>
> Makes me almost suspect that it may make more sense to keep track of =
the
> "depth" in a similar way as "base" and "baselen" as "traversal state"=
 on
> the side of the caller so that you do not have to scan the string for
> slashes over and over again. =C2=A0But given the codeflow, doing so m=
ight make
> the result look too ugly, so I won't recommend that without thinking,
> though.

Moreover, this function is also used by match_pathspec_depth().

>> - =C2=A0 =C2=A0 if (!ps || !ps->nr)
>> + =C2=A0 =C2=A0 if (!ps)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
>>
>> + =C2=A0 =C2=A0 if (!ps->nr) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ps->recursive || ps=
->max_depth =3D=3D -1)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return 1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return !!within_depth(ba=
se, baselen,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !!S_ISDIR(entry->m=
ode),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ps->max_depth);
>> + =C2=A0 =C2=A0 }
>
> This gives different behaviour to between callers that give you NULL =
as
> pathspec and callers that give you a pathspec with zero elements. =C2=
=A0Is this
> intended? =C2=A0What is the use case (iow, what does an end user give=
 from the
> command line to experience this difference)?

Old pathspec type's legacy. When pathspec is of "const char **", it
can be NULL. When struct pathspec is used, I don't think we need to
support NULL pathspec. Will remove that "if (!ps)" clause.

>> @@ -571,7 +580,13 @@ int tree_entry_interesting(const struct name_en=
try *entry,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (!match_dir_prefix(base, baselen, match, matchlen))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Just a random prefix match */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return 2;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (!ps->recursive || ps->max_depth =3D=3D -1)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 2;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return !!within_depth(base+matchlen+1, baselen-matchlen-1,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 !!S_ISDIR(entry->mode),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ps->max_depth);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
> If two pathspecs that overlap with each other (e.g. "Documentation/" =
and
> "Documentation/technical") are given, and if the shorter one comes be=
fore
> the longer one in ps[], wouldn't this give you an unexpected result? =
=C2=A0When
> inspecting "Documentation/technical/api/foo.txt" with depth limit of =
2, if
> you didn't have "Documentation/" pathspec, you count "api/foo.txt"
> relative to "Documentation/technical", declare that the path is withi=
n
> limit, and show it. =C2=A0But if you have "Documentation/" in ps[], y=
ou look at
> it, decide "technical/api/foo.txt" is too deep and return false witho=
ut
> even looking at "Documentation/technical" that may appear later in ps=
[],
> no?

Right. Hmm.. grep's pathspec_matches() probably has this problem too.
--=20
Duy
