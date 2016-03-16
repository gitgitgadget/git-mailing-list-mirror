From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can't git stash after using git add -N
Date: Wed, 16 Mar 2016 14:11:19 -0700
Message-ID: <CAPc5daVnQ94jc8pP=-FUgRA7oS=vXNGG=5Z23NWuZZScnhkQ9g@mail.gmail.com>
References: <20160315230754.GA12058@cloud> <xmqq8u1j7193.fsf@gitster.mtv.corp.google.com>
 <20160316020000.GB12130@cloud> <xmqqvb4n58ko.fsf@gitster.mtv.corp.google.com>
 <20160316120245.GA15091@cloud> <20160316210535.GA2200@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Josh Triplett <josh@joshtriplett.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 22:11:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agIjJ-0003x3-7O
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 22:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636AbcCPVLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 17:11:40 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:34449 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbcCPVLj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 17:11:39 -0400
Received: by mail-yw0-f176.google.com with SMTP id h129so77637246ywb.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 14:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5EvhOfvZVBNHtczqgq6SH+IAmcmwLm/vR+Rf79VajRo=;
        b=oWohL12+BvQcjft3teOsnzEOTXUUtEYoRHs4f3JQCGA5mmIWKn9RQ7qF1hoso+P94o
         tJOnAVZuXCN+EzcUu0PTl3B1IEjYD3aPbEYa2A2jCAcMd0HDeafWgbBbjOwN8YvdvzLk
         TRmD1pRiAyaAw8WaVwonuvesvtf/gIlU/Lx2wNmk3IofBuuBtb2Gu+Ya+Nje5jfRKnyV
         svLXMtjtX0tQRvEWhfxXV2tyaHfK/DUgtpn8PrirJu/T9q4PH3OX+dimuZVk2sUNbEn7
         Mmdpmd8+R6b4ekVhHijbHPBwZJ647GYWhpfh65ikVVvCj5RsjEbPQdGWL9VZU479gmGN
         6vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=5EvhOfvZVBNHtczqgq6SH+IAmcmwLm/vR+Rf79VajRo=;
        b=cIgCyoIH0LXe2hrxN6rsH7k0rEtVZ/nqzM+0Lm5jZHvcKEzAub2R4Lbo9RQ9ZzakuI
         giBHNVxTA73i9JFWvBp2JzKVlcxFnLqdbrg3zz/bRWi2o6iXs2jTOrX8+JASqnwSCNa9
         vlnozeiGEeZkWNPhYsbjlCdL47sFFbgtmh+ttEoO50O7ib/GlNPC0M6tk0d9HYEMfc5o
         4cPb0J8p4FQOksy+u5Qm5m7F9XNMU1wZCvxk/UvQSOpDCNB3p9Jm4slkFpHn5Yfut7zQ
         cy08oanfT8QdXoBZEpRHvD8JEfHPjy/W2jTkHoY3PJOw4v9ljpn+Ugvq0Jt17d3t+/Th
         Dn1A==
X-Gm-Message-State: AD7BkJIhODmsTvJLE9h6AYTKyyQ24Cj+GfbJHPuZdi4BzgE9NcEDDg/pimaHgfLDajmtgNsO/gbHS/hGOLBECA==
X-Received: by 10.129.130.132 with SMTP id s126mr2694780ywf.131.1458162698963;
 Wed, 16 Mar 2016 14:11:38 -0700 (PDT)
Received: by 10.129.116.131 with HTTP; Wed, 16 Mar 2016 14:11:19 -0700 (PDT)
In-Reply-To: <20160316210535.GA2200@sigill.intra.peff.net>
X-Google-Sender-Auth: xBisyKwPU26XU7ujhQ7O0JxeCw0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289037>

I actually think "silently ignore intent-to-add" was a mistake.
We used to error out at write-tree time, which I think is the
right behaviour--"I know I want to have this path, but I cannot
yet decide with what content" is what the user is telling us when
she says "add -N", so until that indecision is resolved, we
shouldn't write out a tree object out of the index.

On Wed, Mar 16, 2016 at 2:05 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 16, 2016 at 05:02:45AM -0700, Josh Triplett wrote:
>
>> On Tue, Mar 15, 2016 at 09:51:35PM -0700, Junio C Hamano wrote:
>> > Josh Triplett <josh@joshtriplett.org> writes:
>> >
>> > > As far as I can tell, if I run "git add -N" on a file, and then commit
>> > > without adding the file contents, it gets committed as an empty file.
>> >
>> > Is that true?  Git once worked like that in earlier days, but I
>> > think write-tree (hence commit) would simply ignore intent-to-add
>> > entries from its resulting tree.
>>
>> Git 2.7.0 does appear to commit an empty file if I commit after git add
>> -N.
>
> I don't think this is the case:
>
>   git init
>   echo content >file
>   git add -N file
>   git commit -m "empty?"
>
>   git ls-tree HEAD
>   git status
>
> shows that we committed an empty tree. So I see two obvious
> possibilities for improvement:
>
>   1. This commit should have failed without --allow-if-empty. We need to
>      be more careful about intent-to-add entries when figuring out if
>      the commit would be empty or not
>
>   2. I'm not sure if "silently ignore intent-to-add" is the best policy.
>      At least a warning ("hey, what did you want to do with these
>      entries") seems merited, if not aborting the commit entirely. I
>      hesitate on the latter only because perhaps that would mess up
>      somebody's legitimate workflow.
>
> -Peff
