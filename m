From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/3] clone: warn users --depth is ignored in local clones
Date: Tue, 24 Aug 2010 15:52:36 +1000
Message-ID: <AANLkTim-XWiZKdY20P+GEtPMTeTybhpBdkrGS=CMH56e@mail.gmail.com>
References: <1282565304-3122-1-git-send-email-pclouds@gmail.com>
	<20100824052846.GE20037@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 07:52:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnmRB-0005RM-FJ
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 07:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331Ab0HXFwj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 01:52:39 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49028 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab0HXFwh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 01:52:37 -0400
Received: by wyb35 with SMTP id 35so35878wyb.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 22:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sWR2kzvGoPWouG9iFDy4qmRAcV57jtqThR5qei1YolU=;
        b=x5JTuS0gQSerRd7SMKOme8MBL/xDCnTU5CrHImbmrFzJDMog5FJ5tLJqdgNFpUkab9
         dv+kuasErvO1ORP0BmG9nZ660saiG+XJhU7p4Do1H6jzOuX05H7+agBWZBKF33KyKRyZ
         h5EiOGZZ2nmSBHlIU7PfxZ2WbM4eS31Z3h94U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ODBcnrtyMnxLS23OpQlCdN2FksKwHGLTGMlP2G9pR/3ZGqp1mIN9xXLC+jsFfyNKlU
         yzK3vDhC4BM40iJQ6XWGRK/LmlRZGd24sg5j/F8obNa9z87QcrY+7jFh3t3/lof1Efje
         dP/wnbd2IteC1xOjurOfSr+Ab5cl/qKg9awMs=
Received: by 10.227.127.149 with SMTP id g21mr5323644wbs.218.1282629156639;
 Mon, 23 Aug 2010 22:52:36 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Mon, 23 Aug 2010 22:52:36 -0700 (PDT)
In-Reply-To: <20100824052846.GE20037@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154295>

On Tue, Aug 24, 2010 at 3:28 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> +++ b/builtin/clone.c
>> @@ -361,7 +361,7 @@ static void write_remote_refs(const struct ref
>> *local_refs)
>>
>> =C2=A0int cmd_clone(int argc, const char **argv, const char *prefix)
>> =C2=A0{
>> - =C2=A0 =C2=A0 int is_bundle =3D 0;
>> + =C2=A0 =C2=A0 int is_bundle =3D 0, is_local;
>> =C2=A0 =C2=A0 =C2=A0 struct stat buf;
>> =C2=A0 =C2=A0 =C2=A0 const char *repo_name, *repo, *work_tree, *git_=
dir;
>> =C2=A0 =C2=A0 =C2=A0 char *path, *dir;
>> @@ -414,6 +414,9 @@ int cmd_clone(int argc, const char **argv, const=
 char
>> *prefix)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 repo =3D xstrdup(ma=
ke_absolute_path(repo_name));
>> =C2=A0 =C2=A0 =C2=A0 else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 repo =3D repo_name;
>> + =C2=A0 =C2=A0 is_local =3D path && !is_bundle;
>> + =C2=A0 =C2=A0 if (is_local && option_depth)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 warning("--depth is igno=
red in local clones, use file://
>> instead.");
>
> Micronit: this comma should be a semicolon or period.

I'd leave it for Junio to edit the patch if he likes it.
--=20
Duy
