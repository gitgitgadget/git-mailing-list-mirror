From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git push performance problems with ~100K refs
Date: Thu, 29 Mar 2012 20:43:06 -0600
Message-ID: <60bff12d-544c-4fbd-b48a-0fdf44efaded@email.android.com>
References: <201203291818.49933.mfick@codeaurora.org> <7v7gy2q1kq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 04:46:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDRrP-0004Vw-3x
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 04:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759602Ab2C3CqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 22:46:18 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:17462 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759139Ab2C3CqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 22:46:16 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6664"; a="174899395"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 29 Mar 2012 19:46:16 -0700
Received: from [192.168.1.160] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 92EBB10004AB;
	Thu, 29 Mar 2012 19:46:15 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <7v7gy2q1kq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194316>



Junio C Hamano <gitster@pobox.com> wrote:

>Martin Fick <mfick@codeaurora.org> writes:
>
>> Does anyone have any hints as to what might be wrong with 
>> the receiving end algorithm that would cause a small change 
>> to use so much CPU?  Is there anything that can be done 
>> about it?  I noticed that the --all option will effectively 
>> feed all the 100K refs to rev-list, is this really 
>> necessary?
>
>It is trying to minimize the transfer cost.  By showing a ref to the
>sending side, you prove you have chains of commits leading to that
>commit
>and the sender knows that it does not have to send objects that are
>reachable from that ref. One thing you could immediately do is de-dup
>the
>100k refs but we may already do that in the current code.

I am sorry I don't quite understand what you are suggesting is taking up the CPU time?  It doesn't take that much CPU just to gather 100refs and send them to the other side, that would be i/o bound.  Could you explain what is happening on the receiving side that is so time consuming?

>> Are there any tests that I can perform to help 
>> debug this?
>
>You do not need to "help debug" it.  It's cause is already known: the
>receiver exposes too many refs to the sending side.

But wouldn't that cause excessive CPU for the sending side?  It did with jgit, but that can be remedied with a simple jgit fix.

Thanks for your insights,

-Martin

Employee of Qualcomm Innovation Center,Inc. which is a member of Code Aurora Forum
