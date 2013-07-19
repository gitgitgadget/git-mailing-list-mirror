From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [RFC/PATCH v2 1/1] cygwin: Add fast_lstat() and fast_fstat()
 functions
Date: Fri, 19 Jul 2013 11:34:05 -0400
Message-ID: <51E95C6D.9030806@gmail.com>
References: <51DDC2AF.9010504@ramsay1.demon.co.uk> <51E2CE97.2040900@gmail.com> <7vppuja9ip.fsf@alter.siamese.dyndns.org> <51E4AABD.9010701@web.de> <51E4C400.6000009@gmail.com> <51E82AE0.9050707@ramsay1.demon.co.uk> <51E862FC.4090607@web.de> <51E86E02.4060208@gmail.com> <7vd2qf1m2s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, dpotapov@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 17:34:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0ChD-0007z7-9B
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 17:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760830Ab3GSPeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 11:34:10 -0400
Received: from mail-qc0-f178.google.com ([209.85.216.178]:56595 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760778Ab3GSPeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 11:34:09 -0400
Received: by mail-qc0-f178.google.com with SMTP id c11so2417344qcv.9
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 08:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ot9hgM6yHed2g1/au3GCmQlEpANQzs+jhbQYVYyYqBw=;
        b=zxu4O5VhXyp8bPNm9nfADV2nrzm//qmsgU5FIEPgPltj0tZDtfWgfd7cTQbZOKRHPm
         zU05RSN8LqeqDL/QeUxZ+s2Q7siCfOIGPppCBDHryFXwUlkhsb1pexnx3s+23rXX1OeJ
         cfX9YvwiXxEvzoZN1wJjmPVMdJWBtW30SMrCoomq3SutmnjJDlMN1YalYx83bEGbziMW
         nBDnn4dlf0X+1yMntwjeP6tQAl5mWYe8PnvlR8WhzyJo0i17JQNfSlBn193QEFykoEkt
         DRfwB7BsBRQCLqC1CUnukGuxPYtLbLCX5PLmbhHklnzedeKLbMM/eDDfXfjX9ZagIv5e
         9olw==
X-Received: by 10.224.223.136 with SMTP id ik8mr2419033qab.110.1374248048280;
        Fri, 19 Jul 2013 08:34:08 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id a8sm23205610qae.11.2013.07.19.08.34.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 08:34:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
In-Reply-To: <7vd2qf1m2s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230816>

On 07/18/2013 07:32 PM, Junio C Hamano wrote:
> Mark Levedahl <mlevedahl@gmail.com> writes:
>
>> Unlike the results on the fast Win7 laptop, the above show
>> statistically significant slow down from the fast_lstat approach. I'm
>> just not seeing a case for the special case handling, and of course
>> Junio has already voted with his preference of removing the special
>> case stuff as well.
> Please don't take what I said as any "vote" in this thread.  I do
> not have a first-hand data to back anything up.
>
> I was primarily trying to see my understanding of the consensus of
> the thread was correct. If we can do without s/lstat/fast_lstat/
> almost everywhere in the codebase, of course, I would be happier, as
> it would give us one less thing to worry about.
>
> If the assumptions like "they were declining minority and only lose
> population over time", "it is easy for them to revert the removal
> and keep going", and "removal will not hurt them too much in the
> first place, only a few hundred milliseconds", that might trump the
> longer-term maintainability issue, and we may end up having to carry
> that win32 stat implementation a bit longer until these users all
> switch to Cygwin 1.7, but judging from the "cvs binary seems to be
> built incorrectly" incident the other day, it might be the case some
> users still hesitate to update, fearing that 1.7 series may not be
> solid enough, perhaps?
>

I cannot say how many users of 1.5 exist. I see no evidence of 1.5 users 
on the Cygwin lists, the developers noted a total of 14 downloads of the 
1.5 installer in the year prior to removal of 1.5 from the mirrors. The 
stated reason for keeping 1.5 available for four years after its 
development stopped was support of older Windows variants (which 
Microsoft dropped support of before Cygwin did, BTW). But, none of this 
is conclusive about the current relevance of v 1.5.

The status as I understand things:
1) The existing schizophrenic stat on master is incompatible with the 
new reference api on pu, therefore some change is required.
2) Ramsay has graciously provided two separate patches to address the 
above, one reverting to use only of cygwin stat/lstat, one including a 
fast_lstat that should provide better speed at the expense of POSIX 
compliance.
3) We have conflicting reports about the speed of the second patch: 
Ramsay shows a good speed up on Cygwin 1.5, with slight performance 
regrets on MINGW, no change on Linux. I found no effect on a current 
bare-metal Window 7 installation using Cygwin 1.7, but degradation on a 
virtualized WinXP installation using Cygwin 1.7. Ramsay also showed a 
significant performance difference between running from the git tree vs 
being installed, I looked for this effect but failed to replicate it.

The maintenance argument between the two patches is clear, the 
performance argument less so. Perhaps others can help clarify this.

Mark
