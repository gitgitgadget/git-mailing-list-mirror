From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Command-line interface thoughts
Date: Thu, 09 Jun 2011 10:36:18 -0700
Message-ID: <7vd3imykj1.fsf@alter.siamese.dyndns.org>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
 <m339jps1wt.fsf@localhost.localdomain>
 <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
 <201106051311.00951.jnareb@gmail.com>
 <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
 <7vwrgza3i2.fsf@alter.siamese.dyndns.org> <4DF08D30.7070603@alum.mit.edu>
 <20110609161832.GB25885@sigill.intra.peff.net>
 <BANLkTinyYjXeg_khoU1dJVenP0mO2++hsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 19:36:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUj9u-0007D7-Hy
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 19:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313Ab1FIRgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 13:36:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab1FIRgg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 13:36:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BE0F84C49;
	Thu,  9 Jun 2011 13:38:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7morZ8eesF/hvkITivsw8QiBI84=; b=o6HHzW
	Cr7Ev53HV5jdSx4LFS9a+J3PFZ/bxvSveAApMhb9/71i1/JzVNIMGo5G5O7r9NPC
	zl5vUMzVox0kQZ5V3glg5pSlDlylQCjtFw0Wa1xheR0ACK2unGNchoRQep3A+Gfq
	05j2D4SRxi6F3MXA6TgErCgrTQOkXSOf5APVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mQXaQPMe9N1lT9GhbDb4xLuAWGAO/iIF
	4ytZZsFhrH+VJlIY29TkPaR6fFIBJHr9971f7KH+yPtIQ6M4wGjE9UVNC4flsLOT
	bfp2VD9Ih9HX7yJzyCn6PBVJnb7EtZS8KllFOKAdzQswrr9rHakha3ABpVFkH988
	SOnTStMXMcs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4AA364C48;
	Thu,  9 Jun 2011 13:38:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3193F4C47; Thu,  9 Jun 2011
 13:38:28 -0400 (EDT)
In-Reply-To: <BANLkTinyYjXeg_khoU1dJVenP0mO2++hsw@mail.gmail.com> (Jay
 Soffian's message of "Thu, 9 Jun 2011 13:15:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4EF38AAE-92BF-11E0-852A-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175559>

Jay Soffian <jaysoffian@gmail.com> writes:

> In fact, my first step after a conflicted merge is:
>
>   $ git tag -f ours HEAD
>   $ git tag -f theirs MERGE_HEAD
>   $ git tag -f base $(git merge-base HEAD MERGE_HEAD)

That looks like quite a convoluted set-up, I would think, than
necessary. You only need to remember these:

 # what does the result look if I said "commit -a" now?
 $ git diff HEAD	  

 # I want to also see comparison with the original
 $ git checkout --conflict=diff3 <conflicted paths>...
 $ git diff

 # What did they do since they forked from my history?
 $ git diff ...MERGE_HEAD

 # What did I do since I forked from them?
 $ git diff MERGE_HEAD...

 # I want step-by-step explanation of how these paths were touched
 $ git log -p --left-right --merge [<conflicted paths>...]
