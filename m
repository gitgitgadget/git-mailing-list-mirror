From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 04/19] Convert struct diff_options to use struct pathspec
Date: Tue, 14 Dec 2010 12:02:39 +0700
Message-ID: <AANLkTim_SfWQ4OTsj0Are8kJGbiOLoj1wTa92qhb0KJA@mail.gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
 <1292233616-27692-5-git-send-email-pclouds@gmail.com> <7vhbeh1oru.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 06:03:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSN2m-0004Wo-S6
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 06:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071Ab0LNFDQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Dec 2010 00:03:16 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47357 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab0LNFDP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 00:03:15 -0500
Received: by wwa36 with SMTP id 36so190152wwa.1
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 21:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=v2bI4/Nm6pOtugrpwcqGb7BpI9RyROBB4UbMsCk6A8E=;
        b=CifzWF8jqyJWxTcslxpFmzj9vSLrKuViDWb8sEeJyzS57k4mKzzf3/gNyiJBf23U7a
         FI9cKrqmN9BlbpjYKBdAtPtEUF9WPuStuVJzzdOEKLPe95TqOSbidgt4EeFsZvRWHmEK
         EBvUFEacYj0A7nM1kT+V+koEKoNJnOlNJ5fuk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RE0+sn5jzo2PcwNa8W1zqdiXIcx9KKwQb4oRJtGEV+QhPmInRxcOCKFSSF9bcOu2yK
         xrHvr9oifMj3NJ9CYWnbOGvr1+GqS+l6fg1As67lX2fL3mtwmbr7Zm89WE1KS0ed/N4S
         7PqWJSbDlFiU7XA9d9qipavGhQrGUYsw5erNk=
Received: by 10.216.24.134 with SMTP id x6mr4124149wex.34.1292302994095; Mon,
 13 Dec 2010 21:03:14 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Mon, 13 Dec 2010 21:02:39 -0800 (PST)
In-Reply-To: <7vhbeh1oru.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163625>

2010/12/14 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> diff --git a/diff-lib.c b/diff-lib.c
>> index 392ce2b..3b809f2 100644
>> --- a/diff-lib.c
>> +++ b/diff-lib.c
>> @@ -501,7 +501,7 @@ int do_diff_cache(const unsigned char *tree_sha1=
, struct diff_options *opt)
>> =C2=A0 =C2=A0 =C2=A0 active_nr =3D dst - active_cache;
>>
>> =C2=A0 =C2=A0 =C2=A0 init_revisions(&revs, NULL);
>> - =C2=A0 =C2=A0 revs.prune_data =3D opt->paths;
>> + =C2=A0 =C2=A0 revs.prune_data =3D opt->pathspec.raw;
>> =C2=A0 =C2=A0 =C2=A0 tree =3D parse_tree_indirect(tree_sha1);
>> =C2=A0 =C2=A0 =C2=A0 if (!tree)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("bad tree objec=
t %s", sha1_to_hex(tree_sha1));
>
> Hopefully the prune_data will become opt->pathspec not "raw" and use =
your
> generalied/unified pathspec matching code in later patches in the ser=
ies,
> yes?

Yes. But that needs closer look. "prune_data" is void* and casted in
many places. Compiler won't catch mistyping for us.
--=20
Duy
