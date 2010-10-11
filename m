From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] [PATCH v3 02/14] mingw: implement syslog
Date: Mon, 11 Oct 2010 17:28:16 +0200
Message-ID: <AANLkTi==sd=jm9LZ6p6NLVBMc4wnU0PrYvJY6ezGWiWt@mail.gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
 <1286716854-5744-3-git-send-email-kusmabite@gmail.com> <4CB2190F.6000908@gmail.com>
 <AANLkTinsqAOj7LtACpbcOrVZfeUApDjmQe2uYLH8npBF@mail.gmail.com>
 <4CB22FF3.5070503@gmail.com> <AANLkTinBE14dWCecXvpH=8N1b0H=9j9tc=t07d_MHEFF@mail.gmail.com>
 <4CB24A43.9090501@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	Mike Pape <dotzenlabs@gmail.com>
To: Eric Sunshine <ericsunshine@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 17:28:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5KIu-00075J-E3
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 17:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181Ab0JKP2i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Oct 2010 11:28:38 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37832 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281Ab0JKP2h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Oct 2010 11:28:37 -0400
Received: by vws2 with SMTP id 2so958363vws.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 08:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=F4jTMdirFMiEsa9IgzvuPJiwVG2etdLFIppMU5vSfeM=;
        b=Sq2lc5yeJiz5CvA9czNnZ9a0X52FMjXLf/NHrbwPiGI+yjvW90+BYbkcrZp0VEuhwD
         7+4iClEYOb7AAmfNRsUJH8G8ORdoPIdp6f1Y9tWSCuNSeH1KfLBF5LHmF8+kfQ821Q+4
         p+0l9BvEUGOF8AaSwVEOqJMClw46A0RPm4P6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=gZeb1/TxGnJooeEwAtVMZ9IVivJtX4KSk6dICoAxUW+ldZnilyXbu8Xb2g2iDXwUhH
         iT1hMQXflz5bIRyruYNKMWG5ZmbbQlk/EPjtMwPyWR9PaLBFOIRsInWhx1SwZX1TUovT
         XrNJTd04Y+JqS99dYV/ttsSyXcXZjPO2v0Pvg=
Received: by 10.220.195.133 with SMTP id ec5mr195909vcb.97.1286810916790; Mon,
 11 Oct 2010 08:28:36 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Mon, 11 Oct 2010 08:28:16 -0700 (PDT)
In-Reply-To: <4CB24A43.9090501@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158767>

On Mon, Oct 11, 2010 at 1:20 AM, Eric Sunshine <ericsunshine@gmail.com>=
 wrote:
> On 10/10/2010 6:16 PM, Erik Faye-Lund wrote:
>>
>> On Sun, Oct 10, 2010 at 11:28 PM, Eric Sunshine<ericsunshine@gmail.c=
om>
>> =A0wrote:
>>> (On the other hand, for the '%s' check above, the code does report =
a
>>> warning
>>> and then exits, so it is not inconceivable that a '%n' could also e=
mit a
>>> warning.)
>>
>> I guess I could add something like this:
>>
>> if (strstr(arg, "%1"))
>> =A0 =A0 =A0 =A0warning("arg contains %1, message might be corrupted"=
);
>>
>> I don't want to return in that case, because I think some output is
>> better than no output, and it seems to work on Vista.
>
> Rather than emitting a warning, it might be reasonable to perform a s=
imple
> transformation on the string if it contains a %1 (or %n generally) in=
 order
> to avoid ReportEvent()'s shortcoming. Even something as simple as ins=
erting
> a space between '%' and '1' might be sufficiently defensive.
>

Yes, but I'm tempted to defer fixing this until we see that it's a
problem in reality. The logic to somehow escape such sequences looks a
bit nasty in my head. But perhaps strbuf_expand() is the right hammer
for this use...

Then the logical next question becomes what we should expand it to.
Does "%1" -> "% 1" make sense for IPv6 addresses?
