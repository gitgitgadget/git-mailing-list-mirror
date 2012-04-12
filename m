From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] Be more specific if upstream branch is not fetched
Date: Thu, 12 Apr 2012 08:15:52 -0700
Message-ID: <7vd37dgevr.fsf@alter.siamese.dyndns.org>
References: <1334161035-26355-1-git-send-email-zbyszek@in.waw.pl>
 <1334161035-26355-5-git-send-email-zbyszek@in.waw.pl>
 <20120412053017.GA27369@sigill.intra.peff.net> <4F869D37.1050508@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Apr 12 17:16:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SILl6-0007yd-Jr
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 17:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757503Ab2DLPPz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 11:15:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32794 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753220Ab2DLPPz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 11:15:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B19F0628D;
	Thu, 12 Apr 2012 11:15:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=f8paLXyaF9n4
	BwiHwL5NTRGTMJQ=; b=sGt6GWgzW9mp1H9DyqzYTKuKtRqveqPo2Hcl9r4kFjM7
	C2aXrowgUcoNuVwC3OTO9Bk8gJ8YIyFzep0+sYCjravIySNdSbaM6cQyu9ft8BUP
	ozuUarP7LKe4T3rW5wXbF0tWLPT+DILzWZRN8o/D7JZoE6u2Vic8owjDVIKTVBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vmiihU
	ccee29mEpIcffwYbUcast9MQfLJqI9zV5MPhAmOBdJzrLeKeM3BFdkO4QQzX5hwj
	4TQ66mdNKqBWIXEIyp75Z+yxA1jPbx0Mv+rVtaXUFEhOvwkm/LtuCNWVCycszVqU
	kmWSxL9i2qQcDT3wqv0SRnOs/769oas5j+ts4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8F3F628C;
	Thu, 12 Apr 2012 11:15:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DE616289; Thu, 12 Apr 2012
 11:15:54 -0400 (EDT)
In-Reply-To: <4F869D37.1050508@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?= message of "Thu, 12 Apr 2012 11:15:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 65AC0F10-84B2-11E1-80E1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195334>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> maybe I'm missing something, but I think that git will not fetch bran=
ches
> (or commits) which are not part of remote's refspecs.

A remote's refspec does not have to "store" a tracking branch.  The bra=
nch
is still fetched, but not stored anywhere locally.

> % cd clone
> % git config remote.origin.fetch refs/heads/master:refs/remotes/maste=
r

In other words, the fetch refspec could be without colon.  With

	[remote "origin"]
		url =3D ...
        	fetch =3D refs/heads/master
	[branch "master"]
        	remote =3D origin
                merge =3D refs/heads/master

you can still say "git pull" without any other argument while on your
"master" and it will do the right thing.  Actually, you do not even hav=
e
to have remote.origin.fetch at all (branch.master.merge will be added t=
o
the set of refs to be fetched).

In such a case "master@{upstream}" does not (and should not) resolve to
anything, and the reason is not because it is not "fetched", but as Pef=
f
said, because it is not "stored".
