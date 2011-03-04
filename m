From: Alexander Miseler <alexander@miseler.de>
Subject: Re: [BUG] git-am silently applying patches incorrectly
Date: Sat, 05 Mar 2011 00:09:10 +0100
Message-ID: <4D717116.3050305@miseler.de>
References: <4D70EBC3.3010400@colin.guthr.ie> <7vr5am7p30.fsf@alter.siamese.dyndns.org> <7vei6m7muw.fsf@alter.siamese.dyndns.org> <7v39n27llq.fsf@alter.siamese.dyndns.org> <AANLkTim=jpJmBZmtAVX2V8Ui44AwpTbevJtSR2Xk=wLX@mail.gmail.com> <7vy64u65ta.fsf@alter.siamese.dyndns.org> <loom.20110304T210337-216@post.gmane.org> <7vtyfi606a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 00:09:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pve7a-0003j1-Me
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 00:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932779Ab1CDXJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 18:09:13 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:55574 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932684Ab1CDXJM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 18:09:12 -0500
Received: from [192.168.22.13] (g227005127.adsl.alicedsl.de [92.227.5.127])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MXCaX-1PRYY53kWL-00Wt3N; Sat, 05 Mar 2011 00:09:09 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7vtyfi606a.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:YoVoy9TRIO4DU3lbo/svzzxLBUgqxqeuwZ727xrQPhb
 6SUnyjaA313JGz5GySo5YG1qDTEPbVecIySIknqNYH5KLBBYLP
 BP/tvro2+h+dq11d7NxKTiIscfLMFvRxElB7WVuPzh3d071TPq
 IR4gfs2o9a7DLZa3Fxk89nxHuhSrstwz94JFNBGf4+fqPllE8L
 XXS7gh0lTTN20mPHet0xA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168474>

On 04.03.2011 22:33, Junio C Hamano wrote:
> (Please don't cull Cc line).

Sorry. I used the nice gmane web interface and hoped that it keeps the CC intact, which it apparently doesn't. I guess i 
will go old school now and use the mailing list via actual emails :)


> Try implementing that warning logic, and using it in real-life projects.
> You don't actually have to _code_ it, but merely imagining how it would
> work and perform would be sufficient for you to realize that it would be
> quite expensive (you need to find all the possible mismatches, essentially
> scanning the whole file), and worse yet, it would be annoyingly noisy with
> many false positives, because in many real-life projects, end of function
> tends to match the problematic pattern that triggered this discussion
> quite often even without patches that introduce more of the pattern.
>
> Unless you can reduce the false hits to manageable levels, such a warning
> is not very useful (it would be useful as a lame excuse "we warned, but
> you took the suspicious result", but that does not help the users).
>
> In short, Linus and I both know what you are talking about, and we may
> revisit that issue later, but the thing is that it would not be very
> pleasant, and not something that can be done in one sitting during a
> single discussion thread on the list.

Understood. On a side note: if this problem is tackled it might be sensible to add a heuristic to git format-patch that 
increases the context size for hunks that are likely to be ambiguous. "Likely to be ambiguous" is of course a problem in 
itself but even a less than perfect detection might be helpful and it would suffer less from some of the aforementioned 
problems, like noisiness/false hits, which would just increase the patch size instead of harassing the user.
