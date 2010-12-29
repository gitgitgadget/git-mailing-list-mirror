From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH] Re: git submodule -b ... of current HEAD fails
Date: Wed, 29 Dec 2010 10:04:09 +0100
Message-ID: <4D1AF989.3000105@web.de>
References: <20101201171814.GC6439@ikki.ethgen.de> <20101201185046.GB27024@burratino> <7vipydwp50.fsf@alter.siamese.dyndns.org> <4D1A7B42.1050907@web.de> <7vlj39to1t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Klaus Ethgen <Klaus@Ethgen.de>,
	Sven Verdoolaege <skimo@kotnet.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 29 10:04:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXrxH-0001fw-Dd
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 10:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508Ab0L2JEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 04:04:13 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:50442 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab0L2JEM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 04:04:12 -0500
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id 7FFE1184B4FC5;
	Wed, 29 Dec 2010 10:04:11 +0100 (CET)
Received: from [93.240.102.90] (helo=[192.168.178.53])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PXrx5-0008AS-00; Wed, 29 Dec 2010 10:04:11 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7vlj39to1t.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19RavIoqf9RPkVNn7yv+zQvHAIIDD4um7vYRYyr
	2+yEWkmwGOsLfXSj6Sur+S3Nj70WFAeR4eSkk7NZ64cg5rLLG8
	wDNNJVEEqLjqyokyl4hA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164306>

Am 29.12.2010 01:34, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> (But AFAIK the patch doesn't really fix the issue, please see [1] and
>> Jonathan's followup)
>>
>> [1] http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/772659/focus=163242
> 
> I think we queued the later round just uses "checkout -B"; shouldn't that
> work?

That's what I thought too (and that is what I based my ack upon, the
patch hit the right spot and used the - according to the documentation
- better suited -B option). But while writing the test you rightfully
requested I noticed that using -B didn't change much. The reason is
that the following commands both fail in a freshly cloned repo:

$ git checkout -f -q -b master origin/master
fatal: git checkout: branch master already exists
$ git checkout -f -q -B master origin/master
fatal: Cannot force update the current branch.

So maybe the real problem here is that "git checkout -B" barfs when it
doesn't have anything to do instead of silently doing nothing?

So we maybe want to fix this issue in "git checkout"? Then the patch
will start working (and the test for it can be added in a later patch).
