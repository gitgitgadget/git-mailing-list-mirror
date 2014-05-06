From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] t3910: show failure of core.precomposeunicode with
 decomposed filenames
Date: Tue, 6 May 2014 12:11:37 +0200
Message-ID: <CABPQNSavqqB_yWXn1_8JTUWY8t13PZsepx7pez-9vcPAS6iv0w@mail.gmail.com>
References: <20140428161630.GA9435@sigill.intra.peff.net> <5365DA7B.6050000@web.de>
 <20140505214658.GA16971@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 06 20:32:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiNX-0008Bg-E9
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934791AbaEFKMT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 May 2014 06:12:19 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34201 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934609AbaEFKMS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2014 06:12:18 -0400
Received: by mail-ig0-f171.google.com with SMTP id c1so6010121igq.10
        for <git@vger.kernel.org>; Tue, 06 May 2014 03:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=gwXF0NrNygJsXCYeCwEPYLUTXwxS24P4X5r56v0v260=;
        b=z65no5RK2Z6WjE81MkQJFl/lHMqTmvmi8HCOqqWsKyyFCWlCpwvMHkPbloMFhAFHVq
         QiwtnTP+FzgLXymhgIKuCkvHo/4FxAe6B9rdmPNffCnAMlFLJcjQqlbsJvqTmjD+kd5X
         0FSZrtVCbeXKJyGzBjTC6KPV5ItJsC6L8EWzwYyxvlwlhaFElw33yb7Fii3vC+glFhLD
         7QwXhFYP7ojydXU0iH+rFlSCsXrRftSGpJpVGPY2865opZMBIZ6kRL0YfnekFG7Y5Y61
         mbeR/QoxmxP2QdjiIAd/KjPyRTEeCpx9zgwhfvMsfOMlj1l21q6BG+O80+egrmrmPb29
         HAKA==
X-Received: by 10.42.162.68 with SMTP id w4mr13209501icx.50.1399371138084;
 Tue, 06 May 2014 03:12:18 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Tue, 6 May 2014 03:11:37 -0700 (PDT)
In-Reply-To: <20140505214658.GA16971@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248207>

On Mon, May 5, 2014 at 11:46 PM, Jeff King <peff@peff.net> wrote:
> On Sun, May 04, 2014 at 08:13:15AM +0200, Torsten B=C3=B6gershausen w=
rote:
>
>> >   1. Tell everyone that NFD in the git repo is wrong, and
>> >      they should make a new commit to normalize all their
>> >      in-repo files to be precomposed.
>> >      This is probably not the right thing to do, because it
>> >      still doesn't fix checkouts of old history. And it
>> >      spreads the problem to people on byte-preserving
>> >      filesystems (like ext4), because now they have to start
>> >      precomposing their filenames as they are adde to git.
>>      (typo:                                                         =
         ^added)
>> I'm not sure if I follow. People running ext4 (or Linux in general,
>> or Windows, or Unix) do not suffer from file system
>> "feature" of Mac OS, which accepts precomposed/decomposed Unicode
>> but returns decompomsed.
>
> What I mean by "spreads the problem" is that git on Linux does not ne=
ed
> to care about utf8 at all. It treats filenames as a byte sequence. Bu=
t
> if we were to start enforcing "filenames should be precomposed utf8",
> then people adding files on Linux would want to enforce that, too.
>
> People on Linux could ignore the issue as they do now, but they would
> then create problems for OS X users if they add decomposed filenames.
> IOW, if the OS X code assumes "all repo filenames are precomposed", t=
hen
> other systems become a possible vector for violating that assumption.

=46WIW, Git for Windows also doesn't deal with that "filenames are just
a byte-sequence"-notion. We have patches in place that require
filenames to *either* be valid UTF-8 or Windows-1252. Windows itself
treats filenames as Unicode characters, not arbitrary byte sequences.
