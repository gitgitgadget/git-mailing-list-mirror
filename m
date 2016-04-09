From: "Tom G. Christensen" <tgc@jupiterrise.com>
Subject: Hardcoded #!/bin/sh in t5532 causes problems on Solaris
Date: Sat, 9 Apr 2016 22:27:37 +0200
Message-ID: <570965B9.9040207@jupiterrise.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 22:27:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aozTz-0001Le-GC
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 22:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553AbcDIU1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 16:27:42 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:33813 "EHLO
	homiemail-a25.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752641AbcDIU1m (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Apr 2016 16:27:42 -0400
Received: from homiemail-a25.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a25.g.dreamhost.com (Postfix) with ESMTP id 3107E6780B8
	for <git@vger.kernel.org>; Sat,  9 Apr 2016 13:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=to:from
	:subject:message-id:date:mime-version:content-type:
	content-transfer-encoding; s=jupiterrise.com; bh=REjlAq3iATmcMYx
	4q0ulXt5Gsz0=; b=MNvPFZFqvDC57w9DK/hNqTL8lBCv/1Q1GNrQp+o2BvOxlTm
	x9jhd1tyzLVMjOMC88en+QKas5mKq6RT1oQXr8MB7PxAERK406ajKvxULtp9lbaC
	3HwKTWwAiWI5gOOPqDkY/fCjh5MNCiwIcByDFs9qxPboIEGNhPBkvEqsTtXo=
Received: from localhost6.localdomain6 (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: tgc99@jupiterrise.com)
	by homiemail-a25.g.dreamhost.com (Postfix) with ESMTPSA id B432867808D
	for <git@vger.kernel.org>; Sat,  9 Apr 2016 13:27:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by localhost6.localdomain6 (8.14.4/8.14.4) with ESMTP id u39KRbs9031486
	for <git@vger.kernel.org>; Sat, 9 Apr 2016 22:27:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291125>

Hello,

Looking at the testsuite results on Solaris I see a failure in t5532.3.

Running the testsuite with -v -i revealed a shell syntax error:

proxying for example.com 9418
./proxy: syntax error at line 3: `cmd=$' unexpected
not ok 3 - fetch through proxy works
#
#               git fetch fake &&
#               echo one >expect &&
#               git log -1 --format=%s FETCH_HEAD >actual &&
#               test_cmp expect actual
#


Looking a t5532-fetch-proxy.sh the problem is obvious, it writes out a 
helper script which explicitly uses #!/bin/sh but fails to take into 
account that systems like Solaris has an ancient /bin/sh that knows 
nothing about POSIX things like $().
Replacing $() with `` was enough to make the test pass.

-tgc
