From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] Flush progress message buffer in display().
Date: Mon, 19 Nov 2007 12:39:32 -0800
Message-ID: <7voddqm0l7.fsf@gitster.siamese.dyndns.org>
References: <200711192048.58864.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Nov 19 21:40:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuDPW-0001AK-6P
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 21:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbXKSUjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 15:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbXKSUjp
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 15:39:45 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:46849 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbXKSUjo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 15:39:44 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E84BF2F0;
	Mon, 19 Nov 2007 15:40:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6989E96A2B;
	Mon, 19 Nov 2007 15:39:58 -0500 (EST)
In-Reply-To: <200711192048.58864.johannes.sixt@telecom.at> (Johannes Sixt's
	message of "Mon, 19 Nov 2007 20:48:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65498>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> I need this patch on Windows because appearently progress output is buffered
> by stdio. Why doesn't Linux/glibc's stdio buffer output that goes to a pipe?
> ...
> ... What is flushing the progress
> output?

The standard error stream is not "fully buffered":

    http://www.opengroup.org/onlinepubs/000095399/functions/xsh_chap02_05.html#tag_02_05

Not "fully buffered" means either "unbuffered" or "line
buffered".  Because the progress display does not terminate its
line, it means that the additional fflush(stderr) you added are
needed if the stream is line buffered (still conforming).
