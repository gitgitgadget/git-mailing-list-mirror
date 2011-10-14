From: Michael Schubert <mschub@elegosoft.com>
Subject: [BUG] remote-curl.c: honor pushurl
Date: Fri, 14 Oct 2011 17:37:40 +0200
Message-ID: <4E985744.6050904@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: rctay89@gmail.com
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 14 17:38:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REjqO-0004gX-1h
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 17:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933273Ab1JNPik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 11:38:40 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:53266 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933270Ab1JNPij (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 11:38:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 9EB9FDE88A;
	Fri, 14 Oct 2011 17:38:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jzntShOEvWs5; Fri, 14 Oct 2011 17:38:33 +0200 (CEST)
Received: from [192.168.1.101] (g231230129.adsl.alicedsl.de [92.231.230.129])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 56CE9DE898;
	Fri, 14 Oct 2011 17:38:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20111001 Thunderbird/7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183583>

When doing a push (fetch, ..) over http(s), git calls git-remote-http to
communicate with the server.

	git-remote-http <remote> [<url>]

Git correctly honors a configured pushurl and passes it to git-remote-http,
but git-remote-http is initiating the http connection with the url defined
for remote (remote->url) rather than the passed url. This undermines the
purpose of a config like

	url = https://example.com/repo.git
	pushurl = https://user@example.com/repo.git

Introduced around 888692b7 - CC'ing Tay Ray Chuan. (I don't know if it was
working before, though.)
