From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revert.c: defer writing CHERRY_PICK_HEAD till it is safe
 to do so
Date: Thu, 06 Oct 2011 10:28:22 -0700
Message-ID: <7vaa9e113d.fsf@alter.siamese.dyndns.org>
References: <1317911641-47660-1-git-send-email-jaysoffian@gmail.com>
 <7vty7m12b2.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dzh2Njjwykt-f4w_YqpftrJEpQfUW2OvSRs_MSPcNFQnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, nicolas.dichtel@6wind.com,
	Jeff King <peff@peff.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 19:28:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBrkJ-0005E3-Tt
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 19:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758813Ab1JFR20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 13:28:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63633 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758749Ab1JFR2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 13:28:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D4706534;
	Thu,  6 Oct 2011 13:28:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h9/Jj+wNmRk0mbyjKfsIAmfAXWQ=; b=rKDVmV
	kvL6LwDcoqdOv/Sa6o+z0ehv6nuZ3n1pOOHZ+VQ6oX/lLT1ORetKe0LlJ9Apkmf4
	FxJhsmRwcYDdT4PK0Nh1WsYxG+FzR3fnopl8TcMXVbvEv7PgGHIoxUM0QAf/pcXz
	SJ+bWZuOTRJMEk8LbiqU0Jb7P3Hb0F+gJ1y18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tXDijlDcfhEXdddVDwt6ytGAv85cjjDq
	RB407q2fdY4srrT39pU7fMaSKwyWYu9r5gezm0sbnZdI4FnFondT32dOSRWp7kNP
	l1KEDB7scgwJxtY/Pjrl20z5hK494kwyKxWUwHVIQcEgg6M8Py+uE0WDU6uuoKIZ
	1WkNA8NA/mQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 646426533;
	Thu,  6 Oct 2011 13:28:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F0F456531; Thu,  6 Oct 2011
 13:28:23 -0400 (EDT)
In-Reply-To: <CAG+J_Dzh2Njjwykt-f4w_YqpftrJEpQfUW2OvSRs_MSPcNFQnw@mail.gmail.com> (Jay
 Soffian's message of "Thu, 6 Oct 2011 13:21:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98026E48-F040-11E0-914E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182995>

Jay Soffian <jaysoffian@gmail.com> writes:

> For that matter, why does revert.c have it's own implementation of
> recursive instead of just calling try_merge_command("recursive", ...)?

I think the people who did this part wanted not to fork.
