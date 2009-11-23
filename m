From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH 1/2] http-backend: Fix access beyond end of string.
Date: Mon, 23 Nov 2009 12:20:07 -0500
Message-ID: <9201C178-AABF-4320-B7B0-FEE841300E69@gernhardtsoftware.com>
References: <1258233058-2348-1-git-send-email-tarmigan+git@gmail.com> <20091116013654.GX11919@spearce.org> <20091116045532.GC14664@coredump.intra.peff.net> <7viqdb0zhs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>,
	Git List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 18:20:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCcaT-0001cN-SS
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 18:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbZKWRUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 12:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752812AbZKWRUH
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 12:20:07 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:46319 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbZKWRUG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2009 12:20:06 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 6CC261FFC087; Mon, 23 Nov 2009 17:20:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-67-240-172-169.rochester.res.rr.com [67.240.172.169])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id C243A1FFC06B;
	Mon, 23 Nov 2009 17:20:06 +0000 (UTC)
In-Reply-To: <7viqdb0zhs.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133511>


On Nov 16, 2009, at 1:12 AM, Junio C Hamano wrote:

> 	n = out[0].rm_eo - out[0].rm_so; /* allocation */
>        ... validate and fail invalid method ...
>        cmd_arg = xmalloc(n);
>        memcpy(cmd_arg, dir + out[0].rm_so + 1, n-1);
>        cmd_arg[n-1] = '\0';

I just thought I'd point out that this change (committed as 48aec1b) fixed the problem I was having with t5541-http-push (and a couple others) hanging.  Looks like that one extra byte was overwriting something that malloc/free wanted to keep intact on OS X.

~~ Brian