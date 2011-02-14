From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [1.8.0 RFD] Homogeneous use of short options
Date: Mon, 14 Feb 2011 16:04:00 +0100
Message-ID: <4D594460.1040206@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 14 16:07:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp019-0006mA-Ip
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 16:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554Ab1BNPHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 10:07:07 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37432 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753393Ab1BNPHF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 10:07:05 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id AEBCD20424
	for <git@vger.kernel.org>; Mon, 14 Feb 2011 10:07:04 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 14 Feb 2011 10:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:subject:content-type:content-transfer-encoding; s=smtpout; bh=3SgFra93eaNqzTDmXkxHEsAziKI=; b=R0GcEZRIhtm2bwoiKF442YWEoljVUUra9hAR0tWL/lfiWn9VIoNupHw8w52jr7F8IHnz6DMxjNLvuwd7UZWTzbvaBTnPsynVFMDk9Vp/MUFtz4rB3oj1lQW6RqK0yntjW0ufoBClfc6ZKnkQmKJUHhdZavkV08Ckvtj9HFcYckQ=
X-Sasl-enc: AiirPz/a5kU9OVG9H0OwJ7mTIHthz36jcDMYPF/mNjll 1297696024
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5A0434408CB
	for <git@vger.kernel.org>; Mon, 14 Feb 2011 10:07:04 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166717>

Proposal:
Make our use of short options more homogeneous.

I have put together a list of options which are used by the "most common
commands", using the output of "git --help-all":

http://repo.or.cz/w/git/mjg.git/blob/options.txt

(scroll down for the short options)

This leaves out a few commands with different option parsing (diff, log,
rebase, show) but indicates that we're doing a good job already. A few
notable outliers:

add -A: Why capital A? Compare commit -a etc.

commit -n, fetch -n, merge -n: These are REALLY bad! Users should be
able to rely on '-n' being '--dry-run' or at least being no-op to their
repo, like clone/grep/tag -n.

tag -v: This is not a real problem, but users have certain expections
for "-f,-h,-n,-v" which we should break as rarely as possible. OTOH,
what would "verbose" mean for tag? (NB: tag.txt is grossly wrong.)

grep -?: This tries to be compatible with GNU grep, so it's a natural
outlier.

Risks:
Users and scripts may obviously depend on the current options names.

Migration plan:
Introduce new options first (1.7.x) along with warnings in the release
notes (optionally, make the commands output warnings). Then change the
behavior in 1.8.0.

TODO:
Generate an option list for the other common commands.

I'll also follow up with a little series fixing inconsistencies in the
descriptions.
