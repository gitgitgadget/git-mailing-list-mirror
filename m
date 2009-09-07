From: =?ISO-8859-1?Q?Dirk_H=F6rner?= <dirker@gmail.com>
Subject: Re: [PATCH] Do not scramble password read from .cvspass
Date: Mon, 7 Sep 2009 12:39:54 +0200
Message-ID: <4da546dc0909070339x5d78164flc4171882e8b028db@mail.gmail.com>
References: <4AA100E8.9030806@obry.net> <7vvdjyn0j3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>, pascal@obry.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 12:40:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mkbe9-0002ur-Fu
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 12:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbZIGKkR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Sep 2009 06:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752628AbZIGKkQ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 06:40:16 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:51425 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbZIGKkP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Sep 2009 06:40:15 -0400
Received: by ewy2 with SMTP id 2so1951725ewy.17
        for <git@vger.kernel.org>; Mon, 07 Sep 2009 03:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Be43fkcXyoM1YN8tvRWQ5XopgzimFnMA6IEMv7FCavA=;
        b=MwPmktt0+SNbX8h57UM65ewdhju5N5jWMuN9lKxFOyZUTi815XyBqVzwN9FgyfLUUO
         2NBvYQkFv8/ToAAk5eTRxs3yOODIs/xgRu2S9jWHxv7qdA7sf80yXmNPMZJvBWH63FDw
         lzwk7+BPqMAkdvqvn3IhVZN1UcBTc1nd2DBLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=n/zHSXa1Hu5wqZBrAg637OTAABn1NMTkt0/BEPcwsJJmnlmKZRYeNFS7B/ilYsyMA7
         SvaZRpu5xuj/c4MunvoE4N2uxOXG7N2hPComh4RnyE5g2cuWc7I7zYovDpCGv+U0N12W
         JzTpSaaRL5ZRolgM8mus9AIdmsadShFEcTRak=
Received: by 10.211.154.10 with SMTP id g10mr5195174ebo.49.1252320016639; Mon, 
	07 Sep 2009 03:40:16 -0700 (PDT)
In-Reply-To: <7vvdjyn0j3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127918>

Hi Junio,

On Fri, Sep 4, 2009 at 6:21 PM, Junio C Hamano<gitster@pobox.com> wrote=
:
> Dirk, does the patch look Ok to you?

The patch looks fine :-)

Ciao,
Dirk

>
>> =A0git-cvsimport.perl | =A0 =A07 ++++---
>> =A01 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
>> index 593832d..c5cdcae 100755
>> --- a/git-cvsimport.perl
>> +++ b/git-cvsimport.perl
>> @@ -238,7 +238,10 @@ sub conn {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my $rr =3D ":pserver:$user\@$serv:$p=
ort$repo";
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unless ($pass) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ($pass) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $pass =3D $self->_scramble($pa=
ss);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 open(H,$ENV{'HOME'}.=
"/.cvspass") and do {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #
>> :pserver:cvs@mea.tmt.tele.fi:/cvsroot/zmailer Ah<Z
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 whil=
e (<H>) {
>> @@ -253,8 +256,6 @@ sub conn {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 $pass =3D $self->_scramble($pass);
>> -
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my ($s, $rep);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ($proxyhost) {
>>
>> --
>> 1.6.4.2.253.g0b1fac
>
