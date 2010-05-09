From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control end-of-line conversion
Date: Sun, 9 May 2010 12:42:17 +0200
Message-ID: <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com> <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org> <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com> <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com> <20100509070043.GB14069@dpotapov.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: "git@vger.kernel.org List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 09 12:44:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB402-0005iS-2J
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 12:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286Ab0EIKmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 06:42:22 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:51212 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab0EIKmV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 May 2010 06:42:21 -0400
Received: by ey-out-2122.google.com with SMTP id d26so193698eyd.19
        for <git@vger.kernel.org>; Sun, 09 May 2010 03:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=VAJxIjSgQ7XQNwaG+W5Eyvy/+nak5IttNcN16bZ1mpI=;
        b=LsxzNPLmD8WL8RmdTk+3LYqW4TweL+DdOWyYpExwKJ2P+YHEkjmSQmYpnSGuf1NA5u
         bcphlsDigwBW7CReinVNNDA/2b9VN5I482Dac1YX7U+sRQSsq4hw9QLyfbOjEJiuAR7p
         yPr56zSkcZTJqCFAwkc/khTvldFGicujI/OZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=qY9PetXLs2JUMLoEhh86PbsiiR8isDVyHDvENMGZOgNSfXgW/o2RrBF+vqPcpjElsI
         D+7d/kEYfjb3f6+ZztfwJETY/IPuPoVx49x/PHwjpaweaZxoxs0+X8/ABWgOZmB+nyIh
         Sim2WFAZbYoQaR1HWS8xqqwsZqCaFuSYBfo10=
Received: by 10.213.57.136 with SMTP id c8mr726080ebh.5.1273401739781;
        Sun, 09 May 2010 03:42:19 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 15sm1977146ewy.8.2010.05.09.03.42.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 May 2010 03:42:19 -0700 (PDT)
In-Reply-To: <20100509070043.GB14069@dpotapov.dyndns.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146717>

I guess I should nail my flag to the mast: Here's what I would have done, with the benefit of plenty of hindsight, had we not had core.autocrlf, and also what I think we should do to approach that ideal.

Please don't get hung up too much on the names, they were chosen to not match anything suggested so far so that I can refer back to them unambiguously.

My user interface would have been:

- an attribute "eolconv" that enables or disables line ending conversion
- a config variable "core.eolconv" that sets "eolconv" for all files where it is unset
- a config variable "core.localeol" that decides whether LF or CRLF is preferred

This provides the means to enable normalization on a per-project ("eolconv") or per-repository ("core.eolconv") basis, and allows the user to override the platform native line ending when normalization is in effect.


Now, how does that compare to Git's current implementation of autocrlf?

- The config variable "core.autocrlf" enables or disables line ending conversion and decides if conversion occurs in "both" directions ("autocrlf=true") or just towards the repository ("autocrlf=input").

- The attribute "crlf" allows the automatic detection of binary files to be overridden, and forcing one-way conversion even if "core.autocrlf" is true ("crlf=input").  It only has an effect when "core.autocrlf" is enabled.

I think I've stated my case against these settings before, but just to be clear, I think the biggest problem is that there's no way to tell if a repository is normalized from the contents of the repository, and it's not safe to enable autocrlf if the repository isn't normalized.

The second biggest problem is that "true" and "input" are bad names for "normalize and put CRLFs in my working directory" and "normalize and put LFs in my working directory", respectively.


So how to progress from here?

As Junio observed, the "crlf" attribute can act just like my hypothetical "eolconv" if you squeeze its semantics a bit and add a new setting.  Disregarding "crlf=input" makes it exactly equivalent to "eolconv".  The name is a bit off, but it's not monstrous.

"core.localeol" has no equivalent in the current implementation.  Using "core.autocrlf" as a stand in would not work, since that setting is expected to actually enable normalization, so if we want a moral equivalent of "eolconv", we need a new setting.  "core.crlf" has been suggested to match the "crlf" attribute, but that causes confusion: why doesn't setting "core.crlf=auto" mean the same thing as setting "crlf=auto" on all files?  I think a new variable is needed.

"core.autocrlf" is problematic because it mixes up two things: you use it to turn on normalization _and_ to decide which line endings you prefer, and to maintain backwards compatibility its semantics can't be changed too much.  A new setting "core.autocrlf=auto" (meaning the same as "eolconv=auto" on all files where "eolconv" isn't explicitly set) is a possibility, if kind of ugly.  Another alternative is to make "core.autocrlf=true" respect "core.localeol", but that would be a v1.8.0 kind of change.


My current thinking on how to change my series now runs along these lines:

- keep the current "crlf=auto" change
- rename "core.eolStyle" to "core.localcrlf"
- add a "core.crlf" that sets the "crlf" attribute on paths where it isn't explicitly configured
- keep "core.autocrlf" for backwards compatibility, but make "core.autocrlf=input" and "core.autocrlf=true" complain if they are in conflict with the other config settings.



An apology: I know I've said a lot of nasty things about autocrlf, but I haven't had to touch a thing about its implementation, which works very well.  My only beef is with its user interface (which probably made sense when it was implemented); the reason I don't think I'm just whining about the colour of the bike shed is that a lot of other people trip over that interface, to the point where the standard recommendation is simply to disable the feature, and I'd like to make it both more functional and more understandable.

In short, I'm burning autocrlf to save it :)
-- 
Eyvind
