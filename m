From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 6/6] refactor fetch's ref matching to use ref_abbrev_matches_full_with_rules()
Date: Sun, 11 Nov 2007 18:31:32 +0100
Message-ID: <BC8C5856-E629-44F2-8B77-510E2B5C3194@zib.de>
References: <1194789708646-git-send-email-prohaska@zib.de> <11947897083381-git-send-email-prohaska@zib.de> <11947897081278-git-send-email-prohaska@zib.de> <11947897083159-git-send-email-prohaska@zib.de> <11947897083265-git-send-email-prohaska@zib.de> <1194789709671-git-send-email-prohaska@zib.de> <11947897092576-git-send-email-prohaska@zib.de> <fh7548$15u$1@ger.gmane.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 18:30:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrGdp-0004Hm-EP
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 18:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855AbXKKRaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 12:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754260AbXKKRaU
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 12:30:20 -0500
Received: from mailer.zib.de ([130.73.108.11]:41942 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754460AbXKKRaT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 12:30:19 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lABHUG7o008660;
	Sun, 11 Nov 2007 18:30:16 +0100 (CET)
Received: from [192.168.178.21] (brln-4db11614.pool.einsundeins.de [77.177.22.20])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lABHUFWm019250
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 11 Nov 2007 18:30:15 +0100 (MET)
In-Reply-To: <fh7548$15u$1@ger.gmane.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64477>


On Nov 11, 2007, at 3:55 PM, Jakub Narebski wrote:

> Steffen Prohaska wrote:
>
>> The old rules used by fetch were coded as a series of ifs.  The old
>> rules are:
>> 1) match full refname if it starts with "refs/" or matches "HEAD"
>> 2) verify that full refname starts with "refs/"
>> 3) match abbreviated name in "refs/" if it starts with "heads/",
>>     "tags/", or "remotes/".
>> 4) match abbreviated name in "refs/heads/"
>>
>> This is replaced by the new rules
>> a) match full refname
>> b) match abbreviated name prefixed with "refs/"
>> c) match abbreviated name prefixed with "refs/heads/"
>>
>> The details of the new rules are different from the old rules.  We no
>> longer verify that the full refname starts with "refs/".  The new  
>> rule
>> (a) matches any full string.  The old rules (1) and (2) were  
>> stricter.
>> Now, the caller is responsible for using sensible full refnames.   
>> This
>> should be the case for the current code.  The new rule (b) is less
>> strict than old rule (3).  The new rule accepts abbreviated names  
>> that
>> start with a non-standard prefix below "refs/".
>>
>> Despite this modifications the new rules should handle all cases as
>> expected.  Two tests are added to verify that fetch does not resolve
>> short tags or HEAD in remotes.
>>
>> We may even think about loosening the rules a bit more and unify them
>> with the rev-parse rules.  This would be done by replacing
>> ref_ref_fetch_rules with ref_ref_parse_rules.  Note, the two new test
>> would break.
>
> Does still "origin" matches "origin/HEAD" if we have emote "origin"?

No, and it did not before. fetch does _not_ match origin as
refs/remotes/origin/HEAD. I added a test to confirm the old
behaviour. Only the git-rev-parse rules match origin as
refs/remotes/origin/HEAD.

	Steffen
