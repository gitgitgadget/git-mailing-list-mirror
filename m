From: David Rothenberger <daveroth@acm.org>
Subject: Re: [PATCH 2/2] git-svn: allow git-svn fetching to work using serf
Date: Sun, 07 Jul 2013 09:18:36 -0700
Message-ID: <51D994DC.9050500@acm.org>
References: <ABDE5FFA-C19F-44BF-A360-3FD5D74F2B28@gmail.com> <20130707002430.GE30132@google.com> <8CACBE8F-8672-43AB-882E-4ADA05B4D822@gmail.com> <20130707022332.GD4193@google.com> <3871C226-16AE-4E25-8AD3-007EDAB0E25F@gmail.com> <20130707133957.GA3648@lp-shahaf.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kyle McKay <mackyle@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>, Eric Wong <normalperson@yhbt.net>
To: users@subversion.apache.org
X-From: git-owner@vger.kernel.org Sun Jul 07 18:18:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvrft-0003Qs-5M
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 18:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539Ab3GGQSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 12:18:39 -0400
Received: from qmta06.emeryville.ca.mail.comcast.net ([76.96.30.56]:52794 "EHLO
	qmta06.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752506Ab3GGQSi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jul 2013 12:18:38 -0400
Received: from omta15.emeryville.ca.mail.comcast.net ([76.96.30.71])
	by qmta06.emeryville.ca.mail.comcast.net with comcast
	id xTrC1l0051Y3wxoA6UJe23; Sun, 07 Jul 2013 16:18:38 +0000
Received: from [10.249.1.104] ([24.16.16.7])
	by omta15.emeryville.ca.mail.comcast.net with comcast
	id xUJc1l008098amo8bUJdy1; Sun, 07 Jul 2013 16:18:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <20130707133957.GA3648@lp-shahaf.local>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1373213918;
	bh=x8kIfop9k+f812rg88TA6QhnERG9yxjKtHM66xjTYcc=;
	h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
	 Content-Type;
	b=WySZ7YE2U3rqCq8IpJOsDyYPDZgoLPgekRqgpnc3Y1JO+L7RjVg1PIrCNgj+0isIw
	 gZ/y1iYzp/UNU80T+DTMXR3o1XBffMIeUkHul6fQUtMnfEH2RFpojwCoGIT+fHomMe
	 hJOzVPxPbFv4RFXp5xGQwQhhzkt+0Yj4RgT6jNYbuaspIRSu+H/MRP90XVBaTFRdnQ
	 mCoeXSijWvYVvjgGQj1YZvpTsyUJJVZZtnaIN2m87XGelKPcYgFALqFLd3mGjzaIFj
	 NG+SbBrXyXQau+HkIdDeku43QRYYRcpq7s7UiIB09F95HKB5r2ZarkNN6PfwboEcdk
	 nCTLbxO0+odJQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229777>

On 7/7/2013 6:39 AM, Daniel Shahaf wrote:
> Kyle McKay wrote on Sat, Jul 06, 2013 at 19:46:40 -0700:
>> On Jul 6, 2013, at 19:23, Jonathan Nieder wrote:
>>> Kyle McKay wrote:
>>>
>>>> Unless bulk updates are disabled when using the serf access method
>>>> (the only one available with svn 1.8) for https?: urls,
>>>> apply_textdelta does indeed get called multiple times in a row
>>>> without an intervening temp_release.
>>>
>>> You mean "Unless bulk updates are enabled" and "without an intervening
>>> close_file", right?
>>
>> The problem seems to be skelta mode although it may just be the fact  
>> that ra_serf has multiple connections outstanding and since ra_neon only 
>> ever has one it can't happen over ra_neon.
>>
>> If the server disables bulk updates (SVNAllowBulkUpdates Off) all  
>> clients are forced to use skelta mode, even ra_neon clients.
> 
> As Brane and I have pointed out, git-svn can instruct libsvn_* to use
> bulk updates regardless of the server version, by setting
> SVN_CONFIG_OPTION_HTTP_BULK_UPDATES (new in 1.8).

According to the table in the release notes [1], Skelta mode will be
used if the 1.7 or 1.8 server sets SVNAllowBulkUpdates to Off,
regardless of what the client sets in the configuration.

Is that not true?

[1] https://subversion.apache.org/docs/release-notes/1.8.html#neon-deleted

-- 
David Rothenberger  ----  daveroth@acm.org
