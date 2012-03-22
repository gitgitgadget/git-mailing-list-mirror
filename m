From: Lucian Poston <lucian.poston@gmail.com>
Subject: Re: [PATCH 1/1] Fix --stat width calculations to handle --graph
Date: Thu, 22 Mar 2012 12:39:37 -0700
Message-ID: <CACz_eyeyni0EkM25neWdPXF7Nu8GnZv1am-UkRz3BOxBvvA1Xg@mail.gmail.com>
References: <1332229097-19262-1-git-send-email-lucian.poston@gmail.com>
	<1332229097-19262-2-git-send-email-lucian.poston@gmail.com>
	<7vehsn6vy1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Bo Yang <struggleyb.nku@gmail.com>,
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 20:39:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAnrN-0002Vj-2u
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 20:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297Ab2CVTjk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 15:39:40 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56019 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127Ab2CVTjj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2012 15:39:39 -0400
Received: by ghrr11 with SMTP id r11so2122691ghr.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 12:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=P+h2nlyOEvEXSK8A05CABRbBhWtmB1Re0F74fuPF7y4=;
        b=IE3RgxeOyzCbxpSN1ufTtQWyKX1m6ND4CUtSmH9r34Ucsy/ts27lIeG21RjBiK1BIV
         z8qlWr5X5eo8861GEUhg/zhNdkFnLS/awWPCuRtJO9rq2tgWy96ykHGa+7vRir4B77z0
         f4GPI0Fla0QeNWAt2Nh+6gTljFIQY8Y4muOqoY/0LJrkG4FyhgKjfXSdtcsK1iwUVdmg
         GTJ+iEskqcLUJklurENrZ0zCAfoAvgzYL1gzd/9sx3sYltAm8ons2dCWGxmqeZjX1nUg
         q5ki8uxJSAJFYH2tCX7CSlXkAm0lpHBd82eudwottNdINYsJGcroIsU3keFLPI9hMf/M
         k8rg==
Received: by 10.68.191.161 with SMTP id gz1mr17007088pbc.76.1332445178489;
 Thu, 22 Mar 2012 12:39:38 -0700 (PDT)
Received: by 10.68.47.232 with HTTP; Thu, 22 Mar 2012 12:39:37 -0700 (PDT)
In-Reply-To: <7vehsn6vy1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193698>

2012/3/20 Junio C Hamano <gitster@pobox.com>:
> Regarding the log message:
>
> =C2=A0- Please start it with a problem description. Describe both wha=
t the
> =C2=A0 current code shows, and why you think it is wrong or suboptima=
l.
> =C2=A0 I.e. the observation of the problem in your second paragraph c=
omes at
> =C2=A0 the beginning
>
> =C2=A0- Our log message usually gives an order to the codebase or to =
the person
> =C2=A0 who is applying the patch in order to address the problem you =
described
> =C2=A0 in the earlier part of the log message, instead of tells a sto=
ry of
> =C2=A0 what happened in the past.
>
> E.g.
>
> =C2=A0 =C2=A0The recent change to compute the width of diff --stat ba=
sed on the
> =C2=A0 =C2=A0terminal width did not take the width needed to show the=
 --graph
> =C2=A0 =C2=A0output into account, and makes lines in "log --graph --s=
tat" too long.
>
> =C2=A0 =C2=A0Adjust stat width calculation to take the width of graph=
 prefix into
> =C2=A0 =C2=A0account. ...

Thanks for letting me know. Patch v2 has updated log messages. Let me
know whether they meet the conventions.

> I think the caller should be taught to pass the exact width it carves=
 out
> of the available width for use by the ancestry graph output, and if w=
e are
> to do so, adding "int output_prefix_len" field (which usually is 0) t=
o
> diff_options, and seting it in graph.c::diff_output_prefix_callback()=
 (at
> that point, graph->width has the number you want, I think), may be th=
e way
> to go.

Added outout_prefix_length to struct diff_options in patch v2.

>> diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
>> index 328aa8f..84dd8bb 100755
>> --- a/t/t4052-stat-output.sh
>> +++ b/t/t4052-stat-output.sh
>> @@ -162,7 +162,7 @@ test_expect_success 'preparation for long filena=
me tests' '
>> =C2=A0'
>>
>> =C2=A0cat >expect <<'EOF'
>> - ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++++
>> + ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++++++++++
>> =C2=A0EOF
>
> Isn't it a sign that the change is doing a lot more than justified th=
at it
> has to change the test vector for cases where --graph is *NOT* involv=
ed at
> all?

It is, and I didn't make that clear in the log message. In patch v2,
the log message describes what has changed to in the calculation to
cause this.

Thanks!
Lucian
