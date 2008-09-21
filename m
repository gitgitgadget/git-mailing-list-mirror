From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 0/6] gitweb pathinfo improvements
Date: Sun, 21 Sep 2008 22:57:37 +0200
Message-ID: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Lea Wiemann <lewiemann@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 21 22:58:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhW13-0002jI-EJ
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 22:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbYIUU5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 16:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752505AbYIUU5a
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 16:57:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:19442 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbYIUU53 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 16:57:29 -0400
Received: by nf-out-0910.google.com with SMTP id d3so407275nfc.21
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 13:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=/eZQgr8xDvt6l7YfIBTuwJu4z1H79hzgPq7Ie7E2SPc=;
        b=FYdE4GOgPUK6nECgC5a/TImcjx33WB2eC239y5fO4X8YlbS5zlG4we2aewsciF/kIn
         I1T0/fSrO8v/5+wq71Q1pp+0bx9NILDlTSO+hRWm7VUhxvE9vUeZRBVt0Ykn1ELTRIml
         C8kIjl+7oLHuV1dJohi4HZb24Wgxx6ZDS0eCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=n9HbNr66FvMzCM41vAvujxzviEs4fxk+V7h2B7KrfW4Bsw3/I1xcb19N6vgdaJPbeq
         FDjBttEbNVcr2kgI+QEvWsWKuszQ2wRQw+SvtMfuwU8LcL0EjP4asrSegNlMS7ssZyWb
         5PajK/Q5/Fq26Jer0y1hb4N3NlmDocrDmxKfk=
Received: by 10.210.120.17 with SMTP id s17mr3823357ebc.85.1222030647738;
        Sun, 21 Sep 2008 13:57:27 -0700 (PDT)
Received: from localhost ( [94.37.17.250])
        by mx.google.com with ESMTPS id 3sm6423610eyi.5.2008.09.21.13.57.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Sep 2008 13:57:26 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96432>

This is a resend, with some improvements and a proper cover
letter, of my patchset to extend PATH_INFO support in gitweb.
Hopefully I'm doing it the right way this time :)

The basic idea is to have gitweb support paths in the form of
project/action/parent:/filename..hash:/filename
(modulo missing parameters) and to generate them when use_pathinfo
is enabled.

For backwards compatibility, old-style urls $project/$hash are
still supported (unless $hash is a named ref that happens to
coincide with a gitweb action). Also, CGI parameters are still
used when the path_info form would be ambiguous (e.g. filenames
with two consecutive dots in their name).

Giuseppe Bilotta (6):
  gitweb: action in path with use_pathinfo
  gitweb: use_pathinfo filenames start with /
  gitweb: parse parent..current syntax from pathinfo
  gitweb: use_pathinfo creates parent..current paths
  gitweb: remove PATH_INFO from $my_url and $my_uri
  gitweb: prevent double slashes in PATH_INFO hrefs

 gitweb/gitweb.perl |  161 +++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 122 insertions(+), 39 deletions(-)
