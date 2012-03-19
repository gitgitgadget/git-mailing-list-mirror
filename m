From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: [PATCH] rebase -i: remove CHERRY_PICK_HEAD when cherry-pick failed
Date: Mon, 19 Mar 2012 17:00:23 -0400
Message-ID: <4F679E67.4080708@sohovfx.com>
References: <CAMP44s1EAwHjQ7S2ArLvhNg5qkR05DRJ70tQmP8sXYdOP=i_zQ@mail.gmail.com> <1332106632-31882-1-git-send-email-andrew.kw.w@gmail.com> <7vk42gbkl1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 22:22:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9k2R-0000ne-K4
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 22:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028Ab2CSVWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 17:22:43 -0400
Received: from smtp04.beanfield.com ([76.9.193.173]:60022 "EHLO
	smtp04.beanfield.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502Ab2CSVWl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 17:22:41 -0400
X-Greylist: delayed 1329 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Mar 2012 17:22:41 EDT
X-Spam-Status: No
X-beanfield-mta04-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta04-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta04-MailScanner: Found to be clean
X-beanfield-mta04-MailScanner-ID: 1S9jgm-000Jgi-6X
Received: from [66.207.196.114] (helo=[192.168.1.112])
	by mta04.beanfield.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1S9jgm-000Jgi-6X; Mon, 19 Mar 2012 17:00:24 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101026 SUSE/3.0.10 Thunderbird/3.0.10
In-Reply-To: <7vk42gbkl1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193461>

On 03/19/2012 12:51 PM, Junio C Hamano wrote:
> Isn't the real solution *not* to create the CHERRY_PICK_HEAD in the
> sequencer when it is not know if it is needed, instead of the current code
> which seems to create first and then selectively try to unlink() it?
>   
I do agree that it's not pretty to create the file, then quickly delete
it. I did consider putting a condition around the code that creates
CHERRY_PICK_HEAD and REVERT_HEAD.

A possible condition would be checking the env var GIT_CHERRY_PICK_HELP,
which is only set if 'cherry-pick' is called under 'rebase -i'. I never
liked how we're passing in a help message using an env var, so I don't
feel like introducing another dependency on this env var is a good idea.

Another possible condition would be to add another flag to
"cherry-pick". But a proper implementation would not only involve adding
code to parse the flag in 'cherry-pick', but also adding code to
save/restore the option in sequencer, even though 'rebase -i' only need
it for single_pick. It's not that adding these codes are difficult, but
it seems like we're adding a lot of code just to add a behavior that
only 'rebase -i' needs.

Though if the additional flag in "cherry-pick" and additional option in
sequencer could be useful elsewhere, I could do it that way too.
