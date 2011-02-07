From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] Re: [PATCH v4 5/5] mingw_rmdir: set errno=ENOTEMPTY
 when appropriate
Date: Mon, 7 Feb 2011 22:57:37 +0100
Message-ID: <AANLkTi=r1Ujz7RXTTepiVUCMNRWUmydTeOmUkyd1+AC4@mail.gmail.com>
References: <20101214220604.GA4084@sandbox> <AANLkTiks1drfpu9eR6S7KQ9X2MgVy91QAfKs-SRF_voG@mail.gmail.com>
 <7vmxo6pxyi.fsf@alter.siamese.dyndns.org> <20110207204818.GA63976@book.hvoigt.net>
 <20110207205400.GF63976@book.hvoigt.net> <AANLkTin6A-HVKvM9_5ggMezpM--tt1qUwSXF+CEaXg7J@mail.gmail.com>
 <20110207211844.GH63976@book.hvoigt.net> <AANLkTi=ntgYOW58pPnt-azMw6rFZfJjDW3OaCgLsvJp6@mail.gmail.com>
 <7vk4hbtsro.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 22:58:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmZ5y-0007Ur-Iz
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 22:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755074Ab1BGV6B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Feb 2011 16:58:01 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42175 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068Ab1BGV6A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Feb 2011 16:58:00 -0500
Received: by ewy5 with SMTP id 5so2655990ewy.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 13:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=2rEVsSekFEpchF66jIraIRVvVwgeHnBu9/jz01FQRiE=;
        b=a5HKK8NVBuIHJJHZDslzkpnL2Fr8q6CGt9Y83vF87LaGpUzZ4bRXM+RJ17utlRDebr
         XbSMwi63JCkOvN4X/TGVb5/Bt3smac686zdwqL49XdvKRwoYyC8asV5Sfc2m0ofXDqK8
         XnwmaZMsVoH6nnQOe9qAyeNxYxeWbdoPhO5+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=HoXRo/IFG99kozVhJJzam60pt6BPADhy/O2cDT/EETtzCcJCvfoI+ThUFnla6naIHD
         GM+IF2usCZzgbuZ0oxppWL6iy6A3V2Cq9GcL8GWvrQPxxcgOInh+mUuONWYRwcPMUSRa
         /XafNd+DBd1pvohSdUl1x84Ql3+itoR9F//NI=
Received: by 10.223.73.198 with SMTP id r6mr4902564faj.14.1297115878910; Mon,
 07 Feb 2011 13:57:58 -0800 (PST)
Received: by 10.223.116.210 with HTTP; Mon, 7 Feb 2011 13:57:37 -0800 (PST)
In-Reply-To: <7vk4hbtsro.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166304>

On Mon, Feb 7, 2011 at 10:54 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> On Mon, Feb 7, 2011 at 10:18 PM, Heiko Voigt <hvoigt@hvoigt.net> wro=
te:
>> ...
>>> I think Johannes was referring to the case when a directory is busy=
=2E
>>> E.g. a process is running that has its working directory inside tha=
t
>>> directory. In that case ENOTEMPTY was not returned even though the
>>> directory is not empty. Thats what I read from the patch.
>>
>> I don't think that's the case either:
>> $ echo "int main() { while (1); }" | gcc -x c - -o foo/bin.exe
>> [kusma@HUE-PC:/git@work/xgetenv]
>> $ foo/bin.exe &
>> [2] 3188
>> [kusma@HUE-PC:/git@work/xgetenv]
>> $ ./a.exe
>> rmdir: Directory not empty
>> errno: 41 (expected 41)
>
> I don't do windows, but I think Heiko is talking about running some
> process inside the directory that is getting removed. =A0Assuming tha=
t your
> a.exe is to remove the 'foo' directory, you would need to run ./bin.e=
xe
> after going into 'foo' directory, perhaps like this:
>
> =A0 =A0$ (cd foo && ./bin.exe) &
> =A0 =A0$ ./a.exe

Of course, silly me:

$ ./a.exe
rmdir: Permission denied
errno: 13 (expected 41)

Thanks for clearing that up, now I'm on board :)
