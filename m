From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] log: decorate grafted commits with "grafted"
Date: Thu, 18 Aug 2011 09:02:50 +0700
Message-ID: <CACsJy8DvbN6w_ZBpjPdjpdsyYPa=O2G8gpcu2Oxx-mbvz_+4=A@mail.gmail.com>
References: <1313593326-12077-1-git-send-email-pclouds@gmail.com> <7v8vqreuwk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 04:04:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtry3-0004TK-Rh
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 04:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744Ab1HRCDX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Aug 2011 22:03:23 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56145 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543Ab1HRCDW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2011 22:03:22 -0400
Received: by bke11 with SMTP id 11so1118409bke.19
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 19:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=czdjkXTL2yqctfO4GgXDQ+iWkjd+F+bBk3buh4NFGlk=;
        b=WnP7utu2aQAgUb4oZi3aQWf3U8gIH3+AiJahiV5MVFBAYJ41FDkyLN/eiREllbr6xy
         HWC7PFXrter3HGTY3HhxR10dJqWaf1tghMshepdYVIYJOazC+oda+YMlByUhLKaVAXYX
         gKdZlbNbm1i8geIzBcp/meuGalWOK5zGI8ktM=
Received: by 10.204.233.76 with SMTP id jx12mr56647bkb.71.1313633000254; Wed,
 17 Aug 2011 19:03:20 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Wed, 17 Aug 2011 19:02:50 -0700 (PDT)
In-Reply-To: <7v8vqreuwk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179552>

2011/8/18 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> @@ -638,6 +640,9 @@ int log_tree_commit(struct rev_info *opt, struct=
 commit *commit)
>> =C2=A0 =C2=A0 =C2=A0 log.parent =3D NULL;
>> =C2=A0 =C2=A0 =C2=A0 opt->loginfo =3D &log;
>>
>> + =C2=A0 =C2=A0 if (!commit->parents && lookup_commit_graft(commit->=
object.sha1))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_name_decoration(DECO=
RATION_GRAFTED, "grafted",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &commit->object);
>
> I am not very enthused about this change.
>
> We have already looked up the commit when we parsed it, and then we a=
gain
> have to call lookup_commit_graft() which would yield false for most o=
f the
> commits?

which is why there's "!commit->parents" check. I made this patch with
shallow clone in mind. You probably have seen that if grafts are used
to extend history instead of cutting it, it won't show.

> Does this work with replacements and shallows, by the way?

Shallows, yes (that was my aim). Replacements, no. A better way would
be go over commit_graft[] and replace_object[] arrays, decorate all
grafted/replaced commits, instead of checking in log_tree_commit().
--=20
Duy
