From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] optionally disable gitattributes
Date: Wed, 27 Jan 2016 16:04:39 +0100
Message-ID: <56A8DC87.2080307@web.de>
References: <20160127095021.GA25281@ecki.hitronhub.home>
 <xmqqy4bb8c86.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Jan 27 16:05:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aORei-0002Yy-Rq
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 16:05:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933245AbcA0PFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 10:05:09 -0500
Received: from mout.web.de ([212.227.15.4]:60616 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933054AbcA0PFH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 10:05:07 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0Le4js-1Zjc863ZgS-00ptxa; Wed, 27 Jan 2016 16:04:42
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.1
In-Reply-To: <xmqqy4bb8c86.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:nkclTQ0jOWQUXZoXu1BwL6rIC3V8pTeuZk2d8FqwbPCv/0zFUGC
 w3dmfbfDaWnerxvVG3scjvVtDADdHCLJ3d/+4UTMmWWF2wyd1bzCkcbTwPjAz36b/k02xmy
 ZRuZSpQ8F/YNaIY5qlfTRuNQO4xrnASiuhAZcYvMDNMdgLA0XgZbSm8OIhEFL81jF4Ejcl5
 E3bsZhjj9IzAgZwyWluMw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:91UKdXjQr00=:Zq37duu3I9eq2FrcPnj1dq
 5XlPxNxWPfZwN9RjJAlgyA+L1lGbXtaKIiL3CkOuLjgEoXMJDNG+4j048qkZ40fMIDASFdPDH
 YzF2ndK96bzr8t9RurUh3Jyjx28B0tjRhpyf2aijmTzofHvVlSbtipqfRgJqi8xBP7d4GI6gJ
 H0Af03rHI37JZ4Jtx9lnumPhi6USH4/s3m4zWhuxQFHhA5O6MyBnYCsz59fysEut1dEnwoqmZ
 8WoighIvEuBiYCZPRhRPdOzeNzef2vMkwqGOW4tbtGzAlRigynJjXc6n+pp5yxRa7mktkr4NY
 L4SoMJhSmrDxOFDX/+qMvVqNGgsqwjBC5LE1moR+iKWvl7ocg5XHSng5Xd7v9EWBIjJ3Zy9fO
 HHBMs5/dmB8vnroTriSdHtmAQmujwnuhyxyZ6BFjPS6waMism7dw6ANSrhhfMJBROzU1cX/QY
 OJ8mD9GST5bx0eYsg8TBvmoWmJsuXeHHJkOIem8vKBTSN1t0v6zL47ci9VcqYqsiYlDPUrITz
 2YvzEeUUsdHZKH8bb3byy62xk1MDm3ZuwMq3VrddpSJee13XK3DDNbTG7ffiliJszP/eHAoqO
 uJyK9l3Z8T3zJmiGz498ifALvsp/9x5WdV54w+9ghV0igjHcE5UztYClECPc9c99YNWdfhm7T
 Vo2kXOfpuOgJmy8m3hDggBS0JV7b4EuWyfcfb4nknJQn7YGl5HDDRUAhqljL7ahFPdfntuZT0
 POeyQOuTQkUfiz3wZIvr+OQqPlYEnIg48U2y4+gNMVNrgky6I8u/YEi4KArrKHmr9yNYLMli 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284912>

On 27.01.16 12:59, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
>> If committed files are not normalized, adding gitattributes has the
>> side effect that such files are shown as modified, even though they
>> were not actually modified by the user, and the work tree matches
>> the committed file. This is because with gitattributes, the file is
>> modified on the fly when git reads it from disk, before it compares
>> with the index contents.
>>
>> This is desirable in most situations, because it makes the user
>> aware that files should be normalized. However, it can become an
>> issue for automation. Since Git considers the work tree to be
>> dirty, some operations such as git rebase or git cherry-pick refuse
>> to operate. Those commands offer no flag to force overwrite work
>> tree changes. The only options are to commit the changes, or to
>> remove gitattributes, but that changes the repository state, which
>> may be undesirable in a scripted context.
It feels like a workaround for something that could be fixable, or is already ongoing.
Before going into more details,
could you tell us which attributes you are typically using (when having this problems) ?
Is it
* text=auto
or
*.sh text 
or something else?


>>
>> Introduce an environment variable GIT_ATTRIBUTES_DISABLED, which if
>> set makes Git ignore any gitattributes.
>>
>> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
>> ---
> 
> Is the problem you are trying to solve related to the issue we
> discussed recently in a nearby thread?
It seems that I missed the thread ?
> 
> That is, even after "reset --hard", if the result of converting the
> contents in the index to the working tree representation and then
> converting that result back to the normalized representation does
> not match what is in the index, Git would sometimes say that the
> working tree contents differ from the index?
> 
> I think the change in this patch has some uses, and I think the
> issue we discussed recently in a nearby thread indeed is a problem,
> but I do not think there is an impedance mismatch beween the two, so
> I'd like to first make sure you are trying to solve the problem I
> think you are trying to solve.
