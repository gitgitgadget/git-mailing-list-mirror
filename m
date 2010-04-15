From: Junio C Hamano <gitster@pobox.com>
Subject: Re: failed to lock
Date: Thu, 15 Apr 2010 12:00:25 -0700
Message-ID: <7vd3y0k0c6.fsf@alter.siamese.dyndns.org>
References: <j2o76718491004141349l53b53347v7f4c0edcab69e4c2@mail.gmail.com>
 <t2i76718491004141402h33bb2044g155ef1715c63904e@mail.gmail.com>
 <k2x76718491004142100v6e1ece6djc62aa540e51eed5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 21:00:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2UIo-0000AH-Jt
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 21:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750Ab0DOTAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 15:00:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39755 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755674Ab0DOTAc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 15:00:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D32F4AB1BD;
	Thu, 15 Apr 2010 15:00:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jKQLF5VK1BICrTdpIOzHuMPuUMs=; b=YY65Xl
	1NXfO9pkjq1kRSy6mH1iKKZWZfaUcHXwdIRACgKPZD8STo8fOAbKOdm8DDnTUX3z
	1DjtKDj9IbyePIy3075NhzqMajKHXF95OJLmBg0ngal45sBDdZFJrgf6LA1LZ++N
	xoRTcQz6SChYnLsWzEKivt3eSLEPd6NXdPF3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e6LkSmIAegSfcpVD3Dcd4wG9A28jCuMj
	rDYjNSQzPGM2XWABGIhG6OkyKpQL6iJOiyz6I587sfKSN2XAMwVkHT5omvGLyGUb
	W2KGcAf+AetWv0P04oFLXjQDGFBXCNm4Lg98EGzlDLmfuyclm2j3p+PebfpFfH4E
	msx1rmZ74FU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AB459AB1BC;
	Thu, 15 Apr 2010 15:00:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 227D7AB1BB; Thu, 15 Apr
 2010 15:00:26 -0400 (EDT)
In-Reply-To: <k2x76718491004142100v6e1ece6djc62aa540e51eed5@mail.gmail.com>
 (Jay Soffian's message of "Thu\, 15 Apr 2010 00\:00\:37 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 28EA1D12-48C1-11DF-8112-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145002>

Jay Soffian <jaysoffian@gmail.com> writes:

>> The origin/HEAD symref and --mirror do not get along together. Hmm.
>
> Proposal: receive-pack should look through the list of heads it has
> received and check whether each is locally a symref.

I would rather think that "git push" should notice that */HEAD is a symref
and refrain from pushing it.  Stated more precisely,

 - It is perfectly fine to do this:

   $ git push there HEAD:somebranch

 - But it does not make sense to push a symref via

   [remote "there"]
   	push = refs/*:refs/*

   to a bare repository that is used as a back-up mirror by including
   refs/HEAD:refs/HEAD in the result of wildcard expansion.
