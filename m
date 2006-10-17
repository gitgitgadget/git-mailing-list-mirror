From: Andreas Ericsson <ae@op5.se>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 10:16:34 +0200
Message-ID: <45349162.90001@op5.se>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca> <200610170119.09066.jnareb@gmail.com> <45346290.6050300@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 10:16:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZk7u-00024Z-TQ
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 10:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422777AbWJQIQj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 04:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422782AbWJQIQj
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 04:16:39 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:7140 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1422777AbWJQIQh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 04:16:37 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 6E3A06BDE1; Tue, 17 Oct 2006 10:16:36 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id BB2BE6BCEC; Tue, 17 Oct 2006 10:16:34 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <45346290.6050300@utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29032>

Aaron Bentley wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Jakub Narebski wrote:
>> Well, <ref>~<n> means <n>-th _parent_ of a given ref, which for branches
>> (which constantly change) is a moving target.
> 
> Ah.  Bazaar uses negative numbers to refer to <n>th parents, and
> positive numbers to refer to the number of commits that have been made
> since the branch was initialized.
> 

What do you do once a branch has been thrown away, or has had 20 other 
branches merged into it? Does the offset-number change for the revision 
then, or do you track branch-points explicitly?

>> One cannot have universally valid revision numbers (even
>> only per branch) in distributed development. Subversion can do that only
>> because it is centralized SCM. Global numbering and distributed nature
>> doesn't mix... hence contents based sha1 as commit identifiers.
> 
> Sure.  Our UI approach is that unique identifiers can usefully be
> abstracted away with a combination of URL + number, in the vast majority
> of cases.
> 
>> But this doesn't matter much, because you can have really lightweight
>> tags in git (especially now with packed refs support). So you can have
>> the namespace you want.
> 
> The nice thing about revision numbers is that they're implicit-- no one
> needs to take any action to update them, and so you can always use them.
> 
>> I wonder if any SCM other than git has easy way to "rebase" a branch,
>> i.e. cut branch at branching point, and transplant it to the tip
>> of other branch. For example you work on 'xx/topic' topic branch,
>> and want to have changes in those branch but applied to current work,
>> not to the version some time ago when you have started working on
>> said feature.
> 
> If I understand correctly, in Bazaar, you'd just merge the current work
> into 'xx/topic'.
> 

merge != rebase though, although they are indeed similar. Let's take the 
example of a 'master' branch and topic branch topicA. If you rebase 
topicA onto 'master', development will appear to have been serial. If 
you instead merge them, it will either register as a real merge or, if 
the branch tip of 'master' is the branch start-point of topicA, it will 
result in a "fast-forward" where 'master' is just updated to the 
branch-tip of 'topicA'.

>> What your comparison matrick lacks for example is if given SCM
>> saves information about branching point and merges, so you can
>> get where two branches diverged, and when one branch was merged into
>> another.
> 
> I'm not sure what you mean about divergence.  For example, Bazaar
> records the complete ancestry of each branch, and determining the point
> of divergence is as simple as finding the last common ancestor.  But are
> you considering only the initial divergence?  Or if the branches merge
> and then diverge again, would you consider that the point of divergence?
> 
> merge-point tracking is a prerequisite for Smart Merge, which does
> appear on our matrix.
> 
>> Plugins = API + detection ifrastructure + loading on demand.
>> Git has API, has a kind of detection ifrastructure (for commands and
>> merge strategies only), doesn't have loading on demand. You can
>> easily provide new commands (thanks to git wrapper) and new merge
>> strategies.
> 
> I'm not sure what you mean by API, unless you mean the commandline.  If
> that's what you mean, surely all unix commands are extensible in that
> regard.
> 

I'm fairly certain he's talking about the API in the sense it's being 
talked about in every other application. Extensive work has been made to 
libify a lot of the git code, which means that most git commands are 
made up of less than 400 lines of C code, where roughly 80% of the code 
is command-specific (i.e., argument parsing and presentation).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
