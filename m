From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Makefile: promote wildmatch to be the default fnmatch implementation
Date: Thu, 30 May 2013 18:37:08 +0700
Message-ID: <CACsJy8Cz5z6adg1ZUP2Lf+WL1VdNdhLot+JhONUMwQaSHCeEyA@mail.gmail.com>
References: <1369877684-5050-1-git-send-email-pclouds@gmail.com> <7vvc61p5jw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 30 13:37:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui1Au-0000bc-4I
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 13:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958Ab3E3Lhk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 07:37:40 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:65102 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab3E3Lhj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 07:37:39 -0400
Received: by mail-ob0-f170.google.com with SMTP id ef5so279246obb.29
        for <git@vger.kernel.org>; Thu, 30 May 2013 04:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=qdpLvMzLl+G3N9vHREMpojOaPka1sB7/EIRP+URhEjs=;
        b=F3zh4mlgW4fS3JXDP1wYTv7LI4Bm1XayUA40x0OX3S1St8TxCLEovBa0sysA+4kTou
         l9b0DBSjZefBQ9dlnzJ6tu0vIBa8VBQ3H5rCC9YcWejK2/c6nkifGfJgBOkk+GonrmCO
         EfV1IWUX8deehkWGiQF/S0yLxB7pYytsXBa47mFFeqLujKlv47pDfQuYsgR4TmOCkHah
         UV4GGLv21qNK6Em6g0Lu9+CwN+nzbgu/vexU52iAPpQiv5F8AmQhvrG7R3izpLRRyh6i
         I5eKiY0j6qj6gz7eAH4JYA4BybvBnxd+KH+d7/uuLQjnzi7Aw8TcV6IBlGLM1pDKWp+w
         rLug==
X-Received: by 10.60.59.37 with SMTP id w5mr3916009oeq.7.1369913858637; Thu,
 30 May 2013 04:37:38 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Thu, 30 May 2013 04:37:08 -0700 (PDT)
In-Reply-To: <7vvc61p5jw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225966>

On Thu, May 30, 2013 at 9:25 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> This makes git use wildmatch by default for all fnmatch() calls. Use=
rs
>> who want to use system fnmatch (or compat fnmatch) need to set
>> NO_WILDMATCH flag.
>>
>> wildmatch is a drop-in fnmatch replacement with more features. Using
>> wildmatch gives us a consistent behavior across platforms.
>
> While I agree this is a good move in the longer term in that we get
> the often-asked-for "foo/**/*.c" match and also we have one less
> platform differences to worry about, I somehow have a recollection
> that we discussed that there are incompatibilities in dark corners
> we would want to warn users about and lay a transition plan across
> some major version bump.

I've skimmed through all wildmatch related mails in my gmail archive.
There are differences between fnmatch versions, e.g. [1], but I don't
think anyone would run into those cases on purpose. There were
performance concerns [2] and they should have been addressed with
nd/retire-fnmatch series. Originally I was worried that this new code
might not be mature enough, but I've been running wildmatch-only git
for quite some time, can't really complain.

Not really a transition plan, but maybe we could provide a runtime
switch to return to system fnmatch when wildmatch becomes default, for
a few cycles. This way if wildmatch turns out broken, people can
switch back while we work on a fix.

> Hmph, could you (no need to hurry, though) check the previous
> discussion and point at what we decided if we did reach any
> conclusion to refresh our collective memory?

We all seemed to agree that the replacement would be a way to go. But
not hard decision was reached.

[1] http://thread.gmane.org/gmane.comp.version-control.git/207385/focus=
=3D207540
[2] http://thread.gmane.org/gmane.comp.version-control.git/211823/focus=
=3D211836
--
Duy
