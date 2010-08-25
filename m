From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD PATCH 00/32] subtree clone v2
Date: Wed, 25 Aug 2010 12:27:54 -0700
Message-ID: <7vpqx6qypx.fsf@alter.siamese.dyndns.org>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
 <20100824223741.GB2376@burratino>
 <AANLkTikipryFVf_XvvbHopWSo5Ey_mvgTevY2NAvhygQ@mail.gmail.com>
 <AANLkTinsNvVup43B6nQtU6dvJy789n8kQm6N6na0J9oa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 21:28:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoLdu-0004LV-J7
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 21:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857Ab0HYT2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 15:28:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53757 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab0HYT2G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 15:28:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F1E29D0955;
	Wed, 25 Aug 2010 15:28:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0bjuaxirtWYSqo2TYxb19l01LP8=; b=e1xKoK
	nV1lUUPHl8jiovkz9dir+oW6j9vzNJ95H0AMuJT2zO/wrbjrn4POnMiuS6qJUAQt
	iZLUsS3sf52IOdwgo6TDoXQ/+xTdq/x/h2nMGvoIvrN/68Gs4e4tb0QwvcqZeF4w
	Dh7YkZhkey1cqIVK3u5GdjxeWCLS0i5Inf0tU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R7+J2oyffoxrQbvLL0XacNgJJlCh3iph
	iauOJtReC8mTzf6UqB1kekngHrb131L7Rol2cTBO7Nbk8riZWMGh+eDQh+gHKl6G
	2H+IxuWZapUtn311hZDG+NJTWQcENgBAiekyhtXUZxFi1Cy86CP75awIADFspB32
	K/JDnJo+JaY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A6FF9D0951;
	Wed, 25 Aug 2010 15:28:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5AC3AD0947; Wed, 25 Aug
 2010 15:27:56 -0400 (EDT)
In-Reply-To: <AANLkTinsNvVup43B6nQtU6dvJy789n8kQm6N6na0J9oa@mail.gmail.com>
 (Elijah Newren's message of "Tue\, 24 Aug 2010 22\:37\:07 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E01942C2-B07E-11DF-8404-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154464>

Elijah Newren <newren@gmail.com> writes:

> I'm not sure I follow.  Are you allowing changes outside the narrow
> tree to occur?  If you're not, I would have assumed that repeated
> pulls just work, without any need to talk to the server, using a
> resolve-like strategy (with no special rename detection).
>
> Here's my understanding, though it might have holes:
>
> If you have a narrow/subtree clone, it means that you only have the
> data for a certain paths.  I'm assuming that also meant you would only
> allow modifying those paths.  In other words, you have no changes
> outside the narrow tree.  Because of that, I think you can handle
> paths outside the narrow region using trivial-merge logic ...

I think you can do a merge only once, but after that you would be lost.

Suppose you forked from commit A, narrowed to one subdirectory and created
B (iow, diff(A, B) contains only changes to that subdirectory).  Somebody
else worked on the whole tree and queued commit C on top of A.

      B---?
     /   /
 ---A---C

Your merge between B and C that uses A as the common ancestor can take all
changes outside the subdirectory from C (but you need to know all the tree
object names in C near the top outside your area).  So far, so good.

While this was going on, somebody else also forked from A and made changes
that touch both inside and outside your area, and its tip commit is E.

      B---D---?
     /   /   /
 ---A---C   /
     \     /
      o---E

Now you want to merge changes made on the branch that leads to E to your
copy.  How would we do that?

You cannot merge D and E without having enough information necessary to
make a merge between C and E with full tree, can you?
