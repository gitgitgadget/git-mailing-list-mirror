From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] configure.ac: move the private git m4 macro to a dedicated directory
Date: Fri, 09 Aug 2013 09:51:19 -0700
Message-ID: <7v61ve7qpk.fsf@alter.siamese.dyndns.org>
References: <1376059045-14866-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, stefano.lattarini@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 18:51:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7puZ-0004zW-AY
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 18:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968237Ab3HIQv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 12:51:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52101 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968232Ab3HIQvW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 12:51:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8A1D37B97;
	Fri,  9 Aug 2013 16:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D+y67kcmYAfCo0ioUgQNmzaxXAk=; b=BxrP1H
	bR52OjOjOcvnL+uFmfAeeQg0OE1E7dp8a7mkA13rR7ryLU4QcbAYsexrfsDHzpvn
	psj8nZLmKwWiHpPBiwCEpKW1zjoeYjiRFJZ6G1L0YQEZJI2dVdY5Yswv4Nw2uFeo
	JavFvSROuam85IIsdy3V5fz9U0Wr+s+Cm1m9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s9Aa18gsDRdz5Bpb5fAPPMsGl8DzK0XW
	tfOVamHfpWRlrILxawjffuvQHB95Vw9nY+ysBBzmVoIQC7qtcGy+6CDTjV04mZcb
	/pzoOXDgc7W/6il3HMBaCdFUddwIJtoo40YNEsiqyqkxBfIamFIvIsNk5dH0woYe
	AaUoKic6Z8w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADACA37B96;
	Fri,  9 Aug 2013 16:51:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09CA137B95;
	Fri,  9 Aug 2013 16:51:20 +0000 (UTC)
In-Reply-To: <1376059045-14866-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Fri, 9 Aug 2013 07:37:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB0936CC-0113-11E3-99A6-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231994>

Elia Pinto <gitter.spiros@gmail.com> writes:

> Git use, as many project that use autoconf, private m4 macros.
>
> When not using automake, and just relying on autoconf, the macro
> files are not picked up by default.
>
> A possibility, as git do today, is to put the private m4 macro
> in the configure.ac file, so they will copied over  the final configure
> when calling autoreconf(that call also autocon). But this makes configure.ac difficult
> to read and maintain, especially if you want to introduce new macros later.
>
> Starting from version 2.58, autoconf provide the macro AC_CONFIG_MACRO_DIR
> to declare where additional macro files are to be put and found.
> The argument passed to this macro is commonly m4.
>
> This macro, for the longest time, has been used only by libtool
> starting from version 2.0, to identify where to copy its own macro files
> when using libtoolize --copy.
>
> Starting from version 1.13, automake augments autoconf with a macro
> called AC_CONFIG_MACRO_DIRS, that provides a space-separated list
> of directories to use for looking up m4 files.
> The same macro will be available as part of autoconf 2.70,
> actually in development. Anyway also this version permit
> to use AC_CONFIG_MACRO_DIR and not need automake.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>

That explains why you created a separate directory to for the new
file and why you needed to use AC_CONFIG_MACRO_DIR while doing so.

But in the above explanation, I fail to see the reason why we would
want to create that new file out of the existing file, only to
include it in the original file.

Why is it needed?  Why is it a good idea?
