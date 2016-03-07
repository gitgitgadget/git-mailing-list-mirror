From: "Anton Wuerfel" <anton.wuerfel@fau.de>
Subject: Adding RFC 3161 timestamps to git tags
Date: Mon, 7 Mar 2016 15:15:16 +0100
Message-ID: <9bf0ad940a5ce20c0c3742a3dfca70f8.squirrel@faumail.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: i4passt@cs.fau.de, phillip.raffeck@fau.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 15:23:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acw48-0006ji-GA
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 15:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbcCGOXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 09:23:17 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:60195 "EHLO
	mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752350AbcCGOXP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Mar 2016 09:23:15 -0500
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Mar 2016 09:23:15 EST
Received: from boeck2.rrze.uni-erlangen.de (boeck2.rrze.uni-erlangen.de [131.188.11.32])
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTP id 3qJhX463qyz8xMp
	for <git@vger.kernel.org>; Mon,  7 Mar 2016 15:15:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fau.de; s=fau-2013;
	t=1457360116; bh=ZrGd4Uw5KotQ8ShJWatC1A8hFM+s4bulSwkZOu7ZKmw=;
	h=Date:Subject:From:To:Cc:From:To:CC:Subject;
	b=GOM0O3hXTkrWZbmoZy3eZQm9NPwWFNPHreF9Ewe+WAdIAH8SuJBs3dvy+YsXEpyqD
	 2UtTelyYgTHCkWUJw47+28tVFbZmHrC0mgjn7Tb2IUhmmSCnUZJY/7wRmQvxHR4ryL
	 glAqcVz+8eGX4gDikM4FUqKFIwznblTJJE4YCA/84smCU5x7m246YOSIerLMKhaXPT
	 QpMp2DeWKHlKffLQxmHI42Up822Cv3GnIZIYzCP3886q0pmXtUK49ExIR6FTKd3Jpb
	 wORTUwth5cjIHV8+AIExZopMPsiwsERd0yy1HNSBPNVejgNGIECTNM/DNzr5DJze/+
	 0+b4QwS3h/9hg==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20])
	by boeck2.rrze.uni-erlangen.de (boeck2.rrze.uni-erlangen.de [131.188.11.32]) (amavisd-new, port 10026)
	with LMTP id AeRl_slD4uUi; Mon,  7 Mar 2016 15:15:16 +0100 (CET)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTP id 3qJhX412gzz8xMd;
	Mon,  7 Mar 2016 15:15:16 +0100 (CET)
X-RRZE-Submit-IP: 131.188.11.38
Received: from faumail.uni-erlangen.de (smtp.fau.de [131.188.11.38])
	by smtp.uni-erlangen.de (Postfix) with ESMTP id 3qJhX40gJJzHpw5;
	Mon,  7 Mar 2016 15:15:16 +0100 (CET)
Received: from 131.188.42.190
        by faumail.uni-erlangen.de with HTTP;
        Mon, 7 Mar 2016 15:15:16 +0100
User-Agent: SquirrelMail/1.4.23 [SVN]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288390>

Hello,

as part of an university project we plan to implement time stamp
signatures according to RFC 3161. This enables users to create and verify
cryptographic time stamp signatures to prove that a commit existed at a
certain point in time.

As a long-term goal, we would like to get this new feature accepted into
upstream, so we are very interested in your opinions and suggestions for
our approach described in the following.

We plan to add new command line options to git tag and call openssl
similar to how "git tag -s" is calling gpg. The time stamp query generated
by openssl will be sent to the time stamping authority via libcurl.
Verification of timestamps will be possible via git verify-tag.

In order to store time stamp signatures, the file format for git tags
needs to be extended. Similar to how gpg signatures are stored, we would
store the signed time stamp responses in base64 surrounded by BEGIN and
END tags:
-----BEGIN RFC3161-----
Issuer: [issuer-name]
[time stamp response in base64]
-----END RFC3161-----

We plan to offer git config options to configure, which timestamping
authority to use and where trusted certificates are stored.

Regards,
Phillip Raffeck
Anton Wuerfel
