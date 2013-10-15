From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Tue, 15 Oct 2013 08:29:56 -0500
Message-ID: <525d4354a5436_5844e73e843d@nysa.notmuch>
References: <1381561485-20252-1-git-send-email-felipe.contreras@gmail.com>
 <20131014205908.GA17089@shrek.podlesie.net>
 <525c63b6711fa_197a905e845b@nysa.notmuch>
 <20131015123505.GA3097@shrek.podlesie.net>
 <525d35e766ad4_55661275e7426@nysa.notmuch>
 <20131015133327.GA22723@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Krzysztof Mazur <krzysiek@podlesie.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 15 15:41:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VW4sg-0005qJ-KW
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 15:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754Ab3JONlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 09:41:45 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:51081 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932628Ab3JONlc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 09:41:32 -0400
Received: by mail-ob0-f177.google.com with SMTP id wm4so5812930obc.8
        for <git@vger.kernel.org>; Tue, 15 Oct 2013 06:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=KxyeKbBp6HxuDC6+jpwaH9TCaa8tsM7zfLEvvFCGONw=;
        b=HyWkbvfGk0NMlbSq8uUePzF5Xo8DJACT3xx9/lpnTUl1jW9lLqm5RWdxyc8+uA6vFu
         TJ3WG+ZVNzcNYwFWxwM68HtIIZSaf4cpvACuUgyhU6eHRjOsC1UbWyQ8OGdAemG4qjzF
         D6FKvUAezascI6WmUxaSZxVJL25+VTlaGoDFwLFzZ13Asa/Ul9mPmFsVFmtOyvYSYMLq
         eTS7OZJC0fLhrwr97/2uGmj1TIYVlwgsznsND+nJZAKGIu4LAs+0MqFWQnvvuc39kqON
         que542exWOmGHp5XapiBLTcx2xpOE35Qbl1pKKbHasgRh8R4eR6hP2AkSJaDweOrws/I
         OQsw==
X-Received: by 10.182.18.102 with SMTP id v6mr718806obd.71.1381844491517;
        Tue, 15 Oct 2013 06:41:31 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hl3sm49545971obb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 06:41:30 -0700 (PDT)
In-Reply-To: <20131015133327.GA22723@shrek.podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236184>

Krzysztof Mazur wrote:
> On Tue, Oct 15, 2013 at 07:32:39AM -0500, Felipe Contreras wrote:
> > Krzysztof Mazur wrote:
> > > 
> > > But with core.mode = next after upgrade you may experience incompatible
> > > change without any warning.
> > 
> > Yes, and that is actually what the user wants. I mean, why would the user set
> > core.mode=next, if the user doesn't want to experencie incompatible changes? A
> > user that sets this mode is expecting incompatible changes, and will be willing
> > to test them, and report back if there's any problem with them.
> 
> With your patch, because it's the only way to have 'git add' v2.0.

Yeah, but that's not what I'm suggesting. I suggested to have *both* a
fined-tunned way to have this behavior, say core.addremove = true, and a way to
enable *all* v2.0 behaviors (core.mode = next).

If we have both, and the user sets core.mode = next, that means the user wants
*all* the incompatible changes.

> But if another git v2.0 incompatible change will be added it will not
> be warned, because with core.mode=next he decided to enable also
> future changes and that's why I would never set that.

That's fine, you wouldn't set that, but I would. That's why it's a
configuration.

> > > I think it's better to keep the old behavior by default and warn the user if
> > > with new behavior the result might be different. So the user:
> > > 
> > > 	a) knows about the change
> > > 
> > > 	b) may set appropriate option to enable the new default or keep
> > > 	   the old behavior and disable the warning
> > > 
> > > 	c) may report that he does not like that change
> > 
> > But that's what we are doing already. Look at the test I wrote, it's testing
> > the warnings for the current version of Git.
> 
> With pull.default we did that, but with git add v2.0 now we only warn
> the user. With your patch he can enable new git add (and disable warning),
> but he also enables future incompatible changes and disables
> warnings for such changes.

Yeah, but I suggested to have *both* a fine-tunned option and a general one,
didn't I?

> He also cannot keep the old behaviour and disable the warning.

He cannot do that regardless if my patch is merged or not.

> > > I don't see the change in "git add" as an improvement, because
> > > removing files with "git add" IMHO is more confusing than ignoring
> > > such files. Maybe introducing new command - "git update" for instance -
> > > which is equivalent to new "git add" and teaching new users to use it
> > > instead of "git add" is better.
> > 
> > I agree. At first I simply ignored the changes because I didn't have the
> > patience to figure out what exactly did they mean. Now I was forced to
> > understand them to write this patch, and I'm also forcing myself to use this
> > behavior.
> > 
> > 'git add' removing files is counter-intutive, 'git stage' (currently an alias
> > to 'git add') might make more sense.
> 
> Yeah, 'git stage' as an alias to 'git add -A' is much more intuitive.

Agreed.

-- 
Felipe Contreras
