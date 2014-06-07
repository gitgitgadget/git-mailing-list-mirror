From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Reset by checkout?
Date: Sat, 7 Jun 2014 15:52:58 +0100
Organization: OPDS
Message-ID: <241E3E5EB7AE44E6821EA5DFAA24C28F@PhilipOakley>
References: <20140601132624.821C.B013761@chejz.com> <538AE814.2010407@bracey.fi> <20140607135439.7893.B013761@chejz.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Atsushi Nakagawa" <atnak@chejz.com>,
	"Kevin Bracey" <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Sat Jun 07 16:53:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtHzY-0005p7-3p
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 16:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbaFGOxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2014 10:53:03 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:58196 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752707AbaFGOxB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jun 2014 10:53:01 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmEXAOImk1MCYJr+/2dsb2JhbABZgw1SE4htu10FAQIBAQx3F3WDfgUBAQUIAQEuHgEBHAULAgMFAgEDDgcDCSUUAQQaBgcXBgESCAIBAgMBiDUJtS6YBhMEjmw1gn2BFgSEYAKFFoZSnRyDPTw
X-IPAS-Result: AmEXAOImk1MCYJr+/2dsb2JhbABZgw1SE4htu10FAQIBAQx3F3WDfgUBAQUIAQEuHgEBHAULAgMFAgEDDgcDCSUUAQQaBgcXBgESCAIBAgMBiDUJtS6YBhMEjmw1gn2BFgSEYAKFFoZSnRyDPTw
X-IronPort-AV: E=Sophos;i="4.98,994,1392163200"; 
   d="scan'208";a="485367881"
Received: from host-2-96-154-254.as13285.net (HELO PhilipOakley) ([2.96.154.254])
  by out1.ip03ir2.opaltelecom.net with SMTP; 07 Jun 2014 15:52:59 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251043>

From: "Atsushi Nakagawa" <atnak@chejz.com>
> Kevin Bracey <kevin@bracey.fi> wrote:
>> On 01/06/2014 07:26, Atsushi Nakagawa wrote:
>> > Kevin Bracey <kevin@bracey.fi> wrote:
>> >> The original "git reset --hard" used to be a pretty top-level 
>> >> command.
>> >> It was used for aborting merges in particular. But I think it now
>> >> stands out as being one of the only really dangerous porcelain
>> >> commands, and I can't think of any real workflow it's still useful
>> >> for.
>> > My thoughts exactly.  I think the 'reset --soft/--mixed/--hard' 
>> > pattern
>> > is so ingrained, that many people just don't realize there's a 
>> > safer
>> > alternative.  (I've heard work mates on more than one occasion
>> > recommending 'reset --hard' as the go-to command for discarding 
>> > commits.)
>> >
>> > I believe this is likely because many third party GUI tools just 
>> > don't
>> > support 'reset --keep', and these tools present a "Reset..." dialog 
>> > with
>> > the de facto Soft/Mixed/Hard options.  (Even 'gitk' does this.)
>> True on the GUI - "hard" really needs demotion.
>>
>> It would help if the documentation explained better straight off what
>> the different reset modes are intended /for/ in a more practical way,
>> rather than the technical jargon.
>
> On one hand, I agree that improving man git-reset and making it easier
> to understand would be of benefit.
>
> However, one of the main culprits of confusion here seems to be the 
> mere
> existance of '--keep', which is somewhat of a conceptual black sheep.
>
> The --soft/--mixed/--hard trio seems quite easy to explain, /if/ you
> didn't need to also explain --keep...
>
> To that end, I'm wondering if it's better to just deprecate 'reset
> --keep' and shift the use-case over to 'checkout':
>
> checkout [-u|--update] [<commit>|<branch>]
>
> -u
> --update
>    Rather than checking out a branch to work on it, check out a commit
>    and reset the current branch to that commit.
>
>    This is functionally equivalent to 'checkout -B CURRENT_BRANCH 
> <commit>'.
>
>    (...Maybe a warning here about commits becoming unreachable...)
>
>
> Then, as an added bonus, anything I've staged is kept intact.  *And*, 
> I
> can attempt 'checkout -u --merge' if I'm feeling particulary careless.
>
>> --hard
>>     All [] changes are dropped[] and the [working tree] and index are
>>     forcibly reset to the [state of <commit>].  Note that this is
>>     dangerous if used carelessly.  ALL uncommitted changes to ALL
>>     tracked files will be lost[].
>>
>>     Older documentation often recommends "git reset --hard" to
>>     undo commits; the newer "--keep" option is [safer and is now the
>>     recommended] alternative [for use in this situation].
>
> I like this explaination of '--hard' and prefer it over current, which
> doesn't much explain the gravity of the command.  I've made some edits
> above.
>
>> --merge
>>     Performs the operation of "git merge --abort", intended for use
>>     during a merge resolution - see git-merge(1) for more 
>> information.
>>     This form is not normally used directly.
>
> Aha, so that's what that's for.  I couldn't really understand the
> explanation in the current manpage, but your version at least tells me
> that it's an option I don't need to worry about.
>

Just to say there has been a similar confusion about 'git reset' 
reported on the Git Users group for the case of reset with added 
(staged), but uncommitted changes being wiped out, which simlarly 
reports on the difficulty of explaining some of the conditions 
especially when some are wrong ;-)

 https://groups.google.com/forum/#!topic/git-users/27_FxIV_100


--
Philip 
