From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule
  working directory in git gui and gitk
Date: Wed, 06 Jan 2010 19:32:31 +0100
Message-ID: <4B44D73F.6000607@web.de>
References: <4B3F6742.6060402@web.de> <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de> <4B42F425.4010901@web.de> <7v1vi428w0.fsf@alter.siamese.dyndns.org> <4B43292C.5060106@web.de> <7vd41oz9mp.fsf@alter.siamese.dyndns.org> <4B439A86.3020500@web.de> <7vbph8oxg0.fsf@alter.siamese.dyndns.org> <4B4498BC.5040400@web.de> <7vbph7181x.fsf@alter.siamese.dyndns.org> <fcaeb9bf1001060923m6559f00bp794bb5fdd4af704c@mail.gmail.com> <7vljgbw21x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Lars Hjemli <hjemli@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 19:34:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSahx-0000rP-45
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 19:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755935Ab0AFSeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 13:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755494Ab0AFSeG
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 13:34:06 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:41895 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755875Ab0AFSeB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 13:34:01 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 7E8111446FFE7;
	Wed,  6 Jan 2010 19:32:38 +0100 (CET)
Received: from [80.128.107.143] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NSagK-0002PB-00; Wed, 06 Jan 2010 19:32:32 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <7vljgbw21x.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+XhZW7iKbYvj2f1MrO4gXjnCriu3Mu4F3R7mq/
	3c+CYBn2NFdompQ0lTF8MDmLiGHCHDILgalXxv7JjI9vF0n22j
	HoGNiV5ZTIx/+kN3SOJQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136286>

Am 06.01.2010 18:55, schrieb Junio C Hamano:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> 
>> On 1/7/10, Junio C Hamano <gitster@pobox.com> wrote:
>>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>>
>>>
>>>> Am 06.01.2010 02:04, schrieb Junio C Hamano:
>>>  >> After all we _were_ in agreement.  We both think the user should be told
>>>  >> about untracked files in submodule directory when inspecting the status to
>>>  >> make a commit in the superproject.
>>>  >
>>>  > Thanks. So i'll take a closer look at the diff core (but i suspect i'll
>>>  > need some time until i can come up with some patches because i don't know
>>>  > this part of git very well).
>>>
>>>
>>> I don't see a direct connection between "the user should be told about
>>>  untracked in the submodule before committing" and diffcore.  It is just
>>>  the matter of "git status" and "git commit" running another instance of
>>>  "git status" via run_command() interface in the submodule directory, no?
>>
>> You would need to rewrite file paths so that files in submodules are
>> also relative to the same directory as files in supermodule (I tried
>> to do that with GIT_WORK_TREE and needed to change a bit). Or you
>> could show each "git status" output separately, which does not look as
>> nice as the former in my opinion.
> 
> You could show output separately if you want, but I think that is a
> separate issue.
> 
> I was envisioning that the "git status" in submodule will be run with its
> recent --porcelain option, and "git status" or "git commit" would read it
> to postprocess and incorporate into its own output.

And i thought about printing just one line for each dirty submodule that
contains uncommitted and/or new files. I did not intend to list every
file, for the same reason a "git diff --submodule" only shows the first
line of the commit messages, not the actual differences of all changed
files in the submodule. I am not against being able to show all files
too, but i really would want to have an option to get a short output for
git gui and gitk.
