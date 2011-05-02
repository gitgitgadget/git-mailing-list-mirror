From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH/RFC 3/4] grep: introduce pattern which matches at line number
Date: Mon, 2 May 2011 16:32:09 +0200
Message-ID: <BANLkTi=qKGdZpU+-aG3tuM8mssb6FnmpHw@mail.gmail.com>
References: <cover.1304318972.git.bert.wesarg@googlemail.com>
	<f768ea6e107cdd229a18df0bac3bf583eb1f9fc5.1304321122.git.bert.wesarg@googlemail.com>
	<cover.1304321122.git.bert.wesarg@googlemail.com>
	<2681b60988c7c4d059f83df368395eca0520012c.1304321122.git.bert.wesarg@googlemail.com>
	<f85d783d43bfe7f9e9f23a10e72e8a2a83033cac.1304321122.git.bert.wesarg@googlemail.com>
	<BANLkTinUWbhCKyfpimUuvCsxnCmRi3E=dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 02 16:32:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGuAa-0000zP-Ou
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 16:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759293Ab1EBOcM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 10:32:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37657 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757862Ab1EBOcK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2011 10:32:10 -0400
Received: by fxm17 with SMTP id 17so3660880fxm.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 07:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cehZe9YQV9DwogsmdpNgi+g4gjyt6q1nAejl83R6lpo=;
        b=s6Z0AbGCjK3XxU3ppIAfFSeBDX2Jp1bzs1LIdWOnNT3gu53RsE/6P+diO/hFcNjFBG
         oy3tSGyKys0Tki8UkurQ59Yygg9PzpHFyiPM3aalamwmn9+LKXM0FJaJDSualEel8WMB
         hHWlUh0bvIP6sfCeRxiH9Dz0Y0GUq4la6r93k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oKF8eMxAhTywD56TL4mzXC7NIBodf8bY1VWgOv9K+Ix8Ce+NvmRp0wlvj+TcT/CK1j
         tKkY7jxdNaJtjZgKACaW17P1ykcu+rRbtOvkTvlhOtBYkWu0WAQd7uzA0yOeY6o0hgTf
         ge5ehLzEs54cUC7txUx8pqo9hlYn51Y+8/RQc=
Received: by 10.223.5.3 with SMTP id 3mr1471002fat.56.1304346729374; Mon, 02
 May 2011 07:32:09 -0700 (PDT)
Received: by 10.223.71.205 with HTTP; Mon, 2 May 2011 07:32:09 -0700 (PDT)
In-Reply-To: <BANLkTinUWbhCKyfpimUuvCsxnCmRi3E=dg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172595>

On Mon, May 2, 2011 at 15:33, Thiago Farina <tfransosi@gmail.com> wrote=
:
> On Mon, May 2, 2011 at 8:39 AM, Bert Wesarg <bert.wesarg@googlemail.c=
om> wrote:
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>> ---
>> =C2=A0grep.c | =C2=A0 33 +++++++++++++++++++++++++++++++++
>> =C2=A0grep.h | =C2=A0 =C2=A07 +++++--
>> =C2=A02 files changed, 38 insertions(+), 2 deletions(-)
>>
>> diff --git a/grep.c b/grep.c
>> index f21b022..cbb3757 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -87,6 +87,15 @@ static void compile_regexp(struct grep_pat *p, st=
ruct grep_opt *opt)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> =C2=A0}
>>
>> +static void parse_lno(struct grep_pat *p, struct grep_opt *opt)
> Maybe parse_line_number?
>
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 char *eon;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 p->u.lno =3D strtoul(p->pattern, &eon, 10);
>> + =C2=A0 =C2=A0 =C2=A0 if (*eon || p->u.lno =3D=3D 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("'%s': Invali=
d number for line match", p->pattern);
>> +}
>> +
>> =C2=A0static struct grep_expr *compile_pattern_or(struct grep_pat **=
);
>> =C2=A0static struct grep_expr *compile_pattern_atom(struct grep_pat =
**list)
>> =C2=A0{
>> diff --git a/grep.h b/grep.h
>> index 9912c11..41821f3 100644
>> --- a/grep.h
>> +++ b/grep.h
>> @@ -10,7 +10,8 @@ enum grep_pat_token {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0GREP_OPEN_PAREN,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0GREP_CLOSE_PAREN,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0GREP_NOT,
>> - =C2=A0 =C2=A0 =C2=A0 GREP_OR
>> + =C2=A0 =C2=A0 =C2=A0 GREP_OR,
>> + =C2=A0 =C2=A0 =C2=A0 GREP_LNO
>
> Maybe GREP_LINE_NR?
>
>
>> =C2=A0};
>>
>> =C2=A0enum grep_context {

Yeah, I must admit that these symbols should probably get a more
descriptive name.

Bert
