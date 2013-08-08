From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Thu, 08 Aug 2013 11:52:29 -0700
Message-ID: <7va9ks9frm.fsf@alter.siamese.dyndns.org>
References: <1375756727-1275-1-git-send-email-artagnon@gmail.com>
	<CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com>
	<7v61vgazp5.fsf@alter.siamese.dyndns.org>
	<201308081134.35735.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Aug 08 20:52:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7VKA-0001MV-UH
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 20:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966155Ab3HHSwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 14:52:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61484 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966099Ab3HHSwd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 14:52:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32C0837326;
	Thu,  8 Aug 2013 18:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qFV5tNGRy2hAjceHN7sfScDAR3w=; b=GCTxIk
	CBU9adz8sWFiU6Lx0ygtZmA5sZU+Og0pabXvamoNicxAAHJ5g9NRleuxuIKPAxHt
	ks8W0vgVPHh4cGIg7cLC3yHSWJSYIJ8mcBlAB6fOXIDek0rRPpkeydCEpb4knOBF
	bl92HD1I1bcGiABIwS7DX3TBu6NiIgD5EHb9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GkNpkprOOBV1Mja9wFUl1gupC1l4h1Qf
	xNYTGZb34dhhGkdKQrp4FmQ6iOdR49+jX+A9a7ifNxzTNIUcfwr/ZtCUbolB9Ev6
	rs4FYdO3yV0PbaT9HZ4sbhYaGKWRo57Hu2gp+bwGju2gyr8tsfmmvmNWNmV8ZLn2
	QaSPCoSV+c0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C34BB37325;
	Thu,  8 Aug 2013 18:52:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C32E3731E;
	Thu,  8 Aug 2013 18:52:31 +0000 (UTC)
In-Reply-To: <201308081134.35735.mfick@codeaurora.org> (Martin Fick's message
	of "Thu, 8 Aug 2013 11:34:35 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE255CDA-005B-11E3-97DC-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231919>

Martin Fick <mfick@codeaurora.org> writes:

> Assuming I understand what you are suggesting, would these 
> "young object" likely still get "deduped" in an efficient 
> way without doing history traversal (it sounds like they 
> would)?

Yes.

The very first thing pack-object machinery does is to get the list
of object names and sort them in a certain order to help producing
good deltas, and this initial input preprocessing will dedup them.

> If so, then yeah this might be nice, especially if the history
> traversal is what would speed this up.

That was the assumption behind the "it might help" suggestion.  If
that helps or not is not known yet, and since Ram started this
subthread telling me not to talk about performance improvements, my
time on this thread is _not_ spent on that (yet).
