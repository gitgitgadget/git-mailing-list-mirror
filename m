From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 23:51:16 +0200
Message-ID: <200610172351.17377.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610172301.27101.jnareb@gmail.com> <45354AD0.1020107@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 23:50:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZwpn-0003cb-6L
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 23:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWJQVus (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 17:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWJQVus
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 17:50:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:7722 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750776AbWJQVur (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 17:50:47 -0400
Received: by ug-out-1314.google.com with SMTP id o38so54905ugd
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 14:50:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=s9fgfm1nGmIgh0eEWM3UEsQzQAlGpAUjW+xYtqUNfUvUNGDXc8ddIF6hbkzbpRy1Vta5zR6iTmGpyi+3s9Av6w9B4NsYYeeyTQUvxMlMBRy0gWWQzt7oaHMzPuIaIsDEbgqHFHaedCNC74+FeLtTOn+xEUqU73i9Dr0lcplhngg=
Received: by 10.67.105.19 with SMTP id h19mr2298853ugm;
        Tue, 17 Oct 2006 14:50:45 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id g30sm181396ugd.2006.10.17.14.50.44;
        Tue, 17 Oct 2006 14:50:45 -0700 (PDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <45354AD0.1020107@utoronto.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29120>

Aaron Bentley wrote:
> Jakub Narebski wrote:

>>>Ah, now I see what you mean, and the "graft" plugin mentioned by others
>>>fills that role.  I've never used it, though.
>>
>> Very useful as a kind of poor-man's-Quilt (or StGit). You develop some
>> feature step by step, commit by commit in your repository cooking it
>> in topic branch. Then before sending it to mailing list or maintainer
>> as a series of patches (using git-format-patch and git-send-email)
>> you rebase it on top of current work (current state), to ensure that
>> it would apply cleanly.
> 
> What is the bad side of using merge in this situation?

We want linear history, not polluted by merges. For example you cannot
send merge commit via email. Another problem is that you want to
send _series_ of patches, string of commits (revisions), creating feature
part by part, with clean history; with merge you get _final result_
which will apply cleanly, with rebase you would get that series
of patches will apply cleanly.
 
>>>Interesting.  We don't do 'fast-forward' in that case.
>>
>> Fast-forward is a really good idea. Perhaps you could implement it,
>> if it is not hidden under different name?
> 
> We support it as 'pull', but merge doesn't do it automatically, because
> we'd rather have merge behave the same all the time, and because 'pull'
> throws away your local commit ordering.

I smell yet another terminology conflict (although this time fault is
on the git side), namely that in git terminology "pull" is "fetch"
(i.e. getting changes done in remote repository since laste "fetch"
or since "clone") followed by merge. pull = fetch + merge.

>>>So it sounds to me like git is extensible, though not as thoroughly as bzr.
>>
>>
>> I think having good API for C, shell and Perl (and to lesser extent for any
>> scripting language) means that it is extensible more.
> 
> I guess it's a value judgement on which is more important to extensibility:
> 
> Git has more language support.
> 
> Bzr has plugin autoloading, Protocol plugins, Repository format plugins,
> and more.  Because Python supports monkey-patching, a plugin can change
> absolutely anything.

Which is _not_ a good idea. Git is created in such way, that the repository
is abstracted away (introduction of pack format, and improving pack format
can and was done "behind the scenes", not changing any porcelanish (user)
commands), but we don't want any chage that would change this abstraction.
Changing repository format is not a good idea for "dumb" protocols; native
protocol is quite extensible (for example there was introduced multi-ack
extension for better downloading of multiple branches with lesser number
of object in the pack sent; even earlier there were intoduced thin packs),
and does a kind of feature detection between client and server. Adding
cURL based FTP read-only support to existing HTTP support was a matter
of few lines, if I remember correctly.

Besides, if monkey-patching is something akin to advices, I guess that
performance might suffer.


To make perhaps not that good analogy. In git adding new commands is
like adding new filesystem to Linux kernel using existing VFS interface,
or existing FUSE/LUFS interface. In Bazaar adding new command is like
writing new filesystem support (plugin) in mikrokernel like L4/Mach.
(And please take note for what project git was created for :-))

-- 
Jakub Narebski
ShadeHawk on #git
Poland
