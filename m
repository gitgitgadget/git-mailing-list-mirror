From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 02/11] ref-filter: make `color` use `ref_formatting_state`
Date: Mon, 27 Jul 2015 22:53:06 +0530
Message-ID: <CAOLa=ZQABLyaKVXub_dzCZem=aK-pFr5odM4aXaKjnMN6Rk=kQ@mail.gmail.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
 <1437982035-6658-1-git-send-email-Karthik.188@gmail.com> <1437982035-6658-2-git-send-email-Karthik.188@gmail.com>
 <vpqa8uhaht3.fsf@anie.imag.fr> <xmqq4mkpk73h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 19:23:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJm7p-0008Fd-IR
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 19:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485AbbG0RXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 13:23:37 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:36004 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754477AbbG0RXg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 13:23:36 -0400
Received: by obnw1 with SMTP id w1so64532240obn.3
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 10:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ryMOWhHRXJZ0d+AkyAbIJNJ9kqaHVbWWqWq+W4QyVFo=;
        b=1KXF0bp2B9XrDalYJSRanCeRF7XVrZ8Eo7Ou3lfgGsWN3UPvCjHSbeeXMk21WxHGlp
         fpS8knpWCl6t+fkjxTcmU/6vx2Xa1zs7tjhLHOjgu0N/06EECWN+tsL3OkUgU/Y8IcpD
         237Bm2oUZ/aboG+3qU/NaDWxwa19Ncek7/6ySB89AKRalbKXkQ4QHycODHfOLd8AYtQG
         5f3/esH7SaDhHcuy2TQHQgGL81B9+yw0odtbudAJ0gBtNQrMuowUYJmylhMao9Big1Ji
         I9uClofeE4qxowkxFVDhmB+sj+ysk7f1liyOr7axKaOPFA68pB/6ojSpaZJnqEgDelTF
         2Ktg==
X-Received: by 10.60.62.105 with SMTP id x9mr28669558oer.1.1438017815494; Mon,
 27 Jul 2015 10:23:35 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 27 Jul 2015 10:23:06 -0700 (PDT)
In-Reply-To: <xmqq4mkpk73h.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274693>

On Mon, Jul 27, 2015 at 7:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> Make the `color` atom a pseudo atom and ensure that it uses
>>> `ref_formatting_state`.
>>
>> Actually, I think this is an incorrect change.
>>
>> Previously, %(color:...) was taking effect immediately, and after this
>> patch, it takes effect starting from the next atom.
>> ...
>> As a consequence of the remark above, I think the name and comment of
>> the field are misleading. There are 3 kinds of atoms:
>>
>> * Placeholders for ref attributes
>>
>> * Atoms that take action immediately, but that are not ref attributes
>>   like %(color)
>>
>> * Atoms that only act as modifiers for the next atom. Perhaps they could
>>   be called "prefix atoms" or "modifier atoms".
>
> My fault.
>
> I briefly thought that it may be simpler to treat %(color) just as a
> different way to express a literal that cannot be typed from the
> keyboard, but your "different kind of atom" is a much better way to
> think about it.

Yes even I agree with this.

>
> What is necessary is that, just like the updated "print_value()"
> knows about the formatting state, "emit()" needs to be told about
> the same formatting state.  Some of these "state affecting" atoms
> may take effect on what is output by "emit()" (e.g. "color" is
> obviously an example, the hypotethical one that counts the current
> output column and uses that knowledge to "align" the output to
> certain columns, instead of "right pad to make the next column
> 30-columns wide" one, which is in this series, is another).

This depends on whether these modifier atoms should effect only succeeding
atoms or any string. Since there is a conversation about this topic on the other
patch, let's continue this discussion there.

>
> Thanks for finding this, and Karthik, sorry for an incomplete
> suggestion based on a faulty thinking.

I don't see why you have to be sorry, you were trying to help :)

-- 
Regards,
Karthik Nayak
