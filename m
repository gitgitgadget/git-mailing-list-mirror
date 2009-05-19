From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH] Fix type-punning issues
Date: Mon, 18 May 2009 23:32:48 -0500
Message-ID: <449c10960905182132h2c1b38b4jd28721adaeb38484@mail.gmail.com>
References: <1242091058-25197-1-git-send-email-dpmcgee@gmail.com>
	 <7vy6t292ix.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue May 19 06:32:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6H0c-0004bW-G3
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 06:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbZESEcu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2009 00:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbZESEct
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 00:32:49 -0400
Received: from mail-ew0-f224.google.com ([209.85.219.224]:33009 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbZESEcs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2009 00:32:48 -0400
Received: by ewy24 with SMTP id 24so4598954ewy.37
        for <git@vger.kernel.org>; Mon, 18 May 2009 21:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:cc:content-type
         :content-transfer-encoding;
        bh=wRZqQERGRilUq+769B/9NSJOaHhaqd3T/M6dloaoiFQ=;
        b=vEgVM5XyDCWKu06tsq9A1Ngbs3x4qeN4TpZCTG7DZlXIXczVubPm6MBp53UhUaDRjk
         zl3nBHk5Q+SQB9yWNUHuYpQ7bp9fuSZalGmZBvAdnscdgNiwCUldbfy+M14j/+AY4uI6
         WX/1b/jSecwQKPfENQV99mRDf0SZTYoLNE4o4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:cc
         :content-type:content-transfer-encoding;
        b=t/FySF7FzK3geRGcGoRWk8ERrbrW7BAqv2WrqbXb+74phIPfPcTwxaH8ZAczUgcKqv
         okUibcJiIkJTm5tRibFXtR486wUWwJW+WnwDkGENlyVwy2/CFGNUSie0Is20g1m2l2rw
         pakZblFM8W5nFao+3Pm883FhOZCKWMRb+Ovo0=
Received: by 10.216.52.194 with SMTP id e44mr2332782wec.34.1242707568950; Mon, 
	18 May 2009 21:32:48 -0700 (PDT)
In-Reply-To: <7vy6t292ix.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119487>

On Tue, May 12, 2009 at 2:57 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Dan McGee <dpmcgee@gmail.com> writes:
>
>> In these two places we are casting part of our unsigned char sha1 ar=
ray into
>> an unsigned int, which violates GCCs strict-aliasing rules (and prob=
ably
>> other compilers).
>
> Yay.
>

> It might make more sense to have one canonical
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int hash_obj(const struct object =
*obj, unsigned int n)
>
> here, export it to object.h, and remove the one in decorate.c.
>
> Or am I missing something?

(argh: sorry Junio for sending the last reply to just you)

So due to me taking so long to resubmit, I see you committed a
stripped-down version of my patch. I had a patch just like this (minus
one newline diff), but it was in a series of 4 I will submit in just a
second.

The three remaining patches implement the above suggestion of having
one canonical "hash" function. However, the name changes to hash_char
and takes a unsigned char pointer rather than a struct object pointer
so we can use the same function for both insertion into the hashes as
well as lookup.

Looking forward to any feedback.

-Dan
