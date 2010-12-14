From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 15/19] pathspec: add match_pathspec_depth()
Date: Tue, 14 Dec 2010 12:07:12 +0700
Message-ID: <AANLkTikmkr8aSH_tmRJJajHSvw81YHQtJsZ4RqNd+Hx=@mail.gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
 <1292233616-27692-16-git-send-email-pclouds@gmail.com> <7vzks9zd3f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 06:07:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSN7F-0005la-Rn
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 06:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674Ab0LNFHp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Dec 2010 00:07:45 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37972 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624Ab0LNFHo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 00:07:44 -0500
Received: by wwa36 with SMTP id 36so192391wwa.1
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 21:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=fTvrkhV6s3yUplb5R+lOdxxvU1Xp/yMXk5oQdusctU8=;
        b=RQ+080+XEpiZLObn5eMUVyaoqUidnS30r7nyHuBGjvVkmSjaPCVuJSwwAKfbfinLja
         5lQ4AmoAy1uidHzO8jihzzMoOOKe2cB5yreamL2Ohlq3UZQqlyFPg4t4G/RiBDOJhRd+
         eU6aoqq/2pDdEEwMvwMo1ZzVIhtLwiMpp9pwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BYqfOAG756Yit2ssiuQlSHU+epqdpb7aoD8u4Pjl27kRo8fe0EWyez+P49vC4FwV5p
         sIry4a8JZg5OZYmnmAXV7AcoIchEZzutDDiTnOKwxyxJbrDK9IsKtaPkBDjk60p8hkUM
         L9RDr6U7AjTEtqH8vtNb+zNxSwQyJxf13bE6Q=
Received: by 10.216.177.9 with SMTP id c9mr5686651wem.34.1292303262896; Mon,
 13 Dec 2010 21:07:42 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Mon, 13 Dec 2010 21:07:12 -0800 (PST)
In-Reply-To: <7vzks9zd3f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163626>

2010/12/14 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> match_pathspec_depth() is similar to match_pathspec() except that it
>> can take depth limit.
>>
>> In long term, match_pathspec() should be removed in favor of this
>> function.
>
> Hmm, this strongly suggests that match_pathspec() should take "const
> struct pathspec *" which already contains the necessary information a=
nd
> more, including the depth limit, no?

Good idea. Thanks!

>> +int match_pathspec_depth(const char **pathspec, int max_depth,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0const char *name, int namelen,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0int prefix, char *seen)
>> +{
>> + =C2=A0 =C2=A0 int i, retval =3D 0;
>> +
>> + =C2=A0 =C2=A0 if (!pathspec) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (max_depth =3D=3D -1)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return MATCHED_RECURSIVELY;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (within_depth(name, n=
amelen, 0, max_depth))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return MATCHED_EXACTLY;
>
> Why the difference between _RECURSIVELY and _EXACTLY here? =C2=A0If y=
ou have a
> five-level deep project and give max-depth of 1000, shouldn't you get=
 the
> same result as you run the same command with unlimited depth?

But if max-depth is 5 and the project is 1000-level deep, it should
return _EXACTLY, not _RECURSIVELY, right?
--=20
Duy
