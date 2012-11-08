From: Uri Moszkowicz <uri@4refs.com>
Subject: Re: Long clone time after "done."
Date: Thu, 8 Nov 2012 16:16:59 -0600
Message-ID: <CAMJd5ATX5Ru9Orp2t3p39q7tsNRfGjqDYGnf4-9QYNSTpQ-YuA@mail.gmail.com>
References: <CAMJd5AQBbnFqT5xrFuPOEsJevwDE=jUgBVFZ5KqTZk5zv5+NOw@mail.gmail.com>
 <CAMJd5ASL1UPfzUmfXqACuYuGhXQjJLqbsjq7dfpRpF4K-hZFtA@mail.gmail.com>
 <20121108155607.GD15560@sigill.intra.peff.net> <CAMJd5AQ24u11BH6rMAHvR95N4ys6KHfEQKD1uLzr+=TDgN_69Q@mail.gmail.com>
 <20121108203332.GQ15560@sigill.intra.peff.net> <CAMJd5ARLCk_WQTbyLciv0LnrMa_J0YstNsrq-hLYM5DXiO0hLA@mail.gmail.com>
 <20121108221128.GA11186@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 08 23:17:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWaPm-0004F6-CL
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 23:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756696Ab2KHWRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 17:17:21 -0500
Received: from mx71.nozonenet.com ([204.14.89.24]:40808 "EHLO
	mail3.nozonenet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756662Ab2KHWRU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 17:17:20 -0500
Received: (qmail 27193 invoked by uid 399); 8 Nov 2012 17:17:19 -0500
Received: from mail-ie0-f174.google.com (smtp@4refs.com@209.85.223.174)
  (de-)crypted with TLSv1: RC4-SHA [128/128] DN=unknown
  by mail3.nozonenet.com with ESMTPSAM; 8 Nov 2012 17:17:19 -0500
X-Originating-IP: 209.85.223.174
X-Sender: smtp@4refs.com
Received: by mail-ie0-f174.google.com with SMTP id k13so5033818iea.19
        for <git@vger.kernel.org>; Thu, 08 Nov 2012 14:17:19 -0800 (PST)
Received: by 10.50.37.133 with SMTP id y5mr9594365igj.8.1352413039362; Thu, 08
 Nov 2012 14:17:19 -0800 (PST)
Received: by 10.64.28.231 with HTTP; Thu, 8 Nov 2012 14:16:59 -0800 (PST)
In-Reply-To: <20121108221128.GA11186@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209194>

I ran "git cat-file commit some-tag" for every tag. They seem to be
roughly uniformly distributed between 0s and 2s and about 2/3 of the
time seems to be system. My disk is mounted over NFS so I tried on the
local disk and it didn't make a difference.

I have only one 1.97GB pack. I ran "git gc --aggressive" before.

On Thu, Nov 8, 2012 at 4:11 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Nov 08, 2012 at 03:49:32PM -0600, Uri Moszkowicz wrote:
>
>> I'm using RHEL4. Looks like perf is only available with RHEL6.
>
> Yeah, RHEL4 is pretty ancient; I think it predates the invention of
> "perf".
>
>> heads: 308
>> tags: 9614
>>
>> Looking up the tags that way took a very long time by the way. "git
>> tag | wc -l" was much quicker. I've already pruned a lot of tags to
>> get to this number as well. The original repository had ~37k tags
>> since we used to tag every commit with CVS.
>
> Hmm. I think for-each-ref will actually open the tag objects, but "git
> tag" will not. That would imply that reading the refs is fast, but
> opening objects is slow. I wonder why.
>
> How many packs do you have in .git/objects/pack of the repository?
>
>> All my tags are packed so cat-file doesn't work:
>> fatal: git cat-file refs/tags/some-tag: bad file
>
> The packing shouldn't matter. The point of the command is to look up the
> refs/tags/some-tag ref (in packed-refs or in the filesystem), and then
> open and write the pointed-to object to stdout. If that is not working,
> then there is something seriously wrong going on.
>
> -Peff
