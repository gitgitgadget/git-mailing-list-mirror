From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [RFC/PATCH v2 1/1] cygwin: Add fast_lstat() and fast_fstat()
 functions
Date: Mon, 15 Jul 2013 23:44:58 -0400
Message-ID: <51E4C1BA.4010509@gmail.com>
References: <51DDC2AF.9010504@ramsay1.demon.co.uk> <51E2CE97.2040900@gmail.com> <7vppuja9ip.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, mhagger@alum.mit.edu,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, tboegi@web.de,
	dpotapov@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 05:53:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UywKB-0005hw-07
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 05:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758638Ab3GPDxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 23:53:10 -0400
Received: from mail-qe0-f42.google.com ([209.85.128.42]:58282 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755599Ab3GPDxI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 23:53:08 -0400
Received: by mail-qe0-f42.google.com with SMTP id s14so123518qeb.1
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 20:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=JG12F+J6aaw6rqF77eZUVLu26pHZRkWdKHtp+/vuW4M=;
        b=NFKSqH6Aqp9V+XL/VxmArUho7luYAlYAgjAaIeK4gBIESAvlEPvnVS6tUNgrd3Dm1S
         /QR3/GIB68of2w7Eb6gYPBEIGNNmaPeKht0Tdlb7CJGP64XK0T2o8q3UOjIdfa1ejxo4
         Nl6rkwLK0K0+kAJm7XeuBOJQZkHwrgPlPPCQdQTLAVDgZ0RtszblBAyD+K5CChsUgptJ
         y2WCYK3V2NInWXZOkaAYw2Zlpxi/UUru/nm+rvqW+nKd1xOgOFXCluHTEPLLB+uHu6pj
         JTgX14JUTVVfjlB5nfUtcG6/ooYDiCthzEpxA1xjDOI1kx3nTfmY2n9bRi9Er6oM8izX
         Fqww==
X-Received: by 10.49.98.196 with SMTP id ek4mr54101934qeb.8.1373946300727;
        Mon, 15 Jul 2013 20:45:00 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id pg6sm59986384qeb.5.2013.07.15.20.44.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 20:44:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
In-Reply-To: <7vppuja9ip.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230538>

On 07/15/2013 03:49 PM, Junio C Hamano wrote:
> Mark Levedahl <mlevedahl@gmail.com> writes:
>
>>> In order to limit the adverse effects caused by this implementation,
>>> we provide a new "fast stat" interface, which allows us to use this
>>> only for interactions with the index (i.e. the cached stat data).
>>>
>>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>>> ---
>> I've tested this on Cygwin 1.7 on WIndows 7 , comparing to the results
>> using your prior patch (removing the Cygwin specific lstat entirely)
>> and get the same results with both, so this seems ok from me.
>>
>> My comparison point was created by reverting your current patch from
>> pu, then reapplying your earlier patch on top, so the only difference
>> was which approach was used to address the stat functions.
>>
>> Caveats:
>> 1) I don't find any speed improvement of the current patch over the
>> previous one (the tests actually ran faster with the earlier patch,
>> though the difference was less than 1%).
>> 2) I still question this whole approach, especially having this
>> non-POSIX compliant mode be the default. Running in this mode breaks
>> interoperability with Linux, but providing a Linux environment is the
>> *primary* goal of Cygwin.
> Sounds like we are better off without this patch, and instead remove
> the "schizophrenic stat"?  I do not have a strong opinion either
> way, except that I tend to agree with your point 2) above.
>
In case my opinion is unclear, I think removal of the schizophrenic stat 
is the right approach. Speed is important, but not at the expense of 
correctness.

Mark
