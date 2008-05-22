From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix t6031 on filesystems without working exec bit
Date: Thu, 22 May 2008 02:04:09 -0700
Message-ID: <7vskwawvzq.fsf@gitster.siamese.dyndns.org>
References: <20080518145727.GA3058@steel.home>
 <7v7idqaocb.fsf@gitster.siamese.dyndns.org>
 <20080519060015.GA3179@steel.home>
 <7v8wy360l8.fsf@gitster.siamese.dyndns.org>
 <81b0412b0805220116h4e4ff279k2e433a8a9a1cd9fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 11:06:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jz6k9-0004lq-IE
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 11:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760801AbYEVJEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 05:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760456AbYEVJE3
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 05:04:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47065 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757977AbYEVJE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 05:04:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4CAA73E5F;
	Thu, 22 May 2008 05:04:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 915763E5B; Thu, 22 May 2008 05:04:22 -0400 (EDT)
In-Reply-To: <81b0412b0805220116h4e4ff279k2e433a8a9a1cd9fc@mail.gmail.com>
 (Alex Riesen's message of "Thu, 22 May 2008 10:16:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 149C923C-27DE-11DD-8903-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82606>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> 2008/5/21 Junio C Hamano <gitster@pobox.com>:
> ...
>> @@ -12,6 +15,7 @@ test_expect_success 'mode change in one branch: keep changed version' '
>>        git add dummy &&
>>        git commit -m a &&
>>        git checkout -b b1 master &&
>> +      chmod +x file1 &&
>>  	  git update-index --chmod=+x file1 &&
>
> Now, this is pointless in my setup. Cygwin just ignores the operation
> and decidedddds (presumably according the file _content_ or maybe
> phase of the moon) that is not executable. Working tree is still modified.

Doesn't it mean you spotted a bug?

If your repository is marked so that executable bit is untrustworthy
there, the check done when switching to branch "a1" to compare if "file1"
that is involved in the switch operation has local changes should ignore
(apparent and false) executable-bit change, shouldn't it?
