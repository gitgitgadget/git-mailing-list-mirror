From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add autoconf tests for pthreads
Date: Mon, 03 Nov 2008 14:07:14 -0800
Message-ID: <7vd4hcv4z1.fsf@gitster.siamese.dyndns.org>
References: <1225736068-97988-1-git-send-email-david.syzdek@acsalaska.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com
To: david.syzdek@acsalaska.net
X-From: git-owner@vger.kernel.org Mon Nov 03 23:08:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx7bI-0007MG-F6
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 23:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbYKCWHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 17:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753377AbYKCWHb
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 17:07:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbYKCWHa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 17:07:30 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F086C92627;
	Mon,  3 Nov 2008 17:07:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 69F4792624; Mon,  3 Nov 2008 17:07:16 -0500 (EST)
In-Reply-To: <1225736068-97988-1-git-send-email-david.syzdek@acsalaska.net>
 (david syzdek's message of "Mon, 3 Nov 2008 09:14:28 -0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CE07A92C-A9F3-11DD-86AA-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100003>

david.syzdek@acsalaska.net writes:

> +# Define PTHREAD_LIBS to the linker flag used for Pthread support and define
> +# THREADED_DELTA_SEARCH if Pthreads are available.

This may affect platforms that do have pthread library but choose not to
use threaded delta search for whatever reason by suddenly turning it on.

Which arguably may be a good thing to do, but it is a change unrelated to
porting to FreeBSD.

> +AC_LANG_CONFTEST([AC_LANG_PROGRAM(
> +  [[#include <pthread.h>]],
> +  [[pthread_mutex_t test_mutex;]]
> +)])
> +${CC} -pthread conftest.c -o conftest.o > /dev/null 2>&1
> +if test $? -eq 0;then
> + PTHREAD_LIBS="-pthread"
> + THREADED_DELTA_SEARCH=YesPlease
> +else
> + ${CC} -lpthread conftest.c -o conftest.o > /dev/null 2>&1

Maybe I am old fashioned, but having "-library" very near the beginning of
the command line and naming the final link product (i.e. not with -c) *.o
makes me go "Huh?"  If it were written like this,

	$CC -o conftest$ac_exeext conftest.c -lpthread

it might have been easier to swallow.  I dunno.
