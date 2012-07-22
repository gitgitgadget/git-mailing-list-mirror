From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC] Designing a faster index format - Progress report week 13
Date: Sun, 22 Jul 2012 11:52:35 -0700
Message-ID: <7vfw8jsk5o.fsf@alter.siamese.dyndns.org>
References: <20120716203300.GA1849@tgummerer.surfnet.iacbox>
 <7vwr23zb65.fsf@alter.siamese.dyndns.org>
 <20120717082452.GC1849@tgummerer.surfnet.iacbox>
 <500C1AA9.4000306@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu, pclouds@gmail.com, trast@student.ethz.ch,
	JGit Developers list <jgit-dev@eclipse.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 20:52:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St1Gq-0002Y0-LA
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 20:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab2GVSwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 14:52:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34626 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752244Ab2GVSwh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 14:52:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53BA48F44;
	Sun, 22 Jul 2012 14:52:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T5Sv1XHZ67MolRWurSppZteM98c=; b=KMOI37
	xkFs1QxxyPCyzPBD0biKsta4HyuT57tcEHtouDij9A9nx3Xd+pZth0ETZZRp5cKd
	W8o6WkgoJKoH+rOWoscTddbMoqbYPox//GXaqujSEbXNqV9/WTD/YfdDexZ3vTn0
	EciIrsDSBNm9dItI4n7Kj3JJNf/Sb4rkvD7tg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AK5ctMwvXzhg7IrenT+pmFbG+qAZe4vZ
	5dXGT+OW5XCRTeU89ROd5K5MrUnaW+VBKqgMLAa4t6fpcbcIFvfnaaQHAywQ8HrE
	lvZHBWyY3/fjaOJPa8QoiqYc8z+Xxwkwt7MRHjKKgPTnR3ULhxWZazBT+dhP839S
	c7jda27ym2E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4030E8F43;
	Sun, 22 Jul 2012 14:52:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A76E68F41; Sun, 22 Jul 2012
 14:52:36 -0400 (EDT)
In-Reply-To: <500C1AA9.4000306@dewire.com> (Robin Rosenberg's message of
 "Sun, 22 Jul 2012 17:22:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 67724032-D42E-11E1-AEC7-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201856>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> A note on how JGit would work here. Java has none of the fields
> that constitute statcrc. I guess we would write zero here when
> creating new entries. Git could recognize that when checking status
> and simply assume "clean" unless mtime or st_size says otherwise.

Even though it may not be the end of the world, that is certainly
bad. Recording the constituent fields separately without the statcrc
microoptimization, thereby not shaving a handful of bytes per the
index entry, is not the end of the world either in the same sense,
which leads us to question the benefit we would be getting from such
a change.
