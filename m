From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH v3] Threaded grep
Date: Mon, 18 Jan 2010 14:28:26 +0100
Message-ID: <4c8ef71001180528h6182ef4l8a617fd038bd7318@mail.gmail.com>
References: <20100118103334.GA17361@fredrik-laptop>
	 <4B5441D7.40503@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Andrzej K. Haczewski" <ahaczewski@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jan 18 14:28:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWrer-0001pU-LR
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 14:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455Ab0ARN2h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jan 2010 08:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436Ab0ARN2h
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 08:28:37 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:42741 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296Ab0ARN22 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jan 2010 08:28:28 -0500
Received: by fg-out-1718.google.com with SMTP id e12so28236fga.1
        for <git@vger.kernel.org>; Mon, 18 Jan 2010 05:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LxfPf33NY5ueLiam7MfFMbN4Q/jFMa0ZOgkj/bAMwbQ=;
        b=gAdinnzkUiFk9g7WOEuIAJAFlpwd/6TxxG0LsjVjJVpQKVf0hcj+DiA4vuPjDdCDdh
         GCEuA8CKblEuz810xl+ms5OUYwwObTig0FINB2lVgdeSC0MHxKGiCXy7lY8Z/eC3VOqr
         l8iomMe2rZ7Ikn5Y6b03XZSb2gkreKiv8/jfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VNi8JhUlk1NFGORf0L3tgudAIqhyopXso0xK4LfQtJ4Tf/iwWIIffTVkLpM0xrcjQZ
         yBchrF52Loy+1CRU6J0G/JmUAXV526Voj6Lqi0utRv94/9OYqGpcCtnoDRiai5K+lUT7
         Ll7jxBAUanZAapWz6Scpp+TMaYdO8bW4J0ROg=
Received: by 10.239.160.7 with SMTP id a7mr652069hbd.98.1263821306668; Mon, 18 
	Jan 2010 05:28:26 -0800 (PST)
In-Reply-To: <4B5441D7.40503@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137385>

On Mon, Jan 18, 2010 at 12:11, Johannes Sixt <j.sixt@viscovery.net> wro=
te:
> Fredrik Kuivinen schrieb:
>> +/* This lock protects all the variables above. */
>> +static pthread_mutex_t grep_lock =3D PTHREAD_MUTEX_INITIALIZER;
>> +
>> +/* Signalled when a new work_item is added to todo. */
>> +static pthread_cond_t cond_add =3D PTHREAD_COND_INITIALIZER;
>> +
>> +/* Signalled when the result from one work_item is written to
>> + =A0 stdout. */
>> +static pthread_cond_t cond_write =3D PTHREAD_COND_INITIALIZER;
>> +
>> +/* Signalled when we are finished with everything. */
>> +static pthread_cond_t cond_result =3D PTHREAD_COND_INITIALIZER;
>
> Please do not use PTHREAD_MUTEX_INITIALIZER nor PTHREAD_COND_INITIALI=
ZER;
> call pthread_mutex_init and pthread_cond_init (and the corresponding
> *_destroy!!) from the code.

Ok. Will fix.

>> +static void add_work(enum work_type type, char *name, char *buf, si=
ze_t size)
>> +{
>> +...
>> + =A0 =A0 pthread_mutex_unlock(&grep_lock);
>> + =A0 =A0 pthread_cond_signal(&cond_add);
>
> Please swap these two lines, so that pthread_cond_signal() is called =
while
> the lock is held.

May I ask why?=A0(just curious)


Thanks for your comments.

- Fredrik
