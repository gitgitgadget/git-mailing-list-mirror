From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] checkout: add --sparse for restoring files in sparse
 checkout mode
Date: Sun, 24 Mar 2013 18:57:17 -0700
Message-ID: <20130325015717.GA3542@elie.Belkin>
References: <514C3249.7000100@ivt.baug.ethz.ch>
 <1364101583-6035-1-git-send-email-pclouds@gmail.com>
 <20130324181752.GA4543@elie.Belkin>
 <CACsJy8ByH8U0wYuaKaMKd3bauLBbS52peMs1eiGz++2vj2JKTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kirill.mueller@ivt.baug.ethz.ch
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 02:58:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJwfj-0007gD-Ub
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 02:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755118Ab3CYB51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 21:57:27 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:41123 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754714Ab3CYB50 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 21:57:26 -0400
Received: by mail-pd0-f179.google.com with SMTP id x10so2274023pdj.24
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 18:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=n5UCg/QRCRXvoPugCWgeH68GIP7o7kJ0Y9ZLZMMQqHU=;
        b=GiLW+/MzEIBdQmgWSx3SZQY2Nr11z3fMLggSiUP/IlzPkefQr/g9pqPGm0CGp07Lie
         SO4ISP0STZa7ytwm0gDbCQiX6unGnAwLngDbGrdbuoeww6OHhAoL92NTZihen4TADa++
         jjEE8vWbDEFDh2x2e00SMzS13u87Gad1dMifdAU+AAAxPYwCK5LmPEigWKZvcEryKe63
         Y1ym3SzuwfanNeqa0oUkktE0mTw90daAD/IIAXYjIzVMWsOMTcrFhGod0dR+V7KUA/qR
         Wbb6kjWi4Cd0FIEI+PPbbQaE+oe/1NZ5t8ZO+vx0xrFbY1K3kWM5X+ewgBscK/HxuuuB
         mg+g==
X-Received: by 10.68.224.169 with SMTP id rd9mr14626125pbc.199.1364176645735;
        Sun, 24 Mar 2013 18:57:25 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id y1sm11380968pbg.10.2013.03.24.18.57.23
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Mar 2013 18:57:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8ByH8U0wYuaKaMKd3bauLBbS52peMs1eiGz++2vj2JKTA@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219004>

Duy Nguyen wrote:
> On Mon, Mar 25, 2013 at 1:17 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Hm, should this be the default?
>>
>> In principle, I would expect
>>
>>         git checkout -- .
>>
>> to make the worktree match the index, respecting the sparse checkout.
>> And something like
>>
>>         git checkout --widen -- .
>>
>> to change the sparse checkout pattern.
[...]
> Changing the default may involve a painful transition phase (e.g. "add
> -u").

I don't think it needs to.  There aren't many people using sparse
checkout even these days, and I think they'd generally be happy about
the change.

But if we want to be conservative until some later point (like 2.1),
perhaps --sparse should be named something like --no-widen?  That
way, I can do

	git checkout --no-widen -- .

to make the worktree match the index, respecting the sparse checkout.
And I can do

	git checkout --widen -- .

to change the sparse checkout pattern.  Meanwhile the confusing
command

	git checkout -- .

would be ill-defined for sparse checkouts --- in past git versions,
if I understand you correctly it acted like --widen, while in some
unspecified future version it may change to mean --no-widen.  No
need for warnings because I doubt anyone is relying on either
behavior.

Would that work?
Jonathan
