From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] log and rev-list: Fixed newline termination issues
 with --graph
Date: Mon, 07 Apr 2008 17:58:43 -0700
Message-ID: <7vfxtxnovw.fsf@gitster.siamese.dyndns.org>
References: <1207518444-5955-1-git-send-email-adam@adamsimpkins.net>
 <1207555281-9362-1-git-send-email-adam@adamsimpkins.net>
 <1207555281-9362-2-git-send-email-adam@adamsimpkins.net>
 <7vod8mqdlw.fsf@gitster.siamese.dyndns.org>
 <7vwsnaoxlz.fsf@gitster.siamese.dyndns.org>
 <7vmyo5nr2h.fsf@gitster.siamese.dyndns.org>
 <5d46db230804071725r44694e76l3d6e63aabc67f372@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org,
	"Adam Simpkins" <adam@adamsimpkins.net>
To: "Govind Salinas" <blix@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 03:00:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jj2CV-00076S-CH
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 03:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756069AbYDHA7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 20:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755837AbYDHA7z
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 20:59:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45419 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840AbYDHA7y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 20:59:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A3340DFDB;
	Mon,  7 Apr 2008 20:58:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B7FF0DFCC; Mon,  7 Apr 2008 20:58:51 -0400 (EDT)
In-Reply-To: <5d46db230804071725r44694e76l3d6e63aabc67f372@mail.gmail.com>
 (Govind Salinas's message of "Mon, 7 Apr 2008 19:25:28 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78992>

"Govind Salinas" <blix@sophiasuchtig.com> writes:

> Shouldn't whatever option is used here respect line_terminator such
> that it will use NULL bytes when -z is used?

Yes but it is orthogonal to what is being discussed.  What the patch shows
is how to allow --pretty=format: to conditionally do what --pretty=oneline
already does.  If the current --pretty=oneline forces "\n" under -z (I
haven't checked if that is the case) that might be something we may want
to change.  Once you do so, you would get the same fix for --pretty=format
for free ;-)

Also when you talk about line_terminator, you need to be careful to
realize that it is _not_ really a "line_terminator".  For example, we do
not substitute 's/\n/\0/' the EOLN in multi-line log messages.  Neither do
we use NUL terminated lines in diff nor stat output when -p and --stat are
in effect.  They are more like "separator between parts of output".
