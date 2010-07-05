From: Eric Niebler <eric@boostpro.com>
Subject: Re: help moving boost.org to git
Date: Mon, 05 Jul 2010 19:11:10 -0400
Message-ID: <4C32668E.9040000@boostpro.com>
References: <4C31E944.30801@boostpro.com> <20100705220443.GA23727@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 06 01:11:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVuov-0005Ap-FO
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 01:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988Ab0GEXLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 19:11:19 -0400
Received: from boostpro.com ([206.217.198.21]:57992 "EHLO boostpro.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752938Ab0GEXLS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 19:11:18 -0400
Received: from [192.168.2.114] (c-76-118-178-34.hsd1.ma.comcast.net [76.118.178.34])
	(Authenticated sender: eric)
	by boostpro.com (Postfix) with ESMTPSA id D90A014A007
	for <git@vger.kernel.org>; Tue,  6 Jul 2010 00:11:16 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.10) Gecko/20100512 Lightning/1.0b1 Thunderbird/3.0.5
In-Reply-To: <20100705220443.GA23727@pvv.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150300>

On 7/5/2010 6:04 PM, Finn Arne Gangstad wrote:
> On Mon, Jul 05, 2010 at 10:16:36AM -0400, Eric Niebler wrote:
>> I have a question about the best approach to take for refactoring a
>> large svn project into git. The project, boost.org, is a collection of
>> C++ libraries (>100) that are mostly independent. (There may be
>> cross-library dependencies, but we plan to handle that at a higher
>> level.) After the move to git, we'd like each library to be in its own
>> git repository. Boost can then be a stitching-together of these, using
>> submodules or something (opinions welcome). It's an old project with
>> lots of history that we don't want to lose. The naive approach of simply
>> forking into N repositories for the N libraries and deleting the
>> unwanted files in each is unworkable because we'll end up with all the
>> history duplicated everywhere ... >100 repositories, each larger than 100Mb.
> 
> If the libraries are not independent (i.e. some commits are across
> multiple libraries), submodules will give you some interesting
> challenges to put it mildly.

You have correctly assessed the situation. There *are* cross-library
commits in our history. What are the implications of this for
modularlization?

> The current boost 1.43 is 29344 files, is this all there is? 

Yes.

> This
> should fit eaily into a single repository. The Linux kernel is much
> larger, and that is sort of the canonical single repo git project. I
> _strongly_ recommend that you go for a single repo if you can make it
> work.

It does fit into one repo, but that doesn't meet our needs for the
future. Users want to install and build library X and its dependencies,
not all of boost. This is increasingly becoming a problem as boost
grows. Imagine if a perl programmer had to download all of CPAN to use
or hack on any one perl module. Or if contributing to CPAN meant getting
the whole shebang, history and all. I'm sure even in the Linux kernel,
not *every* third-party driver is maintained in the master git repo.

We are aiming to make boost a clearing-house for C++ libraries (like
CPAN, or PyPi for python), turning the official boost distribution into
little more than a well-tested collection of the libraries that have
passed our peer-review and regression test process.

In fact, the modularization has already been done, and work is well
underway on the infrastructure to support dependency tracking. But the
modularization is not history-preserving and needs to be redone.

> If you manage to create a single git repo with the history you want,
> it is trivial to split out separate repositories of subdirectories
> later (and those repos will then be comparatively small). git subtree
> allegedly automates this process more or less (I have not used it, but
> have heard good things about it). What about having a single "master
> repository", and then using subtree to create single-library repos for
> the library developers if they want a smaller repo to play around in?

This sounds like it might be ok, but I need to research it.

>> So,, what are the options? Can I somehow delete from each repository the
>> history that is irrelevant? Is these some feature of git I don't know
>> about that can solve this problem for us?
> 
> How do you define "irrelevant"? Do you only require enough history for
> git annotate/blame to give correct results?  Or does this only refer
> to multiple repositories sharing the same ancient history?

If multiple repositories share the same ancient history, wouldn't that
give git annotate/blame enough information? Sorry, git newbie here.

>> At boost, We've already discussed a few possible approaches. Feel free
>> to comment and/or criticize any of the solutions suggested here:
>>
>>   http://github.com/ryppl/ryppl/issues#issue/4
> 
> It is unclear from the discussion if you will change to git, or use
> git in addition to svn? This will have some impact on how to go about
> this.

The plan is to move to git. However, we don't expect this to happen
overnight, so a way to continue to pull changes from a svn mirror while
the new git repositories are being set up would be ideal.

-- 
Eric Niebler
BoostPro Computing
http://www.boostpro.com
