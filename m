From: Junio C Hamano <gitster@pobox.com>
Subject: Is column.ui.* configuration a bit too strong?
Date: Mon, 23 Jun 2014 12:03:11 -0700
Message-ID: <xmqqsimvbg9c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 21:03:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz9WV-0001QO-7Z
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 21:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483AbaFWTDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 15:03:19 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59498 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754205AbaFWTDS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 15:03:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 82AB722D21;
	Mon, 23 Jun 2014 15:03:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type; s=sasl;
	 bh=cjHppuQCWkZLVtaRchyauHI8Awk=; b=BaefxCvVJPTyXk1F/nGlRG/W3T9D
	+CwAO1mSdtMtNXMttby5uH8UP9N9sTig8rU9l2hByZM9J2bV3xfWFkuTY1zlPfpK
	YFuWe752hMf2EvkkKYceXBU7ET5pKkqpDpzbO7M/omreR6avxDrSRWLaB2VZoJuY
	S8J466VbQizXafk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	p1O9pMv/8AE6jCH5c0iMpsWvOATXzlqqSFpBkDjFlRmwMgL/t9MVhMasvkBIhIfp
	dCjL5rIR94YRDPWAdaVKHDa+8lK3CMb+OAjCejavU47BAjMLvGW8jxwcevFEN6l1
	/JKjp/6MDqsXAlRD5GuZoYhSOS8Jm9USU9z+aSXd2yE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7669822D20;
	Mon, 23 Jun 2014 15:03:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9D27E22D1C;
	Mon, 23 Jun 2014 15:03:08 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 03B28E18-FB09-11E3-BFA1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252365>

Since its inception at 7e29b825 (Add column layout skeleton and
git-column, 2012-04-21), it seems that git_column_config() asked for
a specific $command did not give "column.$command.*" any precedence
over the fallback value defined for "column.ui.*".  If you happen to
have column.ui.* earlier than the corresponding column.$command.* in
your configuration, then the values come from column.ui.* may be
overwritten, but the code does not seem to enforce "if there is a
setting for a specific command, honor that, otherwise fall back to
the generic 'ui' setting".

Am I misreading the code?
