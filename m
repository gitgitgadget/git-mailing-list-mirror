From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 4/4] notes: teach git-notes about notes.<ref>.merge option
Date: Wed, 12 Aug 2015 15:03:51 -0700
Message-ID: <CA+P7+xp0zhqM4CHmFpKuPyNMTx3DBxiLSOsiwz=byrfTEDj3sA@mail.gmail.com>
References: <1439326641-9447-1-git-send-email-jacob.e.keller@intel.com>
 <1439326641-9447-5-git-send-email-jacob.e.keller@intel.com>
 <CALKQrgeDuRkXm2LzDOuZDZLOBRXjLmmRvhtXfXScWfLKX+9t=g@mail.gmail.com>
 <xmqqy4hhmedb.fsf@gitster.dls.corp.google.com> <CALKQrgf2hdvNExVbvnP5sVUM4sEh7thj9HLw93LbYWSStNjeYg@mail.gmail.com>
 <CA+P7+xrQnrQdE3OOhdc2-2__V3Huzc+HfGEXKBZULy2JkQR37Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Aug 13 00:04:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPe88-0007Rw-I4
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 00:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbbHLWEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 18:04:12 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:32958 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbbHLWEL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 18:04:11 -0400
Received: by igbpg9 with SMTP id pg9so121627396igb.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 15:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iAORVbMMbalvzuJcB4sD/PhcTAel3GTZt+JudrTG/yQ=;
        b=D4RNiqT9BfhH09IQJkUmOscG/gSYi3chkKO269N/kKGz5HIV61CmvyzHJx2VrFZCaa
         CdyrSc/85NIQ5SugXF5QeF6vynyk09yq+HvaD9TtoswJLhBaak1u3qfmBdedlgkTNwCp
         hQ5bRRnTq/CniFRTFnDJLX+gHP2lR3davGQ31eTmvOLDmE+LbtkOAPY88+oWMO0purws
         uErvNBAb8IFiG8Ow3j71U1QEgpqbNw7cG64AWraP/Yf5lQCDpnLNvx7o3ZZhFmtZBoFT
         IrK/lhMUQCSXA/FptRnKpSwa+WIJk9ufakujns5otIGFiPVnNAEhsa+gkn1EwmJWeZcw
         SPHQ==
X-Received: by 10.50.72.113 with SMTP id c17mr24605472igv.73.1439417051283;
 Wed, 12 Aug 2015 15:04:11 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Wed, 12 Aug 2015 15:03:51 -0700 (PDT)
In-Reply-To: <CA+P7+xrQnrQdE3OOhdc2-2__V3Huzc+HfGEXKBZULy2JkQR37Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275821>

On Wed, Aug 12, 2015 at 2:57 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Wed, Aug 12, 2015 at 2:46 PM, Johan Herland <johan@herland.net> wrote:
>> If we don't already refuse to merge into a ref outside refs/notes, then
>> I would consider that a bug to be fixed, and not some corner use case that
>> we must preserve for all future.
>>
>> After all, we do already have a test in t3308 named 'fail to merge into
>> various non-notes refs', where one of the non-notes ref being tested are:
>>
>>   test_must_fail git -c "core.notesRef=refs/heads/master" notes merge x
>>
>
> This test is checking if the ref pointed at by refs/heads/master *is*
> a note. But you could create a ref outside of refs/notes which is a
> note but which isn't inside refs/notes
>
> I did just find that we expand remote-ref using expand_notes_ref, and
> it does *not* currently let us reference refs outside of refs/notes..
> so we can merge IN to a ref not inside refs/notes (using the
> environment variable) but we can't merge FROM
> refs/tracking/origin/notes/y for example, which means currently all
> notes we merge from have to be located into refs/notes/*
>
> There are some weird issues here.
>
> Regards,
> Jake


I spoke to soon. We have an "init_notes_check" function which shows
that it does refuse to merge outside of refs/notes/* It prevents all
notes operations outside of refs/notes

Since this is the case, I would prefer to modify the DWIM to be as I
suggested, and use this DWIM for the notes.

We will need to modify the DWIM so that it doesn't change refs/* even
if this will fail later, as we use expand_notes_ref for the remote_ref
of a merge, and we probably want to allow notes refs to be located
somewhere outside of notes such as refs/tracking/<origin>/notes or
something in the future.

So we can make our config option take only unqualified values.

Thoughts?

Regards,
Jake
