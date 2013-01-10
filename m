From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH 06/19] reset.c: remove unnecessary variable 'i'
Date: Thu, 10 Jan 2013 00:41:49 -0800
Message-ID: <CANiSa6jJcYRUyswSktq86pWttxBjZedZcPheRgPCf+EubC_kLg@mail.gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
	<1357719376-16406-7-git-send-email-martinvonz@gmail.com>
	<7vpq1e5ent.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 09:42:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtDiE-000102-TF
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 09:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab3AJIlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 03:41:50 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:39281 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091Ab3AJIlt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 03:41:49 -0500
Received: by mail-ie0-f170.google.com with SMTP id k10so375038iea.15
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 00:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VQzWF141KAHb1HdJ3gIjxO87jiv/rydr2t08P34Y1hU=;
        b=e+vK3DP38CbOgDXtiLP5QoTTNjNDyjhxlSlqREOsHl6arikB945f4N62KAC1uTnN7z
         Espekb/faG0ORwFHR8tAZYaQHAQL4khKOVjXqMcrhaI+ByG+LicqIt8md1jngWGbm9dE
         ybZh4UYnVi5TLHvEy9/aoV6uT23GUpXLnqlyv1xEj2bvDmiiHDN7Yc1Y4EZketUVr26q
         9PJ3O/oW8kY3MeQgDWxlcdnZLobCdHCDFNSofXy8Mu3jNSQ26mhuBMaihhmYyzo7tAjg
         syKDH4pXBO9AYWZCJSR8ukzxy8PLGilOBd2gFxoUCkX2ZYHgUiPjcgx7VFtfBmBFrwRN
         KD5A==
Received: by 10.43.17.199 with SMTP id qd7mr49868192icb.52.1357807309337; Thu,
 10 Jan 2013 00:41:49 -0800 (PST)
Received: by 10.64.86.68 with HTTP; Thu, 10 Jan 2013 00:41:49 -0800 (PST)
In-Reply-To: <7vpq1e5ent.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213129>

On Wed, Jan 9, 2013 at 11:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>
>> Throughout most of parse_args(), the variable 'i' remains at 0. In the
>> remaining few cases, we can do pointer arithmentic on argv itself
>> instead.
>> ---
>> This is clearly mostly a matter of taste. The remainder of the series
>> does not depend on it in any way.
>
> I agree that it indeed is a matter of taste between
>
>  (1) look at av[i], check with (i < ac) for the end, and increment i to
>      iterate over the arguments; and
>
>  (2) look at av[0], check with (0 < ac) for the end, and increment
>      av and decrement ac at the same time to iterate over the
>      arguments.
>
> When (ac, av) appear as a pair, however, adjusting only av without
> adjusting ac is asking for future trouble.  It violates a common
> expectation that av[ac] points at the NULL at the end of the list.

Good points.

> If a code chooses to use !av[0] as the terminating condition and
> never looks at ac, then incrementing only av is fine, but in such a
> case, the function probably should lose ac altogether.

Makes sense. I've picked this style for now (i.e. dropped both 'i' and
'argc'). I was surprised by the style that referred to the variable in
many places where it was know to be 0, but I'm no experienced C
programmer, so if that's a common practice when it comes to argument
parsing, I'm also happy to drop the patch. Let me know what you
prefer.
