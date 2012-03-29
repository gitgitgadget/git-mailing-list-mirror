From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Use SHELL_PATH from build system in
 run_command.c:prepare_shell_cmd
Date: Thu, 29 Mar 2012 01:09:36 -0500
Message-ID: <20120329060936.GB2026@burratino>
References: <20120328042215.GB30251@sigill.intra.peff.net>
 <1332977191-29069-1-git-send-email-bwalton@artsci.utoronto.ca>
 <7v8vikrr5l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, peff@peff.net,
	j.sixt@viscovery.net, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 08:10:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD8ZK-0003N6-R9
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 08:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841Ab2C2GJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 02:09:58 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44740 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366Ab2C2GJk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 02:09:40 -0400
Received: by iagz16 with SMTP id z16so2574404iag.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 23:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zORnjP8m6CE2dgZfLwX6XXL8G+PVylmgvdPFv+F+PV0=;
        b=kH81fXEBNJ8R9Qb6G8ifewFXsACPoAIS0918qJLucXxMY16oLtZ8ZYi3tJeF+zS7HW
         XC/akR43QbIF/t+evDH0B2AUhHY4EeHt7nEfTnFNSvZXpiXI2eWw+CD0p29pDP82WdjY
         m5lELicKZEKQRzTazuIMM78WM00gzhF1EWABrFpu7pCWehRk0EMbuh1jezatx89Qce34
         p8EjjIUcMYBIavYjADULSuj8I4PwCq4PSozQMmd1ishuV07jGaYpa2EGxmoNVlqEv1sY
         jjRp71IVPIR6c9tFb8kyj5J5x+0PtsK9Wuj3T+MOr2HefQyJ7CrsiQgJInasSoZ892dZ
         JzfQ==
Received: by 10.42.150.131 with SMTP id a3mr11337649icw.6.1333001379894;
        Wed, 28 Mar 2012 23:09:39 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id k8sm5325291igz.4.2012.03.28.23.09.38
        (version=SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 23:09:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v8vikrr5l.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194233>

Junio C Hamano wrote:
> Ben Walton <bwalton@artsci.utoronto.ca> writes:

>> Possible fixes for this issue are:
>> ...
>> 2. The git wrapper could prepend SANE_TOOL_PATH to PATH for
>>    consistency with builtin commands.
>>
>> 3. The run_command.c:prepare_shell_command() could use the same
>>    SHELL_PATH that is in the #! line of all all scripts.
>> ...
>> Option 2 is voided by the same example that turned up this issue.
>> SANE_TOOL_PATH might also include 'insane' tools.
[...]
> This line of reasoning makes me feel uneasy.

I think the missing detail in the above explanation is that "sh" is a
special case.  Even though POSIX and good sense would require "sh" to
name a reasonable shell just like "grep" needs to name a reasonable
grep, on Solaris we have never been able to count on an "sh" for git's
needs and common practice seems to be to give up and just use bash or
ksh.

See v1.5.5-rc0~5^2~3 (filter-branch: use $SHELL_PATH instead of 'sh',
2008-03-12), for example.
