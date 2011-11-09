From: David Michael Barr <davidbarr@google.com>
Subject: Re: Benchmarks regarding git's gc
Date: Wed, 9 Nov 2011 23:34:58 +1100
Message-ID: <CAFfmPPNeriyNbnag9ekXW6YEVzordKNxUCjw837roub8hn+HGw@mail.gmail.com>
References: <CAMP44s3E-YCMQQzJAU2wjjD-adpNy6bGb-=iUQ=p=bFTWxm+Ng@mail.gmail.com>
	<CA+sFfMdax6UYsi2ojGWQT_TdPSMPGMGRZA3jz+VaENmbs4buzQ@mail.gmail.com>
	<20111108215812.GB18529@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Brandon Casey <drafnel@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 09 13:35:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RO7N3-0008FF-5p
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 13:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982Ab1KIMfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 07:35:01 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40777 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960Ab1KIMe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 07:34:59 -0500
Received: by ywf7 with SMTP id 7so1658906ywf.19
        for <git@vger.kernel.org>; Wed, 09 Nov 2011 04:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record;
        bh=Y7Rz2G6cpL4HmW+6MAFaLaCmhEjhWhH8Q3f/NqYAHVo=;
        b=PuBGz2pTqQDmjdB2ApSvdwKS3rn+3U5VpEZm9qwVQOe0dEH+URllIlSQrGTQyHs2SS
         SjSRJHtaGNIiwC8yjv/A==
Received: by 10.101.111.11 with SMTP id o11mr1157474anm.139.1320842099115;
        Wed, 09 Nov 2011 04:34:59 -0800 (PST)
Received: by 10.101.111.11 with SMTP id o11mr1157462anm.139.1320842098869;
 Wed, 09 Nov 2011 04:34:58 -0800 (PST)
Received: by 10.100.225.6 with HTTP; Wed, 9 Nov 2011 04:34:58 -0800 (PST)
In-Reply-To: <20111108215812.GB18529@sigill.intra.peff.net>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185154>

On Wed, Nov 9, 2011 at 8:58 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 08, 2011 at 10:40:15AM -0600, Brandon Casey wrote:
>
>> On Tue, Nov 8, 2011 at 5:34 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>> > Has anybody seen these?
>> > http://draketo.de/proj/hg-vs-git-server/test-results.html#results
>> >
>> > Seems like a potential area of improvement.
>>
>> I think this is a case of designing the problem space so that your
>> intended winner wins and your intended loser loses.
>
> Sort of. It is a real problem space, and mercurial does have some
> advantage in that area.
[...]
> So he may have a point that mercurial might perform better for some
> metrics than git in the current state. But I think a lot of that is
> because nobody has bothered putting git into this situation and done the
> tweaks needed to make it fast. You can argue that git sucks because it
> needs tweaking, of course, but if I were picking between the two systems
> to implement something like this, I'd consider picking git and doing the
> tweaks (of course, I'm far from unbiased).

It is the case that the default behaviour of git gc --auto is far from optimal.
I've been playing with ways to achieve both better asymptotic
performance and less jitter.
One part of that is choosing "good" packing parameters for a given repo.
I did this in a partially automated fashion for WebKit but I think the
process can be generalised.
The other issue is how often you repack ancient history, the potential
waste is obvious.
To this end I propose a repacking strategy in the spirit of merge-sort:
If you can maintain the constraint that the sizes of packs in a repo
form a geometric sequence, my napkin says the amortised cost of gc is
log(n).

--
David Barr.
