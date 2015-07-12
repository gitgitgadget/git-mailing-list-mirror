From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 01/10] ref-filter: add %(refname:shortalign=X) option
Date: Sun, 12 Jul 2015 08:47:39 +0700
Message-ID: <CACsJy8BsLnkPFX04WujMdnBiRGmXacF1QSQudb3T8nxGrZ_1Fg@mail.gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com> <xmqqk2u8kmre.fsf@gitster.dls.corp.google.com>
 <CAOLa=ZTNGV=NAXDPB3HX=fanPMQaQQc4ZpFdDFeg+LJ8SFuVOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 03:48:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZE6NL-00014J-2l
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 03:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbbGLBsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 21:48:10 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35780 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbbGLBsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 21:48:09 -0400
Received: by igcqs7 with SMTP id qs7so36137382igc.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 18:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fFJnvde4awl4gKamsjk39VvGbs5as0YOUU+OWxvQwt0=;
        b=Qb+5CsjJcrKdBzcoLNk1rGEduAx5rBYdECvF6BlrsGtSLmEA1cJ+JcqIaV6c7Gkvqc
         X98PBHvexcY5j8X3VvuJsTTKhpMDYMnmdzzZsPhKGVvpYnkoOSBo2/BG7Xht/QZw48og
         p2/1RWJTXrHQu4I0aLwHp3heDNfagNmOlUNBYw71/oN+Ccp7PZXSaFYu5o/yANxOGRla
         NtLQyp7JNRMRi+LuTPw6z/hOXqhMYnyo/OovV1IAZb3RaonnQzr3gSJ8J1AdRAdPFwGX
         LxzvvFQzO81snHBjeuVu/zJb40uBk2J38qHfL+hePQtibfXtj2La5lA6VFRL7TPlXuyE
         GhMw==
X-Received: by 10.107.168.99 with SMTP id r96mr10864116ioe.141.1436665688490;
 Sat, 11 Jul 2015 18:48:08 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Sat, 11 Jul 2015 18:47:39 -0700 (PDT)
In-Reply-To: <CAOLa=ZTNGV=NAXDPB3HX=fanPMQaQQc4ZpFdDFeg+LJ8SFuVOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273880>

On Sat, Jul 11, 2015 at 7:05 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Fri, Jul 10, 2015 at 9:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> This may be enough to support the various existing formats that are
>> offered by "git branch" and/or "git tag", but I do not think if this
>> is the right approach in the longer term, or if we are painting
>> ourselves in a corner we cannot cleanly get out of later [*1*].
>> Will the "refname" stay to be the only thing that may want alignment
>> padding appended in the future?  Will it stay true that we want to
>> align only to the left?  Etc., etc.
>>
>> Cc'ed Duy as %< in the pretty-format was his invention at around
>> a5752342 (pretty: support padding placeholders, %< %> and %><,
>> 2013-04-19).
>>
>
> I kinda had the same though, my only justification was that it was only being
> internally used. I'll have another look if as to see if I can make it
> universal somehow.
> Let's see what Duy has to suggest.

I guess if you can have multiple arguments after ':' in an atom, then
you have wiggle room for future. But it looks like you only accept one
argument after ':'.. (I only checked the version on 'pu'). Having an
"alignment atom" to augment the real one (like %< changes the behavior
of the next placeholder), could also work, but it adds dependency
between atoms, something I don't think ref-filter.c is ready for.

Another thing, the atom value is also used for sorting. When used for
sorting, I think these padding spaces should not be generated or it
may confuse the sort algorithm. Left alignment may be ok, right or
center alignment (in future?), not  so much. Perhaps we should do the
padding in a separate phase, outside populate_value(). If you go this
route, having separate atoms for alignment works better: you don't
have to parse them in populate_value() which is for actual values, and
you can handle dependency easily (I think).

By the way, please consider adding _() back to translatable strings,
usually those die() or warn(), or "[ahead %s]"... In the last case,
because you don't really know how long the string is after
translation, avoid hard coding buffer size (to 40).
-- 
Duy
