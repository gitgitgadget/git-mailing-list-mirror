From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [git-users] Highlevel (but simple to implement) commands provided
 by default for git
Date: Thu, 30 May 2013 02:56:20 +0530
Message-ID: <CALkWK0mZqaUHObNqXKeY7=BCOq-0iHtMvtc_eNANHN8Hw8G-fQ@mail.gmail.com>
References: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com>
 <CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
 <CALkWK0k8GkFYNkoGH4YCgmWtSR5rgFSG0dU9Aw2CO_arvuzKxQ@mail.gmail.com>
 <CAMP44s1VFxarV4Gp5KsxhFKJbmd033-DW8koe9P4XUZQcX4mrA@mail.gmail.com>
 <7v38t5sg7k.fsf@alter.siamese.dyndns.org> <CALkWK0=kA8mPt-8h8dYS9HrOcF1tx=0Pj-=jFHfa_UxdC=ehPQ@mail.gmail.com>
 <7vtxllqyhz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	=?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo@gmail.com>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 29 23:27:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhntj-0008SY-KO
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 23:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935171Ab3E2V1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 17:27:04 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:64746 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932609Ab3E2V1B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 17:27:01 -0400
Received: by mail-ie0-f180.google.com with SMTP id b11so11995260iee.39
        for <git@vger.kernel.org>; Wed, 29 May 2013 14:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rfD8sIlSJhKblzSFuDrO7w/CwnpGrZRp15gjC1DXhk0=;
        b=J7u96C2I5P6Aqg0/uCDiPXhcw8sgwfLdWOZnljAFe2A4J/eTSVW4xaZeElM/BZ0v0Y
         QONO2inxgGam9i2aKpYUQ1RUnT1vCSyq6pOQIelJxNcrF0MQavLBVT7+4+mA36llThR/
         YSIpfllRvDNTTDMK77Ef6oOIozRrxam63CF/A+554eqPsk9dBXai/RH0a0Dh9hwrCgxg
         Ur8o05Mh5fp8lXNfHAi3JJV2BjOo4VogifPrtT+xjHCK/wetEfL7sM9+8gLkMMZsjMIc
         axP+ocN/ONtC4U2ui1ZzKg0phg/XugfpHM4DrS0jgG7soX6I+QMESiN5fdoqvgcVIavb
         Ew7A==
X-Received: by 10.50.141.230 with SMTP id rr6mr10363310igb.89.1369862820896;
 Wed, 29 May 2013 14:27:00 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Wed, 29 May 2013 14:26:20 -0700 (PDT)
In-Reply-To: <7vtxllqyhz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225891>

Junio C Hamano wrote:
> The whole point of show-cdup is that people (especially those in
> java land) bury themselves in a hierarchy so deep that it is not
> feasible to tell "Go count the hierarchy and prefix that many ../
> yourself" to them.

Ah.

> The answer to "we cannot count ../" issue is ":(top)" aka ":/" magic
> pathspec modifier.

I thought :/ was a revspec, which is why I was scratching my head so
hard.  Did we introduce this ambiguity intentionally?

This errors out:

  git log :/Makefile

So, I have to do either of these:

  git log :/Makefile --
  git log -- :/Makefile

depending on what I want.

> "git blame" takes a single pathname, not "a set of patterns to match
> against to select concrete paths", which is what a pathspec is.

So the problem is that I can't do:

  git blame -- :/Makefile

So blame has to be converted to use pathspec semantics, and should
error out when the pathspec doesn't match the concrete path of a file.
