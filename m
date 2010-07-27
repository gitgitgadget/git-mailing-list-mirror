From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] hash: Remove useless init_hash()
Date: Tue, 27 Jul 2010 19:58:39 +0000
Message-ID: <AANLkTikHLZlBQW8DSZrxeA-RDOh2Iy6hc0p821tDQoN8@mail.gmail.com>
References: <1280208970-23394-1-git-send-email-bebarino@gmail.com>
	<m3fwz5kykn.fsf@localhost.localdomain>
	<AANLkTimrKzDOlJzGpzaHWF24lwfr67bmh8RrKj6uMYWB@mail.gmail.com>
	<20100727194946.GA11682@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 27 21:58:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdqIc-0007K5-Ha
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 21:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278Ab0G0T6l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 15:58:41 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48546 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab0G0T6k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 15:58:40 -0400
Received: by iwn7 with SMTP id 7so3968218iwn.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 12:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nt3C+FvNigIfbziCKV35sbqi9DvS0MkCHAMWtUtneoM=;
        b=ufnVHnun45AkfB10c3r28KFyhy4yvtt44FBzLmvPISgAO84crnH/JvKGnonzKTH59P
         9jxPkF7p05j8MWHMBHsswYpxFJkxcAQWkl+kjTXKnUb+8mYppIpp/wC+PS+1IwdrijKW
         hzc2Ej/hitDXO4jOzm2rJ12E1x9QsLtGYvRZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BgA0loL8TL+wdBfyRgWn/8s/YNvMzMAFD0J8SreUnbxaV5ZxgLrhe7jaHbTZWSg6oV
         AMyd+VVc+04SwnxkitRBDinBOO2uZp5hELYLthG4xjIr0tUnKvDxEPIdZ1w/J+sxBQV3
         PjBv+y1D7HzaPiwRepW0Eqd2yJKcWH+icC1uo=
Received: by 10.231.177.40 with SMTP id bg40mr9914047ibb.150.1280260719374; 
	Tue, 27 Jul 2010 12:58:39 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 27 Jul 2010 12:58:39 -0700 (PDT)
In-Reply-To: <20100727194946.GA11682@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151981>

On Tue, Jul 27, 2010 at 19:49, Jeff King <peff@peff.net> wrote:
> On Tue, Jul 27, 2010 at 10:36:09AM +0000, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> >> -static inline void init_hash(struct hash_table *table)
>> >> -{
>> >> - =C2=A0 =C2=A0 table->size =3D 0;
>> >> - =C2=A0 =C2=A0 table->nr =3D 0;
>> >> - =C2=A0 =C2=A0 table->array =3D NULL;
>> >> -}
>> >
>> > *This* could be replaced by memset.
>>
>> No it couldn't? The second argument to memset is just an int, so
>> setting the memory area to 0 isn't portable to systems where the
>> representation of NULL isn't "0".
>>
>> (It's early so I may be misremembering my C..)
>
> You're remembering your C correctly. It isn't portable, but it is so
> unlikely on modern machines that we simply don't care (and you will s=
ee
> memsets zero-ing pointers like this all through the git code, so this=
 is
> certainly not introducing anything new).

Thanks for the confirmation. I was aware that NULL !=3D 0 only occured
on long-dead architechtures, but I suspected that some compiler out
there would whine if it could statically determine that you were
reading in a memzero'd area and using it as NULL. Evidently not, or at
least nobody's complained.

> That being said, I agree with the comments that removing init_hash
> actually makes the code _less_ readable. You could just replace these
> three lines with a memset, but why? It's just code churn.

Yeah, and for the record it also missed this part in hash.c:

    void free_hash(struct hash_table *table)
    {
    	free(table->array);
    	table->array =3D NULL;
    	table->size =3D 0;
    	table->nr =3D 0;
    }

Have fun everyone :)
