From: xzer <xiaozhu@gmail.com>
Subject: Re: [PATCH] generate a valid rfc2047 mail header for multi-line subject.
Date: Thu, 24 Feb 2011 00:34:54 +0900
Message-ID: <AANLkTinf6P-erY-9p5WPWbK+uAf1hozvAutV0zPSpHGQ@mail.gmail.com>
References: <1297670968-28130-1-git-send-email-xiaozhu@gmail.com>
	<7vsjvfby0z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 16:35:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsGk3-0006ny-KD
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 16:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894Ab1BWPe4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Feb 2011 10:34:56 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44048 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549Ab1BWPez convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 10:34:55 -0500
Received: by iwn34 with SMTP id 34so1619808iwn.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 07:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3/1P0tIl6ggrGtv8VmRg+McoFwLikQ9u06paM7l5EfQ=;
        b=l85atkUmmPtkMxLhtN+QRm8iUIibE/u+iHWddceLsgQDg3l5y3TJScJfkFsePKjgm7
         IHkKAaTaSdxWPtA6VMUcPORflxxQFc2uV8sFY2oA+5GgDXUh75ifJdKBCrgggrpatzWx
         t7lImVSMA7WWq0ZkljmABEo63T0t+jeAxhGZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FPAL5i+2ZrzZgm7+3m1tAKJF9SHpmvIN2bYD6gvyf2gtXIBlXAcRAQsICXiD3HTUkJ
         IX8TS072tGPeZcztvnk5yDAja1lDlCEn7+dqY/QYHPPeVb2pblJzjqFUO8Y9qGh9s84C
         U9GkN29nzSAAKSIXr05RhvZTIyMwUePK4jemg=
Received: by 10.231.37.196 with SMTP id y4mr3154367ibd.70.1298475295024; Wed,
 23 Feb 2011 07:34:55 -0800 (PST)
Received: by 10.231.35.3 with HTTP; Wed, 23 Feb 2011 07:34:54 -0800 (PST)
In-Reply-To: <7vsjvfby0z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167697>

2011/2/23 Junio C Hamano <gitster@pobox.com>:
> xzer <xiaozhu@gmail.com> writes:
>
>> Subject: Re: [PATCH] generate a valid rfc2047 mail header for multi-=
line subject.
>
> We prefer to have "[PATCH] subsystem: description without final full-=
stop" here.
>
>> There is still a problem that git-am will lost the line break.
>
> What does "still" refer to? =C2=A0It is unclear under what condition =
the
> command lose "the line break" (nor which line break you are refering =
to; I
> am guessing that you have a commit that begins with a multi-line para=
graph
> and you are talking about line breaks between the lines in the first
> paragraph).
>

Yes, that is what I am refering, the line breaks in the first paragraph=
=2E

>> It's not easy to retain it, but as the first step, we can generate
>> a valid rfc2047 header now.
>
> Please describe what is broken (iow, "Given this sample input, we
> currently generate this output, which is not a valid rfc2047") and wh=
at
> the new output looks like ("Update pp_title_line() to generate this o=
utput
> instead.")
>

At present we can only concatenate the lines in the first paragraph so
that we can generate a valid rfc2047 mail, but we will lost the line br=
eaks
after import the patch by git-am.

>> ---
>
> Missing sign-off with a real name.
>

I am sorry that I didn't find the document of submitting a patch until
yesterday, Thanks for your comment.

>> diff --git a/pretty.c b/pretty.c
>> index 8549934..f18a38d 100644
>> --- a/pretty.c
>> +++ b/pretty.c
>> @@ -249,6 +249,33 @@ needquote:
>> =C2=A0 =C2=A0 =C2=A0 strbuf_addstr(sb, "?=3D");
>> =C2=A0}
>>
>> +static void add_rfc2047_multiline(struct strbuf *sb, const char *li=
ne, int len,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 const char *encoding)
>> +{
>> + =C2=A0 =C2=A0 int first =3D 1;
>> + =C2=A0 =C2=A0 char *mline =3D xmemdupz(line, len);
>> + =C2=A0 =C2=A0 const char *cline =3D mline;
>> + =C2=A0 =C2=A0 int offset =3D 0, linelen =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0for (;;) {
>
> You seem to have indent that uses SPs instead of HT around here...
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0linelen =3D=
 get_one_line(cline);
>
> I can see you are trying to be careful not to let get_one_line() over=
step
> past "len" the caller gave you by making a copy first, but is this
> overhead really necessary? =C2=A0After all we know in this static fun=
ction that
> the caller is feeding the contents from a strbuf, which always have a
> terminating NUL (and that is why it is Ok that get_one_line() is not =
a
> counted string interface).
>

I am not sure that who will call this function in future, I think since=
 there is
a argument as len, so I'd better to obey the function declare.

>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cline +=3D =
linelen;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!linele=
n)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0break;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!first)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 strbuf_addf(sb, "\n ");
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offset =3D *(cline -1) =3D=
=3D '\n';
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_rfc2047(sb, cline-li=
nelen, linelen-offset, encoding);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 first =3D 0;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> + =C2=A0 =C2=A0 free(mline);
>> +}
>
> So the general idea of this change (I am thinking aloud what should b=
e in
> the updated commit log message as the problem description) is that:
>
> =C2=A0- We currently give an entire multi-line paragraph string to th=
e
> =C2=A0 add_rfc2047() function to be formatted as the title of the com=
mit;
>
> =C2=A0- The add_rfc2047() functionjust passes "\n" through, without m=
aking it a
> =C2=A0 folding whitespace followed by a newline, to help callers that=
 want to
> =C2=A0 use this function to produce a header line that is rfc 2822 co=
nformant;
>
> =C2=A0- The patch introduces a new function add_rfc2047_multiline() t=
hat splits
> =C2=A0 its input and performs line folding for such a caller (namely,=
 the
> =C2=A0 pp_title_line() function);
>
> =C2=A0- Another caller of add_rfc2047(), pp_user_info, is not changed=
, and it
> =C2=A0 won't fold the name of the user that appear on the From: line.
>
> It is unclear if the last point is really the right thing to do, thou=
gh.
> It is not a new problem that an author name that has a "\n" in it wou=
ld
> break the output, but we probably would want to fix that case too her=
e?
>

Your comment is just right for what I tried to do, I explained why I ad=
d a new
function for subject specially in the mail which replied to Jeff, I
want to remain
the line breaks after import the patch, so I think I need do something =
here
in future, it will be compatible with rfc2047 and also can be imported =
with
line breaks correctly. I don't know how yet, so I just want to left a
possibility.
So I introduce a new function for subject only.

xzer
