From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] fetch: avoid quadratic loop checking for updated submodules
Date: Tue, 13 Sep 2011 21:34:52 +0200
Message-ID: <4E6FB05C.6010202@web.de>
References: <20110912195652.GA27850@sigill.intra.peff.net> <7vwrdd5x61.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 21:35:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Yl2-0002LJ-Eq
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 21:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489Ab1IMTey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 15:34:54 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:52028 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932377Ab1IMTey (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 15:34:54 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate03.web.de (Postfix) with ESMTP id 2EBEB19988803;
	Tue, 13 Sep 2011 21:34:53 +0200 (CEST)
Received: from [79.247.241.245] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1R3Ykv-0007os-00; Tue, 13 Sep 2011 21:34:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <7vwrdd5x61.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+YRIjtvGoQX5o1PILpxZ7AhOxID4fSjrhpGh7L
	ntxrYUEVj3iaI7QGhNRTYU6FpW49wEfEGEXH1qGJBpiDLo4eQn
	Hj/X1KjtTlcdMnTfI5Eg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181304>

Am 12.09.2011 22:21, schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
> 
>> Instead, this patch structures the code like this:
> 
> Yup, I agree that's the right way to do the other half of the issue.

Ack from me too! I tested it on the repo with 3k refs and the time went
down from 142s to 1s (when applied to 3793ac56b4, as later versions of
master contain my other half which would skip Peff's code).

On current master including my other half this takes 0.90s, while running
with Peff's code on top of 3793ac56b4 it takes .96s. That is 6 hundreds
of a second (7%) extra for not having to worry if one must run "git fetch
--recurse-submodules" or not.
