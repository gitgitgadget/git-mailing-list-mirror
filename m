From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH 1/2] sequencer: trivial fix
Date: Wed, 29 May 2013 11:58:03 +0200
Message-ID: <ko4jf7$e4d$1@ger.gmane.org>
References: <1369673539-28692-1-git-send-email-felipe.contreras@gmail.com> <1369673539-28692-2-git-send-email-felipe.contreras@gmail.com> <20130528110014.GA1264@hmsreliant.think-freely.org> <7vobbv2fze.fsf@alter.siamese.dyndns.org> <51a568db9c9b8_807b33e18996fa@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 11:58:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhd9E-0008Dp-Ce
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 11:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965427Ab3E2J6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 05:58:20 -0400
Received: from plane.gmane.org ([80.91.229.3]:44085 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965205Ab3E2J6T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 05:58:19 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Uhd98-00087F-2G
	for git@vger.kernel.org; Wed, 29 May 2013 11:58:18 +0200
Received: from dsdf-4db5271a.pool.mediaways.net ([77.181.39.26])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 May 2013 11:58:18 +0200
Received: from jojo by dsdf-4db5271a.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 May 2013 11:58:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db5271a.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225782>

Felipe Contreras wrote:
> Junio C Hamano wrote:
>> Neil Horman <nhorman@tuxdriver.com> writes:
>>
>>> On Mon, May 27, 2013 at 11:52:18AM -0500, Felipe Contreras wrote:
>>>> We should free objects before leaving.
>>>>
>>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>>> ---
>>>>  sequencer.c | 7 +++++--
>>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/sequencer.c b/sequencer.c
>>>> index ab6f8a7..7eeae2f 100644
>>>> --- a/sequencer.c
>>>> +++ b/sequencer.c
>>>> @@ -626,12 +626,15 @@ static int do_pick_commit(struct commit
>>>>  *commit, struct replay_opts *opts)
>>>>  rerere(opts->allow_rerere_auto); } else {
>>>>  int allow = allow_empty(opts, commit);
>>>> - if (allow < 0)
>>>> - return allow;
>>>> + if (allow < 0) {
>>>> + res = allow;
>>>> + goto leave;
>>>> + }
>>>>  if (!opts->no_commit)
>>>>  res = run_git_commit(defmsg, opts, allow);
>>>>  }
>>>>
>>>> +leave:
>>>>  free_message(&msg);
>>>>  free(defmsg);
>>>>
>>>> --
>>>> 1.8.3.rc3.312.g47657de
>>>>
>>>>
>>> Acked-by: Neil Horman <nhorman@tuxdriver.com>
>>
>> This is better done without "goto" in general.
>>
>> The other patch 2/2/ adds one more "we need to exit from the middle
>> of the flow" and makes it look handier to add an exit label here,
>> but it would be even better to express the logic of that patch as a
>> normal cascade of if/else if/..., which is small enough and we do
>> not need the "leave:" label.
>
> Linux kernel developers would disagree. In C 'goto' is quite of then
> the only sane option, and you can see 'goto' used in the Linux kernel
> all over the place for that reason.
>
> In this particular case it also makes perfect sense.
>
>> It probably is better to fold this patch into the other one when it
>> is rerolled to correct the option name gotcha "on the tin".
>
> Why? This patch is standalone and fixes an issue that is independent
> of the other patch. Why squash two patches that do *two* different
> things?
>
> Anyway, I'll happily drop this patch if you want this memory leak to
> remain. But then I'll do the same in the other patch.
>
> This mantra of avodiing 'goto' is not helping anybody.

adding 5 letters (to change the next "if" into an "else if") versus your 
addition of several lines and some 15 additional letters (ignoring the 
whitsspace)  is IMHO enough to see what is better?

bye, Jojo 
