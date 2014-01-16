From: Yuri <yuri@rawbw.com>
Subject: git quietly fails on https:// URL, https errors are never reported
 to user
Date: Thu, 16 Jan 2014 04:27:03 -0800
Message-ID: <52D7D017.107@rawbw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 16 13:46:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3mLP-0006J6-V5
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 13:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbaAPMqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 07:46:44 -0500
Received: from shell0.rawbw.com ([198.144.192.45]:55169 "EHLO shell0.rawbw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093AbaAPMqn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 07:46:43 -0500
X-Greylist: delayed 1180 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jan 2014 07:46:43 EST
Received: from eagle.yuri.org (stunnel@localhost [127.0.0.1])
	(authenticated bits=0)
	by shell0.rawbw.com (8.14.4/8.14.4) with ESMTP id s0GCR33w089032
	for <git@vger.kernel.org>; Thu, 16 Jan 2014 04:27:03 -0800 (PST)
	(envelope-from yuri@rawbw.com)
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240511>

On one of my FreeBSD systems I can't clone github through https URL.
It only says "Cloning into 'MyProject'...", writes some files, but then 
deletes everything, without printing anything else at all. Exit code is 128.

Replacing https:// with git:// makes it work fine.

While debugging, I find that remove_junk() deletes all directories from 
under __cxa_finalize.
Before this, exit(128) is called from recvline_fh ("Debug: Remote helper 
quit.) And this function in turn is called from under
refs = transport_get_remote_refs(transport);

I think you need to make sure that any https errors (in this and other 
locations) are reported to the user, and git never quits on error 
without saying what the error is.

git-1.8.5.2

Yuri
