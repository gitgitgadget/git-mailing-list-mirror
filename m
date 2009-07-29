From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv3] git apply: option to ignore whitespace differences
Date: Wed, 29 Jul 2009 10:20:44 +0200
Message-ID: <cb7bb73a0907290120x72d0ae99p7cfdd2b88264a24a@mail.gmail.com>
References: <1248814820-25367-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<7vljm84htf.fsf@alter.siamese.dyndns.org> <cb7bb73a0907282333g26efd1d8y7d913fba8a426aa5@mail.gmail.com> 
	<7vab2oynhm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 10:22:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW4QK-0005S2-6p
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 10:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230AbZG2IVL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 04:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbZG2IVJ
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 04:21:09 -0400
Received: from mail-bw0-f221.google.com ([209.85.218.221]:35591 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbZG2IVF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 04:21:05 -0400
Received: by bwz21 with SMTP id 21so533331bwz.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 01:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=cvit+46yZ8lRSK7k3A0CfHwg5hgJpOawjA61tKTkBIs=;
        b=D+uVCLKq/B7ZZjJxcKd7OlqcgjZboDtME0j1IjLTXA7wqLQlXfEMBGxy0EvTTEkVJw
         /3GRKSggvaiFtLcRVyQD43Rn4HurlxKA4dtFrc40zxlqNOimuyO16tVq2nsnLlgAZ5IH
         RiK95WLbU9+G94UTv3KkYmkAqNe+kctpzP2ck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=mlJV/q70484k3Oe7TySdJl4v8El2FJcPF6j7wo+G2d2lVSoGniB7ul3P5O6Q7DepQt
         oCWFH6TMvQPzoQADxHFIZOdH+P8nrciCcr3wtOvFdFp0+bJwD3lXrmMQDCcMnkTMGJzL
         +B1jcigzUo+U94i0NMPhLTH7QqQmDgUCtzre8=
Received: by 10.204.102.133 with SMTP id g5mr5252470bko.180.1248855664198; 
	Wed, 29 Jul 2009 01:21:04 -0700 (PDT)
In-Reply-To: <7vab2oynhm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124320>

On Wed, Jul 29, 2009 at 9:09 AM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> Actually, one thing that I've been thinking about doing is to adjust
>> the new lines to match the kind of whitespace change the context lin=
e
>> underwent. Example: if all the context lines had the change 4 spaces
>> -> tab, it would be nice to have the new lines undergo the same
>> change. However, this is going to be rather hard to implement.
>
> Doing so will be actively wrong.
>
> In the case of "whitespace=3Dfix", it is justifiable to update ws bro=
ken
> context lines while applying a ws corrected patch to a ws broken targ=
et,
> and it also is justifiable not to update context lines while applying=
 a ws
> broken patch to a ws corrected target, because it is clear which one =
has
> the correct whitespace layout (i.e. output of ws_fix_copy() by defini=
tion
> is the correct outcome). =A0But in your example, it is not clear if t=
he
> layout using 4 spaces is correct or the one with a tab. =A0The tool s=
hould
> refrain from guessing in such a case.

I was thinking more about consistency than 'correctness'  in this
case, actually. Typical scenario would be: patch is created for a file
using a given whitespace convention (e.g. 4 spaces). File is updated
to match the rest of the project (tabs). Patch would now introduce the
wrong whitespace convention for the new lines.

Of course, whitespace can (and should) be fixed a posteriori, but when
doing a rebase this can get quite annoying. So some kind of automatic
way to do it would be nice. But I don't think I'd get around to such a
feature any time soon. (Also, the merge case has a higher priority.)

--=20
Giuseppe "Oblomov" Bilotta
