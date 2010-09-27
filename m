From: Pat Thoyts <patthoyts@gmail.com>
Subject: Re: [msysGit] Re: [PATCH] mingw: do not crash on open(NULL, ...)
Date: Mon, 27 Sep 2010 14:31:27 +0100
Message-ID: <AANLkTikv8M8xuESQzO7qfPB72d51hTcosUgKreLu7Y=C@mail.gmail.com>
References: <1285263325-2016-1-git-send-email-kusmabite@gmail.com>
	<AANLkTinJ4kKRsKO6HyqQH4Oy12E1mdqCXxPb2z+59818@mail.gmail.com>
	<7vy6asoz0i.fsf@alter.siamese.dyndns.org>
	<AANLkTi=p13eTY-dqGZJYaogRyj0Z5uO3YM8n1RW4iBUi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, msysgit@googlegroups.com,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Sep 27 15:31:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0Dnz-0004SO-Ol
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 15:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759344Ab0I0Nba convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 09:31:30 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:54422 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635Ab0I0Nb2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 09:31:28 -0400
Received: by qyk33 with SMTP id 33so7841717qyk.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 06:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5KGzL4GPDgnQLCyu1iUY40VsanHxuYJ8tusG6G7Wv8I=;
        b=JZ8LTr/mNCmW0EcN0KQ1F3QkRv8JA//2glrhr2UUIZ4sfRboqxmfkLlZVlF3eCssI3
         Z2uA3cvvLQq+dzTTCgdntsn8JNuuw74vSGLsyXk4MKr1MQbSP3ahA9bJp9PUWOnO/+yA
         gS0fHgD5TsKuUW4fPzrYiC3cF8xAFxAodOL1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Z03DrL2MBhb7RksFHngV/f3mv9o/04z7aBsRgQQU1X8ltwwNKGjUkKzCUqUlLnA3T8
         cQ+Q/4km7CVjnaZChIw+uSbM/kUCdNQNbQZmSBroC8tyQG9WSnU6LBqLUn1G/Av/8ZR/
         IO5pi706jCpRiSRUO4yohCp2hDAVFY2MedQ9Y=
Received: by 10.224.105.4 with SMTP id r4mr5492337qao.83.1285594288125; Mon,
 27 Sep 2010 06:31:28 -0700 (PDT)
Received: by 10.229.85.201 with HTTP; Mon, 27 Sep 2010 06:31:27 -0700 (PDT)
In-Reply-To: <AANLkTi=p13eTY-dqGZJYaogRyj0Z5uO3YM8n1RW4iBUi@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157330>

On 27 September 2010 14:19, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Fri, Sep 24, 2010 at 12:50 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>
>>> On Thu, Sep 23, 2010 at 10:35 AM, Erik Faye-Lund <kusmabite@gmail.c=
om> wrote:
>>>> Since open() already sets errno correctly for the NULL-case, let's=
 just
>>>> avoid the problematic strcmp.
>>>>
>>>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>>>
>>> I guess I should add a comment as to why this patch is needed:
>>>
>>> This seems to be the culprit for issue 523 in the msysGit issue
>>> tracker: http://code.google.com/p/msysgit/issues/detail?id=3D523
>>>
>>> fetch_and_setup_pack_index() apparently pass a NULL-pointer to
>>> parse_pack_index(), which in turn pass it to check_packed_git_idx()=
,
>>> which again pass it to open(). This all looks intentional to my
>>> (http.c-untrained) eye.
>>
>> Surely, open(NULL) should be rejected by a sane system, and your pat=
ch
>> looks sane to me.
>>
>
> Since this doesn't seem to be in git.git yet, perhaps you could squas=
h
> this on top? I didn't notice it in time, but fopen lacked the same
> check (freopen already had the check). It's not as important, because
> it doesn't seem like we have any code reaching this path so far, but
> it would IMO be better to fix this now rather than having to chase
> down the issue again later...
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 4595aaa..f069fea 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -160,7 +160,7 @@ ssize_t mingw_write(int fd, const void *buf, size=
_t count)
> =C2=A0#undef fopen
> =C2=A0FILE *mingw_fopen (const char *filename, const char *otype)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 if (!strcmp(filename, "/dev/null"))
> + =C2=A0 =C2=A0 =C2=A0 if (filename && !strcmp(filename, "/dev/null")=
)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0filename =3D "=
nul";
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return fopen(filename, otype);
> =C2=A0}
>

I'll apply this to the devel branch and try to remember to squash it
on the next rebase-merge.
Cheers,
Pat
