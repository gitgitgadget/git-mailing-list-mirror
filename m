From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: configure: is NEEDS_SSL_WITH_CRYPTO test correct?
Date: Tue, 21 Jul 2009 10:29:32 -0500
Message-ID: <TV3HaUyeB7DH8euAZskzz1ryGof9Nj4sfUP9TBnI8xKT3cuwWrFLpQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 17:29:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTHHn-0003I9-Nh
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 17:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbZGUP3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 11:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754911AbZGUP3j
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 11:29:39 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58342 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484AbZGUP3j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 11:29:39 -0400
Received: by mail.nrlssc.navy.mil id n6LFTXQ3026200; Tue, 21 Jul 2009 10:29:33 -0500
X-OriginalArrivalTime: 21 Jul 2009 15:29:33.0224 (UTC) FILETIME=[0C1D9A80:01CA0A18]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123667>


>From configure.ac, but re-nested:

AC_CHECK_LIB([crypto], [SHA1_Init],
   [NEEDS_SSL_WITH_CRYPTO=],
   [AC_CHECK_LIB([ssl], [SHA1_Init],
      [NEEDS_SSL_WITH_CRYPTO=YesPlease NEEDS_SSL_WITH_CRYPTO=],
      [NO_OPENSSL=YesPlease])])

should it rather be:

AC_CHECK_LIB([crypto], [SHA1_Init],
   [NEEDS_SSL_WITH_CRYPTO=],
   [AC_CHECK_LIB([ssl], [SHA1_Init],
      [NEEDS_SSL_WITH_CRYPTO=YesPlease],
      [NEEDS_SSL_WITH_CRYPTO= NO_OPENSSL=YesPlease])])

Notice the pairing of "action" parameters to the inner AC_CHECK_LIB().
The first one seems to set, and then unset NEEDS_SSL_WITH_CRYPTO.  Not
sure what is going on there.  Was the unsetting of NEEDS_SSL_WITH_CRYPTO
supposed to go into the action-if-not-found section?

-brandon
