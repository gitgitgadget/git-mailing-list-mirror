From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/6] Reject non-ff pulls by default
Date: Wed, 30 Apr 2014 12:28:19 -0700
Message-ID: <xmqqtx9aehws.fsf@gitster.dls.corp.google.com>
References: <1398770226-9686-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqr44eg0s0.fsf@gitster.dls.corp.google.com>
	<53614470489f9_f9b15012ecbc@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 21:28:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfaB9-00082N-TM
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 21:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759389AbaD3T2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 15:28:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37416 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759107AbaD3T2X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 15:28:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D82077F25E;
	Wed, 30 Apr 2014 15:28:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ObZjcrVdgiE23aZNXCzDsoraXdA=; b=a8laj5
	9QAvdoHddmkmACVYeTjUK5N240uTKAsEzROCO+dqd7fGyoShFBmVlpkE9qHdflCT
	aGd19A3YSApSGwvVvEAlS8TVJdU9T8RaBcLSWXSEw4y1/8RIF+H2/thXSby4CiCI
	spZYfnFAKkvaKpyLTlyi2hclp/BD/ti/nqfY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FWBGBsu7W8vCknwdOBOPwHrIy/9j9gHx
	em5wLjy2VZ3lTbBRJW44K92P8MjkW2ANe6PteyaFXijmWPr+izSsJEgN8a4aGFnN
	j4W4Ttu0KQmJX1sKmHqc13E5gDX+XOMhV9UeULWA2XhgdI9ICpUJHH2Dc6TOwOzr
	szpnX8FE9uA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B93387F25D;
	Wed, 30 Apr 2014 15:28:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 990967F25C;
	Wed, 30 Apr 2014 15:28:20 -0400 (EDT)
In-Reply-To: <53614470489f9_f9b15012ecbc@nysa.notmuch> (Felipe Contreras's
	message of "Wed, 30 Apr 2014 13:44:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 96A39B54-D09D-11E3-8BAB-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247760>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
> ...
>> Until the "--merge" option is added, "pull.mode = merge" cannot be
>> the same as "git pull --merge".  I think you either need to squash
>> these two steps into one, or flip the order of them.
>
> Yeah, but the documentation of --merge should mention `pull.mode` and
> `branch.<name>.pullmode`. If I do --merge first I would have to mention
> pull.rebase and branch.<name>.rebase, which is weird.

And the point of your step (1) to introduce pull.mode is to fix the
weirdness, so in that sense, it makes even more sense to do the
"--merge" first and then pull.mode the second.

If you first add --merge with an awkward documentation in the first
step and then correct that awkwardness in the second step that adds
pull.mode (oh, by the way, we need to pay attention to pull.rename
as a fallback at least for a while), that would show a clear
justification why pull.mode is a good idea.

> I think it's more sensible to do the less visible changes first.

The people who discover pull.mode and set it to "merge" will be
greeted with an error with that step.

So it appears that squashing these two (and possibly also the
addition of merge-ff-only) into a single step would be the only
alternative, if you want to avoid the "introduce something that
shows the awkwardness of the situation and immediately fix it"
approach.
