From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] git-am: indicate where a failed patch is to be found.
Date: Thu, 12 Jul 2012 15:36:00 -0400
Message-ID: <4FFF2720.6090705@windriver.com>
References: <1342108243-8599-1-git-send-email-paul.gortmaker@windriver.com> <7vhatcc1ql.fsf@alter.siamese.dyndns.org> <4FFF1821.7030705@windriver.com> <7va9z4byl3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 21:37:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpPCY-0005SN-4q
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 21:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030745Ab2GLThK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 15:37:10 -0400
Received: from mail1.windriver.com ([147.11.146.13]:33455 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934234Ab2GLThG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 15:37:06 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q6CJa29R003400
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 12 Jul 2012 12:36:02 -0700 (PDT)
Received: from [128.224.146.65] (128.224.146.65) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.1.255.0; Thu, 12 Jul 2012
 12:36:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <7va9z4byl3.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [128.224.146.65]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201376>

On 12-07-12 02:53 PM, Junio C Hamano wrote:
> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
> 
>> On 12-07-12 01:45 PM, Junio C Hamano wrote:
>>> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
>>>
>>>> If git am wasn't run with --reject, we assume the end user
>>>> knows where to find the patch.  This is normally true for
>>>> a single patch,
>>>
>>> Not at all.  Whether it is a single or broken, the patch is fed to
>>> underlying "apply" from an unadvertised place.
>>
>> What I meant by this was the difference between:
>>
>> 	git am 0001-some-standalone-single.patch
>> vs.
>> 	git am mbox
>>
>> In the 1st, the standalone patch is 100% clear and easy to access,
>> because we really don't need/care about the unadvertised place.
> 
> It does not matter at all that 0001-foo.patch only has a single
> patch.  If you are going to fix up the patch after you saw "git am"
> failed, you will be fixing .git/rebase-apply/patch with your editor
> and re-run "git am" without arguments, at which point "git am" will
> not look at your 0001-foo.patch file at all.

I think this is where our two thinking paths diverge.  You are
suggesting I edit and fix the patch.  Yes, occasionally I do
that, if it is a trivial context change.  But hand editing a
patch is not for Joe Average, and gets very complicated in all
but the trivial cases.  So, what happens _way_ more often, is that
I want to apply what can be applied, and deal with the rejects
on a one-by-one basis after that.  (BTW, this is not just me;
this patch came about from discussions with other kernel folks.)

> 
>>> This is _NOT_ fine, especially if you suggest "patch" the user may
>>> not have, and more importantly does not have a clue why "git apply"
>>> rejected it ("am" does _not_ use "patch" at all).
>>
>> I'm not 100% sure I'm following what part here is not OK.  If you
>> can help me understand that, I'll respin the change accordingly.
> 
> Do not ever mention "patch -p1".  It is not the command that "git
> am" uses, and it is not what detected the breakage in the patch.

This may be true, but it _is_ the command that I (and others) have
defaulted to using, if for no other reason than ignorance.

> 
> The command to guide the user to is "git apply".
> 

OK.  But I don't see a "--dry-run" equivalent -- and "git apply --check"
just gives me a repeat of the same fail messages that "git am" did.

With "patch -p1 --dry-run"  I get information that immediately
lets me see whether the patch is viable or not.  Is there a way
to get a similar thing from "git apply" that I've overlooked?

Paul.
---
