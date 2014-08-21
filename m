From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v20 43/48] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Thu, 21 Aug 2014 12:42:45 -0700
Message-ID: <CAL=YDWmHigoTYR4ENxozVwczXqY16DWi3_b7VwacX6-iPCeyhg@mail.gmail.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<1403275409-28173-44-git-send-email-sahlberg@google.com>
	<53BC07FC.8080601@alum.mit.edu>
	<20140715180424.GJ12427@google.com>
	<CAL=YDWkYAg-0h3ZwiyZGtUHFEv1KEti_uURTwgbZE9xT_P_XSQ@mail.gmail.com>
	<CAL=YDWmc2gkw=8YavWHyLUAD4du7saPrKzPKT+dsCfdZJz1EiA@mail.gmail.com>
	<53F4B642.7020002@alum.mit.edu>
	<CAL=YDW=zmqwjLzjWYLGCjwb_aQTofTJ-CrmPgoq3KKJjfHR3XQ@mail.gmail.com>
	<53F4EA43.4020802@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 21 21:42:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKYG3-0002bp-Lk
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 21:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbaHUTms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 15:42:48 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:54904 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbaHUTmq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 15:42:46 -0400
Received: by mail-vc0-f171.google.com with SMTP id hq11so11335254vcb.16
        for <git@vger.kernel.org>; Thu, 21 Aug 2014 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Aw8PdVzZrX06f0Wvce+r1+C+IvKKWtgCS1SvF4yCdCY=;
        b=hYEL+PMyNZueRer4dWZIDNQ4HMRziK1sfQ5kp9wHzCxxyRxGRXx3z489eyL3LRQOH8
         H80daiw0T1eVe5PwpTFlQtt5aXCAMgz2xNDAzUWqnlj3ILVqKzTgOVWd5EslE/oQzLE1
         meFg4GMUbe3SIuItpspeXYUsyjVQUYIBqXkf7xUXGYXFCYwudz4ysEVIfnUdI5zK/Oae
         02+qHlCOY3noSzZMSRX8/DEdMZzo/XbJdEXC0ow/UHp1BsnG5wsm7RRTM5VPQ1K9OCqH
         x2PZdYYgrwpGqyD9EE9dCwzhJkHoVvrxbVCMYkeK6TxsgtHOrb69djRJHV7ghzGJDu4x
         wOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Aw8PdVzZrX06f0Wvce+r1+C+IvKKWtgCS1SvF4yCdCY=;
        b=PxpoDRyRW063T+U47RZypFEZk0vXo0teOVECx4WmRJ0pkLXG+73GWgYKBpOqdkhnWm
         LyhF7wKiLymAT4HBJa7JsJKuNtgoVejmFlmH6tpJxtskotVxW948a3fT5tORuZci8W7a
         0Ro/Nniut+xDhYi4J6/qFHe1sfxJrWFlHTxC//dPl13DDidLW8ohZpq/QEeHPc25jdVC
         uEY9TaeSCcpKTrtlJKGoOYYuRkooktksURp81Qqc+VQqJqiLlswsB/CCpmd3mHe5i/kD
         0Els91hKhJdIuuxUBGanI3TK9rJx1NvEsgxwf3EuvOJjlgqidlEjH8Syypob4aEAx/3f
         XABQ==
X-Gm-Message-State: ALoCoQlvXe2d7/BaMufu0c+Xer3yNw29EUnCsfHOub/WmOEpgEkK/Y9Tv0luzdTee9UO2LvQF9Nw
X-Received: by 10.220.97.5 with SMTP id j5mr546306vcn.16.1408650166110; Thu,
 21 Aug 2014 12:42:46 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Thu, 21 Aug 2014 12:42:45 -0700 (PDT)
In-Reply-To: <53F4EA43.4020802@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255635>

On Wed, Aug 20, 2014 at 11:34 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 08/20/2014 06:28 PM, Ronnie Sahlberg wrote:
>> On Wed, Aug 20, 2014 at 7:52 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> I'm a little worried that abandoning *all* refname checks could open us
>>> up to somehow trying to delete a "reference" with a name like
>>> "../../../../etc/passwd".  Either such names have to be prohibited
>>> somehow, or we have to be very sure that they can only come from trusted
>>> sources.
>>
>> I only set this flag from builtin/branch.c so it should only be used
>> when a user runs 'git branch -D' from the command line.
>> All other places where we delete branches we should still be checking
>> the rename for badness.
>>
>> That said, unless the "rules for good refname" changes in the future,
>> which is unlikely, is should be exceptionally rare that a user ends up
>> with a bad refname in the first place.
>> Perhaps my example I gave was bad since if you manually create bad
>> refs using echo > .git/refs/heads/...  then you should probably know
>> how to fix it too and thus maybe we do not need this patch in the
>> first place.
>>
>> Do you want me to delete this patch and resend this part of the series
>> ? Or is the 'only works for branch -D from the commandline' sufficient
>> ?
>> I have no strong feelings either way so I will just follow what you decide.
>
> I think that if you run the refname through normalize_path_copy_len()
> and that function returns (1) without an error, (2) without modifying
> its argument, and (3) the result does not begin with a
> has_dos_drive_prefix() or is_dir_sep(), then we should be safe against
> directory traversal attacks.  I suggest doing this kind of check even if
> not doing the full check_refname_format() check.

Good idea.
Let me add this.


>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
>
