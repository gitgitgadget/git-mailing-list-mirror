From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 1/9] difftool: parse options using Getopt::Long
Date: Sat, 17 Mar 2012 09:54:09 -0400
Message-ID: <CAFouetgpz__1q7F_a3LQoeypCVBXOyTPWmL0e9=rw7vV65d7_g@mail.gmail.com>
References: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
	<1331949442-15039-2-git-send-email-tim.henigan@gmail.com>
	<CAJDDKr7BTz-2THw1JaJEDcK1G4Uxwc88=gFsHCSONHAtqtypRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 14:54:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8u5I-0006tY-Dk
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 14:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170Ab2CQNyL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Mar 2012 09:54:11 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47983 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908Ab2CQNyJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2012 09:54:09 -0400
Received: by iagz16 with SMTP id z16so6877049iag.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 06:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=EPvrrPP0lfocaFNAbj9i8Ihm7fxbq1GC5i9qeKFSd08=;
        b=ka9QT86KsM0rgjxfqC0ONKWVBhs62kvNUDPsIjLrsV4Hm2dhFxULIlm+kt/q6TiyVp
         R/turlUDtbhcISL0+MmKcHZ5JkSXtfruV2JAPB2tSZKZzqZxhyfsLZndolUOgQPcQRSL
         dl2JO9OpppStYgTwizk6/syyCeJ9zOtof+2hHMtkZLmaAQoVN/9JIDXEDn0ZGb8fNEUf
         iJFK4YukUio1R9ptMZty0CzSXV3SZtZ39LVIObqL3ovpI35tyd7BnZCZ7k0uVcq4dSei
         jFRC85bLLw6uTuCp2/tquj9TWB3eV2EKc6z0N0TlzjPEeT/ZfzAa4WRxgOVlAbB7EPEB
         SX9g==
Received: by 10.50.149.131 with SMTP id ua3mr1949681igb.41.1331992449265; Sat,
 17 Mar 2012 06:54:09 -0700 (PDT)
Received: by 10.42.218.65 with HTTP; Sat, 17 Mar 2012 06:54:09 -0700 (PDT)
In-Reply-To: <CAJDDKr7BTz-2THw1JaJEDcK1G4Uxwc88=gFsHCSONHAtqtypRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193324>

On Fri, Mar 16, 2012 at 11:21 PM, David Aguilar <davvid@gmail.com> wrot=
e:
> On Fri, Mar 16, 2012 at 6:57 PM, Tim Henigan <tim.henigan@gmail.com> =
wrote:
>
> I've also wanted to do the same in the past. =C2=A0The one thing hold=
ing me
> back was this note from the perldocs:
>
> "If pass_through is also enabled, options processing will terminate a=
t
> the first unrecognized option, or non-option, whichever comes first."
>
> http://search.cpan.org/~jv/Getopt-Long-2.38/lib/Getopt/Long.pm

That sentence is listed under the documentation of the 'permute'
option.  The documentation of 'pass_through' states that:

"Options that are unknown, ambiguous or supplied with an invalid
option value are passed through in @ARGV instead of being flagged as
errors. This makes it possible to write wrapper scripts that process
only part of the user supplied command line arguments, and pass the
remaining options to some other program.

If require_order is enabled, options processing will terminate at the
first unrecognized option, or non-option, whichever comes first.
However, if permute is enabled instead, results can become confusing."

So early termination would only be a problem if 'pass_through' was
enabled at the same time as 'require_order' or 'permute'.  To verify,
I confirmed that 'git difftool --cached --diff-dir' works as expected.


> Is this indeed the case? =C2=A0I am a little ashamed that the difftoo=
l
> tests do not cover this area. =C2=A0That would be a valuable first st=
ep
> towards exploring this approach, IMO.

I will review the the test cases.  If this goes forward, I still need
to add test cases to confirm the new '--dir-diff' option.


> BTW, I hate @ARGV parsing loops just as much as anyone! =C2=A0I was n=
ot
> ignorant of Getopt::Long, and no, I was not re-inventing the wheel fo=
r
> no reason. =C2=A0The reason it was done that way was so that we can f=
orward
> everything we don't know about to git-diff.

I understand and was not implying anything different.  I simply
thought this would be a positive change.
