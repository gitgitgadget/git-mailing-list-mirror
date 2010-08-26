From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/7] Fix ignoring of pathspecs with rev-list --objects
Date: Fri, 27 Aug 2010 09:15:29 +1000
Message-ID: <AANLkTi=Y5tbdxc4f2j_1D1gib2gwEzNw6_Az3Ag9T1nn@mail.gmail.com>
References: <1282704795-29661-1-git-send-email-newren@gmail.com>
	<1282704795-29661-3-git-send-email-newren@gmail.com>
	<AANLkTimguNHXSFyO1EvS+dHbHiXU-dXTNwkWfEsVUbVC@mail.gmail.com>
	<AANLkTimCv-fn-h21pM8L9NiGg3w7OXBJ-kfiC+HJLsTP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, gitster <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 27 01:15:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OolfU-00044Q-Ij
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 01:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621Ab0HZXPc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Aug 2010 19:15:32 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51009 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660Ab0HZXPb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Aug 2010 19:15:31 -0400
Received: by wwb28 with SMTP id 28so2339638wwb.1
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 16:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NVqKarU5oyiq+3V5r7Pt41UlaiiNFu8iYiNmBDvBVh0=;
        b=F0l95WkC+reHIvlfzSMWYeBZXm5Gq0PLB6XLfjyjZFvfMyAlxFV4NgE0k9hP4rFUQC
         Iug5cta99HVKV5ZKyx3dYeVLMstnl24eCfPwbsA93AiePkk2WKhzpowm10qBKFz71noP
         os0Ln6iC++q28DN6bg4Jy4bHOwAkgwxohOGsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=U/BUn1YJX4LGXE8qxJcr8WfYgts7ITG4BQGTJQjCY+vpOfUIPuaVaiwiRJwCBbu4Qx
         YE4vJ4zyWP3XnOpWB6I2LIckPfniXBMT2/+70Izqi3VljXIk3abvmMbJGZYV0q1rmiNR
         xYlSPIo0slAQrahMZztT6y8fFd2DXuwq8gzX8=
Received: by 10.216.235.104 with SMTP id t82mr29200weq.103.1282864529255; Thu,
 26 Aug 2010 16:15:29 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Thu, 26 Aug 2010 16:15:29 -0700 (PDT)
In-Reply-To: <AANLkTimCv-fn-h21pM8L9NiGg3w7OXBJ-kfiC+HJLsTP@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154569>

On Thu, Aug 26, 2010 at 9:50 AM, Elijah Newren <newren@gmail.com> wrote=
:
>> While at it, can you please also fix its comments? The comments say
>> pathspec while what it uses is actually path prefix. Maybe something
>> like this
>>
>> diff --git a/tree-diff.c b/tree-diff.c
>> index 3c34c77..514dbca 100644
>> --- a/tree-diff.c
>> +++ b/tree-diff.c
>> @@ -83,7 +83,7 @@ static int compare_tree_entry(struct tree_desc *t1=
,
>> struct tree_desc *t2, const
>> =C2=A0}
>>
>> =C2=A0/*
>> - * Is a tree entry interesting given the pathspec we have?
>> + * Is a tree entry interesting given the path prefix we have?
>
> I believe the comment is parsed thus: "tree entry" =3D=3D combination=
 of
> desc, base, and baselen. =C2=A0"pathspec" =3D=3D paths and pathlens f=
ields of
> opt (which do provide a pathspec). =C2=A0So I believe the original wa=
s
> correct, though I can see how it's confusing at first.

Pathspec as in match_pathspec() in dir.c allows wildcards. Though it
seems only used with worktree or index-related operations. To me the
one with wildcard support is called pathspec. The one without is path
prefix. But it's probably just me.

There is also a GSoC suggestion about this [1] and I posted a related
patch a while back [2] but forgot it until now.

[1] https://git.wiki.kernel.org/index.php/SoC2010Ideas#Unify_Pathspec_S=
emantics

[2] http://mid.gmane.org/1243240924-5981-1-git-send-email-pclouds@gmail=
=2Ecom
--=20
Duy
