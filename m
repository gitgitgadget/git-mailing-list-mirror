From: Yuri <yuri@rawbw.com>
Subject: 'git log' escape symbols shown as ESC[33 and ESC[m
Date: Thu, 16 Jan 2014 16:34:01 -0800
Message-ID: <52D87A79.6060600@rawbw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 01:34:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3xNw-0001YD-8r
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 01:34:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbaAQAeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 19:34:04 -0500
Received: from shell0.rawbw.com ([198.144.192.45]:55647 "EHLO shell0.rawbw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994AbaAQAeD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 19:34:03 -0500
Received: from eagle.yuri.org (stunnel@localhost [127.0.0.1])
	(authenticated bits=0)
	by shell0.rawbw.com (8.14.4/8.14.4) with ESMTP id s0H0Y11J062986
	for <git@vger.kernel.org>; Thu, 16 Jan 2014 16:34:01 -0800 (PST)
	(envelope-from yuri@rawbw.com)
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240548>

When I run 'git log' on FreeBSD-9.2, I get output like this:
ESC[33mcommit 398e78c62fd507a317de7c2abb8e25c9fac7ac9eESC[m
Merge: 5fb8f6e d2138ba
...

ESC is white on black background.

Why ESC[33m aren't expanded by the terminal? Is this because git prints 
an unsupported sequence?

Hex of what git writes to terminal is here:
0x0000 1b5b 3333 6d63 6f6d 6d69 7420 6636 6432 6136 3032 3965 6661 6439 
6635 6334 3161 6261  |.[33mcommit f6d2a6029efad9f5c41aba|
0x0022 3961 3830 6131 3032 3138 6332 6333 3465 6662 1b5b 6d0a 4d65 7267 
653a 2033 3938 6537  |9a80a10218c2c34efb.[m.Merge: 398e7|

I think it tries to print the line in yellow (color code 33), and prints 
the wrong sequence. The correct sequence would be:
\033[1;33mString Goes Here\033[0m
It misses "1;" in the beginning, and "0" in the end, this is why the 
sequence is not interpreted.

Why does it print a wrong sequence? Is this because this is some kind of 
linuxism that doesn't work on FreeBSD maybe?
Also, there are the termcap functions that allow to determine what does 
the actual terminal supports. You should first check for cap bits 
corresponding to the features you expect, if you expect something uncommon.

Yuri
