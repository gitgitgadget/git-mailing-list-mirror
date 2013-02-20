From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [BUG] Infinite make recursion when configure.ac changes
Date: Wed, 20 Feb 2013 09:44:58 +0100
Message-ID: <51248D0A.50603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 20 09:45:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U85Ix-0000Ku-6I
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 09:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756474Ab3BTIpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 03:45:04 -0500
Received: from mail-ea0-f171.google.com ([209.85.215.171]:53353 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab3BTIpD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 03:45:03 -0500
Received: by mail-ea0-f171.google.com with SMTP id c13so3388349eaa.16
        for <git@vger.kernel.org>; Wed, 20 Feb 2013 00:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=mJjN7HldndP8hLvgrkeulD/JyFnblZhJDVB5u96Od4s=;
        b=xIDs9hBgu+gKNLuuAIDnc6VGQZStbL4kdfwSQUbtr8HZBZ9Wzh1MEIlwWe8AjpYNlj
         i9y5ood75rVXJJjarhGof/OJQaMFvjmlzrlmogWkYtMSVFVxnIAI+3FPz+NmqePEPVwq
         qnPWnHyVILE5FGNqAg1vcud6NuWepugr3nopLhcGl9XcWD472F52R8AgtrlMIgtEEn3h
         trteKkC2qOjXuddMVySPSmO6djfV6IDSJBw6W0SaL5vo7SB6u5vg2pFLLcaoXkL6HprO
         v55P09AyWebq98JEtlEpbF3QtLJQ+W6ABrCKcUSd2rYFrrcy1AHYKfBdpFKluYccb+8M
         7h7A==
X-Received: by 10.14.216.2 with SMTP id f2mr66794389eep.44.1361349901131;
        Wed, 20 Feb 2013 00:45:01 -0800 (PST)
Received: from [192.168.178.20] (host137-94-dynamic.4-87-r.retail.telecomitalia.it. [87.4.94.137])
        by mx.google.com with ESMTPS id k7sm105341410een.8.2013.02.20.00.44.59
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Feb 2013 00:45:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216693>

>From a pristine master checkout:

  $ make configure && ./configure make
  ... # All successfull
  $ touch configure.ac
  $ make
    GEN config.status
  make[1]: Entering directory `/storage/home/stefano/git/src'
    GEN config.status
  make[2]: Entering directory `/storage/home/stefano/git/src'
    GEN config.status
  make[3]: Entering directory `/storage/home/stefano/git/src'
    GEN config.status
  make[4]: Entering directory `/storage/home/stefano/git/src'
    GEN config.status
  make[5]: Entering directory `/storage/home/stefano/git/src'
    GEN config.status
  ...

and I have to hit ^C to interrupt that recursion.

This seems due to the change in commit v1.7.12.4-1-g1226504: the
issue is still present there, but no longer is in the preceding
commit 7e201053 (a.k.a. v1.7.12.4).

I haven't investigated this any further for the moment.

Regards,
  Stefano
