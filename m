From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/23] pack v4: add commit object parsing
Date: Tue, 27 Aug 2013 10:42:53 -0700
Message-ID: <xmqq4nabdo82.fsf@gitster.dls.corp.google.com>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
	<1377577567-27655-6-git-send-email-nico@fluxnic.net>
	<xmqq7gf7f94f.fsf@gitster.dls.corp.google.com>
	<alpine.LFD.2.03.1308271238270.14472@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Aug 27 19:43:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VENIG-0001XH-PR
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 19:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525Ab3H0RnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 13:43:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47366 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753366Ab3H0Rm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 13:42:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96E9D3CBA2;
	Tue, 27 Aug 2013 17:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7YR6Vnn13riWkcAmQPysRLjJpeA=; b=kB80BF
	/lVj6s+SByUunIXNNp9w/t8v/M1Ss2Ok/GfvmH7nFr9atvxPlGCkvzPA2Vz0I7aS
	8nA+g7g0PRy+/QHlxsudEQAY8mZ0ti5ItEYzs8vT+eJz2VRmdT4833Lf8teVNPmO
	yk1Et7X6VAPZ/9ysfROT0UdQwLGcWKTp+eBBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ChQiLTOqQzZ0yJC0Kd7Hp8DJ5GQlZYMl
	GXg7giH6/xNXfesqnqrxc2XwiVKtU+vMmGv47SCWu/0K7KJSdeiX/GaWj6ouoD99
	NI2iqrk3uFDrHPXrmhPUowSxaCOFyy7/dpBX71VFH0Rs10A5lsAvKevw0+20abpt
	Qn8eiJe6xzM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A6053CBA0;
	Tue, 27 Aug 2013 17:42:58 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BAE9A3CB9D;
	Tue, 27 Aug 2013 17:42:55 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.03.1308271238270.14472@syhkavp.arg> (Nicolas
	Pitre's message of "Tue, 27 Aug 2013 12:47:20 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1B1FC77E-0F40-11E3-B3CC-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233119>

Nicolas Pitre <nico@fluxnic.net> writes:

> Hmmm....  The problem I have with split_ident_line() right now is about 
> the fact that it is too liberal with whitespaces.  Here I must be sure I 
> can deconstruct a commit object and be sure I still can regenerate it 
> byte for byte in order to match its SHA1 signature.

Yeah, I now see.  It's the same "accept with leniency"
get_sha1_hex() does, which is not appropriate for the 
purpose of this codepath.
