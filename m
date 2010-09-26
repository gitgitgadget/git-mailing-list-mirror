From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] rev-parse: stop interpreting flags as options to
 rev-parse once --flags is specified
Date: Sun, 26 Sep 2010 00:11:54 -0700
Message-ID: <7v1v8hnflx.fsf@alter.siamese.dyndns.org>
References: <robbat2-20100924T191752-102740530Z@orbis-terrarum.net>
 <1285399156-21792-1-git-send-email-jon.seymour@gmail.com>
 <AANLkTi=8gv5arpdOVGHvf7sjNd==G=a4HoBBTbizq=OK@mail.gmail.com>
 <AANLkTim0oxhgtgqbrqP-jDL29jj0y=h6BLssEAFzags9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: robbat2@gentoo.org, casey@nrlssc.navy.mil, git@vger.kernel.org,
	brian@gernhardtsoftware.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 09:21:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzlXx-0003bo-Rb
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 09:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264Ab0IZHMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 03:12:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061Ab0IZHMI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 03:12:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A559D9A07;
	Sun, 26 Sep 2010 03:12:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dqnVQLBvHN9zFxhDCRzTjABDCpo=; b=IXVBDU
	E4IF1PpI+7FXDk+WVQXHc+9Evc0wbm7+BhFljPvFx6gMApDyjiNh/A1FiD5V/H4V
	BgxtzaJbeFs0+pwvm0yVWxDOiE+l+EpuMiNcgWH+L3sUbSjs1Yrs5WXIy/hOERWV
	PXCANRp2xM7ahL2PssV7aGkjInZSgRHsUIb9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GwoGfOy6gBOxVucTZzasrypLe7rDYTLZ
	iPzssjaISMqXivTKet1HQMUQsp8ihoDDrC0VkGdVi1rWgksQGfh8N90UJt6E+aYh
	JwhCapmEqDBFCla3y0NdztqtoUW26N39GIXyVDhemmpyPPWoniae0dBgdV8G47/T
	gmNnSUvtTWM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B6D61D9A05;
	Sun, 26 Sep 2010 03:12:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3489D9A04; Sun, 26 Sep
 2010 03:11:55 -0400 (EDT)
In-Reply-To: <AANLkTim0oxhgtgqbrqP-jDL29jj0y=h6BLssEAFzags9@mail.gmail.com>
 (Jon Seymour's message of "Sat\, 25 Sep 2010 17\:25\:16 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5BF224D2-C93D-11DF-8ACD-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157213>

Jon Seymour <jon.seymour@gmail.com> writes:

> Mmmm...almost certainly not going to regress anything, since there
> does not seem to be a test or script that uses --flags. Ahem.

I've already explained the historical background in a separate message; I
realize that my message was missing the important part: conclusion.

If there weren't rev-parse before and we were about to invent the command,
I would agree that --flags should suppress output of HEAD.  Also I doubt
anybody relies on --flags for the purpose of removing non-revision
arguments.  So in that sense, your change would not hurt people.

But I do not think encouraging the use of rev-parse to pick "flags" is a
good idea in the longer term anyway, so I do not care too much about this
issue.  Unless you will teach "rev-parse --flags" about all the options
all other git command take (e.g. it should know --ignore-submodule takes
an optional option argument and be able to parse "--ignore-submodule all"
out), which is fundamentally impossible (e.g. for some commands "-n" does
not take argument, for some other "-n" takes an integer argument, and the
rev-parse command fundamentally cannot decide if it should report what
follows "-n" as part of its "--flags" output).
