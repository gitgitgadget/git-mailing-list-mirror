From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] exclude: do strcmp as much as possible before
 fnmatch
Date: Sun, 27 May 2012 22:02:02 -0700
Message-ID: <7vwr3w6gqd.fsf@alter.siamese.dyndns.org>
References: <1338035474-4346-1-git-send-email-pclouds@gmail.com>
 <1338035474-4346-3-git-send-email-pclouds@gmail.com>
 <7vk3zyp14i.fsf@alter.siamese.dyndns.org>
 <CACsJy8DOz30GD_zv9yO7KD55+=H0t=+q_5qRtt51nOoYXwOBBQ@mail.gmail.com>
 <7v8vgd7ap9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 28 07:02:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYs5r-0001FA-TH
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 07:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403Ab2E1FCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 01:02:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41389 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802Ab2E1FCF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 01:02:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6DC75866;
	Mon, 28 May 2012 01:02:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rf3bIHrtffeX0zagQK4AFuYEln0=; b=mUbA+5
	E4cEJmVYnWa7kTsshQZ84wnc/FEsC4++aFwZvvAj/aHXs+hS5GseY7fsr2mu0w4d
	OjCc5j5XI42P6ftEXcNz/p31uzTKqf7fNJufj6FChsc0GwgISHG/1eabRpWoSwP2
	gCRndNCrnDrIp4Kd+HMWad7o9P+bTMvwCcHxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lQaTsqBORGM2DIFcH+vmCcdZZE3dPgPy
	l6l/8JVCthAyJny9G+I1SleAq3+CnOexlfyVY77Y8W8di+aV929iYZdrKhOLge9R
	Kg1dmoKHlo0WHbLA6XrNIdSOPUCtfE53gFFpqYRjsfFNMBfxKiHDEjBMLDqMLWur
	yZPcj5JDuTw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D4915864;
	Mon, 28 May 2012 01:02:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C4A35863; Mon, 28 May 2012
 01:02:04 -0400 (EDT)
In-Reply-To: <7v8vgd7ap9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 27 May 2012 11:14:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 443DA34A-A882-11E1-BDBE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198625>

Junio C Hamano <gitster@pobox.com> writes:

> And this does not happen per path you check; exclude_stack used by
> excluded() is designed to take advantage of the access pattern that
> we tend to check paths from the same directory together, so such an
> adjustment will be per directory switching (i.e. it will be part of
> the prep_exclude() overhead that is amortized over paths you walk).

Just in case it wasn't clear, I didn't mean to say "mine is the
right way to do so; I will reject your patch that doesn't do so".
