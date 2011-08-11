From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/5] revert: Allow mixed pick and revert instructions
Date: Thu, 11 Aug 2011 15:20:57 +0530
Message-ID: <CALkWK0mMVgnngU5JB4O+7crCjGCdRnVrbm4jjsgkFFUMeBS9_A@mail.gmail.com>
References: <1312970151-18906-1-git-send-email-artagnon@gmail.com>
 <1312970151-18906-4-git-send-email-artagnon@gmail.com> <20110810151527.GC31315@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 11:51:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrRv9-0007HA-P1
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 11:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754868Ab1HKJvT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Aug 2011 05:51:19 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42173 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492Ab1HKJvS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2011 05:51:18 -0400
Received: by wyg24 with SMTP id 24so1289658wyg.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 02:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=VpyoYkQ/Y+Ezsg55MKF0SInUVuVDqA0OaMIgl88HT6M=;
        b=EeyvghE7tTA0p2Z0DkN/5pLG96YaIb9tOW+GEDnwtOcolxfVErscRaqCg+L2NZ7J0n
         qDPH+2ypJgl5otu9Oq/XgjYTq0rf4+xFOy3rLIiWYP9epttnhbSlxhtdeFCpQfiylP/K
         grgba6uB1woFwSh+OKzZavHtyfUs0S3jTIF9Q=
Received: by 10.216.160.9 with SMTP id t9mr1225625wek.108.1313056277093; Thu,
 11 Aug 2011 02:51:17 -0700 (PDT)
Received: by 10.216.139.31 with HTTP; Thu, 11 Aug 2011 02:50:57 -0700 (PDT)
In-Reply-To: <20110810151527.GC31315@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179099>

Hi Jonathan,

I fixed everything; just a few comments/ doubts:

Jonathan Nieder writes:
>> =C2=A0 =C2=A0 =C2=A0 } else
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
>
> Unrelated to this patch: maybe
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return error("unrecognized action in seque=
ncer file: %s", start);
>
> to be easier to debug.

I'd initially refrained from doing this so that errors don't become
overtly verbose, but I suppose it's alright considering the fact that
we're going to make the instruction sheet editable sometime in the
future.  I tweaked the error strings a little so that we get something
like:

  error: Unrecognized action: part
  error: Could not parse line 3.
  fatal: Unusable instruction sheet: .git/sequencer

In essence, I didn't want to be redundant and mention the sequencer in
every line.  I like the above.

>> =C2=A0 =C2=A0 =C2=A0 q =3D strchr(p, ' ');
>> =C2=A0 =C2=A0 =C2=A0 if (!q)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
>
> So we reject "pick a87c8989"? =C2=A0That's a shame.

Good point.  Fixing this will have to be in another patch, where I'll
advertise the fact that I'm changing the instruction sheet format.

>> =C2=A0 =C2=A0 =C2=A0 q++;
>>
>> =C2=A0 =C2=A0 =C2=A0 strlcpy(sha1_abbrev, p, q - p);
>
> memcpy would be clearer. =C2=A0Can't this overflow the sha1_abbrev bu=
ffer?

Good point.  I'm tempted to check (q - p < 40); is there a better way
to do this by not hardcoding "40" perhaps?

> Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

-- Ram
