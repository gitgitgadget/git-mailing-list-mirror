From: Christian Couder <christian.couder@gmail.com>
Subject: Re: git bisect problems/ideas
Date: Fri, 21 Jan 2011 14:18:20 +0100
Message-ID: <AANLkTikG6Ft3Y922Aaakf28cnYs26PcRHoq9GSNj04mu@mail.gmail.com>
References: <855249CA-A006-475C-8F96-EFD614795064@gmail.com>
	<AANLkTikNzpCwEieV8sXXctMm+DR69fkLfCF+F3xB6b-k@mail.gmail.com>
	<54DED602-0BA7-4462-AC00-1DDEEF83068C@gmail.com>
	<AANLkTi=A2Twepg3Jo_VYxtvghkhx6ixcpRH3332BoRQo@mail.gmail.com>
	<0253BAE3-90F7-492C-ADF5-8B16DFFA1E44@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: "Aaron S. Meurer" <asmeurer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 21 14:18:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgGsl-00086J-VX
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 14:18:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930Ab1AUNSX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Jan 2011 08:18:23 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62425 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754864Ab1AUNSW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Jan 2011 08:18:22 -0500
Received: by wyb28 with SMTP id 28so1787762wyb.19
        for <git@vger.kernel.org>; Fri, 21 Jan 2011 05:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=q/pRzrZtF3Qc2EIwO3nLaANfRoRTyunRVv7a1/6IWU8=;
        b=sCfDX9e3M1bS0XklF7Akq/oaUwGSL1lF4CgqDe6xbyi5wRyO0m4drQX0XUZKK/xqcP
         jiu/3Ku/5QwwgxkYlqoK2xKaAlkV2yvsA0225FYyEBKiISJ8tplE1cS0kwP7ND6g/ct0
         cXYePyTVcJz2uxEB6jgEFjWk5ng2CNDwj11Nw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sAX3PuV2S8e4z8hDVx+J7qbmD/E44MUA08VZzz7d79OCKVegkX+J9itSd+xJBLhywR
         npdTv22+tw7tBo9h+aTHTiPQYcVvFY75Z2Qhi3LBBL9Y8OaLK2Qis7pBL8qHXVKckvRO
         u3S3ScloUDjV9yK0b3sFa+jjivW0u5CYSzF1I=
Received: by 10.216.179.207 with SMTP id h57mr601334wem.20.1295615900728; Fri,
 21 Jan 2011 05:18:20 -0800 (PST)
Received: by 10.216.30.65 with HTTP; Fri, 21 Jan 2011 05:18:20 -0800 (PST)
In-Reply-To: <0253BAE3-90F7-492C-ADF5-8B16DFFA1E44@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165367>

On Wed, Jan 19, 2011 at 8:44 PM, Aaron S. Meurer <asmeurer@gmail.com> w=
rote:
>>>
>>> I don't understand how this can only be one way? =A0Isn't this symm=
etric? =A0In
>>> other words, how is it different from
>>>
>>> A-B-C-D-E <-- dev
>>> =A0 =A0\F-G <-- master
>>>
>>> as far as bisect is concerned? Or maybe I am not entirely clear on =
what you
>>> are saying.
>>
>> Yes, it is symmetric, so we cannot just automatically reverse the
>> meanning because there is no "after" or "before" relationship betwee=
n
>> "dev" and "master".
>
> I think I understand. =A0What if something works in A, gets broken in=
 C, stays broken in E, but gets fixed in G? =A0Should it maybe be impli=
ed by whichever one is marked as good first, A or G, if you trying to f=
ind the fix or the break?

In this case, if we are given "git bisect bad E" and "git bisect good
A", yes, as A is before E, we must suppose that we are looking for the
break.

But if we are given "git bisect bad E" and "git bisect good G", we
have to suppose that we are looking for the break too. There are many
good reasons for that:

- it's the logical default for bisect,
- if what is wanted is the fix, there has been for a long time the
possibility to just switch "bad" and "good",
- the user might not even realize that E and G have no "after" or
"before" relationship.

> If no, I think --reverse is actually a suitable fix.

Yeah, but I think that what Dscho started was probably better. The
problem is just that it is not so simple to implement and no one yet
has been interested enough or took enough time to finish it.

Best regards,
Christian.
