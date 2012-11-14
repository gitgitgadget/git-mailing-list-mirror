From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/4] git-status: show short sequencer state
Date: Wed, 14 Nov 2012 09:44:46 -0800
Message-ID: <7vfw4caxkh.fsf@alter.siamese.dyndns.org>
References: <1351553513-20385-1-git-send-email-hordp@cisco.com>
 <1352487385-5929-1-git-send-email-hordp@cisco.com>
 <1352487385-5929-4-git-send-email-hordp@cisco.com>
 <7vip9aiuk8.fsf@alter.siamese.dyndns.org> <50A13C9A.8070108@cisco.com>
 <50A2DCD7.4050909@cisco.com> <7vy5i4b9d8.fsf@alter.siamese.dyndns.org>
 <50A3A040.7040304@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Jeff King <peff@peff.net>, konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 18:45:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYh1M-0008BV-6e
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 18:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423117Ab2KNRou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 12:44:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46379 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423096Ab2KNRot (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 12:44:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23A0DA331;
	Wed, 14 Nov 2012 12:44:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QqLnmJT7++7vWHp/gG0EQPnhiUk=; b=whlTS9
	5WLAoEUhZV/D+CAn3n+ax4qNqYMqu/eb3qZdv2XbMXmpW3AYx83EjJwcZxvMW1Xb
	TSPnxXrqPhCfZ1RZZLJ+6aE1PqjDvz3fpo3edpunZFqHSZqyU9OWyy7q09kolG8A
	iYiOr9Kq5drzYNqf0cFZUz+Vg7Owpo6Jesv3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VC5WU+LdXio806mBJGZWpABBMYECd22a
	nRtPFVinPuxC5vPiEXBmw/O5nEkuDzbjSc+4aPoYhDPMRjC4e0XQktVMQg3beAz8
	6tXs8hk3Rvc9vrFigWGBjasV3arIQhPvrut82U1WfAwBu5JXWADyFUiPt3J0BA6C
	2NjTJIN8XFk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 117DBA330;
	Wed, 14 Nov 2012 12:44:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72657A32D; Wed, 14 Nov 2012
 12:44:48 -0500 (EST)
In-Reply-To: <50A3A040.7040304@cisco.com> (Phil Hord's message of "Wed, 14
 Nov 2012 08:44:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC1E1AF4-2E82-11E2-9B4D-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209733>

Phil Hord <hordp@cisco.com> writes:

> Consider the usage:
>
>   git status   # show work-tree status
>   git status --short  # show short work-tree status
>   git status --tokens  # show work-tree status in token form

OK, your --tokens is more about *how* things are output, but it is
unclear how it would interact with --short.  I had an impression
that you are basing your output on the short output, whose existing
record include "##" (that shows the branch names and states), and
"MM", "A " and friends (that show the per-file states), by adding
new record types that shows tree-wide states.

> But maybe "--tokens" has some better meaning that someone will want to
> use in the future.  I'm not married to it.  But "git status" already
> means "Show the working tree status".  So "git status --show-tree-state"
> sounds redundant or meaningless.

I didn't mean to say that you have to spell out all these words;
"show" and "state" are redundant.

The important part is that unlike the existing "per-file" state the
"status" command is showing, the option is to add "tree-wide" state
to the output, and my suggestion was to pick a word that makes it
clear, rather than using "output is done using tokens" without
saying "what is being output in tokenized form".
