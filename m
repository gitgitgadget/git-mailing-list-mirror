From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] remote: support --all for the prune-subcommand
Date: Tue, 4 Oct 2011 09:40:22 +0200
Message-ID: <CABPQNSb7NYTac5uWSegK9rmYz1n0yt1GJWHKUtLg1k_OYHdDNg@mail.gmail.com>
References: <1317644168-5808-1-git-send-email-kusmabite@gmail.com>
 <20111004070006.GA6824@sigill.intra.peff.net> <CABPQNSZrfxhyA3em8TN2=d7pAHopZMgRg47baKnDT9h14=rxkA@mail.gmail.com>
 <20111004071332.GA7308@sigill.intra.peff.net> <CABPQNSZ-ELfFuxmKMqXCQaAgMZMRsZG3S5wWJLsjkYVvK6aGug@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 04 09:41:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAzcj-0004sS-BZ
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 09:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755018Ab1JDHlE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Oct 2011 03:41:04 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45015 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754945Ab1JDHlC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 03:41:02 -0400
Received: by yxl31 with SMTP id 31so193533yxl.19
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 00:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=O73u1QjOfNZDd0EWJkdzmG0dz2cbG12a1UnmD/lJp3g=;
        b=AaIC98x3gqa4nQs6p27Wy4RO4qDaOQifRcXX0vRJihAqZIqB1+LHWqwhkOpPNVknc8
         7OB38zB4srkruRSsTpJm2cIIsoCKyemWwCUVir3N9zIdV5uWEkMnOhAiCkZ8FdDGgSZz
         puNWH6Xl1KzRkccXT98iNzixdiXLzHGrglBrM=
Received: by 10.68.21.103 with SMTP id u7mr2678160pbe.129.1317714062082; Tue,
 04 Oct 2011 00:41:02 -0700 (PDT)
Received: by 10.68.42.169 with HTTP; Tue, 4 Oct 2011 00:40:22 -0700 (PDT)
In-Reply-To: <CABPQNSZ-ELfFuxmKMqXCQaAgMZMRsZG3S5wWJLsjkYVvK6aGug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182738>

On Tue, Oct 4, 2011 at 9:18 AM, Erik Faye-Lund <kusmabite@gmail.com> wr=
ote:
> On Tue, Oct 4, 2011 at 9:13 AM, Jeff King <peff@peff.net> wrote:
>> On Tue, Oct 04, 2011 at 09:10:40AM +0200, Erik Faye-Lund wrote:
>>
>>> > =A0git fetch --all --prune
>>> >
>>> I wasn't aware that fetch could prune, but yeah, that seems much
>>> better to me. Perhaps a mention of this in the "git remote prune"
>>> documentation could steer other users in the right direction?
>>
>> Yeah, that makes sense.
>>
>> There is one slight difference: I think "git remote prune" will _jus=
t_
>> prune, and not fetch into existing refs at all. I'm not sure exactly
>> why you would want that, though.
>
> Hmm, you might want to do that on, say, a mobile network to save
> bandwidth; i.e throw away the stale branches, but not yet update the
> non-stale ones because downloading the objects might take a long time
> (and/or be expensive).
>
> So with that in mind, I actually think my patch makes sense in some
> cases, but it certainly is less useful that I originally though ;)

Strike that part; I hadn't had my morning coffee yet. It might make
sense to have similar _functionality_, but having this as a flag to
"git fetch" instead of "git remote prune" strikes me as the only sane
approach.

In fact, I'm not sure I understand why we simply do not always prune
by default. My guess would be backward compatibility, but this strikes
me as one of these things where we should introduce a config variable
(there's already one for git-gui: gui.pruneduringfetch), add a warning
if unset, and flip the default at some future major release. After
all, a remote branch isn't the user's branch - it's a cache/mirror
some other user's branch. If a user wants to keep another user's
branch, surely the most sane thing would be to make a local branch of
it?
