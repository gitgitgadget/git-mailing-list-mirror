From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] merge: let custom strategies intervene in trivial
 merges
Date: Sun, 15 Aug 2010 20:39:27 -0700
Message-ID: <7vbp93dy4w.fsf@alter.siamese.dyndns.org>
References: <20100816010652.GA22546@burratino>
 <20100816011106.GB22573@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Yaroslav Halchenko <debian@onerussian.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 05:39:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkqYD-0005F8-4m
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 05:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330Ab0HPDjj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 23:39:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51169 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317Ab0HPDji convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 23:39:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DBC3CD5D5;
	Sun, 15 Aug 2010 23:39:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=K87jzb01S9ZS9g7f0Ncg34TBB
	c0=; b=NzXTg35OVktrRwL3kSeeh/c4BGVZpaF+cF/Sn1VkW2VeXeLaSZ3zBVug0
	nQDHnFvXsil1skeo4Zj3IeGMxfsvadB5pNGu7vVltsVomg8hq36kljVmcDC+bJx1
	JVFRcjzfuPotbRhisAQq5J3XDf1+divNgtaTgWyvpLTEc9Lqew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=l3ju216v9U/YP+u6H9O
	DqC1EP18KeZiIYlHuGxGzjuUnLeiH3UOsGkgeFneYMhr6eO8kEjDiaWWmAnMB3aE
	B7Klx3Mgq6ca2OCw9L3uMFRos2zHdRNqM2EKubrRqBsfgAhRh93r85pc5bkuVEzc
	G6rYD7uukpA+uXo2rJQ9tj+s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B8815CD5C2;
	Sun, 15 Aug 2010 23:39:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1F56CD5BE; Sun, 15 Aug
 2010 23:39:28 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E29BA2F4-A8E7-11DF-A83C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153646>

Jonathan Nieder <jrnieder@gmail.com> writes:

> As v1.6.1-rc1~294^2 (2008-08-23) explains, custom merge strategies
> do not even kick in when the merge is truly trivial.  But they
> should, since otherwise a custom =E2=80=9C--strategy=3Dtheirs=E2=80=9D=
 is not useful.

I think it is a double-edged sword that trivial merge kicks in for cust=
om
strategies.  If your mind is focused narrowly on "ours" or "theirs",
indeed it may be inconvenient, but on the other hand other custom
strategies may not want to run heavy-weight operations if a trivial mer=
ge
is sufficient.

So in the longer term, I suspect that each custom strategy needs to be
able to tell the merge machinery if it wants ff and trivial.
