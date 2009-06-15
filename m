From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Mon, 15 Jun 2009 09:59:57 +0200
Message-ID: <c07716ae0906150059m7f9706x6f9022afde15d3b0@mail.gmail.com>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>
	 <c07716ae0906101237o5038fc4dle9f11b6f2216652a@mail.gmail.com>
	 <7vtz2nlrfs.fsf@alter.siamese.dyndns.org>
	 <200906110602.54861.chriscool@tuxfamily.org>
	 <4A308B5D.2010704@zytor.com> <4A309083.9090907@zytor.com>
	 <c07716ae0906120456j1a14af52n47c3a3542201aaf@mail.gmail.com>
	 <4A33F7E4.4020201@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, Ingo Molnar <mingo@elte.hu>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 10:06:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MG7Cw-0007lQ-0n
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 10:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbZFOIF4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2009 04:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752301AbZFOIFz
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 04:05:55 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:54763 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbZFOIFx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jun 2009 04:05:53 -0400
Received: by bwz9 with SMTP id 9so3146220bwz.37
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 01:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fvNW5G0pjP01WRP80ImyqEumaZaKQMsOPWdEY2LMziA=;
        b=e7XFtLT9pycVBAiCnd6H3HQ6nci1cR4we80fOdUYNgAnec28EHr5fEVRKUOJVaYwbg
         XmQ9UvCHts/HWcz8MTONkxKJmvZshnKE6ZVlOVyx1RR0py1gXBRaNkO3DuCHNO//TCI6
         G92lHsi25mvqkVpM0G076w4cuc6AqUG56D7E8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Rbl9BHGP48w2Pasi4KuUwRIYfKA7LId2wG3O4/FOtO8MMEpkuhCF7feRPtdCzRpUwQ
         GrazICQeTR4ebMXwvBxMlCPRPI772hjxWPK4CXBW+HnEQDTfuN5tU/F18EtCzWK1jzRm
         yDrFDiUAkBxL1/+G3x2jlP+M6N1XrruH6pkQw=
Received: by 10.103.131.18 with SMTP id i18mr3486112mun.107.1245052797167; 
	Mon, 15 Jun 2009 00:59:57 -0700 (PDT)
In-Reply-To: <4A33F7E4.4020201@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121591>

On Sat, Jun 13, 2009 at 9:03 PM, H. Peter Anvin<hpa@zytor.com> wrote:
> Christian Couder wrote:
>> On Thu, Jun 11, 2009 at 7:05 AM, H. Peter Anvin<hpa@zytor.com> wrote=
:
>>> Urk, I managed to get myself completely confused -- I did the serie=
s
>>> approximation on the wrong side of inverting the function. =A0The c=
orrect
>>> power is actually 1.5 (over the range 0 to 1), a value > 1 is neces=
sary
>>> to bias the PRNG toward the beginning (x =3D 0) of the list.
>>
>> I started working on this, but I wonder if it's better to add a
>> #include <math.h> and link with -lm than to provide a custom sqrt
>> implementation. Too bad the best power is not 2.
>>
>
> That's what I would do. =A0It's not like sqrt() is a strange, unporta=
ble
> function.

Yes, but I feared that there could be rounding related differences
between platforms.

By the way, could you explain why power 1.5 is better than 2? It would
be much simpler if we could avoid square rooting anything in the first
place.

>> To implement the PRNG, I guess that using something based on the
>> function given by "man 3 rand" should be ok:
>>
>> int get_prn(int count) {
>> =A0 =A0 count =3D count * 1103515245 + 12345;
>> =A0 =A0 return((unsigned)(count/65536) % 32768);
>> }
>>
>> where the "count" we pass is the count of elements in the list rathe=
r
>> than the static seed.
>
> Yes, or perhaps better we could use some combination of the SHA-1s
> involved as seeds... they are rather nice for this as they are wide a=
nd
> much better PRNGs than most classical algorithms.
>
> The main problem with the above algorithm is that it only produces 16
> bits of output, which when biased can turn into a fairly significant
> granularity.

I don't think this is a real problem for this application. In fact I
think it's already quite overkill and there are better things to do,
like looking for a commit on a different branch among the first ones
in the list, if we want to improve the current behavior.

So unless there is a real flaw, I am going to work on something else.

Best regards,
Christian.
