From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: rebase -p loses amended changes
Date: Wed, 4 Apr 2012 07:43:29 +1000
Message-ID: <CAH3Anrq_Z0V=DpU1iH-A3F8RFWTG0_C1hEe3iDZYe=AYDTRT3g@mail.gmail.com>
References: <592E2EEC-6CBA-48D6-8D44-34A971DD78EC@gmail.com>
	<CAH3Anrqorf481jw6GdHqOPg9WC0rD-OraOHZ7twWRF4+oJ9X4A@mail.gmail.com>
	<87fwcpun95.fsf@thomas.inf.ethz.ch>
	<CAH3AnrpasFU2bLEZsAXRQu4U+=R_YyW+-yRXDfzy2JQpqf9dNw@mail.gmail.com>
	<CADb3U=4Y0njLiYC1qrYbdm+h0h8vLh78yfz_u3B6veEqCX0xCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: J Robert Ray <jrobertray@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:43:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFBVo-00062t-O3
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 23:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291Ab2DCVnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 17:43:31 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:35281 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155Ab2DCVna (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 17:43:30 -0400
Received: by wejx9 with SMTP id x9so108221wej.19
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 14:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2aJHL4ijDZwv27D1uV/KQiXPE4Rt3VKgl1rS4Twy4SU=;
        b=tRbKi0+qgtTilqlBd5LjGWUiaL15Pi3VuNDYrUZ37Ujb3NErGUEXBmCALEzH+PKoTO
         +EFU/ElEkNrO+L1ie9Ca4ov+KPxRHkAoWvC0c2F7+8vj3HLxpKObTTOd4MFR2EjZxA6U
         54oEzATKGi3RRKWstUMY7j75Zq218WfS6q1LHAX0mrR1LQZpbiaCy6of1UOpINwpngnC
         5G7qeom0PgjDeLPhKEU2qm+BNk/z/TNH9hWXBmH2UIqvFaMwG6Hmic8z40ryTxIWj2rN
         VVlORMPkiMYbLNJzbcqQ6zoXe83sd53yJ6aRz3Vv3CBLbpt4JvWTkqVMVewQgEMnALUA
         1s3g==
Received: by 10.180.79.72 with SMTP id h8mr10551959wix.1.1333489409837; Tue,
 03 Apr 2012 14:43:29 -0700 (PDT)
Received: by 10.180.82.35 with HTTP; Tue, 3 Apr 2012 14:43:29 -0700 (PDT)
In-Reply-To: <CADb3U=4Y0njLiYC1qrYbdm+h0h8vLh78yfz_u3B6veEqCX0xCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194651>

On Wed, Apr 4, 2012 at 4:55 AM, J Robert Ray <jrobertray@gmail.com> wrote:
> On Sat, Mar 31, 2012 at 2:39 AM, Jon Seymour <jon.seymour@gmail.com> wrote:
>> On Sat, Mar 31, 2012 at 8:35 PM, Thomas Rast <trast@student.ethz.ch> wrote:
>>> Jon Seymour <jon.seymour@gmail.com> writes:
orrectness point of view.
>
> I thought there would be more concern about the silent data loss.
> Instead of throwing away the amended changes I would prefer the rebase
> to at least fail, if not have the problem require manual conflict
> resolution.
>
> A warning at the time of the amend could confuse or scare users. But a
> mention of this problem in the rebase docs would help.

It'd be quite expensive to attempt to detect cases where this might be
a problem, but let's articulate, as a thought experiment, what such a
solution might look like - I am not suggesting that it is a good idea,
but the thought experiment might be illustrative.

Suppose you have a merge of a A and B that produces M, which is then
amended as M'.

During rebase, you redo the merge A and B. If there are no conflicts,
then compare M with M' to produce D. You now have enough information
to reproduce the amended commit M' during a rebase (merge Ar and,Br
then apply D).

What isn't clear to me, in this thought experiment, is how you might
attempt to solve the case where there were syntactic (as opposed to
semantic) conflicts between the merge of A and B originally. You have
no idea, at that point, how the user originally resolved the conflicts
to produce M, thus no idea how to calculate D or even if there was a
non-trivial D.

In this circumstance, you stop and warn the user about the merge
conflict, but you have no good way (??) to warn them about the
potential loss of the amendment, D, since at this point you have no
clue whether there was such an amendment and you don't want to worry
them about conditions that usually do not occur (amended merges, I
would have thought, are quite rare).

??: does git rerere help at all, in this case, I wonder?

Certainly, there is no harm, I think, adding a note to the
documentation of --preserve-merges that states something like:

--preserve-merges does not attempt to preserve the resolution of merge
conflicts or the amendment of merge commits ???; any histories
containing such changes cannot be reliably recreated by git rebase.

??? - except to the extent allowed by git rerere?

jon.
