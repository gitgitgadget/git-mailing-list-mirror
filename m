From: Junio C Hamano <gitster@pobox.com>
Subject: Re: breakage in revision traversal with pathspec
Date: Wed, 11 Sep 2013 14:15:20 -0700
Message-ID: <xmqqa9jjrrfb.fsf@gitster.dls.corp.google.com>
References: <xmqqy574y4pz.fsf@gitster.dls.corp.google.com>
	<522F8ED2.9000408@bracey.fi>
	<xmqq38pcwc21.fsf@gitster.dls.corp.google.com>
	<5230AD23.2050009@bracey.fi> <20130911182444.GD4326@google.com>
	<5230C6E3.3080406@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Wed Sep 11 23:15:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJrl6-0001Ij-0L
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 23:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757306Ab3IKVP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 17:15:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60116 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755492Ab3IKVP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 17:15:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91CF541341;
	Wed, 11 Sep 2013 21:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6lFAKuRsQY0iKenS1w/rWjVHWlE=; b=GUOsJl
	uU2jIypSkZGLFrvJtuPe7iASaoNzAzOfYUAJuoQVm3fC8Ae3AlMYAzf/8nkehU4D
	nHEsOWz0f1jmHnjcNBy0ZF18RN888LsCleT2KRsFQ4NpP9JCM7PHp7dNfyHndP9U
	PbApze1rz6lZslAjcLgps96KSP0UeW+f8QIFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T3l/IPtQ2KticWISaaXx9/zouY6TBCuK
	8wUgby69iU8Dd0uIQOJtFCHOT3A3VzysvZY0U59kaE+Z3rruXbpGYyIVR8wrZwgq
	9gkd/ZZO2McHxY+b2otEPmFgFEAgHscldNl6zeo575zNuwf2Bum7LsCWaEbjMCSs
	z76GOseZpc0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E83641340;
	Wed, 11 Sep 2013 21:15:25 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8417F4133A;
	Wed, 11 Sep 2013 21:15:22 +0000 (UTC)
In-Reply-To: <5230C6E3.3080406@bracey.fi> (Kevin Bracey's message of "Wed, 11
	Sep 2013 22:39:15 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4555520A-1B27-11E3-BADF-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234608>

Kevin Bracey <kevin@bracey.fi> writes:

> To see the effect at the command line: "git log v1.8.3..v.1.8.4" hides
> the merge, but "git log ^v1.8.3 v1.8.4" shows it. Whoops. A new
> example of a dotty shorthand not being exactly equivalent.
>
> In the ".." case the v1.8.3 tag gets peeled before being sent to
> add_rev_cmdline , and the "mark bottom commits" logic works. But in
> the "^" case, the v1.8.3 doesn't get peeled.

That sounds like a bug.  ^v1.8.3 should mark v1.8.3^0 as
uninteresting.
