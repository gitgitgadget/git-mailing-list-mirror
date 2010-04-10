From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [WIP PATCH 1/4] Prepare checkout_entry() for recursive checkout
 of submodules
Date: Sat, 10 Apr 2010 22:57:52 +0200
Message-ID: <4BC0E650.2030409@web.de>
References: <4BBF9D6F.2000006@web.de> <4BBF9DC9.8030905@web.de> <7vd3y81e3s.fsf@alter.siamese.dyndns.org> <4BBFB40C.1060905@web.de> <4BC0AED8.1080006@web.de> <7vwrwfw3jn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 22:58:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0hkv-0002Xt-Hq
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 22:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773Ab0DJU55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 16:57:57 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:46771 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab0DJU55 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 16:57:57 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id B60CE15675A57;
	Sat, 10 Apr 2010 22:57:55 +0200 (CEST)
Received: from [80.128.68.165] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #4)
	id 1O0hkZ-000350-00; Sat, 10 Apr 2010 22:57:55 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <7vwrwfw3jn.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/iWthjMC33RgphFcDSty5pvGhp4SsGK+dt7zDu
	SkLAXAcuawujpTQ5LMmrgiBiwoXhUPVBZn3z5Mxi3Mzcj5w8r2
	9aIcbhdeasqEeJgBm1Hw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144592>

Am 10.04.2010 20:44, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>>>> This would give you an incorrect result if .git is a file that records
>>>> "gitdir: overthere" (see read_gitfile_gently() in setup.c); I would expect
>>>> it would become a fairly important ingredient if we ever enhance the
>>>> submodule support to add submodule that disappears/reappears in the
>>>> history.
>>>
>>> Right. This assumption is also present in add_submodule_odb() (used by
>>> show_submodule_summary()) and is_submodule_modified(), so i just reused
>>> it. This should be addressed in another patch.
>>
>> What about this one:
> 
> Looks sensible to me.  Thanks, and sorry for not catching this earlier.

While glancing over add_submodule_odb(): It protects against adding
a /new/ odb twice, but assuming the submodules objects later live in
the odb of the superproject too it will happily add that to the
alt_odb_list the first time it sees it, no?
Not knowing the odb code, would it make sense to protect against that?
Or does adding the superprojects .git/objects to the alt_odb_list have
no negative consequences?
