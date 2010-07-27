From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] hash: Remove useless init_hash()
Date: Tue, 27 Jul 2010 10:36:09 +0000
Message-ID: <AANLkTimrKzDOlJzGpzaHWF24lwfr67bmh8RrKj6uMYWB@mail.gmail.com>
References: <1280208970-23394-1-git-send-email-bebarino@gmail.com>
	<m3fwz5kykn.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 12:36:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdhWC-0003Jw-Lv
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 12:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756084Ab0G0KgL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 06:36:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46532 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888Ab0G0KgK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 06:36:10 -0400
Received: by iwn7 with SMTP id 7so3664097iwn.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 03:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oSP7aQ5Gp/s70sTzzHIUnQQQrrBPSKWGm4cowRIgr98=;
        b=ArqSf4OBtH59J7Q2SIRU3hf6FBtqsMLW/jFMZec2OYGUdSOuoO2Hs0ZPMLNZV3Sha8
         /nQ4+K3k0JZKBK2Wp0jNzYTTI0DKsvO8EyW3xsP2SPoRUYBF8a7pAIam/4Po/d+gW74F
         9G+E4v+y8RV0EbcW6lE03BXSHyr+/0VgUTJe0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gmmMNbF50HsK39OQTrFHmhOEHv3N+0Vdj9Eke0fOVQpaqCEMOjcGv/fzQdjR3Os7RB
         3jyuDzAH3C/4lF96CJyJdXm2ny8UtN7Vwh6U2KX4sUttPOpB/2UOMz4RV+eau+yg3l2C
         cWHyNZTijT8L4/4v+fcKl6P8zFHFATDVx0pzs=
Received: by 10.231.19.6 with SMTP id y6mr8231892iba.16.1280226970050; Tue, 27 
	Jul 2010 03:36:10 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 27 Jul 2010 03:36:09 -0700 (PDT)
In-Reply-To: <m3fwz5kykn.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151930>

On Tue, Jul 27, 2010 at 10:30, Jakub Narebski <jnareb@gmail.com> wrote:

CC-ing Linus since he wrote it (per Documentation/SubmittingPatches).

> Stephen Boyd <bebarino@gmail.com> writes:
>
>> init_hash() is essentially a memset() so just use that.
>>
>> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> [...]
>
> Encapsulation is good.
>
> [..]
>
> This is IMHO slightly less readable, and doesn't protect against
> changes in implementation.

Agreed.

>> =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < rename_src_nr; i++)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 insert_file_table(&=
file_table, -1, i, rename_src[i].one);
>>
>> diff --git a/hash.h b/hash.h
>> index 69e33a4..418be24 100644
>> --- a/hash.h
>> +++ b/hash.h
>> @@ -33,11 +33,4 @@ extern void **insert_hash(unsigned int hash, void=
 *ptr, struct hash_table *table
>> =C2=A0extern int for_each_hash(const struct hash_table *table, int (=
*fn)(void *));
>> =C2=A0extern void free_hash(struct hash_table *table);
>>
>> -static inline void init_hash(struct hash_table *table)
>> -{
>> - =C2=A0 =C2=A0 table->size =3D 0;
>> - =C2=A0 =C2=A0 table->nr =3D 0;
>> - =C2=A0 =C2=A0 table->array =3D NULL;
>> -}
>
> *This* could be replaced by memset.

No it couldn't? The second argument to memset is just an int, so
setting the memory area to 0 isn't portable to systems where the
representation of NULL isn't "0".

(It's early so I may be misremembering my C..)
