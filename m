From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Local unset override global options
Date: Mon, 12 Apr 2010 20:36:12 +0200
Message-ID: <p2r40aa078e1004121136xe64cf1ceq6d392402107d6985@mail.gmail.com>
References: <z2kfbd9d3991004092354y21d3ac3fgf1f0675cdb5c51a8@mail.gmail.com>
	 <m3pr25f3ye.fsf@localhost.localdomain>
	 <7v1vekn05h.fsf@alter.siamese.dyndns.org>
	 <201004121902.08345.jnareb@gmail.com>
	 <7vvdbwk004.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Stefan Hajnoczi <stefanha@gmail.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 20:36:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1OUh-0007kp-NX
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 20:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab0DLSgP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 14:36:15 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:44749 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659Ab0DLSgO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Apr 2010 14:36:14 -0400
Received: by wwi17 with SMTP id 17so2374573wwi.19
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 11:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BlXRGSZFfjoIiV1RV+l/ig/vQ3MK6Sd9G4DP7scvWjI=;
        b=t7Q7HwOPaRO275xOoLLia4nCa2aF+B4TymOlXriK3OtufiVmEHkWlOEBVK5W5IAi1y
         IIEsGmGil4aJKVmnD9VEro80boi1lS2ji4tWuGcncuwQ2oBTKGN86eMlMY5yaJy40DJ2
         VMvV5A6ykgsPT0Q/3o1MT+UBpWIoi8w0xs4kQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=Bnmdt2oKVNrNnKErLZ1GOYMcUEZ6ZgDcQoIlaCbCXCrLU7CRFVg1vl1oy5slvolonP
         N2Ulbc7hB9ms903h89FT5fKLiFUwMMPUfF0Ew9B7p0lzMTdTFZ1Weg5KdCM6Ji/gj+Xt
         DYPWyDBFYk6xx6K58py3zMgtPHhpV63JgSWuA=
Received: by 10.216.73.8 with HTTP; Mon, 12 Apr 2010 11:36:12 -0700 (PDT)
In-Reply-To: <7vvdbwk004.fsf@alter.siamese.dyndns.org>
Received: by 10.216.184.195 with SMTP id s45mr2732145wem.28.1271097373017; 
	Mon, 12 Apr 2010 11:36:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144765>

On Mon, Apr 12, 2010 at 8:18 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jakub Narebski <jnareb@gmail.com> writes:
>
>> Junio C Hamano wrote:
>>> Jakub Narebski <jnareb@gmail.com> writes:
>>>
>>> > How does special case of no value, i.e.
>>> >
>>> > =A0 =A0[sendemail]
>>> > =A0 =A0 =A0 =A0 smtpuser
>>>
>>> That is not a special case; that is "boolean true".
>>
>> Well, it is "boolean true" *if* git-config is used with '--bool'.
>>
>> If git-send-email.perl used "git config -l -z" to read all its confi=
g
>> variables at once into hash, like gitweb.perl does in the
>> git_parse_project_config() subroutine, it would be able to distingui=
sh
>> between those the case of no value:
>>
>> =A0 =A0 [sendemail]
>> =A0 =A0 =A0 =A0 =A0smtpuser
>
> If sendemail is ever re-written in C and use git_config() API, the ab=
ove
> will become boolean. =A0Besides, even if you are sticking to sendemai=
l.perl

Actually, I have a very very (very) rudimentary port of send-email in
C. I worked on that mostly for Windows compatibility, but we already
solved the issue for msysGit by supplying msmtp instead, so I haven't
been working at it for quite some time. It's based on an older version
of send-email, and is incomplete in many ways (no alias-support, for
one), but most of the "tricky" parts are done AFAICT (SMTP with SSL if
OpenSSL is available).

Is there any interest in this?

I think in the long run, it'd be beneficial for Git for Windows not to
strictly depend on perl, but I don't really see that happening any
time soon as there's just too many essential tools written in perl.
Send-email is one of them (possibly one of the less essential tools
for most Windows users, though).

--=20
Erik "kusma" Faye-Lund
