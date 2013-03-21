From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Add posibility to preload stat information.
Date: Thu, 21 Mar 2013 07:44:35 -0700
Message-ID: <7vtxo4byng.fsf@alter.siamese.dyndns.org>
References: <1363781732-11396-1-git-send-email-iveqy@iveqy.com>
 <20130320164806.GA10752@sigill.intra.peff.net>
 <7vhak6f0w4.fsf@alter.siamese.dyndns.org>
 <20130320174759.GA29349@sigill.intra.peff.net>
 <87vc8lyqz7.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Fredrik Gustafsson <iveqy@iveqy.com>,
	<spearce@spearce.org>, <git@vger.kernel.org>, <pclouds@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 21 15:45:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIgjq-0005XP-FZ
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 15:45:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932687Ab3CUOoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 10:44:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62548 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753538Ab3CUOoi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 10:44:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFE8CAF88;
	Thu, 21 Mar 2013 10:44:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Zg8zYwj9cHxldHAVVezcUcJrvTk=; b=UAS6wF
	gUXGLakYFSFhBPIcmKDeaC9uOaYBETZ6dWId12FX92thwS42hvIsDsglDEhv3xyM
	t/8zOmtWmfNPFcK7dAgBj69C6a87ugP479SukTZi9YhPL9wXQEAMfhwQJguI2DC6
	YbaUziZKhOCasjZ5bqB9lZCeQybQxoeaysWXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z5OMXDYdoudbpvGw9ip0Ak9E21qdNUzG
	WXlPNE0rE7D4tNqswdlw0YBFfaEDHiOzaW2lL+MSNSMZxuCHpyylI5TrPwIZDLQX
	OiT6BI7M8VLV9qgYsZ1NBLxuQpQX+NDhKLXFn/W9j+IBx5+/0hElwAhYePwWEuXu
	P25E5FMW1k8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2F21AF87;
	Thu, 21 Mar 2013 10:44:37 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FF58AF85; Thu, 21 Mar 2013
 10:44:37 -0400 (EDT)
In-Reply-To: <87vc8lyqz7.fsf@pctrast.inf.ethz.ch> (Thomas Rast's message of
 "Thu, 21 Mar 2013 11:41:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA85D88E-9235-11E2-BC64-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218730>

Thomas Rast <trast@student.ethz.ch> writes:

> I think it would actually be a somewhat interesting feature if it
> interacted with GIT_PS1_SHOW*.  If you use these settings (I personally
> use SHOWDIRTYSTATE but not SHOWUNTRACKEDFILES), the prompt hangs while
> __git_ps1 runs git-status.  It should be possible to run a git-status
> process in the background when entering a repository, and displaying
> some marker ('??' maybe) in the prompt instead of the dirty-state info
> until git-status has finished.

This is somewhat interesting.

Perhaps we can introduce a helper binary that does what __git_ps1()
does, with a --timeout=500ms option to say "I dunno (yet)", and keep
priming the well in the background when it takes more than the
specified amount of time?
