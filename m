From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Fix incorrect ref namespace check
Date: Wed, 11 Jan 2012 08:54:43 +0700
Message-ID: <CACsJy8Af=PjXE4sHqSk1v8qoraivOnT2w495W1c1dVQBW1s-cQ@mail.gmail.com>
References: <1325766924-14943-1-git-send-email-pclouds@gmail.com>
 <1325767180-15083-1-git-send-email-pclouds@gmail.com> <7v39bunmno.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jan 11 02:55:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RknPP-0005eB-6x
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 02:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933391Ab2AKBzR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 20:55:17 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34763 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932646Ab2AKBzP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 20:55:15 -0500
Received: by bkvi17 with SMTP id i17so151987bkv.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 17:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=BeT0+HlebpTl3oiCVrpCO5g8sU5omadgCSG8Pjn9tt0=;
        b=Zv7bAXKMCvphw70KmeQXIH2wYBJGAMWN8g/QQw0Rx1PkV98LjTBTBXISimnMT4KS58
         qAwPnf+ZVO6fy4kE4e1I7TU2O8g+M7dktLqe389rzQxuw5s7EMRFrfoYph4jFZPPAnrQ
         NkhnJ66xbcqdewPEdQVvE/ZPKHJAHhZKxrJxo=
Received: by 10.204.156.156 with SMTP id x28mr9663965bkw.76.1326246914233;
 Tue, 10 Jan 2012 17:55:14 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Tue, 10 Jan 2012 17:54:43 -0800 (PST)
In-Reply-To: <7v39bunmno.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188310>

Any comments Mike?

2012/1/5 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> The reason why the trailing slash is needed is obvious. refs/stash a=
nd
>> HEAD are not namespace, but complete refs. Do full string compare on=
 them.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> =C2=A0I missed prefixcmp(..., "HEAD") right below prefixcmp(..., "re=
fs/stash")
>
> As Michael has been actively showing interest in cleaning up the area=
, he
> should have been CC'ed, I would think.
>
>>
>> =C2=A0builtin/fetch.c =C2=A0| =C2=A0 =C2=A02 +-
>> =C2=A0builtin/remote.c | =C2=A0 =C2=A02 +-
>> =C2=A0log-tree.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A04 ++--
>> =C2=A03 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index 33ad3aa..daa68d2 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -573,7 +573,7 @@ static void find_non_local_tags(struct transport=
 *transport,
>>
>> =C2=A0 =C2=A0 =C2=A0 for_each_ref(add_existing, &existing_refs);
>> =C2=A0 =C2=A0 =C2=A0 for (ref =3D transport_get_remote_refs(transpor=
t); ref; ref =3D ref->next) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prefixcmp(ref->name,=
 "refs/tags"))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prefixcmp(ref->name,=
 "refs/tags/"))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 continue;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> diff --git a/builtin/remote.c b/builtin/remote.c
>> index 583eec9..f54a89a 100644
>> --- a/builtin/remote.c
>> +++ b/builtin/remote.c
>> @@ -534,7 +534,7 @@ static int add_branch_for_removal(const char *re=
fname,
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 /* don't delete non-remote-tracking refs */
>> - =C2=A0 =C2=A0 if (prefixcmp(refname, "refs/remotes")) {
>> + =C2=A0 =C2=A0 if (prefixcmp(refname, "refs/remotes/")) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* advise user how =
to delete local branches */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!prefixcmp(refn=
ame, "refs/heads/"))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 string_list_append(branches->skipped,
>> diff --git a/log-tree.c b/log-tree.c
>> index 319bd31..535b905 100644
>> --- a/log-tree.c
>> +++ b/log-tree.c
>> @@ -119,9 +119,9 @@ static int add_ref_decoration(const char *refnam=
e, const unsigned char *sha1, in
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D DECORATION=
_REF_REMOTE;
>> =C2=A0 =C2=A0 =C2=A0 else if (!prefixcmp(refname, "refs/tags/"))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D DECORATION=
_REF_TAG;
>> - =C2=A0 =C2=A0 else if (!prefixcmp(refname, "refs/stash"))
>> + =C2=A0 =C2=A0 else if (!strcmp(refname, "refs/stash"))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D DECORATION=
_REF_STASH;
>> - =C2=A0 =C2=A0 else if (!prefixcmp(refname, "HEAD"))
>> + =C2=A0 =C2=A0 else if (!strcmp(refname, "HEAD"))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D DECORATION=
_REF_HEAD;
>>
>> =C2=A0 =C2=A0 =C2=A0 if (!cb_data || *(int *)cb_data =3D=3D DECORATE=
_SHORT_REFS)



--=20
Duy
