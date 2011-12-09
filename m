From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 9/9] revert: simplify communicating command-line arguments
Date: Fri, 9 Dec 2011 13:29:19 -0600
Message-ID: <20111209192919.GB20913@elie.hsd1.il.comcast.net>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
 <1323445326-24637-10-git-send-email-artagnon@gmail.com>
 <20111209190236.GA20913@elie.hsd1.il.comcast.net>
 <CALkWK0m_6yGuyLt-VqvRZkAiDoSxES8KeNzeXaejYRCpW=HAOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 20:29:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ68Q-0005Qj-0p
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 20:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342Ab1LIT3Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 14:29:25 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53124 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab1LIT3Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 14:29:24 -0500
Received: by yenm11 with SMTP id m11so2357084yen.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 11:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q8vbRH+KtZiVxa2HtEQ9ja0pSblfERqNL/Hm6jQ/HSM=;
        b=YcW9qAtBbaIGjUMxcREDJxP2/tJ5blcVKbjbvFrPf72kNpX70dxl+HcnVfxEe9JKbi
         ui8tt45GHDXT5v3O1dmOzJdc7PvbzyqdMrxTtakFigsgTLTSFY8zuTzEY+2z5I483F38
         +kp10YxY6TE8PvEkUebjndNRd91XkTHNe3RMY=
Received: by 10.236.131.97 with SMTP id l61mr14385801yhi.52.1323458963894;
        Fri, 09 Dec 2011 11:29:23 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id q16sm26423590anb.19.2011.12.09.11.29.22
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 11:29:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0m_6yGuyLt-VqvRZkAiDoSxES8KeNzeXaejYRCpW=HAOg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186668>

Ramkumar Ramachandra wrote:
>> Ramkumar Ramachandra wrote:

>>> +++ b/t/t3510-cherry-pick-sequence.sh
>>> @@ -414,4 +414,15 @@ test_expect_success 'mixed pick and revert ins=
tructions' '
>>> +test_expect_success 'commit set passed through --all' '
>>> + =C2=A0 =C2=A0 pristine_detach initial &&
>>> + =C2=A0 =C2=A0 test_expect_code 1 git cherry-pick --all &&
>>> + =C2=A0 =C2=A0 git cherry-pick --continue
>>> +'
[...]
> This one's actually quite interesting.  "git cherry-pick --all" first
> tries to apply everything from "intial" to "yetanotherpatch" (both
> inclusive) -- its first "git commit" invocation returns 1, refusing t=
o
> create an empty commit.  Then when we say "--continue", it notices
> that the worktree and index are clean, removes "initial" from the
> instruction sheet and executes everything else as usual.  This is
> something we should attempt to fix

So, is it a bad test?  Was the initial command crazy and ill-defined
enough that no one would actually do that?  Is the response to the
command incorrect, meaning that the new test should be instead
checking for some different result with test_expect_failure?

I only mentioned --all in the first place because it is a "revision
pseudo-option" (i.e., option starting with "--" whose position on the
rev-list command line matters) and gets handled by a slightly
different revision parsing code path than foo..bar.  There are other
revision pseudo-options that are easier to control and might make for
a better test if it's wanted, like --remotes=3Dfoo.

> Way starts with creating an API for "git commit".

Not sure what this means.
