From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Publishing "filtered branch repositories" - workflow / recommendations?
Date: Wed, 11 Dec 2013 23:03:16 +0100
Message-ID: <52A8E124.4000002@web.de>
References: <CACPiFCJPq0fqOQrJD-8CHH405Xw61ZDynqqfN+_aZb3ZBgV2VA@mail.gmail.com>	<52A0D199.1010403@web.de>	<CACPiFCKHprB_oO_eXMYkey_CGbT7WOn5VDDjBdHbLRzcDpHnZw@mail.gmail.com>	<52A0D9F5.3030101@web.de>	<CACPiFCJ3mkOj=E+siideBpPfgS1tSicVQ46KqPK+Tha0DbkZHw@mail.gmail.com>	<52A18F69.70002@web.de>	<CACPiFCJ5hCPvRHB1knvMocN0XdHfSMpbZnqjf7yHAT4mMOSfzw@mail.gmail.com>	<20131209225950.GG9606@sandbox-ub> <xmqqhaahvas2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Dec 11 23:03:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqrsN-0005ke-OA
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 23:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191Ab3LKWDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 17:03:23 -0500
Received: from mout.web.de ([212.227.15.4]:54822 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030Ab3LKWDW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 17:03:22 -0500
Received: from [192.168.178.41] ([84.132.161.19]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0LZvUH-1V7t0G11Vl-00lnir for <git@vger.kernel.org>;
 Wed, 11 Dec 2013 23:03:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <xmqqhaahvas2.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:VtQZ6dNjJSidLeXzlPp9N4Xuroi2poEgnmqz6uHVYuXFoBBf0g/
 mv1iRdJ196z3TQTIFG32D++8dMGaHdJGiK5gV78BqP9SxuW1Ina/s0FnRqojG3OAMmt5pvG
 VQS3d8FNCtJu1vhjW6dH+3WOJXJo6DJYwvrSddy8vlzv0lJdyijJ3YDq6Ey0bbcdugGPDSg
 n3+7eJ6IJ3kOBBnjP1viA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239212>

Am 10.12.2013 00:56, schrieb Junio C Hamano:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
>> On Fri, Dec 06, 2013 at 02:40:15PM -0500, Martin Langhoff wrote:
>>> On Fri, Dec 6, 2013 at 3:48 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>>> Right you are, we need tutorials for the most prominent use cases.
>>>
>>> In the meantime, are there any hints? Emails on this list showing a
>>> current "smart" workflow? Blog posts? Notes on a wiki?
>>
>> None that I know of mainly because we have not yet reached the goal we
>> are aiming at. Maybe we should write something, A few points from
>> $dayjob that come to my mind:
>>
>>   * A submodule commit is only allowed to be merged into master in a
>>     superproject commit if it is merged into master (or a stable branch)
>>     in the submodule. That way you ensure that any submodules commits
>>     that are tracked in a superproject are contained in each other and
>>     can be cleanly merged. (no rewinds, one commit contains the other)
> 
> I think this is closely related to Martin's list of wishes we
> earlier saw in the thread: remind the user to push necessary
> submodule tip before the top-level commit that needs that commit in
> the submodule is pushed out.  Giving projects a way to implement
> such a policy decision would be good, and having a default policy,
> if we can find one that would be reasonable for any submodule users,
> would be even better.  Would adding a generic pre-push hook at the
> top-level sufficient for that kind of thing, I have to wonder.

That could call "git push --dry-run --recurse-submodules=check" to
deny the push if the submodule commit isn't on a remote branch. But
that would only work for a single hardcoded remote, as the remote
itself does not seem to be passed to the pre-push hook.

So me thinks adding a configuration option for the --recurse-submodule
option of push is the best way to achieve that. This could be set to
"check" for those who want to push the submodule manually and to
"on-demand" for those who would like to push automatically. And with
that option the user could configure push just like he already can do
for fetch and pull.
