From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Honor $(prefix) set in config.mak* when defining
 ETC_GIT* and sysconfdir
Date: Wed, 04 May 2011 11:21:08 -0700
Message-ID: <7v4o5afht7.fsf@alter.siamese.dyndns.org>
References: <20110428022922.GC4833@camk.edu.pl>
 <7v62py5nbp.fsf@alter.siamese.dyndns.org> <20110428192751.GE4833@camk.edu.pl>
 <4DBFA3C6.8060209@viscovery.net> <7vzkn3itb5.fsf@alter.siamese.dyndns.org>
 <4DC0E99E.6090402@viscovery.net> <20110504135827.GC18585@camk.edu.pl>
 <4DC1653A.7000000@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kacper Kornet <kornet@camk.edu.pl>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 04 20:21:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHghS-0005Kg-HG
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 20:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405Ab1EDSVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 14:21:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153Ab1EDSVU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 14:21:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E72D54DCD;
	Wed,  4 May 2011 14:23:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v3aPctpVN25Y5VBfhEYXCcrveLM=; b=iysGmd
	ALVMPq93SEsxOP6NF+IXcYu5b7zXw6WYac7MaKPrZIX7243EUQBs1NcHMrpHOkBU
	RwaW89sELzNnCkrBhGr2Kc9S1KuxRUyNN2QzXB3a/l00YWYiRWn280OSRxFmk0NU
	amTBLUbzOhJLuSy/4TaiAkfM1/HE/IWpdCg/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JDDv41yJC5uuWZcn0xn4Jr3CLGrjaA8g
	1OzgkuoFqFx6He8Ai5syVC5OdBgiCRh9YuENUd23GY/g368sJyCU/th45wpeZPL6
	2fG+/clN1ny3vA18H+MU3yXVoU/jegI/qtnM46fFY4d96R4sp6Y3lE9ekYbQmAsr
	ZMQQXN0j7BI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B38794DCB;
	Wed,  4 May 2011 14:23:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7AAD84DCA; Wed,  4 May 2011
 14:23:14 -0400 (EDT)
In-Reply-To: <4DC1653A.7000000@viscovery.net> (Johannes Sixt's message of
 "Wed, 04 May 2011 16:39:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 95BDDAEE-767B-11E0-A276-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172755>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio's worries should not be discarded lightly. But in this case they are
> unfounded.

I appreciate the analysis and explanation.  As you can see from the
exchange, I was only basing my suggestion on the comments left in the
Makefile by you when you did the "relocatable installation" topic.

> So, I don't think that sysconfdir must survive. It was always only a
> helper variable to shorten the code.

My remaining worry was if ./configure users accidentally relied on this
internal use of a variable whose name happens to be sysconfdir.  If so,

    $ ./configure --sysconfdir=/some/where

may give them a different result once we get rid of sysconfdir from our
Makefile.

But I notice that we do not say that sysconfdir is to be replaced in
config.mak.in we ship, so such a command line option would have been
silently discarded anyway.  IOW, no ./configure user would have relied on
what our build procedure does.

BUT.

The vanilla Makefile users might have.  Among those who install with
prefix=$HOME/git, there may be people who do not want to use $HOME/git/etc
and an obvious way to do so is by setting sysconfdir to $HOME/etc (an
alternative would be to set both ETC_GITCONFIG and ETC_GITATTRIBUTES).

So I think it would probably be a less-impact and useful solution to keep
sysconfdir and add "sysconfdir = @sysconfdir@" to config.mak.in as well.

Is Kacper's latest patch with an obvious one-liner to config.mak.in
sufficient to achieve that?

  From: Kacper Kornet <kornet@camk.edu.pl>
  Subject: Re: [PATCH 1/1] Honor $(prefix) set in config.mak* when defin...
  Date: Wed, 4 May 2011 16:29:21 +0200
  Message-ID: <20110504142921.GE18585@camk.edu.pl>
