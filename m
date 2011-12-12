From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [RFC/PATCH] add update to branch support for "floating submodules"
Date: Mon, 12 Dec 2011 17:56:52 -0500
Message-ID: <CABURp0rFOGQ9kAbAn65W3UAHTWbk5prH7spjJnFvL5fqzbFp1w@mail.gmail.com>
References: <20111109174027.GA28825@book.fritz.box> <7vr51htbsy.fsf@alter.siamese.dyndns.org>
 <20111129220854.GB2812@sandbox-rc.fritz.box> <loom.20111210T062013-538@post.gmane.org>
 <7vborhaqgw.fsf@alter.siamese.dyndns.org> <CALFF=ZQKRgx_AodBQH17T9cSe_JFtoKie7DoMMfkTXCyCFospw@mail.gmail.com>
 <4EE61EED.50604@ursus.ath.cx> <CALFF=ZRYB1LkAY5WSC4Eydu-N0KNnWLLM2CfbSXZji18yO82gw@mail.gmail.com>
 <4EE64B04.8080405@ursus.ath.cx> <CALFF=ZRB7qjj7VMhzr12ySdHmZsySoqceu5brFht8rX1+W3NPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Leif Gruenwoldt <leifer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 23:57:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaEoB-0001kP-3X
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 23:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510Ab1LLW5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 17:57:14 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41785 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334Ab1LLW5N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 17:57:13 -0500
Received: by mail-ww0-f44.google.com with SMTP id dr13so12249383wgb.1
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 14:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MpR75dC87TZ1Fv0mMN4Fow4u/g5YyRr33Z7+4N5wzqE=;
        b=ovyJTsKP96TJtBXSBxe4xLjGrHExvhGaQ/CHg+izVubem0fyP1AYY8Tc7+IRE5333G
         4OYsZ53leJFBOyPLgRtJpNFGhm4AqCIFtSzmtT7ajlWXRQID9mrG5PHAna43AZqVISLB
         iNSSFTKSxsZrFy5l67v/GBFoaeBH+qE4og/qA=
Received: by 10.227.203.131 with SMTP id fi3mr18464607wbb.17.1323730633287;
 Mon, 12 Dec 2011 14:57:13 -0800 (PST)
Received: by 10.216.120.199 with HTTP; Mon, 12 Dec 2011 14:56:52 -0800 (PST)
In-Reply-To: <CALFF=ZRB7qjj7VMhzr12ySdHmZsySoqceu5brFht8rX1+W3NPg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186970>

On Mon, Dec 12, 2011 at 2:13 PM, Leif Gruenwoldt <leifer@gmail.com> wrote:
> On Mon, Dec 12, 2011 at 1:42 PM, Andreas T.Auer
> <andreas.t.auer_gtml_37453@ursus.ath.cx> wrote:
>
>> The next question is: Wouldn't you like to have the new stable branch only
>> pulled in, when the projectX (as the superproject) is currently on that new
>> development branch (maybe master)?
>>
>> But if you checkout that fixed released version 1.2.9.8, wouldn't it be
>> better that in that case the gitlinked version of the submodule is checked
>> out instead of some unrelated new version? I mean, when the gitlinks are
>> tracked with the projectX commits, this should work well.
>>
>> And what about a maintenance branch, which is not a fixed version but a
>> quite stable branch which should only have bugfixes. Shouldn't the auto-pull
>> be disabled in that case, too?
>>
>> I think the "auto-pull" behavior should depend on the currently checked out
>> branch. So the configuration options should allow the definition of one or
>> more mappings.
>
> Yes. I think you nailed it. The floating behaviour would best be
> configured per branch.

Yes, I think you nailed it too.  I've been thinking the same thing for
a while now, but I didn't know how to express it completely.  Some of
the discussion on here last week gelled the last bits in my mind.

To wit, I think I would want something like this in my project:

Use gitlinks when the superproject HEAD is one of these:
    refs/heads/maint/*
    refs/heads/svn/*     (historic branches)
    refs/tags/*
    <SHA1> (detached)

Float on the rest, using the branch given in .gitmodules (which may be
* to mean "use the same branch as the superproject".)

But maybe it is foolish of me to keep branches where I really want
lightweight tags.  If so, I could get away with this:

   Float if .git/HEAD begins with "refs/heads"
   Else, use the SHA1.


> An aside. Would this mean a "git pull" on the product repo would
> automatically do a pull (git submodule update) on the submodule too?

Good question.

I want to say "eventually, but not yet."  But someone else may
disagree.  "git pull --recurse-submodules=yes" does not do this yet.
A separate git-submodule-update is still required.  But I think this
is a separate issue from floating submodules.

Phil
