From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 07/10] clone: --branch=<branch> always means refs/heads/<branch>
Date: Thu, 12 Jan 2012 10:00:17 +0700
Message-ID: <CACsJy8DRCqhMqp9n1qrXakRHTBk1SWeCWu5jp0bngXuMQPY88w@mail.gmail.com>
References: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
 <1326189427-20800-8-git-send-email-pclouds@gmail.com> <7v4nw26mbe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 04:01:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlAuV-0006yj-3w
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 04:01:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486Ab2ALDAv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 22:00:51 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35806 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392Ab2ALDAt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 22:00:49 -0500
Received: by bkvi17 with SMTP id i17so927633bkv.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 19:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2lSh6ANY1uH48fbzxA3oR4Jr6SL2dUOqwuU9tSaDwPk=;
        b=UzTMDGo/G1hQLNvtxlknYN4qH6dcabV6diZoCwKHRHg1x4K2nyQatJCrqfavbnHmz3
         avf5VO+X1nIB/EooystNFvRupDvzOqu/hM092iDByN6Udlv80+4FjDkBA0WzwhJrd08T
         DRydADaDAQWnOH+iSYOTIIsP8dFIoi9+qQgrU=
Received: by 10.205.132.14 with SMTP id hs14mr471128bkc.130.1326337248166;
 Wed, 11 Jan 2012 19:00:48 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Wed, 11 Jan 2012 19:00:17 -0800 (PST)
In-Reply-To: <7v4nw26mbe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188421>

2012/1/12 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> It does not make sense to look outside refs/heads for HEAD's target
>> (src_ref_prefix can be set to "refs/" if --mirror is used) because r=
ef
>> code only allows symref in form refs/heads/...
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> =C2=A0builtin/clone.c | =C2=A0 =C2=A04 ++--
>> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index 05224d7..960242f 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -463,7 +463,7 @@ static void update_remote_refs(const struct ref =
*refs,
>> =C2=A0static void update_head(const struct ref *our, const struct re=
f *remote,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 const char *msg)
>> =C2=A0{
>> - =C2=A0 =C2=A0 if (our) {
>> + =C2=A0 =C2=A0 if (our && !prefixcmp(our->name, "refs/heads/")) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Local default br=
anch link */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 create_symref("HEAD=
", our->name, NULL);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!option_bare) {
>
> I think this makes sense. In the following three casees:
>
> =C2=A0- When cloning without --branch, if we could not find a branch =
that match
> =C2=A0 HEAD at the remote;
>
> =C2=A0- When cloning with --branch, if we did not see such a branch a=
t the
> =C2=A0 remote; or
>
> =C2=A0- When cloning from an empty repository
>
> we come here with "our" set to NULL. Additionally, if the remote HEAD
> points outside refs/heads/ and the transport could detect that case
> (e.g. a helper that reads from ls-remote output), we can see our->nam=
e
> outside refs/heads/. Is there any other case where our is not NULL an=
d
> our->name does not start with refs/heads/?

No, this patch pretty much guarantees that our->name must be inside
refs/heads, unless remote's HEAD points outside, which makes it a
broken remote and git-upload-pack should refuse to serve in the first
place. Until --branch=3Dtag comes into the picture.

> The "else if (remote)" clause (not shown, outside the context) that
> follows still has comments that says it is a case for "Source had det=
ached
> HEAD pointing somewhere", and needs to be adjusted for this change, n=
o? It
> is "(1) we know the HEAD points at a non-branch, (2) HEAD may point a=
t a
> branch but we do not know which one, or (3) we asked for a specific b=
ranch
> but it did not exist there" (cloning from an empty will have NULL in
> remote and the comment would not apply to that case).

Yes.
--=20
Duy
