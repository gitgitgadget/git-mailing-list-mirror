From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2] commit, status: #comment diff output in verbose mode
Date: Thu, 17 Mar 2011 09:01:33 +0100
Message-ID: <4D81BFDD.7050009@drmicha.warpmail.net>
References: <1299787140-21472-1-git-send-email-icomfort@stanford.edu> <20110310225233.GH15828@sigill.intra.peff.net> <7vvczq1o4l.fsf@alter.siamese.dyndns.org> <20110311012318.GB15377@sigill.intra.peff.net> <20110311053107.GB16605@sigill.intra.peff.net> <4D79E21A.3040007@drmicha.warpmail.net> <20110317073719.GJ11931@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ian Ward Comfort <icomfort@stanford.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 09:05:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q08Cu-0003v0-4j
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 09:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab1CQIFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 04:05:14 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:56167 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751368Ab1CQIFD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2011 04:05:03 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0A97B20BB2;
	Thu, 17 Mar 2011 04:05:03 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 17 Mar 2011 04:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=XliucHG2AYwihFyvnpBzbIZMQXA=; b=WjuCTcGSZvUwP4vJMa4j0jzoSyE8Z7yvXaM+DS+yAjvYmibdp76qwyFqYvDpUE0xm58o49B+sKTAnyAFKlho6g0cxuhzs1C7UW5MO8SHPkRvixBaMKV53Aod6nIM19OnROybHFMFj1IjCLjz55H+/+MPj26lqCUenXVpLapqG5M=
X-Sasl-enc: d3JI7MFfC76NCQDk7lvmNrs5N/Oaz0uvCuROsnteg86L 1300349102
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 55FB8440D27;
	Thu, 17 Mar 2011 04:05:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110317073719.GJ11931@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169223>

Jeff King venit, vidit, dixit 17.03.2011 08:37:
> On Fri, Mar 11, 2011 at 09:49:30AM +0100, Michael J Gruber wrote:
> 
>>> I do still think I prefer the "#" as comment lines, though. Editors
>>> understand that concept pretty well. For example, one thing that happens
>>> to me a lot is that I write a paragraph, then edit it, then ask the
>>> editor to re-wrap it. Inevitably it buts against the "#" lines, and
>>> those get re-wrapped, too. I could fix it, of course, but I don't bother
>>> because the editor knows that the stuff on "#" lines should remain on
>>> "#" lines. So as it is now, the git-status output gets scrambled, but I
>>> don't have to care. With a special "# Lines below this one..." line, I
>>> will have mangled it and get extra cruft in my commit message.
>>
>> As long as we match for the first n characters of that line with n<60 or
>> so the rewrapping will do no harm (assuming you leave it to start a new
>> paragraph, i.e. "^#Lines..." stays "^#Lines...").
> 
> Yeah, that would work in my case.
> 
>>> But I admit that this is one pretty bizarre personal anecdote and might
>>> not affect anyone else.
>>
>> What affects me more is when when I track files in a different encoding
>> (latin1, say), the diff triggers that encoding for vim and I end up with
>> encoding issues for the commit message (which is supposed to be utf8)...
> 
> Yuck. You may be literally feeding different charsets into a single
> buffer of the editor. The best you could do is something like:
> 
>   au BufNewFile,BufRead COMMIT_EDITMSG set fenc=utf-8
> 
> and then for an empty commit message, vim will read in the latin1, and
> then convert it to utf-8 on output. You will not have munged the "diff"
> line, so git will still recognize it and remove everything after. But if
> you are amending, then you will feed it a utf-8 commit message along
> with a latin1 diff. And vim will screw that up when reading it in.

I resorted to using

git config diff.latin1.textconv "iconv -f latin1"

and setting a latin1 attribute on my (php) files (which use
institute-wide templates enforcing latin1).

This gives me better diffs also, of course. I just hadn't bothered so far.

Though I'm wondering whether we should do something about it in general
(we assume utf8 commit messages, don't we), at least in doc. Your
suggestion above does make things safer (so that you don't screw up the
commit message accidentally) and would make a good patch to vim's
filetype.vim

Michael
