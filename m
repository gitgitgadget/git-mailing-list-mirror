From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] [submodule] Add depth to submodule update
Date: Thu, 27 Jun 2013 16:54:45 +0200
Message-ID: <51CC5235.6030908@web.de>
References: <1371974698-28685-1-git-send-email-iveqy@iveqy.com> <20130624224925.GC32270@paksenarrion.iveqy.com> <20130625221132.GB4161@sandbox-ub> <20130626160219.GC9141@paksenarrion.iveqy.com> <7vli5wvb3n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 16:55:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsDbL-0000l2-Dx
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 16:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753755Ab3F0OzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 10:55:03 -0400
Received: from mout.web.de ([212.227.17.11]:51534 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753744Ab3F0OzA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 10:55:00 -0400
Received: from [192.168.178.41] ([79.193.82.142]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0McFQF-1UaHN81YW7-00JdD3; Thu, 27 Jun 2013 16:54:50
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <7vli5wvb3n.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V03:K0:2yQzizIBViowxITQJ/jy3ArGTfUGGmkGN7a4HeulzAhQpw6L5pD
 otuenZCwM9fl1lSCeBsAzOSYsigCT/VYunqx7wAaSeDcvEg4soi2aoXK2orhTPwlOl8R9lV
 mfTj1XHYJL2U4m33HE6C5o/65LB3AO0WAgU/iup9H/cVQ/34Zc2+Z+e2dIFaSGMyVjHhqDq
 tdgt5H+6QcdHsyOsYdzVg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229108>

Am 26.06.2013 23:03, schrieb Junio C Hamano:
> Fredrik Gustafsson <iveqy@iveqy.com> writes:
> 
>> On Wed, Jun 26, 2013 at 12:11:32AM +0200, Heiko Voigt wrote:
>>> On Tue, Jun 25, 2013 at 12:49:25AM +0200, Fredrik Gustafsson wrote:
>>>> Used only when a clone is initialized. This is useful when the submodule(s)
>>>> are huge and you're not really interested in anything but the latest commit.
>>>>
>>>> Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
>>>
>>> I this is a valid use case. But this option only makes sense when a
>>> submodule is newly cloned so I am not sure whether submodule update is
>>> the correct place. Let me think about this a little more. Since we do
>>> not have any extra command that initiates the clone this is probably the
>>> only place we can put this option. But at the moment it does not feel
>>> completely right.
>>>
>>> Apart from that the code looks good. If the user does a checkout of a
>>> revision that was not fetched submodule update will error out the same
>>> way as if someone forgot to push his submodule changes. So that should
>>> not be a problem.
>>
>> I agree and would love to say that I've a more beautiful solution, but
>> I haven't.
>>
>> The only other solution I can think about is to add a git
>> submodule clone that will do only clones of non-cloned submodules.
> 
> The "update" subcommand already has "--init" to do "init && update",
> and it would not complain if a given submodule is what you already
> have shown interest in, so in that sense, I do not think what the
> posted patch does is too bad---if it is already cloned, it just
> ignores the depth altogether and makes sure the repository is there.
> A separate "submodule clone" would only make it more cumbersome to
> use, I suspect.

Yup, I see no need for a new command either.

Me too thinks adding "--depth" to "update" makes sense (and I don't
think that this pretty generic name will become a problem later in
case someone wants to add a maximum recursion depth, as grep already
uses "--max-depth" for the same purpose).

But "--depth" should also be added to the "submodule add" command.
As an example we already have the "--reference" option, which is
passed to clone on add and update. Additionally that one supports
the form with and without '=', so I'd prefer the new update option
to basically re-use the same code the reference option uses. And
at least two tests, of course ;-)
