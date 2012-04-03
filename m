From: Phil Hord <phil.hord@gmail.com>
Subject: Re: rebase -p loses amended changes
Date: Tue, 3 Apr 2012 18:09:49 -0400
Message-ID: <CABURp0pnXvnT2=fDJXk-yiGctsJBHiNGSCOZiT4Vo74woi0Zxg@mail.gmail.com>
References: <592E2EEC-6CBA-48D6-8D44-34A971DD78EC@gmail.com>
 <CAH3Anrqorf481jw6GdHqOPg9WC0rD-OraOHZ7twWRF4+oJ9X4A@mail.gmail.com>
 <87fwcpun95.fsf@thomas.inf.ethz.ch> <CAH3AnrpasFU2bLEZsAXRQu4U+=R_YyW+-yRXDfzy2JQpqf9dNw@mail.gmail.com>
 <CADb3U=4Y0njLiYC1qrYbdm+h0h8vLh78yfz_u3B6veEqCX0xCQ@mail.gmail.com> <CAH3Anrq_Z0V=DpU1iH-A3F8RFWTG0_C1hEe3iDZYe=AYDTRT3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: J Robert Ray <jrobertray@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 00:10:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFBvd-0005jZ-Tt
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 00:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755463Ab2DCWKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 18:10:11 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39181 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754989Ab2DCWKK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 18:10:10 -0400
Received: by yhmm54 with SMTP id m54so131188yhm.19
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 15:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=E2WboW6WVX5ELrMKpTPZ3pmqAjyzr1UrDk6kMoPUL5w=;
        b=LOKUg7x9p9YGAcmGGfthwxF8cUUHqIPOH1cT1OeLfsShoRPcaQS/mON2xz2sjW9H9R
         k7OXKzabqpoyfL5jtEx/iVBosfeT8PLHRzyKZ748m2Nxzm4WSwj7MiovI+QzOUSYwAsP
         HX4CaxlRZtoIKntl0cWBTTI7h9O78iZXQkS3ayqEeNYaMSRwELMEE3i6S84EuTtBiZVu
         JwCw/Zjb1XXwi2bYr5YbwWo9EjgSFYsvyR/qgsCcAY7cxPtNU6wRhPcNFj/gaHsOanol
         0N+pm4uqJ4Aw3VOm8bZEc8tShH6u8s19x/wyr3Au1exYTGMy3W+rlKWWtcnWaai0gfwo
         t98w==
Received: by 10.101.180.1 with SMTP id h1mr3921085anp.71.1333491009934; Tue,
 03 Apr 2012 15:10:09 -0700 (PDT)
Received: by 10.146.207.6 with HTTP; Tue, 3 Apr 2012 15:09:49 -0700 (PDT)
In-Reply-To: <CAH3Anrq_Z0V=DpU1iH-A3F8RFWTG0_C1hEe3iDZYe=AYDTRT3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194656>

On Tue, Apr 3, 2012 at 5:43 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
> On Wed, Apr 4, 2012 at 4:55 AM, J Robert Ray <jrobertray@gmail.com> wrote:
>> On Sat, Mar 31, 2012 at 2:39 AM, Jon Seymour <jon.seymour@gmail.com> wrote:
>>> On Sat, Mar 31, 2012 at 8:35 PM, Thomas Rast <trast@student.ethz.ch> wrote:
>>>> Jon Seymour <jon.seymour@gmail.com> writes:
> orrectness point of view.
>>
>> I thought there would be more concern about the silent data loss.
>> Instead of throwing away the amended changes I would prefer the rebase
>> to at least fail, if not have the problem require manual conflict
>> resolution.
>>
>> A warning at the time of the amend could confuse or scare users. But a
>> mention of this problem in the rebase docs would help.
>
> It'd be quite expensive to attempt to detect cases where this might be
> a problem, but let's articulate, as a thought experiment, what such a
> solution might look like - I am not suggesting that it is a good idea,
> but the thought experiment might be illustrative.
>
> Suppose you have a merge of a A and B that produces M, which is then
> amended as M'.
>
> During rebase, you redo the merge A and B. If there are no conflicts,
> then compare M with M' to produce D. You now have enough information
> to reproduce the amended commit M' during a rebase (merge Ar and,Br
> then apply D).

How does M' know it is an amended version of M?  When you amended the
commit M you threw away this linkage.

If you created M' as a new commit D instead, then I would agree that
you have enough information to do what you seek.  In fact, I'm pretty
sure git does this already.

Phil
