From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/4] dir.c: support marking some patterns already matched
Date: Tue, 16 Feb 2016 08:36:32 +0700
Message-ID: <CACsJy8AurhYgweE99uWs5rf7PsL9_8nuCo-DtQFO+gXCRPkPMA@mail.gmail.com>
References: <1455527019-7787-1-git-send-email-pclouds@gmail.com>
 <1455527019-7787-4-git-send-email-pclouds@gmail.com> <xmqqio1po7s9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 02:37:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVUZi-0003mZ-Gh
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 02:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbcBPBhF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 20:37:05 -0500
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34275 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbcBPBhD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2016 20:37:03 -0500
Received: by mail-lf0-f41.google.com with SMTP id j78so99080478lfb.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 17:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=YiosPWjUANc83b4rxNY8OuZnOmWkzKHtKXbYjzdjCzk=;
        b=hNtB2URp7go0Elt2LV2WYBTKfe3HXg5Oq/qsM0GPFRcnpwOoPbufAzL7F/I9ARczvd
         hw93+XEL+YCm9zCRFI9N6Tfflt1k6VWw16bkdGMOcJFDiE1TlDQiFM1R5eHjXTCgVlFy
         KRSTE2KDcxYwZETAInfRsQc7pDCstsqbTvGy5pySwmADYdnOytDzJYanXg8WNNAKK4Gz
         0IeVk5/9qLuO8xnH7YSMbWcopG60D9+LW4z+77k2O9eBuPviAJDOMjSwBLSPIfmlZIQO
         qfVvZRENhOgNpf3crsWVt7d5GpxZh1DutPLOaDMuCEUJRRzjCncRYn6YVeIY7qgDGfNL
         2Jrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=YiosPWjUANc83b4rxNY8OuZnOmWkzKHtKXbYjzdjCzk=;
        b=EdGPyNPq2emJRHeq0Wq0BHowFS0Q3nKqaU+zks+qr5NnyHsCI6rxMj5aN2SE6VX2+d
         3w5H/dhLEgVFvSyo7YhRx8WT60H9vknMZWrrNPxqyrMrRdpgBmkW7sWFCQ7YEfoVK1sg
         BamuaUG6BrQyElSTXHqwoL3rzoHzVIavA+gBuyWimk7wRwbRWEvEc+erEs/HUSJOlnnQ
         pnasUQ3jbJJ1f/sW1/HEQZLtI1G5uzrRq/X9XEKmMlj035yPDM0tUwFtZH/hm1Bsijwa
         Zv+CNg8CPXPKrAWjngsF9L4zsF70+YlRcfQRloPa6i2HgEHGuxJvsqG3BZg/WHSGWOLP
         53Cg==
X-Gm-Message-State: AG10YOTj39XY6XLCLCpgtjeKor/WE5etPqS0lQDyX4ucMCm178+HnbfhLaYG0dpqBhGMvahqKC8aPHjbMdk1Ew==
X-Received: by 10.25.19.198 with SMTP id 67mr2226463lft.162.1455586621810;
 Mon, 15 Feb 2016 17:37:01 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Mon, 15 Feb 2016 17:36:32 -0800 (PST)
In-Reply-To: <xmqqio1po7s9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286303>

On Tue, Feb 16, 2016 at 6:47 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Given path "a" and the pattern "a", it's matched. But if we throw pa=
th
>> "a/b" to pattern "a", the code fails to realize that if "a" matches
>> "a" then "a/b" should also be matched.
>>
>> When the pattern is matched the first time, we can mark it "sticky",=
 so
>> that all files and dirs inside the matched path also matches. This i=
s a
>> simpler solution than modify all match scenarios to fix that.
>
> I am not quite sure what this one tries to achieve.  Is this a
> performance thing, or is it a correctness thing?
>
> "This is a simpler solution than" is skimpy on the description of
> what the solution is.

As an example, let's look at pattern "a/". For this pattern to match,
"a" must be a directory. When we examine "a", we can stat() and see if
it is a directory. But when we descend inside, say "a/b", current code
is not prepared to deal with it and will try to stat("a/b") to see if
it's a directory instead of stat("a").

> When you see 'a' and path 'a/', you would throw it in the sticky
> list.  when you descend into 'a/' and see things under it,
> e.g. 'a/b', you would say "we have a match" because 'a' is sticky.
> Do you throw 'a/b' also into the sticky list so that you would catch
> 'a/b/c' later?

No because "a/" can still do the job. I know it's a bit hard to see
because add_sticky() is not used yet in this patch.

> Do you rely on the order of tree walking to cull
> entries from the sticky list that are no longer relevant?
> e.g. after you enumerate everything in 'a/b', you do not need 'a/b'
> anymore.

No explicit culling. But notice that these sticky lists are indirectly
contained in exclude_list. Suppose "a/b" is sticky because of
"a/.gitignore". As soon as we move out of "a", I would expect
prep_exclude() to remove the exclude_list of "a/.gitignore" and the
related sticky lists.

> Or do you notice that 'a/' matched at the top-level and stop
> bothering the sticky list when you descend into 'a/b' and others?
>
> How does this interact with negative patterns?

Negative or not is irrelevant. If "a" is matched negatively and we see
"a/b", we return the same response, "negative match".

> Thanks.  The data structure used in 3/4 smells iffy from performance
> point of view--have you tried it on a large trees with deep nesting?

No I haven't. Though I don't expect it to degrade performance much. We
basically add one new exclude rule when add_sticky() is called and pay
the price of pathname matching of that rule. If there are a lot of
sticky rules (especially ones at top directory), then performance can
go to hell. 4/4 should not add many of them though.
--=20
Duy
