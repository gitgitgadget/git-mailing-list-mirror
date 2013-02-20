From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Provide a mechanism to turn off symlink resolution in
 ceiling paths
Date: Wed, 20 Feb 2013 09:41:04 -0800
Message-ID: <7vsj4qyjbj.fsf@alter.siamese.dyndns.org>
References: <1361351364-15479-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Anders Kaseorg <andersk@MIT.EDU>,
	David Aguilar <davvid@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>,
	"Lars R. Damerow" <lars@pixar.com>, Jeff King <peff@peff.net>,
	Marc Jordan <marc.jordan@disneyanimation.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 20 18:41:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Dfk-0002xP-MB
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 18:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206Ab3BTRlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 12:41:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57349 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750698Ab3BTRlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 12:41:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1CBB7BDF;
	Wed, 20 Feb 2013 12:41:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nTAZ4p+03T/w0tQCu2PbMS/sP4I=; b=jRjEDh
	K2CeU/NCSyi925yIV83FzdGiPiSRZ5P50LZmRV39RBxqbaab9DpHRP4ke8ThEZIu
	RKbGaiRzovsrvNiUzzcvIwwomsj51k+HIBTvTrvCfg35IwygD/2CnwmAG3vwKrY0
	bgSU1ktw1nreytlkZ8c7ysssek761M7Q16ksU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wrWXEzDI9Kbi0BnNDP0LXApIBRFXcgVK
	6lu5W7/+UrPDqwSXCNzL6UIPoglvhNmVbKzk7NChd8iFg71f5wCkgBMLDXs4RBzo
	ycMPzDYiOB5ugl4TfeWio/b2FXCb0kO4KgTIjYZelfppXAgj+3Qyz6KkI5TYntmS
	1NF+Cg2qX/8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E4EF7BD2;
	Wed, 20 Feb 2013 12:41:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E01B7BC8; Wed, 20 Feb 2013
 12:41:06 -0500 (EST)
In-Reply-To: <1361351364-15479-1-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Wed, 20 Feb 2013 10:09:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B446894C-7B84-11E2-96CE-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216712>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This is a possible implementation (untested!) of Junio's suggestion,
> with the slight twist that the empty entry can appear anywhere in
> GIT_CEILING_DIRECTORIES and only turns off symlink expansion for
> subsequent entries.

Sounds like a good way to go, I think.

Originally I thought that checking with the elements literally and
stop when we have a match, and then falling back to call realpath()
on them to compare, might be a solution, but I do not think it is.
I haven't thought things through to convince myself that is the best
approach to require the users to explicitly tell us to omit calls to
realpath().  Perhaps it is the best we could do, but there might be
even better ways somebody can think up.
