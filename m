From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: [PATCH 1/5] MSVC: Windows-native implementation for subset of 
	Pthreads API
Date: Thu, 14 Jan 2010 08:43:30 -0500
Message-ID: <eaa105841001140543q777c868bu27eee5e492192ec4@mail.gmail.com>
References: <cover.1262895936.git.j6t@kdbg.org>
	 <201001122213.38287.j6t@kdbg.org>
	 <20100113125312.GD10586@dpotapov.dyndns.org>
	 <201001131940.43868.j6t@kdbg.org>
	 <20100114051241.GF10586@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, kusmabite@gmail.com,
	msysgit <msysgit@googlegroups.com>, git@vger.kernel.org,
	"Andrzej K. Haczewski" <ahaczewski@gmail.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 14:43:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVPzE-0003Mq-Lw
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 14:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756592Ab0ANNnl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jan 2010 08:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755634Ab0ANNnl
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 08:43:41 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:41388 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab0ANNnk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jan 2010 08:43:40 -0500
Received: by pwj9 with SMTP id 9so31249pwj.21
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 05:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=9DANJ9qQG1mCuV2RbZC+FI5ufHMAN49YzTYADEkHi40=;
        b=CDIjdSau9/IXPB0QpDrRspvVHDxNAq+0F1PDDit9fmbLY2EI2/psxc9IQylIWCDxLt
         tFoYzZ7+Gguro2IedpLKZSogHTPUiohFSiaf3WEbo7YgvJ1ayKDvTi9tX8YXTdzIp3bR
         RO2M+G5jZ0TlfrGq2jXUSEzXFT2l5HKQBhRKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=wX8dIdtrab81yoCbSqwNn+XQJzwNBo3KeyggEFXuBGG9bsI+GTtcRsN0r6EXWhnMpy
         WkWMLVj3OSXJDHuTI3Etwf0WroFMwA7eBB9mUmHBb+bYnFQZBklhNnE9u0CLONJlJENj
         5xnElg2/DxZ46vCY2YoMw2axNMPBsL5cmnwSU=
Received: by 10.142.209.20 with SMTP id h20mr568783wfg.167.1263476610764; Thu, 
	14 Jan 2010 05:43:30 -0800 (PST)
In-Reply-To: <20100114051241.GF10586@dpotapov.dyndns.org>
X-Google-Sender-Auth: 509076db30080e5e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136991>

On Thu, Jan 14, 2010 at 12:12 AM, Dmitry Potapov wrote:
> On Wed, Jan 13, 2010 at 07:40:43PM +0100, Johannes Sixt wrote:
>> Is there "InterlockedRead()"? I suppose no, but I would get confirma=
tion that
>> a simple memory mov instruction is atomic WRT Interlocked* functions=
=2E
>
> If I were writing Interlocked API, I would certainly add InterlockedR=
ead()
> and InterlockedWrite() functions, but somehow Microsoft decided that =
these
> functions are redundant.

InterlockedWrite is spelt InterlockedExchange.

> Finally, there is a paranoiac implementation of InterlockedRead(&foo)=
:
>
> =A0 result =3D InterlockedAdd(&foo, 0)
>
> but, IMHO, it is pathetic...

Agreed. Another pathetic implementation:
  result =3D InterlockedCompareExchange(&foo, 0, 0);

Peter Harris
