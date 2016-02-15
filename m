From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 09/25] upload-pack: tighten number parsing at "deepen" lines
Date: Mon, 15 Feb 2016 10:07:42 +0700
Message-ID: <CACsJy8DLnWpB+3+DRTq0MxAK82qe8yLVrLV29FDY=BmrWh4wWw@mail.gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
 <1454576641-29615-10-git-send-email-pclouds@gmail.com> <xmqqvb64doln.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 04:08:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aV9WM-00024d-IT
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 04:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbcBODIO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2016 22:08:14 -0500
Received: from mail-lb0-f196.google.com ([209.85.217.196]:35817 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbcBODIN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Feb 2016 22:08:13 -0500
Received: by mail-lb0-f196.google.com with SMTP id dx9so5800151lbc.2
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 19:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=cHqDvvEOV/Qn35GOBoecobT0BjgSl+dqC8oOcVtfmgk=;
        b=TWp2n/yjTJwx2bsgswMnFciurlihCX+IHULi1wMiIjR218zfRKJ7gJfxw+Enhr4arG
         5NU5iFi8gVNipORtlNNixZXAeNCPARjBqZuYoFykheoQLVp5qjnBSlhCZiHmG2wSqAv5
         /qKs6skGfU7c7ch/37jbwKygVdIXMIiPixRHzCbhMNRlXXYDjmkvqe4pPI/FQatQqdXv
         f1iG+e02XUFUs+RnvnJXjXw1H+s5V9dzbB1PuJH4JW8ogc9SZ0mASIawNlICU4Cfu9KN
         AMjbQ5YXmB1C9Tui5BoYFlgEI1mNs0tILuBqIcX8C9bx0LcxzfNlYxdhbyISyVDh1BKl
         snrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=cHqDvvEOV/Qn35GOBoecobT0BjgSl+dqC8oOcVtfmgk=;
        b=bl3yZUY+ehFadx2E6RALFmCkoaVHdjzP1bEySJJAWEslHwOaJFzzxkcoUu0du+jhDI
         NKzo2x9NeCiT5DRW7cavfiwW1mBsU/XkCG64CIiiyfJ3MYm6YMCnHCCS05cnianwfxXJ
         xPNd3QskKpaeqzRC8OWsbDAFZg4ztMkJL5Et9bbVIA7IN4lPOUoVIj/6BLqvWAnz9X96
         LcdoDOxZIpRJgzcDk9Mu0wk5m2LH6aGmx1AIX5Ng/xyvjjsszyynQK7qmo2KO8L+1/tv
         5fqcvSf4tFhjgmyQ3L0HwEJVI96L+6AWfYDM6etJFJ+XM0HadNRQS7OWWuH7j/XkNm1C
         k5BA==
X-Gm-Message-State: AG10YOSXatzzdVo63eE5pUWKw4XSjfQqttDbzHr2OvULxe/w81sxOzz/sWLrEbprwHA9eXwpEF46siwsh34Hzg==
X-Received: by 10.112.209.99 with SMTP id ml3mr5471451lbc.26.1455505692383;
 Sun, 14 Feb 2016 19:08:12 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Sun, 14 Feb 2016 19:07:42 -0800 (PST)
In-Reply-To: <xmqqvb64doln.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286167>

On Fri, Feb 5, 2016 at 6:48 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>
> Hmm, so "deepen 10-by-the-way-let-me-tell-you-something-else" was an
> acceptable input that some (third-party) version of "git fetch"
> could have used, but now we are rejecting it.
>
> That "let me tell you something else" part wouldn't have reached
> outside this code, so it is inconceivable that anybody would relied
> on that looseness as a "feature", so the only practical risk would
> be if somebody wrote a protocol driver, mumbling "on the Internet,
> the end of line is CRLF, just like SMTP does", that sends a "deepen
> 10<CR><LF>".  We used not to notice, but now we reject such a
> reimplementation of Git.

On the other hand, if a broken client sends "deepen 10f" instead of
"deepen 271", we should reject and let the client be fixed instead of
sending a fetch of 10 commits deep back. "10<CR>" is not that bad, but
fixing it is still a good idea.
--=20
Duy
