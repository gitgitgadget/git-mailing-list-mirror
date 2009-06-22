From: roel kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] tools: fread does not return negative on error
Date: Mon, 22 Jun 2009 17:47:07 +0200
Message-ID: <25e057c00906220847t15425f38maf486c291d1d2468@mail.gmail.com>
References: <4A3FB09D.9050903@gmail.com> <20090622153431.GA18466@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Mon Jun 22 17:47:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIlkB-0002xH-Kv
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 17:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbZFVPrK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jun 2009 11:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbZFVPrI
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 11:47:08 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:63542 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbZFVPrH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2009 11:47:07 -0400
Received: by bwz9 with SMTP id 9so3253201bwz.37
        for <multiple recipients>; Mon, 22 Jun 2009 08:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lzSpnXjFU9q9iG68RFWOoPlJCWZDaU5beUJ29ohpXp4=;
        b=Y6hldz7ZK0756D81Ym+pLcHhrTWdeOFlGzzg/Krxoe+HEs0968BjN2HcAYrwXaxZvO
         YrYU0aXqi56tJrYvnhnmgdDoAmooie16w7Em9h048RQGEZ6ioNiZQIP0b03CbXRdbgZR
         vsAAUolDPz0RzCGNGPLQUsimDC2DXZghjC2Z8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wyh0gpoRNhdUwGrxy3ZurA0+wEHzjV8X0ZSj0HlC10wjUiKtpA1TWQxUfejQ8c2oZX
         tPD8n+4Q0ZexUD+iDXvIEKG3NV7aU4kINLmhFJn/gquxw8ZOY8ePDMiJAg+jA4ByXd2g
         t+nRTzw7zl4PJwrRTxWW0sU65fKENp/CjZuTI=
Received: by 10.204.70.196 with SMTP id e4mr6400118bkj.107.1245685627889; Mon, 
	22 Jun 2009 08:47:07 -0700 (PDT)
In-Reply-To: <20090622153431.GA18466@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122046>

On Mon, Jun 22, 2009 at 5:34 PM, Ingo Molnar<mingo@elte.hu> wrote:
>
> * Roel Kluin <roel.kluin@gmail.com> wrote:
>
>> size_t res cannot be less than 0. fread returns 0 on error.
>>
>> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
>> ---
>> Is this correct? please review.
>>
>> diff --git a/tools/perf/util/strbuf.c b/tools/perf/util/strbuf.c
>> index eaba093..376a337 100644
>> --- a/tools/perf/util/strbuf.c
>> +++ b/tools/perf/util/strbuf.c
>> @@ -259,7 +259,7 @@ size_t strbuf_fread(struct strbuf *sb, size_t si=
ze, FILE *f)
>> =A0 =A0 =A0 res =3D fread(sb->buf + sb->len, 1, size, f);
>> =A0 =A0 =A0 if (res > 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_setlen(sb, sb->len + res);
>> - =A0 =A0 else if (res < 0 && oldalloc =3D=3D 0)
>> + =A0 =A0 else if (res =3D=3D 0 && oldalloc =3D=3D 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_release(sb);
>> =A0 =A0 =A0 return res;
>
> This comes straight from Git's strbuf.c so i've Cc:-ed the Git list.
>
> Roel, did you get some compiler warning that made you look at this
> code?
>
> =A0 =A0 =A0 =A0Ingo
>

No, I use sed to catch these bugs.

Roel
