From: Eric Brunson <brunson@brunson.com>
Subject: Unexpected behavior using -c to pass url.<site>.insteadof
Date: Thu, 08 May 2014 16:35:26 -0600
Message-ID: <536C06AE.1080103@brunson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 00:35:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiWua-00075V-HA
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 00:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755940AbaEHWf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 18:35:29 -0400
Received: from www.brunson.com ([72.249.185.94]:55344 "EHLO mail.brunson.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755733AbaEHWf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 18:35:28 -0400
Received: from [129.46.10.146] (ebrunson-lnx.qualcomm.com [129.46.10.146])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.brunson.com (Postfix) with ESMTP id E41396C388
	for <git@vger.kernel.org>; Thu,  8 May 2014 16:35:27 -0600 (MDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248460>

Is this the expected operation using git -c to override gitconfig settings?

This is default behavior:

     $ git ls-remote git://original.site/origin
     fatal: unable to connect to original.site:

This is what I expected, override with an insteadof url using -c on the 
command line:

     $ git -c 
url.ssh://replace.site:1234/.insteadof=git://original.site/ ls-remote 
git://original.site/origin
     ssh: Could not resolve hostname replace.site: Name or service not known

Create a URL in ~/.gitconfig:

     $ git config --global url.ssh://other.site/.insteadof 
git://original.site/
     $ cat ~/.gitconfig
     [url "ssh://other.site/"]
         insteadof = git://original.site/

Works as expected, correctly substitutes other.site for original.site:

     $ git ls-remote git://original.site/origin
     ssh: Could not resolve hostname other.site: Name or service not known

The same -c command as above doesn't override the ~/.gitconfig setting, 
still substitutes other.site:

     $ git -c 
url.ssh://replace.site:1234/.insteadof=git://original.site/ ls-remote 
git://original.site/origin
     ssh: Could not resolve hostname other.site: Name or service not known

I've also reproduced in git 1.9.0 and 2.0.0-rc2.

Am I simply misunderstanding the documentation, it doesn't really 
discuss what should happen with multivar settings?

Thanks,
e.
