From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] grep: Add --directories option.
Date: Fri, 10 Jul 2009 01:11:14 -0700
Message-ID: <7vmy7dufdp.fsf@alter.siamese.dyndns.org>
References: <1247167228-2466-1-git-send-email-michal.kiedrowicz@gmail.com>
 <4A56EED7.9040008@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Jul 10 10:12:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPBDM-0003KC-JA
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 10:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbZGJILX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jul 2009 04:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbZGJILW
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 04:11:22 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58192 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553AbZGJILV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 04:11:21 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B18B7264AB;
	Fri, 10 Jul 2009 04:11:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F1DA6264A7; Fri,
 10 Jul 2009 04:11:15 -0400 (EDT)
In-Reply-To: <4A56EED7.9040008@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Fri\, 10 Jul 2009 09\:33\:43 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3FAD9E44-6D29-11DE-9627-DC021A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123044>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> It seems your patch still allows recursion, one level deep.

I suspect what the patch wants to do may be fundamentally unworkable.

Unlike GNU grep that takes its command line arguments literally as file=
s
and directories, we use them merely as pathspec filters, so...

> 	$ git grep -l --directories=3Dskip GNU compat/*

=2E.. while I think you should be able to compensate for this kind  of
"off-by-one" and make it appear to work, I do not think there is a good
definition of which level it should stop if you run it with something
like this (notice the single-quote around the pathspec to prevent it fr=
om
getting expanded by the shell):

	git grep GNU 'compat/*/*'
