From: Max Horn <max@quendi.de>
Subject: Why is ident_is_sufficient different on Windows?
Date: Wed, 6 Feb 2013 14:06:55 +0100
Message-ID: <991CBC1C-912C-4DD6-B911-93F6B41D895E@quendi.de>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 14:07:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U34ii-0004np-9Y
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 14:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578Ab3BFNHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 08:07:00 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:41569 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752423Ab3BFNG7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Feb 2013 08:06:59 -0500
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1U34iF-0006O8-Es; Wed, 06 Feb 2013 14:06:55 +0100
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1360156019;0c96cf4d;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215576>

Hi there,

while trying to understand which parts of the author & committer identity are mandatory (name, email, or both), I ended up in ident.c, looking at ident_is_sufficient(), and to my surprise discovered that this seems to differ between Windows (were both are mandatory) and everyone else:

static int ident_is_sufficient(int user_ident_explicitly_given)
{
#ifndef WINDOWS
	return (user_ident_explicitly_given & IDENT_MAIL_GIVEN);
#else
	return (user_ident_explicitly_given == IDENT_ALL_GIVEN);
#endif
}


According to git blame, this was introduced here:

commit 5aeb3a3a838b2cb03d250f3376cf9c41f4d4608e
Author: Junio C Hamano <gitster@pobox.com>
Date:   Sun Jan 17 13:54:28 2010 -0800

    user_ident_sufficiently_given(): refactor the logic to be usable from elsewhere


The commit message sounds as if this was only a refactoring, but the patch to me look as if it changes behaviour, too. Of course this could very well be false, say due to code elsewhere that already caused Windows to behave differently; I wouldn't know.


Still, I wonder: Why does this difference exist?


Cheers,
Max
