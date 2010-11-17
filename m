From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] builtin: use builtin.h for all builtin commands
Date: Wed, 17 Nov 2010 11:54:04 -0800
Message-ID: <7vzkt7enfn.fsf@alter.siamese.dyndns.org>
References: <1289745857-16704-1-git-send-email-avarab@gmail.com>
 <1289745857-16704-5-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 17 20:54:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIo5E-00049V-6S
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 20:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935412Ab0KQTyP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Nov 2010 14:54:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47354 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935069Ab0KQTyO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Nov 2010 14:54:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0DAF62F5C;
	Wed, 17 Nov 2010 14:54:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WaewaHmZf4u1
	OMISs9+TYh+Ft6U=; b=XUFpSFgbZqwr2kwl3u/rdBDc2EtDX4MmdAu7VJ9wNuGY
	uhaDdeMHBBPNtoaOj3V0XrJR1wgEMXgKvsGsjW4Di4JxcBtJ8GFkxZjrJPXFGtAY
	jOqc2dYhpMkQd9ki5Lck4iY+U7HZuAk4pJOdeTPFBW/Dp9cKdTqqZ3KzHSU3YmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ILaeNd
	dOBNXSrfwBOBUyLHXO8gV0fF13wVpf6LKfNXwRyIpX2Ne1eAIZNj+y/2om7uHP3q
	Mh/ay2TQyp+Zg8C16MHDKVP0c7dC1bcER3NaAtgK8BANxBeiS7aEL4onjIpE6vUd
	gBeSW1D3+5gxdAG7nuroBuh47dANOPXeQ8WVM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CF63F2F5B;
	Wed, 17 Nov 2010 14:54:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C12C52F5A; Wed, 17 Nov 2010
 14:54:14 -0500 (EST)
In-Reply-To: <1289745857-16704-5-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun\, 14 Nov
 2010 14\:44\:17 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 76DBBA54-F284-11DF-B21D-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161632>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the builtin/*.c files and wt-status.c files which weren't usin=
g
> builtin.h to use it, also remove any git-compat-util.h, strbuf.h and
> cache.h from those files. We can trust on builtin.h including them.

As I already said, buitlin/*.c is fine, but wt-status.c is very dubious=
=2E

> This impeded my efforts to gettextize git, since I'd otherwise have t=
o
> add gettext.h to all of these. Using builtin.h is a good idea in any
> case, since it's defining the prototypes for the cmd_* functions that
> these files define.

What about non-builtin commands?  Don't they need to include gettext.h
anyway?

I would have expected that gettext.h would be included from cache.h, so
that all gitty commands, whether they are builtin or standalone, have
access to the symbols defined in it.
