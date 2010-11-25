From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] help: always suggest common-cmds if prefix of cmd
Date: Thu, 25 Nov 2010 11:39:27 +0100
Message-ID: <AANLkTinKDqykfuV5=oHav9PRehDtJZct_q=zm7p8PAeo@mail.gmail.com>
References: <AANLkTina0tnOEE2+17W03pFPqg37Btss0HYBeW+pOEgn@mail.gmail.com>
 <1290539473-2420-1-git-send-email-kusmabite@gmail.com> <7v1v6atsbd.fsf@alter.siamese.dyndns.org>
 <AANLkTi=nxcODCvQ6hmaQe=q38e=bF7cRHWrRaFr+zen6@mail.gmail.com> <7vfwuqrori.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ziade.tarek@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 11:43:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLZIc-00073L-JM
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 11:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362Ab0KYKnO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Nov 2010 05:43:14 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56210 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab0KYKnI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 05:43:08 -0500
Received: by fxm13 with SMTP id 13so636412fxm.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 02:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=zAwC6ZGu9ypOtb59j1WsDYJQPaLfk3ssasmpDgDpMo8=;
        b=X0xstsCSY088ZJDQmIm6GCZWUdVJsl3f42UkBI6qKJPZ4LAwpZ0/6Ga0ds4GsfOJ2b
         7Zob5Ch6LYOT6QUxlLD6tbIBWobGPAdghd1nlqJ98zdkwhc2a7AiT5tEipNUD3LCzske
         Gn8RalYchGaRChBAaQrYb4/MDAwEcNJZTr6U4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=URznLRxnrIZR4tI4h9r5KMXmwZlq0L+zoPTF9ZFWCQ3Cj4ZkUFW1cR0m1qT82AEDKs
         8KhjWAFydyXmFo5m2WnKJ2EIwAP+CvZES7p4QCCnQNoiMypwHDVY6TTz1/txLyhf5sQm
         PYNXTAo4UgXpLqQuWqqGQui+o8L9XSvMgc7FQ=
Received: by 10.223.70.133 with SMTP id d5mr547322faj.64.1290681709188; Thu,
 25 Nov 2010 02:41:49 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Thu, 25 Nov 2010 02:39:27 -0800 (PST)
In-Reply-To: <7vfwuqrori.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162124>

On Thu, Nov 25, 2010 at 5:49 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> Indeed. What about this intra-diff? Hopefully it's a bit clearer, as
>> it's closer to the original, just reusing the same logic for the new
>> similar loop... Also makes the final diff smaller, which is nice.
>>
>> diff --git a/help.c b/help.c
>> index dc76a62..d02a019 100644
>> --- a/help.c
>> +++ b/help.c
>> @@ -339,11 +339,10 @@ const char *help_unknown_cmd(const char *cmd)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 die ("Uh oh. Your system reports no Git =
commands at all.");
>>
>> =A0 =A0 =A0 n =3D 0;
>> - =A0 =A0 do {
>> - =A0 =A0 =A0 =A0 =A0 =A0 best_similarity =3D main_cmds.names[n++]->=
len;
>> - =A0 =A0 } while (!best_similarity);
>> - =A0 =A0 n++;
>> - =A0 =A0 while (n < main_cmds.cnt && best_similarity >=3D main_cmds=
=2Enames[n]->len)
>> + =A0 =A0 while (n < main_cmds.cnt && !main_cmds.names[n]->len)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ++n;
>> + =A0 =A0 best_similarity =3D main_cmds.names[n++]->len;
>> + =A0 =A0 while (n < main_cmds.cnt && best_similarity =3D=3D main_cm=
ds.names[n]->len)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ++n;
>
> Perhaps, but it is probably more conventional to write this kind of l=
oop with:
>
> =A0 =A0 =A0 =A0for (n =3D 0; ...; n++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
>
> no?
>
>> =A0 =A0 =A0 if (autocorrect && n =3D=3D 1 && SIMILAR_ENOUGH(best_sim=
ilarity)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *assumed =3D main_cmds.names[=
0]->name;
>

Sure. I was just trying to match the existing code. But sure, I can
change that if you prefer. I think it makes the end-result slightly
nicer.
