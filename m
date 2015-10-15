From: Francois-Xavier Le Bail <devel.fx.lebail@orange.fr>
Subject: Re: How to rebase when some commit hashes are in some commit messages
Date: Thu, 15 Oct 2015 09:44:59 +0200
Message-ID: <561F597B.8090102@orange.fr>
References: <561C1132.3090606@orange.fr><vpqsi5fx2gr.fsf@grenoble-inp.fr><561CC5E0.7060206@orange.fr> <20151013160004.11a103942062ee09c53bd235@domain007.com> <AD64941D9533442AB025BE27FF8F08AF@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>,
	Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Thu Oct 15 09:52:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmdLE-0003LB-PO
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 09:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbbJOHwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 03:52:44 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:32176 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbbJOHwo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 03:52:44 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Oct 2015 03:52:43 EDT
Received: from [127.0.0.1] ([213.178.77.178])
	by mwinf5d29 with ME
	id VKkz1r00R3qpEb103Kl9ne; Thu, 15 Oct 2015 09:45:12 +0200
X-ME-Helo: [127.0.0.1]
X-ME-Auth: ZGV2ZWwuZngubGViYWlsQHdhbmFkb28uZnI=
X-ME-Date: Thu, 15 Oct 2015 09:45:12 +0200
X-ME-IP: 213.178.77.178
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <AD64941D9533442AB025BE27FF8F08AF@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279648>



On 13/10/2015 15:29, Philip Oakley wrote:
> From: "Konstantin Khomoutov" <kostix+git@007spb.ru>
>> On Tue, 13 Oct 2015 10:50:40 +0200
>> Francois-Xavier Le Bail <devel.fx.lebail@orange.fr> wrote:
>>
>>> >> For example, if I rebase the following commits, I would want that
>>> >> if the commit hash 2222222... become 7777777...,
>>> >> the message
>>> >> "Update test output for 2222222222222222222222222222222222222222"
>>> >> become
>>> >> "Update test output for 7777777..."
>>> >>
>>> >> Is it possible currently? And if yes how?
>>> >
>>> > AFAIK, it's not possible other than by editing the message by hand.
>>>
>>> It seems to me useful to be able to do it. Can we hope a new option?
>>
>> How do you think this could be practically implemented?
>>
>> A couple of things which immediately spring to my mind:
>>
>> To begin with, you are free to specify just a few first characters of
>> the commit name you're referring to.  So the alogrythm which finds the
>> relevant commits them has to be smart to somehow avoid misfires.  Or
>> have knobs to tune it (like -M of `git log`).
>>
>> OK, suppose that this is solved through the usage of some agreed-upon
>> keywords in the commit message.  Say, you adopt a policy to put
>> something like
>>
>>  X-Refers-To: 2dd8a9d9bb33ebffccb2ff516497adc8535bcab4
>>
>> in your commit message to make the finder tool happy.
>>
>> Now think how exactly it should work.  First, any commit at all might
>> mention the name of the target commit in its commit message.  Okay,
>> let's suppose there will be some way to somehow prune the possible DAG
>> down.  Then what happens if the commit to change is a part of the chain
>> of commits reachable from some branch other than that you're rebasing?
>> Automatically rebasing it would rewrite that commits and all commits
>> "after" it -- possibly resulting in what the "Recovering from upstream
>> rebase" part of the git-rebase(1) manual page deals with.
>>
>> Having said that, the feature you're after appears to me to be a
>> sensible thing to have but the possibility of its generic implementation
>> appears to be moot.
>>
>> Note that to deal with narrow simple cases (all possibly affected
>> commits leave on the same branch you're rebasing, and come later than
>> the rebase's anchor) you could write a script which uses `git log` to
>> find those commits which need special care.
> 
> My tuppence is that the only sha1's that could/would be rewritten would be those for the commits within the rebase. During rebasing it is expected that the user is re-adjusting things for later
> upstream consumption, with social controls and understandings with colleagues.
> 
> Thus the only sha1 numbers that could be used are those that are within the (possibly implied) instruction sheet (which will list the current sha1s that will be converted by rebase to new sha1's).

Yes.

> It should be clear that the sha1's are always backward references (because of the impossibility of including a forward reference to an as yet un-created future commit's sha1).
> 
> The key question (for me) is whether short sha1s are accepted, or if they must be full 40 char sha1's (perhaps an option). There are already options for making sure that short refs are not ambiguous.

I think full 40 sha1 is more secure to avoid confusion with previous or future sha1.

> It sound to me like a sensible small project for those that have such a workflow. I'm not sure if it should work with a patch based flow when submitting upstream - I'm a little fuzzy on how would the
> upstream maintainer know which sha1 referred to which patch.
> 
> Philip
