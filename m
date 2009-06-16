From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] builtin-remote: (get_one_entry): use strbuf
Date: Tue, 16 Jun 2009 09:56:41 +0200
Message-ID: <36ca99e90906160056w4f892dc7n761b7e7fb91a288d@mail.gmail.com>
References: <4A35FCFB.1080000@drmicha.warpmail.net>
	 <1245098728-7502-1-git-send-email-bert.wesarg@googlemail.com>
	 <4A374C4E.2090304@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jun 16 10:02:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGTcr-0007LM-Cx
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 10:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbZFPIC2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Jun 2009 04:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbZFPIC1
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 04:02:27 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:63512 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbZFPIC0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jun 2009 04:02:26 -0400
Received: by bwz9 with SMTP id 9so3850455bwz.37
        for <git@vger.kernel.org>; Tue, 16 Jun 2009 01:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=H0Dso2uay0u6MepBjDbycKNIoAqGnthpur37ya6MKNs=;
        b=EkYew2WrDf2GXKMBWmRymRQ+22urR6XkKIMO2UOuQNylYzghwhX2AltdRj3b/5Rve8
         r5fRjqC9W1JxRCXdZZCk0Ji3TLyAez2y8+vfdmVnEUv66u3PF4pEx8JLaGcctAgJvtBJ
         baLB80kzElrJBsJWSezmQ33kEyNzb63MJCo8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hhCrZjJM4GJB/F5sXX23XuI02FUqRhZbPNK2XPC3wG4GVwGShYnPQkasfOr26UBOjb
         d8+EaCx1ruRsnNtstZ2l/kNSg4xbWgwSLbPkTYVoIFIK6TKbp1jvGBqG3aFoHfx187PD
         luSmjq5jJNeueXWSVbyOKvj1WmwBbihj84HB0=
Received: by 10.223.105.75 with SMTP id s11mr4962661fao.4.1245139001170; Tue, 
	16 Jun 2009 00:56:41 -0700 (PDT)
In-Reply-To: <4A374C4E.2090304@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121665>

On Tue, Jun 16, 2009 at 09:39, Michael J Gruber<git@drmicha.warpmail.ne=
t> wrote:
> Bert Wesarg venit, vidit, dixit 15.06.2009 22:45:
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>
>> ---
>>
>> On Mon, Jun 15, 2009 at 09:49, Michael J Gruber<git@drmicha.warpmail=
=2Enet> wrote:
>>> Jim Meyering venit, vidit, dixit 14.06.2009 21:46:
>>>>
>>>> * builtin-remote.c (get_one_entry): Use xmalloc, not malloc.
>>>
>>> Learning something new with every patch... Sorry, Junio; thanks, Ji=
m!
>>>
>> One more reason to re-use existing string handling functions.
>
> Well, when we discussed this before v2 I asked for guidance about
> strbuf, esp. regarding the issue of allocating/freeing.
Well, I stopped reading after this question of yours: "But what do
strbufs bring us here?"

> From your patch
> I infer that "strbuf_detach" is what I was looking for. (And yes, it =
is
> in the api doc where I overlooked it.)
>
>> =C2=A0builtin-remote.c | =C2=A0 21 ++++++++++-----------
>> =C2=A01 files changed, 10 insertions(+), 11 deletions(-)
>>
>> diff --git a/builtin-remote.c b/builtin-remote.c
>> index 709f8a6..31adeaa 100644
>> --- a/builtin-remote.c
>> +++ b/builtin-remote.c
>
> For whatever reason, your patch does not apply (am) here on top of ne=
xt
> + Jim's patch. Given the context (xmallocs), it looks like it's again=
st
> something + Jim's patch. OTOH: 709f8a6 show's a get_one_entry with
> mallocs. Did you hand edit the diff?
Its on top of next (d6a466e528119011d512379f7f9dfac26deb7fd9), plus
hand editing s/malloc/xmalloc/g.
Sorry for this.

Bert

>
> Michael
>
