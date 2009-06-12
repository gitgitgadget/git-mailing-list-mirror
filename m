From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH 1/2] http.c: prompt for SSL client certificate password
Date: Fri, 12 Jun 2009 19:13:32 -0400
Message-ID: <ca433830906121613y68e5bdax5778867c41b00339@mail.gmail.com>
References: <1243480563-5954-1-git-send-email-lodatom@gmail.com>
	 <7vprdaarka.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 01:13:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFFwL-0006sh-Pm
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 01:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559AbZFLXNd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2009 19:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbZFLXNc
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 19:13:32 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:57492 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbZFLXNb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jun 2009 19:13:31 -0400
Received: by bwz9 with SMTP id 9so2366399bwz.37
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 16:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6qr284cDXSCC997x8V+hSfEEhzy+F5QsLYL4CAt62fM=;
        b=bCBiooWEBHDjo1VqEb2wl62setPKuXWQ/zHA6rXvy/v256m1IUlEEyKeSF2UFPWQXn
         l1VCeK0coL/4jMgs2ZuGv7/BNckjXrD52C0fE4m6eVy0u25H0JYb++x/1a7rGvWkJET9
         UJZl11r0OigCsobCcPyid/xRKpMIEAD709K4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tFUahhidLhjTnw2JJTXBPzVq1iJ1oXBlk7j79NU/xK3RYxnb3Fns/+UBQA9v5WamyC
         oGFjBFsd/YnGWD8OeRTAj8FREbFOAPnqu5z5Il74Wmh51TT4b/NQanZVlP40xCvcQ+KG
         +ebTNKFjDSbZlD1NbfMbjEwV6AfWeRGINpxes=
Received: by 10.223.104.74 with SMTP id n10mr3111002fao.5.1244848412936; Fri, 
	12 Jun 2009 16:13:32 -0700 (PDT)
In-Reply-To: <7vprdaarka.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121467>

On Fri, Jun 12, 2009 at 2:34 AM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> Mark Lodato <lodatom@gmail.com> writes:
>
>> @@ -189,6 +207,16 @@ static CURL *get_curl_handle(void)
>>
>> =C2=A0 =C2=A0 =C2=A0 if (ssl_cert !=3D NULL)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 curl_easy_setopt(re=
sult, CURLOPT_SSLCERT, ssl_cert);
>> + =C2=A0 =C2=A0 if (has_cert_password())
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 curl_easy_setopt(result,
>> +#if LIBCURL_VERSION_NUM >=3D 0x071700
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CURLOPT_KEYPASSWD,
>> +#elif LIBCURL_VERSION_NUM >=3D 0x070903
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CURLOPT_SSLKEYPASSWD,
>> +#else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CURLOPT_SSLCERTPASSWD,
>> +#endif
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ssl_cert_password);
>
> This is purely style and readability, but if you do something like th=
is
> much earlier in the file:
>
> =C2=A0 =C2=A0#if !defined(CURLOPT_KEYPASSWD)
> =C2=A0 =C2=A0# if defined(CURLOPT_SSLKEYPASSWD)
> =C2=A0 =C2=A0# =C2=A0define CURLOPT_KEYTPASSWD CURLOPT_SSLKEYPASSWD
> =C2=A0 =C2=A0# elif defined(CURLOPT_SSLCERTPASSWD
> =C2=A0 =C2=A0# =C2=A0define CURLOPT_KEYTPASSWD CURLOPT_SSLCERTPASSWD
> =C2=A0 =C2=A0# endif
> =C2=A0 =C2=A0#endif
>
> you can write your main codepath using the latest cURL API without if=
def.
> The callsite can simply say:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (must_set_cert_password())
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0curl_easy_seto=
pt(result, CURLOPT_KEYPASSWD, ssl_cert_password);
>
> which I think would be much easier to follow.

I realized this after I submitted the patch.  Locally I have modified
my version to do something similar to the above, but checking libcurl
versions rather than checking the existence of the macros (which don't
exist, as Daniel pointed out.)  If this patch series is accepted, I
will make a cleaner version that includes this change.

Mark
