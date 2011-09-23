From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Bug: git log --numstat counts wrong
Date: Sat, 24 Sep 2011 00:38:19 +0800
Message-ID: <CALUzUxoujys1eWL6i6YJmFZZakcQx8oa8ZbRjixUzANB1Hpb3Q@mail.gmail.com>
References: <D3CF0A47-64DA-4EBB-9DCD-D2D714596C50@inf.fu-berlin.de>
	<7vr53a2icn.fsf@alter.siamese.dyndns.org>
	<3BF8BA51-4CAA-40A2-8B45-D39AAEE58E6F@inf.fu-berlin.de>
	<7vobyd1vmo.fsf@alter.siamese.dyndns.org>
	<7vobycxy71.fsf@alter.siamese.dyndns.org>
	<CALUzUxrswZ+AREq+OeqpTsnoB4J+_aExfmAA6X3cauJqj8RnpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexander Pepper <pepper@inf.fu-berlin.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 18:38:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R78le-0000Yz-0v
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 18:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527Ab1IWQiV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Sep 2011 12:38:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62516 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099Ab1IWQiV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2011 12:38:21 -0400
Received: by fxe4 with SMTP id 4so3985769fxe.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 09:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=55k5oiUWpcySxZaStbnzkpAriTNVIc6x1p/pYNe2YZY=;
        b=btdPgsLthIHh3UGwt3CFNQoinv0W/TRJp3EAOATKSld5Z8ULHlArQLNG/lKOYagrhU
         rZaCedptkJFLmVNeB9TIwRWHGjKrWhdoDlXuRGKS0TUBkaH1LbuwhEaljy2cF+czVCBQ
         dekDeOAuDkABymftXxPBsF6oJvbfcHTdLLd5M=
Received: by 10.223.33.10 with SMTP id f10mr768473fad.121.1316795899889; Fri,
 23 Sep 2011 09:38:19 -0700 (PDT)
Received: by 10.223.79.65 with HTTP; Fri, 23 Sep 2011 09:38:19 -0700 (PDT)
In-Reply-To: <CALUzUxrswZ+AREq+OeqpTsnoB4J+_aExfmAA6X3cauJqj8RnpQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181976>

On Fri, Sep 23, 2011 at 5:18 PM, Tay Ray Chuan <rctay89@gmail.com> wrot=
e:
> On Fri, Sep 23, 2011 at 1:51 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> [snip]
>> Applying the following patch should make the last two use the defaul=
t
>> context or -U$num given from the command line to be consistent with =
the
>> codepath where we generate textual patches.
>>
>> =A0diff.c | =A0 =A02 ++
>> =A01 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/diff.c b/diff.c
>> index 9038f19..302ef33 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -2251,6 +2251,8 @@ static void builtin_diffstat(const char *name_=
a, const char *name_b,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memset(&xpp, 0, sizeof(xpp));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memset(&xecfg, 0, sizeof(xecfg));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xpp.flags =3D o->xdl_opts;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xecfg.ctxlen =3D o->context;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xecfg.interhunkctxlen =3D o->interhunk=
context;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xdi_diff_outf(&mf1, &mf2, diffstat_co=
nsume, diffstat,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&xpp, &xe=
cfg);
>> =A0 =A0 =A0 =A0}
>
> Thanks Junio.
>
> But wait, where does this patch go? Before or after 27af01d? If I'm
> understanding the situation correctly, this patch won't change the
> reporting 10/9 for --numstat, no?

I think I can answer this - on to v1.7.6, which is before 27af01d was m=
erged in.

> Anyway, this patch looks right.

On further thought, I think the patch merely side-steps the problem -
ie. that -U0 generates "incorrect" diffs.

=46urther digging reveals a xdiff-interface.c::trim_common_tail();
commenting its one and only call (patch below) gives back 10/9. Note
that it only has effect when -U0.

I think this function is incorrect. xdl_cleanup_records() and
xdl_clean_mmatch() may potentially look into common tail lines, so it
may not be "safe" to drop all common tail lines.

-- >8 --
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 0e2c169..da4fab6 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -131,7 +131,7 @@
        mmfile_t a =3D *mf1;
        mmfile_t b =3D *mf2;

-       trim_common_tail(&a, &b, xecfg->ctxlen);
+/*     trim_common_tail(&a, &b, xecfg->ctxlen);  */

        return xdl_diff(&a, &b, xpp, xecfg, xecb);
 }
-- >8 --

--=20
Cheers,
Ray Chuan
