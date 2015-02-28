From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Sat, 28 Feb 2015 07:07:17 +0700
Message-ID: <CACsJy8AqRPm8ked+u0k83R2sFCE+XCGDEzeT_d4QsrKOOXUwLw@mail.gmail.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
 <CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
 <CAPc5daVbrUaU6LFM65evru0+1tBT916+0AOyids=f7DZThTPGw@mail.gmail.com>
 <CAGZ79kbZHtZuPrb6rEP41vbdnZqJmsMwq+8pNer-_D4U5B1xZw@mail.gmail.com>
 <CACsJy8BN2imGCW0cueh-jGKfN_nRg3=J-GTX2P5h2z0Tu=id6A@mail.gmail.com>
 <xmqqsidtoojh.fsf@gitster.dls.corp.google.com> <CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
 <CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
 <xmqqzj80l9c7.fsf@gitster.dls.corp.google.com> <xmqqioenhs4p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 01:07:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRUwm-0006XE-Mp
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 01:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870AbbB1AHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 19:07:50 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33359 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808AbbB1AHs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 19:07:48 -0500
Received: by igbhl2 with SMTP id hl2so4291847igb.0
        for <git@vger.kernel.org>; Fri, 27 Feb 2015 16:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DdUgGFi+FFLi+lB0THyxMmbggR7Tf6lMg5U0DePq6Oo=;
        b=Mtfb1ed5b0u1D6gylkD+spNtg2oyt/4RlMBWDkwO//dyaG0tqguKF5LvH60Hst/JrR
         ediO1hOopNMn22R11dq6PsQO0yn/cbVHXVa4PPyvdIW2LBnXXteW87Deamkv9Jd4Mc8C
         vPki39l051Z2kzuFCybIYY0vzXKOMDzWPv7wPxq4j5I0EYHyvgGV0XOscgGsgg6m7faA
         oh+/9n+mwgubzP8TgORxoaMBAntMyE9o6mqtEQcceEE7NtVcuu38ko0S91TF3NSMgPE4
         D4MTc11XCkZtIkAdBh/qll8Gph9Sc7pmw0iF+aXrdyqEc8dOheiBJlkOmm4ghkufRc2r
         gJgQ==
X-Received: by 10.107.8.213 with SMTP id h82mr21377496ioi.89.1425082067739;
 Fri, 27 Feb 2015 16:07:47 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Fri, 27 Feb 2015 16:07:17 -0800 (PST)
In-Reply-To: <xmqqioenhs4p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264514>

On Sat, Feb 28, 2015 at 6:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Just for fun, I was trying to see if there is a hole in the current
> protocol that allows a new client to talk a valid v1 protocol
> exchange with existing, deployed servers without breaking, while
> letting it to know a new server that it is a new client and it does
> not want to get blasted by megabytes of ref advertisement.
> ...
> The idea is to find a request that can be sent as the first
> utterance by the client to an old server that is interpreted as a
> no-op and can be recognised by a new server as such a "no-op probe".
> ...
> And there _is_ a hole ;-).  The parsing of "shallow " object name is
> done in such a way that an object name that passes get_sha1_hex()
> that results in a NULL return from parse_object() is _ignored_.  So
> a new client can use "shallow 0{40}" as a no-op probe.
> ...
> I am _not_ proposing that we should go this route, at least not yet.
> I am merely pointing out that an in-place sidegrade from v1 to a
> protocol that avoids the megabyte-advertisement-at-the-beginning
> seems to be possible, as a food for thought.

There may be another hole, if we send "want <empty-tree>", it looks
like it will go through without causing errors. It's not exactly no-op
because an empty tree object will be bundled in result pack. But that
makes no difference in pratice. I didn't verify this though.

In the spirit of fun, I looked at how jgit handles this shallow line
(because this is more like an implementation hole than protocol hole).
I don't think jgit would ignore 0{40} the way C Git does. This SHA-1
will end up in shallowCommits set in upload-pack, then will be parsed
as a commit. But even if the parsing is through, a non-empty
shallowCommits set would disable pack bitmap. Fun is usually short..

PS. heh my "want empty-tree" hole is probably impl-specific too. Not
sure if jgit also keeps empty tree available even if it does not
exist.
-- 
Duy
