From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] ident: make the useConfigOnly error messages more informative
Date: Wed, 30 Mar 2016 15:27:05 -0700
Message-ID: <xmqqlh4zr492.fsf@gitster.mtv.corp.google.com>
References: <1459366183-15451-1-git-send-email-redneb@gmx.com>
	<1459366183-15451-2-git-send-email-redneb@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Marios Titas <redneb@gmx.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 00:27:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alOa2-0000qT-8k
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 00:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775AbcC3W1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 18:27:10 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56593 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754281AbcC3W1I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 18:27:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C987651B02;
	Wed, 30 Mar 2016 18:27:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WTKxEUYAaohEqjXZieCNVilSPRQ=; b=Iacl/u
	Ed8XLW/kY+warwK/YHfD+lWA80Jq7r+6WxkoFB4sQCU9BjGrDkLC3TALbfmkYfi3
	JDCcgBTGFSIc/HSVladDNOHohWQThxO+2zykePYkZfEQVf5UPHJHUuSsG2tXBOvl
	afayjA25db2tcLX/NUF7XOEA66vg+i5Bo4ntU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r8ut7qCtiRUXvUybTWUJz+lVxXZ7lZon
	mGfB35wQuqQeFUphOecvT/G2G9hNLDhn/g2rKqWDRj0ZsZ0RmGarDIEgyADcHXHH
	UGv8Y5VA/24sFtGckxfHXlpbswsX4dsRUuoG+0XioFkoJl/IfVQ1R3ZIedI2wpDP
	65Ezdun2114=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BF8D651B01;
	Wed, 30 Mar 2016 18:27:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3DF2B51AFD;
	Wed, 30 Mar 2016 18:27:07 -0400 (EDT)
In-Reply-To: <1459366183-15451-2-git-send-email-redneb@gmx.com> (Marios
	Titas's message of "Wed, 30 Mar 2016 22:29:43 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8954E182-F6C6-11E5-8DE8-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290355>

Marios Titas <redneb@gmx.com> writes:

> -			    && !(ident_config_given & IDENT_NAME_GIVEN))
> -				die("user.useConfigOnly set but no name given");
> +			    && !(ident_config_given & IDENT_NAME_GIVEN)) {
> +				fputs(env_hint, stderr);
> +				die("no name was given and auto-detection is disabled

Hmph.  I do not think that this is making the message "more
informative".

When a user hits this error, the old message allowed the user to
easily see how to toggle the "disable auto-detection" bit off to let
the code continue by telling the name of the configuration, but the
updated message hides that name, making it harder for the user to
disable the disabling of auto-detection.

I can buy the argument that this change helps the user by making the
message "less" informative, though.  By discouraging the users from
toggling the user.useConfigOnly bit off, it indirectly makes the
other option to work around this error condition, i.e. giving a name
more explicitly, more appetizing.
