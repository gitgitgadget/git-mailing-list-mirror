From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCHv3 3/4] git-status: show short sequencer state
Date: Tue, 13 Nov 2012 18:50:47 -0500
Message-ID: <50A2DCD7.4050909@cisco.com>
References: <1351553513-20385-1-git-send-email-hordp@cisco.com> <1352487385-5929-1-git-send-email-hordp@cisco.com> <1352487385-5929-4-git-send-email-hordp@cisco.com> <7vip9aiuk8.fsf@alter.siamese.dyndns.org> <50A13C9A.8070108@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Jeff King <peff@peff.net>, konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 00:51:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYQFz-0002D9-VY
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 00:51:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755974Ab2KMXuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 18:50:50 -0500
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:59857 "EHLO
	rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755928Ab2KMXut (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 18:50:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2065; q=dns/txt; s=iport;
  t=1352850649; x=1354060249;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=qQhGQRMuZ5vTSXA55cVq/OuYdkhlz9lBpsjrAe/2GrY=;
  b=KX8uk9i/102lSX7q5V/eBe4sz4sY4vUi0b6u2QvotQvAJ1Isxxvg7A+m
   1PW23UFxiOfBQmYEVNPxvMZMBrC5AlpOBl6CrbFnDEV3KfXwyOF9sKYMD
   Oq3/xbyyaRcU+XJ2KuY2UGx29h1citqHqNfS7JyoWa23n1NFDjGV4mIUr
   4=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EAL3bolCtJV2d/2dsb2JhbABEwzeBCIIeAQEBBBIBZQEQCxgJFg8JAwIBAgFFBg0BBQIBAR6HaJsOj2WQJJJ+A4hajSKFa4htgWuDDQ
X-IronPort-AV: E=McAfee;i="5400,1158,6895"; a="142074222"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-5.cisco.com with ESMTP; 13 Nov 2012 23:50:49 +0000
Received: from [64.100.104.138] (dhcp-64-100-104-138.cisco.com [64.100.104.138])
	by rcdn-core-6.cisco.com (8.14.5/8.14.5) with ESMTP id qADNomPl026742;
	Tue, 13 Nov 2012 23:50:48 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
In-Reply-To: <50A13C9A.8070108@cisco.com>
X-Enigmail-Version: 1.4.5
X-TagToolbar-Keys: D20121113185047561
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209687>

Phil Hord wrote:
> Junio C Hamano wrote:
>> Phil Hord <hordp@cisco.com> writes:
>>
>>> State token strings which may be emitted and their meanings:
>>>     merge              a merge is in progress
>>>     am                 an am is in progress
>>>     am-is-empty        the am patch is empty
>>>     rebase             a rebase is in progress
>>>     rebase-interactive an interactive rebase is in progress
>>>     cherry-pick        a cherry-pick is in progress
>>>     bisect             a bisect is in progress
>>>     conflicted         there are unresolved conflicts
>>>     commit-pending     a commit operation is waiting to be completed
>>>     splitting          interactive rebase, commit is being split
>>>
>>> I also considered adding these tokens, but I decided it was not
>>> appropriate since these changes are not sequencer-related.  But
>>> it is possible I am being too short-sighted or have chosen the
>>> switch name poorly.
>>>     changed-index  Changes exist in the index
>>>     changed-files  Changes exist in the working directory
>>>     untracked      New files exist in the working directory
>> I tend to agree; unlike all the normal output from "status -s" that
>> are per-file, the above are the overall states of the working tree.
>>
>> It is just that most of the "overall states" look as if they are
>> dominated by "sequencer states", but that is only because you chose
>> to call states related to things like "am" and "bisect" that are not
>> sequencer states as such.
>>
>> It probably should be called the tree state, working tree state, or
>> somesuch.
> I think you are agreeing that I chose the switch name poorly, right?
>
> Do you think '--tree-state' is an acceptable switch or do you have other
> suggestions?
>

I've been calling these 'tokens' myself.  A token is a word-or-phrase I
can parse easily with the default $IFS, for simpler script handling.

I'm happy to make that official and use --tokens and -T, but I suspect a
more appropriate name is available.

Phil
