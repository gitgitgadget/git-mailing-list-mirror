From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule.sh: Don't use $path variable in
 eval_gettext string
Date: Wed, 18 Apr 2012 16:42:11 -0700
Message-ID: <7v4nsgk3os.fsf@alter.siamese.dyndns.org>
References: <4F8DAFDA.1020108@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bwalton@artsci.utoronto.ca, Johannes Sixt <j6t@kdbg.org>,
	Jens.Lehmann@web.de, avarab@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Apr 19 01:42:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKeVv-00017s-W5
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 01:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860Ab2DRXmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 19:42:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60599 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152Ab2DRXmO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 19:42:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB23A7326;
	Wed, 18 Apr 2012 19:42:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rzJ044eAe97gFpjSxmFIyHvP9Vk=; b=wAgwUy
	x/Ge+fXMGsCv6rVyE5PgxgahvX4jBUivF7Qtq+oRpaBgoFcciLLoRTBPPcnC5zbM
	85bi7D1AuxbXeiG5ST2vyAHTZhHlG0UGRluxZCMZ9WkRgYe9TVTiA0sd1CwjKaJk
	ZONLEZP/CCgVgGgIXp6+X7xajOVJOPMRV3nhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b4D0v1jS8GhtoNQik5mHPO5BIphWiQTK
	qEVAyP4Y/BPgwfs22+jL9lJkDH2v34i7Sp4xzQqdpYbNSR6oOWyl4VIjr7Id+e71
	pLQoTatSimIYYnwsIyVNgTpVGm4wlWrb5IwFdFnLoECTXlbyUiKpaOM+gip/w0Zf
	4KE9MQOmSRg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0AF87325;
	Wed, 18 Apr 2012 19:42:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B96C7323; Wed, 18 Apr 2012
 19:42:13 -0400 (EDT)
In-Reply-To: <4F8DAFDA.1020108@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Tue, 17 Apr 2012 19:00:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F87828C-89B0-11E1-8C8E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195916>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> As an alternative, we finesse the problem by renaming the $path
> variable to $sm_path (submodule path). This fixes the problem on
> MinGW along with all test failures on cygwin (t7400.{7,32,34},
> t7406.3 and t7407.{2,6}). We note that the foreach subcommand
> provides $path to user scripts (ie it is part of the API), so we
> can't simply rename it to $sm_path.

Which might mean that foreach is unusable on systems whose environment
variables are case insensitive, as whatever command spawned by foreach
has its $PATH clobberred.  It is not a regression to them, so it is not
urgent to address it, but going forward, perhaps we can encourage users
of _all_ platforms to use $sm_path for portability?
