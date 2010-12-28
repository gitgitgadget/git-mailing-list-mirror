From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Re: git submodule -b ... of current HEAD fails
Date: Tue, 28 Dec 2010 13:42:19 -0800
Message-ID: <7vipydwp50.fsf@alter.siamese.dyndns.org>
References: <20101201171814.GC6439@ikki.ethgen.de>
 <20101201185046.GB27024@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Klaus Ethgen <Klaus@Ethgen.de>,
	Sven Verdoolaege <skimo@kotnet.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 28 22:42:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXhJY-0008W5-So
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 22:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421Ab0L1Vmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 16:42:36 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34168 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab0L1Vmf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 16:42:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 426023424;
	Tue, 28 Dec 2010 16:43:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Iw4QSSVz1WmdRbT9SPLJXNywJ/E=; b=sdh7bW
	iztc62fePPgWg8efzl89q94CoaLnqaGWkK4iXBcqDFGpncG5TFwKDEpNrwfbxy7K
	K9MXMzp1fGZPoztsCQPvKP+OO2RMTWxYmQYLAWMWb206npJx56BN8QqU3hLBmJtt
	tVCMEoB5VOBZWBO73gOZei0l6Ptg1xuX3btHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ow+wxPStbLMZYlBygUcz8jaOe+lbnWWh
	Jrsh8Noywidw27ZYzbn2gMVaG41PRLJkuWp05SYp4JCiQzOkfb9YmtHFjMGpHKlS
	LacmGbcxHcgCBWCL5ZNyou7g3ODlzCCP6Ud2QIA2+1efIVDYouMeTIsxKueLgC+w
	CMhgm2JNA+M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C19223422;
	Tue, 28 Dec 2010 16:42:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3A053341D; Tue, 28 Dec 2010
 16:42:51 -0500 (EST)
In-Reply-To: <20101201185046.GB27024@burratino> (Jonathan Nieder's message of
 "Wed\, 1 Dec 2010 12\:50\:46 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6FFAF580-12CB-11E0-AAA7-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164289>

Jonathan Nieder <jrnieder@gmail.com> writes:

> 	git submodule add -b $branch $repository
>
> fails when HEAD already points to $branch in $repository.

I was reviewing the overall picture before tagging 1.7.4-rc0 and started
wondering if this was a good change.  If repository already had branch
checked out, and if it was pointing at a commit that was different from
whatever was taken from origin, shouldn't the command _fail_ to prevent
the divergent commits from getting lost?
