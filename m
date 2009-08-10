From: Ryan Flynn <parseerror@gmail.com>
Subject: Re: [PATCH] fix potential infinite loop given large unsigned integer
Date: Mon, 10 Aug 2009 12:14:43 -0400
Message-ID: <a3f15ee60908100914n6d9e11fbk77a90f5619b9a860@mail.gmail.com>
References: <a3f15ee60908082141l7b2134cg5ddcef17c45fc888@mail.gmail.com>
	 <7v3a81a13z.fsf@alter.siamese.dyndns.org>
	 <40aa078e0908090525h7b4d6efeh658e2edcfbe16c7e@mail.gmail.com>
	 <200908100724.53345.chriscool@tuxfamily.org>
	 <40aa078e0908100412l3c2afd1bnda9b10aaf1de383f@mail.gmail.com>
	 <alpine.DEB.1.00.0908101421340.8324@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 10 18:15:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaXWa-0002XI-50
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 18:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559AbZHJQOn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2009 12:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755423AbZHJQOn
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 12:14:43 -0400
Received: from mail-vw0-f172.google.com ([209.85.212.172]:46678 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755417AbZHJQOm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2009 12:14:42 -0400
Received: by vws2 with SMTP id 2so2772339vws.4
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 09:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NOilejRx/d5FM+9PNaIxvSvd3c+Af0j+vp9L03hQcMA=;
        b=hjnU80Ditw6bw32sKxi3tKx7dSsiz06QCQfMTreSoFoaSVvru9OdiKRyKvw0ayRZmp
         z/g0XPlDiNqJDntAAO9KzPZAncLJWIiFHx/ICcFYZhCqgJlmEf4NWQt6xysAVdWBrPX8
         hWP1hTJIkONNd0XAVz/6n9wovo6lnUR1+Jn+8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=o7R+4V6GIG42lJuubPsYiUCaRPYUOx0DxvJJ1EtojGihkFP74lo1DJR9ivcTFifiz7
         kf1PXryeR5fs/nGHzCT4oJhPbPqHBjg/uEhPd+fMZWnAwRvYJ0NJbJc33LxfwZZJ/DKx
         Br0zNlIu7a0rqU1mC8hF323H8jNQWDb+ICUZM=
Received: by 10.220.74.142 with SMTP id u14mr4710845vcj.83.1249920883463; Mon, 
	10 Aug 2009 09:14:43 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908101421340.8324@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125475>

On Mon, Aug 10, 2009 at 8:24 AM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 10 Aug 2009, Erik Faye-Lund wrote:
>
>> On Mon, Aug 10, 2009 at 7:24 AM, Christian
>> Couder<chriscool@tuxfamily.org> wrote:
>> >> log10() appears to be C99, but can be emulated on earlier C-versi=
ons by
>> >> doing #define log10(x) (log(x) / log(10.0))
>> >
>> > That would mean linking with -lm?
>>
>> I guess so. Are we currently trying to avoid linking to the math-par=
ts
>> of libc?
>
> Yes.
>
> I guess we could fix the overflow thing very easily, though:
>
> static unsigned int digits_of_number(unsigned int number) {
> =A0 =A0 =A0 =A0unsigned int result;
> =A0 =A0 =A0 =A0for (result =3D 1; number; number /=3D 10, result++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0; /* do nothing */
> =A0 =A0 =A0 =A0return result;
> }
>
> Ciao,
> Dscho
>
>

that is equivalent to the original patch, yes.
