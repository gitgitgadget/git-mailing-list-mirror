From: David Aguilar <davvid@gmail.com>
Subject: Re: Fixing the p4merge launch shell script
Date: Wed, 3 Oct 2012 23:59:03 -0700
Message-ID: <CAJDDKr6qqo+a545bx=ygDmzLFAT5yU=ue+Fv0QpZeBGXuOeG6A@mail.gmail.com>
References: <506B7AFB.1070700@game-point.net>
	<7vipas5qpu.fsf@alter.siamese.dyndns.org>
	<loom.20121003T103315-553@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:14:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtTe-0001w8-2F
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756515Ab2JDG7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 02:59:06 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:62363 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900Ab2JDG7E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 02:59:04 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so159817vbb.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 23:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7jSIWdlLPkg00GXrxJmnKVuONSz7HDBWrRkFQ+3CFHA=;
        b=KI/qA+ugLhUKk4xQ5LPuaxdzuGjurCHDDN7s+CdcVqVqPSxRHXxtZ1MYkbtIXrHd5q
         JMvh3qBVG2QZazdikqR1N34o3UDOrD7HgWsVrXe7kz6KraJRpbK48elNtreM2tNL0zVC
         mOc51pFUu/xbJjsVhXu3L5LK4FpQWmxMKrps7hRDIy1ekJ+J1jezGXx1TZuOH+qB9dyJ
         I9xr0WQKmpbnpuBTVlnjzY3OM4qnwPlzqbQmcUVRRtZXpS/w6vgu4hoHebrC6LCvCI6Y
         F29mOFOzuBBWHgbS/aZLncr2GL92d+mSMAQN2KfKJzzM9BbNoJmpi28eof7AR1YHtmk6
         WNCw==
Received: by 10.52.74.227 with SMTP id x3mr2160264vdv.12.1349333943866; Wed,
 03 Oct 2012 23:59:03 -0700 (PDT)
Received: by 10.58.180.39 with HTTP; Wed, 3 Oct 2012 23:59:03 -0700 (PDT)
In-Reply-To: <loom.20121003T103315-553@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206981>

On Wed, Oct 3, 2012 at 1:34 AM, Jeremy Morton <admin@game-point.net> wrote:
> Junio C Hamano <gitster <at> pobox.com> writes:
>
>>
>> Jeremy Morton <admin <at> game-point.net> writes:
>>
>> > I've noticed that the p4merge shell script could do with some
>> > improvement when it comes to merging.  Because p4merge throws up an
>> > error when one of the files it's given to diff is "/dev/null", git
>> > needs to create a temporary empty file and pass that to p4merge when
>> > diffing a file that has been created/deleted (eg. create file, git add
>> > ., git diff --cached).
>> > ...
>> > Thoughts?  Is there an easier way to do this?
>>
>> Which version of git?  Perhaps you do not have ec245ba (mergetool:
>> Provide an empty file when needed, 2012-01-19) yet?
>>
>
> That patch fixes the mergetool part, but the part I was referring to was the
> difftool part, which still has this problem.
>
> Best regards,
> Jeremy Morton (Jez)

Thanks for the heads-up, Jez.

I should have some time to take a look this weekend.
If someone beats me to it I'll be happy to review the patches before
then (Jeremy? ;-)

Is `git diff` giving us /dev/null as the path here,
and p4merge doesn't like that, or is something else
going on?

If that's indeed happening, then I would imagine
a sensible thing for git-difftool--helper to do
would be to check for /dev/null and create some
temporary empty file.

Does that sound like the right way to go?
Another option would be for git-diff's external diff
code to handle it at a much earlier point, perhaps
guarded behind an option that git-difftool knows to
pass (changing existing behavior is off the table).

These both sound like pretty big changes given
that we're getting ready for 1.8.0.

If it's just p4merge that doesn't like this then
perhaps the right decision is to paper over it
in p4merge's mergetools/ scriptlet.

It's certainly the least-impactful option.  Thoughts?
-- 
David
