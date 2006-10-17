From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 23:01:26 +0200
Message-ID: <200610172301.27101.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <45349162.90001@op5.se> <453536AE.6060601@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 23:01:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZw3b-0002YF-Kt
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 23:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWJQVBA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 17:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWJQVBA
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 17:01:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:26931 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750824AbWJQVA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 17:00:58 -0400
Received: by ug-out-1314.google.com with SMTP id o38so43391ugd
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 14:00:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FNGz4TSbOFj2+6z9HC3q4sNxsFL5+p/0uMp2mjmMyeWFZJH2R3WfdQ5xf1Fkyv0/YHfAokYKJTo//L7HLXZz1ahrhRDJKSS7Jk/14cRXCdZlztdL29/uE72BmgCoVny+2dCLVW9+rCRvojWOmdq9/CNNkkeeHvMCRU+Sg0HTnVA=
Received: by 10.67.97.7 with SMTP id z7mr10532749ugl;
        Tue, 17 Oct 2006 14:00:56 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id 13sm120744ugb.2006.10.17.14.00.55;
        Tue, 17 Oct 2006 14:00:55 -0700 (PDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <453536AE.6060601@utoronto.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29115>

Aaron Bentley wrote:
> Andreas Ericsson wrote:
>> Aaron Bentley wrote:
>>> Ah.  Bazaar uses negative numbers to refer to <n>th parents, and
>>> positive numbers to refer to the number of commits that have been made
>>> since the branch was initialized.
>>>
>>
>> What do you do once a branch has been thrown away, or has had 20 other
>> branches merged into it? Does the offset-number change for the revision
>> then, or do you track branch-points explicitly?
> 
> We always track the number of parents since the initial commit in the
> project.  Sorry, I don't think I said that clearly before.

While this I think is quite reliable (there was idea to store "generation
number" with each commit, e.g. using not implemented "note" header, or
commit-id to generation number "database" as a better heuristic than
timestamp for revision ordering in git-rev-list output), and probably
independent on repository (it is global property of commit history,
and commit history is included in sha1 of its parents), numbering branching
points is unreliable, as is relying on branch names.
 
>>> If I understand correctly, in Bazaar, you'd just merge the current work
>>> into 'xx/topic'.
>>>
>>
>> merge != rebase though, although they are indeed similar. Let's take the
>> example of a 'master' branch and topic branch topicA. If you rebase
>> topicA onto 'master', development will appear to have been serial.
> 
> Ah, now I see what you mean, and the "graft" plugin mentioned by others
> fills that role.  I've never used it, though.

Very useful as a kind of poor-man's-Quilt (or StGit). You develop some
feature step by step, commit by commit in your repository cooking it
in topic branch. Then before sending it to mailing list or maintainer
as a series of patches (using git-format-patch and git-send-email)
you rebase it on top of current work (current state), to ensure that
it would apply cleanly.
 
>> If
>> you instead merge them, it will either register as a real merge or, if
>> the branch tip of 'master' is the branch start-point of topicA, it will
>> result in a "fast-forward" where 'master' is just updated to the
>> branch-tip of 'topicA'.
> 
> Interesting.  We don't do 'fast-forward' in that case.

Fast-forward is a really good idea. Perhaps you could implement it,
if it is not hidden under different name?
 
>>> I'm not sure what you mean by API, unless you mean the commandline.  If
>>> that's what you mean, surely all unix commands are extensible in that
>>> regard.
>>>
>>
>> I'm fairly certain he's talking about the API in the sense it's being
>> talked about in every other application. Extensive work has been made to
>> libify a lot of the git code, which means that most git commands are
>> made up of less than 400 lines of C code, where roughly 80% of the code
>> is command-specific (i.e., argument parsing and presentation).
> 
> Ah, okay.
> 
> So it sounds to me like git is extensible, though not as thoroughly as bzr.

I think having good API for C, shell and Perl (and to lesser extent for any
scripting language) means that it is extensible more. Git is not as of yet
libified; when it would be we could think about bindings for other
programming languages (there is preliminary Java binding/interface).
-- 
Jakub Narebski
Poland
