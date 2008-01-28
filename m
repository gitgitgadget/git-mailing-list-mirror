From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix off by one error in prep_exclude.
Date: Mon, 28 Jan 2008 00:46:39 -0800
Message-ID: <7vprvmuykw.fsf@gitster.siamese.dyndns.org>
References: <47975FE6.4050709@viscovery.net>
	<1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com>
	<alpine.LSU.1.00.0801272043040.23907@racer.site>
	<7v3asiyk2i.fsf@gitster.siamese.dyndns.org>
	<20080128003404.GA18276@lintop>
	<7vodb6wtix.fsf@gitster.siamese.dyndns.org>
	<479D805E.3000209@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jan 28 09:47:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJPeZ-00049C-6T
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 09:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757981AbYA1Iqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 03:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756154AbYA1Iqt
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 03:46:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53711 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234AbYA1Iqr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 03:46:47 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EC96569F6;
	Mon, 28 Jan 2008 03:46:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6071B69EF;
	Mon, 28 Jan 2008 03:46:41 -0500 (EST)
In-Reply-To: <479D805E.3000209@viscovery.net> (Johannes Sixt's message of
	"Mon, 28 Jan 2008 08:12:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71863>

Johannes Sixt <j.sixt@viscovery.net> writes:

> The "problem" is not only with git-clean, but also in others, like
> git-ls-files. Try this in you favorite repository:
>
>    $ git ls-files -o /*bin
>
> The output does not make a lot of sense. (Here it lists the contents of
> /bin and /sbin.) Not that it hurts with ls-files, but
>
>    $ git clean -f /
>
> is basically a synonym for
>
>    $ rm -rf /

Yeah, /*bin is not inside the repository so it should not even
be reported as "others".  Shouldn't the commands detect this and
reject feeding such paths outside the work tree to the core,
which always expect you to talk about paths inside?
