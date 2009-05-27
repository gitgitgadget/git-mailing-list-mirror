From: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
Subject: Re: RFE: "git bisect reverse"
Date: Wed, 27 May 2009 23:07:50 +0100
Message-ID: <efe2b6d70905271507s187babe9yf19a25268ab0b95e@mail.gmail.com>
References: <4A1C6B70.4050501@zytor.com> <4A1CACB2.7000702@vilain.net> 
	<4A1CBF7A.3090708@zytor.com> <200905270726.59883.chriscool@tuxfamily.org> 
	<efe2b6d70905271411g4e1616b5w548141ee9fab2c14@mail.gmail.com> 
	<20090527211836.GA14841@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu May 28 00:08:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9RIJ-0004ol-NJ
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 00:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756175AbZE0WIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 18:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755191AbZE0WIK
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 18:08:10 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:64645 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007AbZE0WIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 18:08:09 -0400
Received: by ewy24 with SMTP id 24so4751745ewy.37
        for <git@vger.kernel.org>; Wed, 27 May 2009 15:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=SToe5E+IpiW68mGmLNR2WzmcBv6wgJY8YCQFoWDfusI=;
        b=Qg1LDcqosWST5i8IcNfFwltsOAxYuCPkGPKFFUPM2jGoUT5eI61O2BX1LhG2IsZG2B
         LIV483CO3OUMuUoAR5RXKwRumwWGmR/QG1N4x4gcgqDxgQ5q8mnInHgRV3WUwBZPuHOV
         yLa7W4FaPPVhp4p/7jMW1FFE6kvb3WG8ICu2U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Ye/YRshbQkUcR4GyOfhwpEp0ri9avEzKlHsuwrbQuarOtQnIgQer5ipngrt9hLXqoq
         XIB5m2v6ki0yjihVnK+m/t/rYbKi0u7GpTYTPGxCHxIzMShv/s+pwQ1bYeNpNcj+pQEn
         9jwVbpYMHLgjni+bnxnZmAGkxZ5X+lsxFpUBo=
Received: by 10.216.17.213 with SMTP id j63mr193326wej.140.1243462090216; Wed, 
	27 May 2009 15:08:10 -0700 (PDT)
In-Reply-To: <20090527211836.GA14841@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120111>

On Wed, May 27, 2009 at 10:18 PM, Clemens Buchacher <drizzd@aon.at> wrote:
> On Wed, May 27, 2009 at 10:11:35PM +0100, Ealdwulf Wuffinga wrote:
>> >> Sam Vilain wrote:
>> >> > Oh, yes.  And another thing: 'git bisect run' / 'git bisect skip'
>> >> > doesn't do a very good job of skipping around broken commits (ie when
>> >> > the script returns 126).  It just seems to move to the next one; it
>> >> > would be much better IMHO to first try the commit 1/3rd of the way into
>> >> > the range, then if that fails, the commit 2/3rd of the way through it,
>> >> > etc.
>>
>> As I understand it, the idea is that the probability that a commit is
>> broken is greater if it is close in the DAG to a known-broken commit.
>> I wonder if this can be made more concrete? Can we derive a formula
>> for, or collect empriical data on, these probabilities?
>
> No. The idea is that we want to reduce to bisect as close to the middle as
> possible so we only have to do log2(n) tests. But if a commit is skipped,
> that means we cannot decide whether the test passes or fails for this
> commit. But if we choose a commit close to the skipped one, we will likely
> have to skip the that one for the same reason.

You say 'no', but your explanation does not appear to contradict what
I have said.
I am not sure what you are disagreeing with?

I agree, the whole point is to do the bisection in as few tests as possible.
This means that the test must gain the maximum information possible,
which in the
deterministic case (git-bisect) means testing in the middle. For the
non-deterministic case,
in bbchop, I directly calculate the information gain of each potential
test, then choose the greatest.

The question is how to avoid skips, which gain no information. You say
'if we choose a commit close to the skipped one, we will likely have
to skip the that one'. This is what I meant by 'the idea is that the
probability that a commit is broken is greater if it is close in the
DAG to a known-broken commit'. Maybe you are reading this as 'bad
commit', but this is not the sense in which Sam is using the term.

For git-bisect, Sam and H Peter are proposing a heuristic to trade off
between information gained and likelihood of testing a bad commit. For
bbchop, I am already doing calculating the information gain directly,
so if I can incorporate the probability that a commit is broken - has
to be skipped - then the trade-off will happen automatically.
Therefore it would be useful to have some plausible theory as to how
the probability of a broken commit should be calculated, given some
known-broken and known-not-broken commits.

Ealdwulf
