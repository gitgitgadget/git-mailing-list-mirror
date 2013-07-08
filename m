From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] test-lib.sh - cygwin does not have usable FIFOs
Date: Mon, 08 Jul 2013 18:18:07 -0400
Message-ID: <51DB3A9F.6020504@gmail.com>
References: <1372975470-13573-1-git-send-email-mlevedahl@gmail.com> <20130707005558.GI30132@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 00:18:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwJlA-000844-E8
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 00:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298Ab3GHWSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 18:18:12 -0400
Received: from mail-qc0-f173.google.com ([209.85.216.173]:47616 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab3GHWSL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 18:18:11 -0400
Received: by mail-qc0-f173.google.com with SMTP id l10so2612764qcy.4
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 15:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=2L+8XSqPOSQidAx0Nv1ddC2sg799TyfU/2RPq69NqnI=;
        b=X8ubdS1JoZX2FReh70IlbYXjxtpCoOievEKu/i7OiH5G4cfVYHIdoFeeNePiTS72EX
         WxWXjmZ1Os7wBYawlt5U6agwqf+sBaHqRGIf/7oK95OLAnGOp5GTyRLFMsegRkYN4WV/
         U0tVhwkQUsmavOy77RTlHkVe/By4Ngmxkvb0CXw5glvQzbd7SfGi8PFmvCWgmbKreIGB
         aZNS9hZbqjd6DQwF1GN7qw16rprs/NVInHinbLZwvms+iPxcCHRZTkjzdFNti5CdTnLW
         3r+iaKsaSbc2AY1ILJwjXIazjb5Zht1matweEP5BrGsE4X2DV+AdWx89P7FPuRR/jQOj
         GlpQ==
X-Received: by 10.224.54.204 with SMTP id r12mr20140267qag.105.1373321890884;
        Mon, 08 Jul 2013 15:18:10 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id i1sm16863468qas.10.2013.07.08.15.18.08
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jul 2013 15:18:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
In-Reply-To: <20130707005558.GI30132@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229899>

On 07/06/2013 08:55 PM, Jonathan Nieder wrote:
> Mark Levedahl wrote:
>
>> Do not use FIFOs on cygwin, they do not work. Cygwin includes
>> coreutils, so has mkfifo, and that command does something. However,
>> the resultant named pipe is known (on the Cygwin mailing list at
>> least) to not work correctly.
> Hm.  How would you recommend going about writing a script that takes
> output from a command, transforms it, and then feeds it back into
> that command's input?  Are sockets a more reliable way to do this kind
> of IPC on Cygwin?
>
> See reinit_git and try_dump from t9010-svn-fe.sh for context.
>
> Thanks,
> Jonathan
>

On the one hand, sockets work fine on cygwin so that path would probably 
work.

However, I don't understand why git would need to consume its own output 
- If named pipes are really needed to use git-svn because git-svn 
depends upon git feeding the same git process, then that package should 
not be available on cygwin or any other platform that does not support 
fifos. If not, then I don't think the test suite should require fifos or 
any other construct with the same git process feeding itself either, it 
just blurs the line about what is actually being tested.

Mark
