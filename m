From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Git 2.3.7 hangs on fetch but not clone
Date: Sun, 6 Dec 2015 17:12:12 -0500
Message-ID: <001f01d13073$28d428a0$7a7c79e0$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: "'git mailing list'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 06 23:12:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5hXa-0004S4-H9
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 23:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766AbbLFWMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 17:12:18 -0500
Received: from elephants.elehost.com ([216.66.27.132]:47437 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745AbbLFWMR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 17:12:17 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id tB6MCEI1010390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 6 Dec 2015 17:12:15 -0500 (EST)
	(envelope-from rsbecker@nexbridge.com)
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdEwb1ZvbxZcoM1VSWKtwB/DkFhMaQ==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282066>

I have some strange behaviour I am trying to diagnose on the NonStop port of
git 2.3.7. The situation is we have a *LARGE* cloned repository with some
local modifications of openssl, which we are trying to clone again for a
Jenkins build. The command:
	git clone /local/openssl openssl
works fine and rapidly (well under 30 seconds), but with a newly created
empty repo, simulating what the Jenkins Git plugin does:
	mkdir /local/test/openssl
	cd /local/test/openssl
	git init /local/test/openssl
	git -c core.askpass=true fetch --verbose --progress
/local/git/openssl +refs/heads/*:refs/remotes/origin/*
does the usual:
	remote: Counting objects: 113436, done.
	remote: Compressing objects: 100% (23462/23462), done.
then hangs forever without creating any files in the working directory.
There are also no files or directories modified since the init operation.
Processes left around, and without consuming resources, are:
1493172290 2030043151 - 15:58:29       00:15 git pack-objects --revs --thin
--stdout --progress --delta-base-offset --include-tag
452984908  402653262 - 15:58:29       00:00 git -c core.askpass=true fetch
--verbose --progress /local/git/openssl +refs/heads/*:refs/remotes/origin/*
402653262 1694498903 - 15:58:28       00:00 git -c core.askpass=true fetch
--verbose --progress /local/git/openssl +refs/heads/*:refs/remotes/origin/*
2030043151  402653262 - 15:58:29       00:00 git-upload-pack
/local/git/openssl

This does not happen for our smaller repositories. Any pointers on where to
look would be appreciated.

Kindly,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.
