From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] Convert resolve_ref+xstrdup to new resolve_refdup function
Date: Sat, 10 Dec 2011 22:40:22 +0700
Message-ID: <CACsJy8C0CJyHdtWJ5QVqX9ksHWgdBpm6XekQ+mZP4sxBVA_8vQ@mail.gmail.com>
References: <1323521631-24320-1-git-send-email-pclouds@gmail.com> <20111210131503.GI22035@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Tony Wang <wwwjfy@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 16:41:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZP2s-0000ii-KC
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 16:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798Ab1LJPk4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Dec 2011 10:40:56 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42303 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764Ab1LJPkz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2011 10:40:55 -0500
Received: by bkcjm19 with SMTP id jm19so103922bkc.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 07:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=hLMutzc0h4XdpWUbCaNXXBWVmwg3mggS868g6DhFWdI=;
        b=Cxg/SH7xfp6luU49Xlkl+uX3aLcc3iblj5emStH0pddyghMyO4EHOWB6emsmV00hQ7
         gL9AEQDOzTYNvxCV+YE+fBW8bn2nCudAYhM4rSPo98xwYtRlJj40TnTVymWyPrLXbhWD
         vos6Fc95sXFEv18372Abr8KYxMgHovd37998U=
Received: by 10.205.126.18 with SMTP id gu18mr6006285bkc.79.1323531653285;
 Sat, 10 Dec 2011 07:40:53 -0800 (PST)
Received: by 10.204.129.205 with HTTP; Sat, 10 Dec 2011 07:40:22 -0800 (PST)
In-Reply-To: <20111210131503.GI22035@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186783>

2011/12/10 Jonathan Nieder <jrnieder@gmail.com>:
>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
>> @@ -901,7 +901,7 @@ static int rollback_single_pick(void)
>> =C2=A0 =C2=A0 =C2=A0 if (!file_exists(git_path("CHERRY_PICK_HEAD")) =
&&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !file_exists(git_path("REVERT_HEA=
D")))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error(_("no =
cherry-pick or revert in progress"));
>> - =C2=A0 =C2=A0 if (!resolve_ref("HEAD", head_sha1, 0, NULL))
>> + =C2=A0 =C2=A0 if (read_ref_full("HEAD", head_sha1, 0, NULL))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error(_("can=
not resolve HEAD"));
>> =C2=A0 =C2=A0 =C2=A0 if (is_null_sha1(head_sha1))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error(_("can=
not abort from a branch yet to be born"));
>
> Unrelated change that snuck in, I assume?

Yeah that slipped in. It should be part of c689332 (Convert many
resolve_ref() calls to read_ref*() and ref_exists() - 2011-11-13). I
guess either I missed it or it was a new call site after that patch.
Split it out as a separate patch?
--=20
Duy
