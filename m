From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-submodule.sh: Handle submodules with merge
 conflicts
Date: Tue, 22 Mar 2011 14:41:26 -0700
Message-ID: <7voc52kf3t.fsf@alter.siamese.dyndns.org>
References: <4D886430.3080300@kalray.eu> <4D88F6EF.3020804@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Morey-Chaisemartin <nmorey@kalray.eu>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 22 22:41:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q29Kh-0002H7-Rw
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 22:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326Ab1CVVlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 17:41:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45336 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755210Ab1CVVli (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 17:41:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 710C2455F;
	Tue, 22 Mar 2011 17:43:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UjFVUNlCp4BGW5xt4CJJoUAgcKA=; b=akBYR1
	Bln5qw3g7n5Sv2b06553DYDMkwIEoHYcEjcSxqundOUISjnsWDWwfAKMuq4WdOcA
	V/JY0SGSNU6YmGhcpSjzPm5sU3N7Hoev2w9vr8hT8z3PBM6fkTbz0rs/dYBT9AIw
	JwQe5rqAFV0CPS8nhpxpnjTJk48rClnksyXDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e9x3XfXoxYK+o4s+nRs5mlPu26v1Pi/I
	vHNtiUtyQhCIdbjuv4lJtehZIBbQmLZGBuJX7ah4Vm4p5WkBXBe4Kxljih6d/3ZD
	a8HwU1eQGcr6gPiA21/5SxF6Ia0KVcbxhmT0hSTrqjUoMeWzSo0swELu/QIbrDDa
	n2CSqy1DD8o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3FE8D455E;
	Tue, 22 Mar 2011 17:43:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 37573455D; Tue, 22 Mar 2011
 17:43:06 -0400 (EDT)
In-Reply-To: <4D88F6EF.3020804@web.de> (Jens Lehmann's message of "Tue, 22
 Mar 2011 20:22:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6216F16E-54CD-11E0-B9AD-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169778>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Thanks, that fixes it nicely!
>
> Am 22.03.2011 09:56, schrieb Nicolas Morey-Chaisemartin:
>> During a merge with conflict on a submodule, the submodule appears 3 times in git ls-files (stage 1,2,3) which caused the submodule to be used 3 times in git submodule init, sync, update and status command.
>> This patch filters the results of git ls-files to generate a single entry for conflicting submodules with a 0 SHA1 and 'U' as stage.
>
> Nit: Usually we wrap commit messages at about 72 characters.

Also it is very dissapointing to see that none of the careful thinking
that was needed while deciding what each subcommand should do was copied
from <7vhbb1320t.fsf@alter.siamese.dyndns.org> -- did I just waste my
time trying to guide this topic forward?

>> After this patch:
>> - init and sync behave as previously but only once per submodule
>> - update skips submodule with merge conflicts
>> - status now display a null SHA1 prefixed by 'U' for submodule with merge conflicts
>
> A test case would be nice (t7405 looks like the right spot for one).
