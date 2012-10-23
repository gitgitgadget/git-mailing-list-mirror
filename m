From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH] git-status: show short sequencer state
Date: Tue, 23 Oct 2012 14:03:07 -0400
Message-ID: <5086DBDB.9070606@cisco.com>
References: <1350948569-28445-2-git-send-email-hordp@cisco.com> <vpqsj95soxp.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "phil.hord@gmail.com" <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"konglu@minatec.inpg.fr" <konglu@minatec.inpg.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 23 20:03:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQip4-0002Au-Sc
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 20:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756777Ab2JWSDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 14:03:12 -0400
Received: from rcdn-iport-9.cisco.com ([173.37.86.80]:50071 "EHLO
	rcdn-iport-9.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756875Ab2JWSDK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 14:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4285; q=dns/txt; s=iport;
  t=1351015390; x=1352224990;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=IFB/l3y8DzxGzPo86L3tLbDLGQwPVR/dd4/bMDPRX18=;
  b=dpMqL1KcTTjKuHeA1kSFjNvJMcB6+cwxnbWACrY/eAW3pD6+ttQfRpV6
   27ZNxlPThayDHiShzlyFfUvOsE0uqCA4YmIMVwO+imHEboY0ntMFmzaQ7
   S5UZ7rrY7RQ6k7+R1nLkbFA7Pc3glqK6H+XW02ACT1jNN95L9QOzVlS0P
   Q=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EAFTbhlCtJXHB/2dsb2JhbABEwXCBCIIeAQEBAwESARRRAQULCxgJFg8JAwIBAgFFBg0BBQIBAR6HXAacC49ckDOSPQOVcYVkiGqBa4ML
X-IronPort-AV: E=Sophos;i="4.80,637,1344211200"; 
   d="scan'208";a="131566321"
Received: from rcdn-core2-6.cisco.com ([173.37.113.193])
  by rcdn-iport-9.cisco.com with ESMTP; 23 Oct 2012 18:03:09 +0000
Received: from [64.100.104.96] (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by rcdn-core2-6.cisco.com (8.14.5/8.14.5) with ESMTP id q9NI39Ax009667;
	Tue, 23 Oct 2012 18:03:09 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <vpqsj95soxp.fsf@grenoble-inp.fr>
X-Enigmail-Version: 1.4.5
X-TagToolbar-Keys: D20121023140306980
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208236>


Matthieu Moy wrote:
> Phil Hord <hordp@cisco.com> writes:
>
>> +	merge              a git-merge is in progress
>> +	am                 a git-am is in progress
>> +	rebase             a git-rebase is in progress
>> +	rebase-interactive a git-rebase--interactive is in progress
>> +	cherry-pick        a git-cherry-pick is in progress
>> +	bisect             a git-bisect is in progress
> Avoid using git-foo syntax in documentation, it suggests that this is
> valid command, which isn't true anymore. `git foo` seems the most common
> syntax. Also, git-rebase--interactive is not user-visible => `git rebase
> --interactive`.

Thanks. 

>> -	if (state->am_empty_patch)
>> +	if (state->substate==WT_SUBSTATE_NOMINAL)
>>  		status_printf_ln(s, color,
>>  			_("The current patch is empty."));
> This looks weird. First, spaces around == (here and below). Then, the
> logic is unintuitive. The "if" suggests everything is allright, and the
> message below is very specific. This at least deserves a comment.

Yes, I agree. It was less clear but more reasonable before I tried to
clear it up some.  It's driven by the short-token printer. The state is
"you're in a 'git am' but I do not see any conflicted files.  Therefore,
your patch must be empty."  I suspect this may be a leaving from the
git-am machinery where it did not choose to clean up after itself if the
patch was empty, but perhaps it should have.  I seldom use git-am, so I
do not know if this code reflects a common and useful state.

I'll try to make this more explicit.   Currently the short-status
version will say either "am" or "am \n conflicted" when a 'git am' is in
progress.  The logical path to follow if I re-add 'git-am-empty' state
tracker is for this to now show either "am \n am-is-empty" or "am \n
conflicted".  But I think I should suppress the "am-is-empty" report in
that case.  What do you think

>>  	if (advice_status_hints) {
>> -		if (!state->am_empty_patch)
>> +		if (state->substate==WT_SUBSTATE_CONFLICTED)
> Spaces around ==.
>
>> +static void wt_print_token(struct wt_status *s, const char *color, const char *token)
>> +{
>> +	color_fprintf(s->fp, color, "%s", token);
>> +	fputc(s->null_termination ? '\0' : '\n', s->fp);
>> +}
> The output format seems to be meant only for machine-consumption. Is
> there any case when we'd want color? I'd say we can disable coloring
> completely for this format (normally, color=auto does the right thing,
> but I prefer being 100% sure I'll get no color when writing scripts)

Originally I had this output nested in the normal 'git status --short'
output, like a shortened form of the "advice".  Then, 'git-status
--porcelain' would show the tokens without color, but 'git status
--short' would show them with color.  I thought I might be going back
there, or that I might combine this with full 'git status' again
somehow, and colors seemed appropriate still. 

The --short status report is too confusing when tokens may or may-not
appear, and it would likely break some scripts, even though they should
be using --porcelain.  And the full status already has its long versions
of the same text.   So I can remove this color decorator until someone
finds a need for it.

 
>> +static void wt_shortstatus_print_sequencer(struct wt_status *s)
> [...]
>> +void wt_sequencer_print(struct wt_status *s)
>> +{
>> +	wt_shortstatus_print_sequencer(s);
>> +}
>> +
> Why do you need this trivial wrapper?

Another left-over from its previous multiple versions. I'll simplify it.

> Other than that, I like the idea (although I have no concrete use-case
> in mind), but I didn't actually test the patch.

My own use-case involves $PS1. I keep running into "you cannot
cherry-pick because you are in the middle of a rebase" in submodules in
which I have long forgotten about the failed action and have gone on to
write many new commits, or switched branches, or worse.  I do not know
what 'git rebase --abort' will give me in those cases, and I wonder what
work I might have lost for having been interrupted in the middle of that
action in the past.  These tokens will help me decorate my prompt to
remind me I left some baggage untended.

Thanks for the feedback.

Phil
