From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 4/4] notes: teach git-notes about notes.<ref>.merge option
Date: Wed, 12 Aug 2015 14:57:01 -0700
Message-ID: <CA+P7+xrQnrQdE3OOhdc2-2__V3Huzc+HfGEXKBZULy2JkQR37Q@mail.gmail.com>
References: <1439326641-9447-1-git-send-email-jacob.e.keller@intel.com>
 <1439326641-9447-5-git-send-email-jacob.e.keller@intel.com>
 <CALKQrgeDuRkXm2LzDOuZDZLOBRXjLmmRvhtXfXScWfLKX+9t=g@mail.gmail.com>
 <xmqqy4hhmedb.fsf@gitster.dls.corp.google.com> <CALKQrgf2hdvNExVbvnP5sVUM4sEh7thj9HLw93LbYWSStNjeYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Aug 12 23:57:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPe1W-0003H9-Jx
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 23:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbbHLV5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 17:57:22 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35532 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbbHLV5V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 17:57:21 -0400
Received: by igbjg10 with SMTP id jg10so52234442igb.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 14:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HHclVzpFdWNpXy9UVYZRHKOypHj1wDZc8BdI97b94Cg=;
        b=DSmQzvubRB0yw5p2lWouq7esdhL8Tk/Uku/8HXUeJ6wN9mi6tNya++/scBDrbFvPl8
         UzN/MLON7hfu3574KRkHdDI8UvrBHaERcbG4ufjHm9KEAfSRcPxl3i2kJIR0Bxi+G/kc
         RRIY3RGR9loBskqznfe8HIgPZwjOOocqfvjKPWNP5lJdyAdnlb3FNgWw0qFbhKVbxaL0
         uDSJFxYwc94wUD46eoXyaz22FgOX+u403dJxJ+xJmVxb2t8SSQ3k1MGo/7bjltinSXTY
         t5EkqxQg2Ip8DZgBFRgX9bGkd0DP+xE3ciTwgOAAGDPjnkgSQ/sa5m054sVkuSzN8MZQ
         IMCQ==
X-Received: by 10.50.124.97 with SMTP id mh1mr27152024igb.92.1439416640848;
 Wed, 12 Aug 2015 14:57:20 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Wed, 12 Aug 2015 14:57:01 -0700 (PDT)
In-Reply-To: <CALKQrgf2hdvNExVbvnP5sVUM4sEh7thj9HLw93LbYWSStNjeYg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275815>

On Wed, Aug 12, 2015 at 2:46 PM, Johan Herland <johan@herland.net> wrote:
> If we don't already refuse to merge into a ref outside refs/notes, then
> I would consider that a bug to be fixed, and not some corner use case that
> we must preserve for all future.
>
> After all, we do already have a test in t3308 named 'fail to merge into
> various non-notes refs', where one of the non-notes ref being tested are:
>
>   test_must_fail git -c "core.notesRef=refs/heads/master" notes merge x
>

This test is checking if the ref pointed at by refs/heads/master *is*
a note. But you could create a ref outside of refs/notes which is a
note but which isn't inside refs/notes

I did just find that we expand remote-ref using expand_notes_ref, and
it does *not* currently let us reference refs outside of refs/notes..
so we can merge IN to a ref not inside refs/notes (using the
environment variable) but we can't merge FROM
refs/tracking/origin/notes/y for example, which means currently all
notes we merge from have to be located into refs/notes/*

There are some weird issues here.

Regards,
Jake
