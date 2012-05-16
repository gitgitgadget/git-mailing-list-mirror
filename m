From: Bobby Powers <bobbypowers@gmail.com>
Subject: Re: [PATCH] diff --no-index: reset temporary buffer lengths on
 directory iteration
Date: Wed, 16 May 2012 10:20:32 -0400
Message-ID: <CAArOQ2UNJyBHNa5_+G+J0bihCEOxPebey8-EkcoXDyeR1wM+yw@mail.gmail.com>
References: <1337141693-3515-1-git-send-email-bobbypowers@gmail.com>
	<4FB34A42.60300@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed May 16 16:20:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUf5k-0007fk-2J
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 16:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401Ab2EPOUf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 10:20:35 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:41978 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab2EPOUd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 May 2012 10:20:33 -0400
Received: by qabj40 with SMTP id j40so1018076qab.1
        for <git@vger.kernel.org>; Wed, 16 May 2012 07:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=RboE0xOlteGWue/sZZ7EsmrWJI0woF/iRNFRxr9iEG4=;
        b=wbD8nYIztlwrKNqL+lJ0D5xPV9JWqJ2M5B6silbhU+gkfOuLM3j/F4jE9CYnEz7SQ3
         KbcaesVUhwCD9jQJuoc1JfKQV87/F7yL67Vsg05hnCErZOAtSrgb7gYwpl/pH/5ZgLVU
         44gRCKpFCRISMy5ShPgy6cKwu4IXUeu8nAbgFrb/+vAUqSLTKY2B/I0Afs7xnp11aEAb
         s+PWIv3ntsXKu1e04ivmDpy0ke970mg3AfV67mgMsXhbb5KHnWH8uHd+Hy6nE126SQmN
         tLGLy71Nbq1xUemTG/J6Rodh3Aj3H4hshdOGfDP0UT0ZFV01iohQJmLgczfoiwLjqhuS
         Ljyw==
Received: by 10.224.217.9 with SMTP id hk9mr10141669qab.59.1337178032934; Wed,
 16 May 2012 07:20:32 -0700 (PDT)
Received: by 10.229.225.206 with HTTP; Wed, 16 May 2012 07:20:32 -0700 (PDT)
In-Reply-To: <4FB34A42.60300@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197881>

On Wed, May 16, 2012 at 2:33 AM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 16.05.2012 06:14, schrieb Bobby Powers:
>
>> Commit 875b91b3 introduced a regression when using diff --no-index
>> with directories. =A0When iterating through a directory, the switch =
to
>> strbuf from heap-allocated char arrays caused paths to form like
>> 'dir/file1', 'dir/file1file2', rather than 'dir/file1', 'dir/file2' =
as
>> expected. =A0By resetting the length on each iteration (but not
>> buf.alloc), we avoid this.
>>
>> Signed-off-by: Bobby Powers <bobbypowers@gmail.com>
>> ---
>> =A0diff-no-index.c | =A0 =A07 ++++++-
>> =A01 file changed, 6 insertions(+), 1 deletion(-)
>
>
> Nice catch! =A0Could you please also add a test case so that we can b=
e sure a
> similar bug is not reintroduced later?

Yup, will do.

>
>
>> diff --git a/diff-no-index.c b/diff-no-index.c
>> index b44473e..bec3ea4 100644
>> --- a/diff-no-index.c
>> +++ b/diff-no-index.c
>> @@ -67,7 +67,7 @@ static int queue_diff(struct diff_options *o,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct strbuf buffer2 =3D STRBUF_INIT=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct string_list p1 =3D STRING_LIST=
_INIT_DUP;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct string_list p2 =3D STRING_LIST=
_INIT_DUP;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i1, i2, ret =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int len1 =3D 0, len2 =3D 0, i1, i2, re=
t =3D 0;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (name1 && read_directory(name1, &p=
1))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
>> @@ -80,18 +80,23 @@ static int queue_diff(struct diff_options *o,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbuf_addstr(&buffer=
1, name1);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (buffer1.len && bu=
ffer1.buf[buffer1.len - 1] !=3D
>> '/')
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbu=
f_addch(&buffer1, '/');
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len1 =3D buffer1.len;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (name2) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbuf_addstr(&buffer=
2, name2);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (buffer2.len && bu=
ffer2.buf[buffer2.len - 1] !=3D
>> '/')
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbu=
f_addch(&buffer2, '/');
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len2 =3D buffer2.len;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i1 =3D i2 =3D 0; !ret && (i1 < p=
1.nr || i2 < p2.nr); ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *n1, *n2;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int comp;
>
>
> If you declare len1 and len2 right here at the start of the loop and =
reset
> the strbufs at its end, you wouldn't have to initialize them to zero =
and
> they'd have the right scope for their task.

Nope, thats not what we want actually.  At the start of the first
iteration, the buffers have directory names in them, like 'dir_1/' and
'dir_2/'.  The loop appends the directory contents to the directory
path, upon each iteration we only want to clear the last filename from
the buffer, not the entire buffer.

>
> Using type size_t, the type used in struct strbuf, is more correct.

Done.

>
>
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buffer1.len =3D len1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buffer2.len =3D len2;
>
>
> It's cleaner to use strbuf_setlen() instead of setting the len member
> directly.

Done.

>
> Looking at the code, I think the strbufs are never freed and the
> strbuf_reset() calls after the loop should be replaced by ones to
> strbuf_release() in order to avoid leaking. =A0This is a different is=
sue, but
> would be nice to squash as well.

Yup, I noticed that as well.  I'll send a separate patch out for it.

Thanks for the review!  I'll send a revised patch out momentarily.

yours,
Bobby

>
>
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (i1 =3D=3D p1.nr)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0comp =
=3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (i2 =3D=3D p2=
=2Enr)
>> -- 1.7.10.2
>>
>
