From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/8] Git remote helpers to implement smart
 transports.
Date: Tue, 01 Dec 2009 12:42:29 -0800
Message-ID: <7vskbuwhmy.fsf@alter.siamese.dyndns.org>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <fabb9a1e0912010812t4de8027dj1faf828051d1adc2@mail.gmail.com>
 <20091201165245.GF21299@spearce.org> <20091201171908.GA15436@Knoppix>
 <20091201193009.GM21299@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 01 21:42:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFZYe-0000Ma-1d
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 21:42:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288AbZLAUmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 15:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753280AbZLAUmg
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 15:42:36 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51752 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbZLAUmf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 15:42:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2BD6FA3644;
	Tue,  1 Dec 2009 15:42:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ieaTwTJ/qAwSp/jL1pfWeqYoFXM=; b=Nj66UR
	agj73ht367AoqSYb8BRV7SRcuSo26K4jCjSg2DSJuqXGAilgJTUidsT5S6TI06Rw
	xdrkm3Xo9gufZrE2H1DcawCpXBYs63ichKaIcu9OEY1qeOnyogKKLSlQ5QEGvuqm
	SykULMKWClnT9I2Ra4MrprW7yPRYD2HFJ8ZFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VmtaCbp3b26fxdVXhldwFSlVsoY7iMLl
	1JSPSjqH6J2j/5Kb2laAYaoyYa9s5lefOASBQ3bdZjKZI3xTTawrXmHTwsOOKXH7
	icZRZzYJKJ74URBLZM4FBrWaeckkA158s/xhwNIj20tYPS3KgI1uBPYCvzxjF+PP
	0NCjCSM7zb8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E3186A3643;
	Tue,  1 Dec 2009 15:42:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 16E2FA3639; Tue,  1 Dec 2009
 15:42:30 -0500 (EST)
In-Reply-To: <20091201193009.GM21299@spearce.org> (Shawn O. Pearce's message
 of "Tue\, 1 Dec 2009 11\:30\:09 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0F3F5682-DEBA-11DE-84C0-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134255>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
>> 
>> For instance, to support new types of authentication for smart transports
>> without patching client git binaries (SSH has lots of failure modes that
>> are quite nasty to debug) or abusing GIT_PROXY (yuck). 
>
> So the bulk of this series is about making a proxy for git://
> easier to tie into git?
>
> Forgive me if I sound stupid, but for gits:// shouldn't that just
> be a matter of git_connect() forking a git-remote-gits process
> linked against openssl?  Or, maybe it just runs `openssl s_client`?
>
> Why go through all of this effort of making a really generic proxy
> protocol system when the long-term plan is to just ship native
> gits:// support as part of git-core?

I didn't know what the long-term plan was to be honest, but after skimming
the series, I think your response is a good summary.

It is somewhat unfortunate that a few changes I liked (e.g. the "debug"
bit), even though it was somewhat painful to read them due to coding style
differences, were not at the beginning of the series but instead buried
after changes that are much bigger and controversial (e.g. [6/8]).
