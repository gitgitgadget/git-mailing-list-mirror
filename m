From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unexpected cherry-pick behaviour
Date: Tue, 10 Dec 2013 11:34:06 -0800
Message-ID: <xmqqvbywts9d.fsf@gitster.dls.corp.google.com>
References: <118044938ad8ebf6b069bcc1d220a986@matos-sorge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paulo Matos <paulo@matos-sorge.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 20:34:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqT4S-0003Kv-M0
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 20:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335Ab3LJTeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 14:34:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62301 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806Ab3LJTeK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 14:34:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2818F5A6A9;
	Tue, 10 Dec 2013 14:34:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hhHB+ZZfnjB0mKLygQquWB7i8kA=; b=tZF7/4
	HbZ7Y1aIG0SgNKaNzaYioUezT+Oz4CUu/EvtnKoXYECND1NeYwXUPhP0y4hwcbdT
	2pInZY5e+H89z48Zyq7nrtcL2pe+n5frNorxQZUpNG9b8jcvO1/NmEY54uCIxvLZ
	iWcqGkBD9p4+Rtq55RTkNxz8GtUS9PiWNRySc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xjGQ6oy7xfVinnE3AvDjjs6IgfX/OkE2
	DtHWbr5SgG8/26qX60ODGP7clq00w7yDstv1lp5XdES3lypfxqNGLRh45gMi6t+P
	axgWD7purqpMl41PKK6IxDWpffrX2wDgQy/L3NGQtEy5XOBZ//kcVZ1yhYc77+sw
	sHYcBD3D+Cs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11D2E5A6A7;
	Tue, 10 Dec 2013 14:34:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52B615A6A6;
	Tue, 10 Dec 2013 14:34:09 -0500 (EST)
In-Reply-To: <118044938ad8ebf6b069bcc1d220a986@matos-sorge.com> (Paulo Matos's
	message of "Tue, 10 Dec 2013 11:04:16 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0A346368-61D2-11E3-9523-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239153>

Paulo Matos <paulo@matos-sorge.com> writes:

> Note how there are changes that are not part of the cherry-picked
> patch outside of the conflicting zone. This is trouble some because it
> means that when I go in to fix a patch and look only at the
> conflicting zone, I will have code outside the zone, that are _not_
> part of the patch modified as well.

My suspicion (I am too lazy to try it myself ;-) is that your
addition of a line "myport_hook()" was done to a section of code
that was modified between the original you added the line to and the
target you are trying to cherry-pick your change (that will
inevitably cause conflicts and you cannot avoid that), and the
post-processing done to make the three-way merge result more
readable are ejecting common changes out of the conflicted region.

Perhaps immediately after "cherry-pick" stopped and asked your help
to resolve the conflicts, running

	$ git checkout --conflicts=diff3 gcc/tree-ssa-threadedge.c

and looking at the file again may show you what is going on better.
