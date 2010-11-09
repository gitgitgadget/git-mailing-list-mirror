From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] dir.c: fix EXC_FLAG_MUSTBEDIR match in sparse checkout
Date: Tue, 9 Nov 2010 09:47:01 +0700
Message-ID: <AANLkTin7Rg19=vxO3PtcxEEXH2XeB92_VHxXPKgMbEqK@mail.gmail.com>
References: <loom.20101107T172926-284@post.gmane.org> <1289153098-15684-1-git-send-email-pclouds@gmail.com>
 <7vfwvbpo9c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, thomasr@sailguy.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 03:47:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFeF6-0004ih-JZ
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 03:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923Ab0KICrX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Nov 2010 21:47:23 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33157 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722Ab0KICrW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Nov 2010 21:47:22 -0500
Received: by wyb36 with SMTP id 36so4337199wyb.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 18:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Cu8PyhInnBjUzsM9eHdGpN5i76e8vmLJA0K5GNCp9Dk=;
        b=LZeiVBHGHwT1ayE63os+yA6KfK+SRbz8M2OCyLew1jGFqRbW54xPkshjgyRnUwTuP5
         3nWkOtBCldRpY3NyTOuGJSNUXKplBeIf7aIvF/vhpq5XQpp3pdRpCUxpCJR5f/BM0lhH
         wmoWU13PkdY8MJTuJBlcMB10zd29pqT6FatEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FlHErj49QBoO5k8KkzcSKOLyNyzslvdPAnd+gvu2dLWe2GclpMzXF5EHTA1Yes46qu
         LznmclKtzuihekUh5yIMFcFo0akC7MD89aIVhCXijSJu/eCaNnp3kMTsoOWsELeJSvE8
         BbIRyjY7qspjyR6Av0Yil9mIphTipMLlDNIdc=
Received: by 10.216.35.74 with SMTP id t52mr6264370wea.41.1289270841201; Mon,
 08 Nov 2010 18:47:21 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Mon, 8 Nov 2010 18:47:01 -0800 (PST)
In-Reply-To: <7vfwvbpo9c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161012>

2010/11/9 Junio C Hamano <gitster@pobox.com>:
>> diff --git a/dir.c b/dir.c
>> index d1e5e5e..b2dfb69 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -360,7 +360,8 @@ int excluded_from_list(const char *pathname,
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (x->flags & EXC_FLAG_MUSTBEDIR) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!dtype) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!prefix=
cmp(pathname, exclude))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!prefix=
cmp(pathname, exclude) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 pathname[x->patternlen] =3D=3D '/')
>
> - Can pathname be much shorter than x->patternlen (it doesn't matter =
as
> =C2=A0prefixcmp will return false in that case)?

prefixcmp will return non-zero in that case.

> - Can pathname be equal to exclude (yes it can but in that case pathn=
ame
> =C2=A0is not a directory but is a regular file, symlink or a submodul=
e)?

In index context, regular files, symlinks and submodules are the same
and should not match here even if they're equal to exclude (the
original exclude is "foo/". The trailing slash was converted to
EXC_FLAG_MUSTBEDIR).

> So it may be a tricky code, but I do not think it is a "workaround" i=
n any
> way. =C2=A0Isn't it just a "correct solution"?

Hmm.. when I added it, unpack-trees.c was the only callsite and it was
a workaround (i.e. foo/ match foo directory, but foo alone does not).

> By the way, builtin/add.c calls excluded() with DT_UNKNOWN and relies=
 on
> the fact that the macro is accidentally defined as 0. =C2=A0108da0d (=
git add:
> Add the "--ignore-missing" option for the dry run, 2010-07-10). =C2=A0=
If it
> means NULL, it should spell it out as such.

It does mean NULL. Should builtin/add.c pass a proper pointer that
contains DT_UNKNOWN instead? DT_UNKNOWN has special treatment (right
after that "if").

diff --git a/builtin/add.c b/builtin/add.c
index eed37bf..b104851 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -446,7 +446,8 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 			if (!seen[i] && pathspec[i][0]
 			    && !file_exists(pathspec[i])) {
 				if (ignore_missing) {
-					if (excluded(&dir, pathspec[i], DT_UNKNOWN))
+					int dtype =3D DT_UNKNOWN;
+					if (excluded(&dir, pathspec[i], &dtype))
 						dir_add_ignored(&dir, pathspec[i], strlen(pathspec[i]));
 				} else
 					die(_("pathspec '%s' did not match any files"),
--=20
Duy
