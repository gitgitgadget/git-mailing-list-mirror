From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v3 2/6] t5541-http-push.sh: add test for unmatched, 
	non-fast-forwarded refs
Date: Wed, 6 Jan 2010 10:12:57 +0800
Message-ID: <be6fef0d1001051812nce6ab9aic3cd71e2e5188c1a@mail.gmail.com>
References: <20091224154057.33611ae7.rctay89@gmail.com>
	 <20091224154005.a642c8ec.rctay89@gmail.com>
	 <20091224154158.15ba580f.rctay89@gmail.com>
	 <7viqbgoxgg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 03:13:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSLOZ-0002Zt-Pd
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 03:13:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100Ab0AFCNA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jan 2010 21:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754597Ab0AFCM7
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 21:12:59 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:42284 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab0AFCM7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jan 2010 21:12:59 -0500
Received: by iwn32 with SMTP id 32so1283606iwn.33
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 18:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pLssAa4/0ooZ/HSw+fz4VkwyecmkqGcI8Tv/bOoKIVA=;
        b=mQlEW1Ko31XwHAq7x5qsXTvm7sU2p28SMWl7w3435lWHRIMw+3x9ShIojc/BiGfwGk
         OwtEFjqUVOH2L4scFaWNAF1LhQ5DWMGH87jtOhyAAhewNY5+w3GtfjbIvtiPNvHaiLdu
         Sv78AAX4yu11ay4RMdpkVotPPV9+f6qxf+Qq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vviWnUxK7T2tRPCc6CdbiUg8FfegKh6yhYdrtYOU4aiwd2zsGgiHoSjy53aC2MoHJT
         FB20Yd0VmMI/036l2zB5H8r2uwGA4qPmPN9IFYmPE9/OAvNxF4pwVlNvp285ggRsLegM
         dtl3y/XKkXzu34MyBhyOnHIXeB6WtJtvNrPTE=
Received: by 10.231.146.2 with SMTP id f2mr1330546ibv.23.1262743977686; Tue, 
	05 Jan 2010 18:12:57 -0800 (PST)
In-Reply-To: <7viqbgoxgg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136236>

Hi,

On Wed, Jan 6, 2010 at 9:04 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Tay Ray Chuan <rctay89@gmail.com> writes:
>
>> Test that when non-fast-forwarded refs cannot be matched without an
>> explicit refspect, the push fails with a non-fast-forward ref status=
 and
>> help message.
>>
>> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
>> ---
>> =A0t/t5541-http-push.sh | =A0 20 ++++++++++++++++++++
>> =A01 files changed, 20 insertions(+), 0 deletions(-)
>>
>> diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
>> index f49c7c4..5ebe04a 100755
>> --- a/t/t5541-http-push.sh
>> +++ b/t/t5541-http-push.sh
>> @@ -111,5 +111,25 @@ Merge the remote changes before pushing again. =
=A0See the '"'non-fast-forward'"'
>> =A0section of '"'git push --help'"' for details." output
>> =A0'
>>
>> +test_expect_failure 'push fails for non-fast-forward refs unmatched=
 by remote helper' '
>> + =A0 =A0 # create a dissimilarly-named ref so that git is unable to=
 match the refs
>> + =A0 =A0 git push origin master:retsam
>> +
>> + =A0 =A0 echo "change changed" > path2 &&
>> + =A0 =A0 git commit -a -m path2 --amend &&
>> +
>> + =A0 =A0 # push master too. This ensures there is at least one '"'p=
ush'"' command to
>> + =A0 =A0 # the remote helper and triggers interaction with the help=
er.
>> + =A0 =A0 !(git push -v origin +master master:retsam >output 2>&1) &=
&
>
> A dumb question. =A0Why is this done in a sub-shell?
>
>> +
>> + =A0 =A0 grep "^ + [a-z0-9]\+\.\.\.[a-z0-9]\+[ ]*master -> master (=
forced update)$" output &&
>> + =A0 =A0 grep "^ ! \[rejected\][ ]*master -> retsam (non-fast-forwa=
rd)$" output &&
>
> [a-z0-9] seems too broad to catch hexadecimal.

Oops, my bad.

> =A0"\+" to introduce ERE
> elements to grep that expects BRE is a GNU extension, IIRC. =A0You co=
uld use
> egrep if you really want to say one-or-more, but I think in this case=
 it
> is better to simply replace it with a zero-or-more '*'.

Ok.

> =A0Why is a single
> SP made into character class with "[ ]" pair?

To make it clearer that I'm trying to match a SP.

--=20
Cheers,
Ray Chuan
