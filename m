From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Tue, 13 Oct 2009 13:53:12 -0700
Message-ID: <7vljjfuibr.fsf@alter.siamese.dyndns.org>
References: <0016e68fd0123a175304754694b4@google.com>
 <200910122340.13366.trast@student.ethz.ch>
 <7vr5t89qiw.fsf@alter.siamese.dyndns.org>
 <200910130836.57011.trast@student.ethz.ch>
 <7vljjf226t.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0910131358000.32515@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Euguess@gmail.com, Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 22:58:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxoS0-0006dS-9O
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 22:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934142AbZJMUyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 16:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934034AbZJMUyU
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 16:54:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32982 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934008AbZJMUyT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 16:54:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ABD4C57542;
	Tue, 13 Oct 2009 16:53:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Axjh25LQXZHn74cbr0oVq0qZPus=; b=BARuT4
	THDjc+hqrvrUIkTnzXWLIAm4eduDVpnkfoUiyB+WtF1VcuR1rrOCkMm6csHH9lVo
	1+01IgAGfi4b0gC3IfVZZyknzpVDVosvkwAs5uyenorrZRQxWedvJQniVXgpe8Xl
	kvjwU76eirWs6Fx3S1afgbkvtoRV+TWUqJqWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HeHDPufwrktzrCr/W2QDDFq2aWu5bgl+
	AKpexHE+6rUmofDFM2JoCOM8yo58xT3sS8tDsTQPqMiuyqmRlg44HD/opBeszJJC
	NKalrEYX89YjXPp+GbUtwEQG/m2mVSpPTHtimg+l8ZZd0K8hk8s95/pD/SZolRCh
	FvEMaVqrO5E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AA0E5753E;
	Tue, 13 Oct 2009 16:53:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C35C55753C; Tue, 13 Oct
 2009 16:53:13 -0400 (EDT)
In-Reply-To: <alpine.LNX.2.00.0910131358000.32515@iabervon.org> (Daniel
 Barkalow's message of "Tue\, 13 Oct 2009 14\:39\:51 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7367190C-B83A-11DE-9799-B3E4ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130209>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I suspect that a very common pattern for people who follow trees for 
> testing and such or who only develop in topic branches is:
> ...
> << many issues with this kind of DWIM omitted >>
> ...
> On the second cycle, either git refuses or does something actively 
> confusing to this user, and the user has to learn the difference between 
> local branches and remote branches on the *second* cycle. IMHO, it's much 
> better to make users learn things at the point when they don't think they 
> know how to use the system, rather than when they think they understand it 
> and are just trying to get things done.

Yeah, and I think J6t pointed out the same issue.

I think it tells us something, after some of "the most trusted Git
contributors" thought "really long and hard, and making sure to take
user-friendliness into account at least as much as simplicity of
implementation", they are getting to the same conclusion that this
particular DWIMery is a misguided attempt to be helpful without really
helping but rather hurting the users.

I will stop trying to come up with a strawman for other people's itch that
I do not agree to begin with, at least for now.  I will still look at
concrete and workable proposals from other people, though.
