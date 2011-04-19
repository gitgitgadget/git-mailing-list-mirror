From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Retry on all A/AAAA records
Date: Tue, 19 Apr 2011 09:51:56 +0200
Message-ID: <BANLkTimbFSoWEkurwoj2ixyDSj9LstsU6Q@mail.gmail.com>
References: <alpine.LNX.2.01.1104161312590.11706@obet.zrqbmnf.qr> <7v39le7tvz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Engelhardt <jengelh@medozas.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 09:52:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC5jT-0003t7-DN
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 09:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807Ab1DSHwT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2011 03:52:19 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44389 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab1DSHwR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2011 03:52:17 -0400
Received: by bwz15 with SMTP id 15so4318865bwz.19
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 00:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=7TbM06g0s9e423tHwSsdW5oQJlTLZnhmv4LjVkTxMQc=;
        b=PWxeuC0P09ev6Hsp/kbCRgpUwZxhMGQEWQJ8U/KeqOecge+eFR2DhbMFh3g2/f6ZV0
         VzZWbfSjsMzza2Bik3ecZmr9pCA6+2YBKsYItGpJvDWlGBsFHZ+IQG5BK8YE+M0Phg6Q
         vwcYUhGLcpQdzbSKeEPmkkOzb2zuIkTTF9k7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Kis2B0E5Q1M8GljdYnL+PoqGKobVFhggK7GwPad30346o0WyWWGIXNjDYtSecwt4SA
         7rjqu/h9ojVcztmaQiZhz2yVjqyiJBYEBrRDEASBJDFF/CeIzcNeCkiWThBJHJ2BPJ9c
         q05aFpM1ZyW8M+iF+bMbHsZczwKek8IiPoaps=
Received: by 10.204.187.129 with SMTP id cw1mr1029708bkb.138.1303199536214;
 Tue, 19 Apr 2011 00:52:16 -0700 (PDT)
Received: by 10.204.29.2 with HTTP; Tue, 19 Apr 2011 00:51:56 -0700 (PDT)
In-Reply-To: <7v39le7tvz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171779>

On Tue, Apr 19, 2011 at 06:22, Junio C Hamano <gitster@pobox.com> wrote=
:
> Jan Engelhardt <jengelh@medozas.de> writes:
>
>> Just now, some git server that is in the DNS rotation seems to have =
an
>> issue,
>> $ telnet git.eu.kernel.org git
>> Trying 199.6.1.166...
>> Connected to git.eu.kernel.org.
>> Escape character is '^]'.
>> Connection closed by foreign host.
>>
>> I thought it would be nice if git-fetch would retry the operation on
>> the other DNS records that were returned if the connection breaks.
>
> I think people who wrote git_tcp_connect_sock() in connect.c apparent=
ly
> thought so, too. =C2=A0It uses either gethostbyname() or getaddrinfo(=
) and
> iterate over the list of addresses returned from these functions.

Jan probably means trying next server even if Git protocol fails, not
just tcp connect.
