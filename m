From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] {fetch,receive}-pack: skip sha-1 integrity test on
 objects from new pack
Date: Fri, 16 Mar 2012 09:24:34 +0700
Message-ID: <CACsJy8A-W97Jd+8FOk1zWbDoTPb=RwO6Ck37O73v7DRrR+M5ew@mail.gmail.com>
References: <7vfwdq8914.fsf@alter.siamese.dyndns.org> <1331736055-21019-1-git-send-email-pclouds@gmail.com>
 <7vy5r1inax.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 03:25:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8Mqv-0008Fy-Mq
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 03:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696Ab2CPCZJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Mar 2012 22:25:09 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:64475 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193Ab2CPCZH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Mar 2012 22:25:07 -0400
Received: by wgbdr13 with SMTP id dr13so117766wgb.1
        for <git@vger.kernel.org>; Thu, 15 Mar 2012 19:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=CuiGTWh39uVjyM8I1DDEPDL7NFx1cMg8pzatGpWxogI=;
        b=cJ3cw/D8rYKVLrILt4dzI/BxawFOYaFVeFE1Z1FPCEC8T80c6W0nT2hNFFT1M/73Nm
         7iOjAi/FhoX+BOoCv3q9p2jjyQAIcrSWYHxspfodKBUed3otGpPDIPJtW7cw1vJrLsq6
         Yx160ssjUffVNR/njrrFiB8T1Z9rmo5xfYzal2ixM0ndzgJx8Z7pgPNrAG8hJm5Hxd1C
         xiig3JIbkdrR/MoA0lU/RGSOmhb8k4RuPNK99q0eZ587SagKxUZgq8OBBEKlK5mLUyBG
         /OS2eY3ibi16DCGkRCn8f7p54pbJ2eX4pYyUXPA9bNdL692zWHGKs9TjZtnqkhZDRxOS
         NE8Q==
Received: by 10.216.134.200 with SMTP id s50mr450030wei.116.1331864705206;
 Thu, 15 Mar 2012 19:25:05 -0700 (PDT)
Received: by 10.223.13.5 with HTTP; Thu, 15 Mar 2012 19:24:34 -0700 (PDT)
In-Reply-To: <7vy5r1inax.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193238>

2012/3/16 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> When we fetch or push, usually "git rev-list --verify-objects --not
>> --all --stdin" is used to make sure that all objects between existin=
g
>> refs and new refs are good. This means no gaps in between, all objec=
ts
>> are well-formed, object content agrees with its sha-1 signature.
>>
>> For the last one, --verify-objects calls check_sha1_signature() via
>> parse_object(). check_sha1_signature() is an expensive operation,
>
> After thinking about this a bit more, I am beginning to think that th=
e
> validation of object contents is unnecessary in _all_ cases that invo=
lve
> "git fetch". =C2=A0Unpack-objects and index-pack already validate ind=
ividual
> objects, and the only thing we would want to catch are objects that w=
e
> already happened to have had in our repository but were unreferenced =
from
> our refs.

What about remote helpers? Should we declare it's remote helper
responsibility to validate all incoming objects?
--=20
Duy
