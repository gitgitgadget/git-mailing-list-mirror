From: David Lang <david.lang@digitalinsight.com>
Subject: Re: Weird shallow-tree conversion state, and branches of  shallowtrees
Date: Tue, 17 Apr 2007 12:50:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704171250120.1696@qynat.qvtvafvgr.pbz>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net><2007041520
 51.35639.andyparkins@gmail.com>  <Pine.LNX.4.64.0704151317180.5473@woody.linux-foundation.org><200704161003.
 07679.andyparkins@gmail.com> <Pine.LNX.4.64.0704160814300.5473@woody.linux-foundation.org>
 <Pine.LNX.4.63.0704161528130.30610@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 22:23:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HduCb-0005bL-UL
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 22:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161232AbXDQUW6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 16:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161260AbXDQUW6
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 16:22:58 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:45307 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1161232AbXDQUW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 16:22:57 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Tue, 17 Apr 2007 13:22:57 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 17 Apr 2007 13:22:51 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.63.0704161528130.30610@qynat.qvtvafvgr.pbz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44816>

sorry for the re-send, I didn't see this go through the list and it's relavent 
to the current discussion

On Mon, 16 Apr 2007, David Lang wrote:

> Date: Mon, 16 Apr 2007 16:25:37 -0700 (PDT)
> 
> I have a different situation where I'm interested in keyword expansions, and 
> am waiting for the appropriate hooks to be added to git to allow be to use 
> it.
>
> I have a bunch of config files on different servers that are logicly 
> equivalent, even though they have different values in some fields there is a 
> translation table in my software that tells it what to do.
>
> I'd really like to have a version control repository that I can 
> share/more/replicate across the machines. to do this on checkin the software 
> would need to run my helper to create a 'generic' version and check that in. 
> on checkout it would need to run my helper to take the generic version and 
> make the host specific version.
>
> a lot of the problems taht you refer to in your message apply to most of the 
> things that have been discussed related to gitattributes.
>
> if improperly used it can corrupt the data (either by the checkin/checkout 
> munging or inappropriately merging things)
>
> it breaks the 1-1 coorespondance between the packed version and the checked 
> out version.
>
> On Mon, 16 Apr 2007, Linus Torvalds wrote:
>
>> On Mon, 16 Apr 2007, Andy Parkins wrote:
>> 
>> [ Ok, take a break here, and think about why "keyword expansion" might be
>>  a problem for "git rebase" in a way that CRLF is not, before you read on ]
>> 
>> Hint: the reason statefulness is broken for things like "git rebase" is
>> that the natural operation for something like that is to generate a patch,
>> and carry it forward. Now, what is in the patch? Keywords. Will the patch
>> apply to the target? Yes? No?
>
> if you send a patch, that patch needs to be relative to the connonical 
> version, namely what's checked into the SCM. if your patch includes keywords 
> it won't apply cleanly to a checked-out of the file. any mergeing and merge 
> resolution needs to be based on the connonical version (i.e. one that doesn't 
> go through the checkin/out conversion)
>
>> See? Keywords means that you suddenly have merge problems with something
>> as simple as patches. Does this matter in CVS? Not often. CVS is so
>> limited that you cannot much do those operations anyway, but if you've
>> ever done a merge in CVS, keyword expansion tends to be one of the things
>> that just make it more complicated. So now you have to remember flags like
>> like "-kk" that disable keywords.
>
> I don't think the problems with patches are insurmountable. if everyone in 
> the project is useing git then you don't have to worry about anything, things 
> will just work (except for manually fixing failed merges)
>
> I would definantly agree that sprinkling a little of this into a large 
> project is going to massivly confuse people
>
>> Or what about generating a diff between two branches? Keywords are a total
>> *nightmare*. Do you realize just how *fast* git is in diff generation.
>> Have you ever done "cvs diff"? Have you ever *thought* about how git can
>> be so fast? Hint: we don't even *look* at the contents for most files. But
>> if the content is "generated" depending on history, you just screwed that
>> up too.
>
> you do a diff of the connonical files in the repository, the same way you do 
> today.
>
>> Or what about something as seemingly unrelated as "git grep". You may not
>> even *realize* how nasty a problem it is when you have two different
>> representations of the same data: one that has keywords in it and is
>> checked out, and one that does not. Which one should you choose? Which one
>> is the right one? What about the git optimization of using the checked-out
>> data because it doesn't need any unpacking?
>
> the one with the keywords is the one to choose. and you suffer a performance 
> hit becouse you can't use the checked-out version (without running it through 
> the conversion, which is a performance hit itslef)
>
>> And the whole keyword issue gets *worse* when you move between
>> repositories. If you stay "inside" the SCM, you can generally teach it to
>> ignore them. For example, going back to the "git rebase" example (or the
>> "git grep" one, for that matter), you can just define that it's done
>> without keyword expansion.
>
> right, this would avoid most of the problems
>
>> But when you move the data between people? That's exactly where keyword
>> expansion is enabled, and now you not only make things like "git diff"
>> fundamentally broken and much much slower (in fact, it *cannot*work* in
>> the git model, because we don't even *have* tree history, so you cannot
>> add keywords to a tree!), you also guarantee that the end result is much
>> less useful, because now when you send the patch to others, they'll have
>> all the same issues that you had to work around locally.
>
> why would you do keyword expansion when moving the files between different 
> people's repositories? or is that still considered 'inside the SCM'?
>
>> I don't know if I can convince you, but take it from me, keyword expansion
>> is fundamentally broken in the first place, but it's *more* so with git
>> than with CVS, for example.
>> 
>> In CVS, the reason you can do keyword expansion in the first place is:
>> 
>> - it's file-based to begin with. A file actually *has* history in CVS, in
>>   a way it fundmanentally does *not* have in git. So when you generate a
>>   diff on a file, the revision information is "just there". That's simply
>>   not true in git. There *is* no per-file revision information. You
>>   cannot know who touched the file last, for example, without starting
>>   from a commit, and doing very expensive things.
>
> this is a valid argument against the keyword being a version string. it's not 
> nessasarily relavent to other uses.
>
>> - it's slow to begin with. This is related to the above thing: exactly
>>   because CVS is file-based and not content-based, when you do things
>>   like "cvs diff" you will walk files individually anyway. People
>>   *accept* (and I cannot imagine why) that an empty "cvs diff" on some
>>   big project will take minutes. And the problems aren't even about
>>   keyword expansion - keyword expansion is just a small detail.
>
> if you define the keyword to be equivalent there is no need to look at the 
> content of all the files.
>
>> - it's centralized in more ways than one. You are simply not expected to
>>   work by applying patches between two unrelated CVS trees. It's not
>>   done. It cannot work. The closest you get is
>> 	(a) merging. Which is *hell*. Again, keyword expansion is just a
>> 	    small detail in why it's hell, and people don't generally pick
>> 	    it up exactly because the merge problems are so much bigger.
>> 	(b) applying patches from the outside from people who do *not* use
>> 	    CVS, and thus don't generally touch things around the
>> 	    keywords (but even here, you actually end up having problems
>> 	    occasionally).
>
> external patches could be a problem, but there are two ways to deal with 
> them.
>
> 1. have the patch be against the version of the file with the keywords 
> expanded, and have the result checked in (collapsing the keywords)
>
> 2. have the patch be against the version of the file with the keywords 
> collapsed. this _would_ require the ability to bypass the expansion of the 
> keywords and is not something you would want to do very much.
>
> of these two, I suspect that #1 would make sense in most cases, and should be 
> the default.
>
>> I'll finish off trying to explain the problem in fundamental git terms:
>> say you have a repository with two branches, A and B, and different
>> history  on a file "xyzzy" in those two branches, but because they both
>> ended up applying the same patches, the actual file contents do end up
>> being 100% identical. So they have the same SHA1.
>> 
>> What is
>>
>> 	git diff A..B -- xyzzy
>> 
>> supposed to print?
>> 
>> And *I* claim that if you don't get an immediate and empty diff, your
>> system is TOTALLY BROKEN.
>
> I agree, and what I've been talking about above would produce exactly this.
>
>> And now think about what keywords do. And realize that keywords are
>> TOTALLY BROKEN!
>
> it may be that we are thinking of different things when we use the term 
> 'keywords', and that may be why we are seeing different levels of problems.
>
> David Lang
>
