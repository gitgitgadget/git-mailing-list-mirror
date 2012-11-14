From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/4] git-status: show short sequencer state
Date: Wed, 14 Nov 2012 11:35:59 -0800
Message-ID: <7v7gpoasf4.fsf@alter.siamese.dyndns.org>
References: <1351553513-20385-1-git-send-email-hordp@cisco.com>
 <1352487385-5929-1-git-send-email-hordp@cisco.com>
 <1352487385-5929-4-git-send-email-hordp@cisco.com>
 <7vip9aiuk8.fsf@alter.siamese.dyndns.org> <50A13C9A.8070108@cisco.com>
 <50A2DCD7.4050909@cisco.com> <7vy5i4b9d8.fsf@alter.siamese.dyndns.org>
 <50A3A040.7040304@cisco.com> <7vfw4caxkh.fsf@alter.siamese.dyndns.org>
 <50A3ED8A.9080604@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Jeff King <peff@peff.net>, konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 20:36:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYil2-00010N-5W
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 20:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976Ab2KNTgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 14:36:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48685 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212Ab2KNTgD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 14:36:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49F509473;
	Wed, 14 Nov 2012 14:36:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2TRWm8RgO7cyEbYHUcS95+Sh3Dk=; b=K1z0R3
	qgtRPTVOoifwabj7EW16p5f7OIGoeJCG6+jvmgBxWk1RB6A+vdzqV8UKBH9QXVmB
	oehH6BHebWGt5lmGtsaPeMp77yEirYZQIY/R0mzTW7YTXHkfKFDTXVYuuHSPudU+
	oeQQVgaLUCeqJ8ByPqnMBf38hKFhjL61C06Is=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L7w0iazvzPMQwa968w5yrj0bhRElXFlN
	2TXiRM73hRNbIoYcwR0sv0kDO150WHkv5cuePvvIpy+uiXVgkKg97Jkt5c6JXYmc
	iIq/gqfta/1WPr1B2Ffc3RG9lSFfa9//6NNTOH3YWV7PWeHN9FoNIAm7M8bsODBd
	OEuufUilI1Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 361BA9471;
	Wed, 14 Nov 2012 14:36:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 726EA9470; Wed, 14 Nov 2012
 14:36:01 -0500 (EST)
In-Reply-To: <50A3ED8A.9080604@cisco.com> (Phil Hord's message of "Wed, 14
 Nov 2012 14:14:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 858AC17A-2E92-11E2-B338-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209744>

Phil Hord <hordp@cisco.com> writes:

>   # tokens and short-status
>   $ git status --tree --short  
>   ## changed-files
>    M foo.txt

Hrm, how will the existing readers of the output avoid getting
confused by this overloading of "##", which has meant the current
branch information?

>   # tokens only?
>   $ git status --tree --porcelain
>   changed-files

It probably is simpler for parsers of the --porcelain format if you
(1) always used first two bytes as the record type, and (2) avoided
using "##" that is already used for the tree-wide status.

Just a thought.
