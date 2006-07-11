From: sf <sf@b-i-t.de>
Subject: [RFC]: Pack-file object format for individual objects (Was: Revisiting
 large binary files issue.)
Date: Tue, 11 Jul 2006 11:40:11 +0200
Message-ID: <44B371FB.2070800@b-i-t.de>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jul 11 11:41:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0Ejd-0003z4-CZ
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 11:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWGKJkt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 05:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWGKJkt
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 05:40:49 -0400
Received: from main.gmane.org ([80.91.229.2]:7296 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750821AbWGKJks (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 05:40:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G0EjO-0003w0-Ks
	for git@vger.kernel.org; Tue, 11 Jul 2006 11:40:38 +0200
Received: from ip-213157015184.dialin.heagmedianet.de ([213.157.15.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Jul 2006 11:40:38 +0200
Received: from sf by ip-213157015184.dialin.heagmedianet.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 11 Jul 2006 11:40:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip-213157015184.dialin.heagmedianet.de
User-Agent: Thunderbird 1.5.0.4 (X11/20060606)
In-Reply-To: <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23700>

Linus Torvalds wrote:
...
> The problem is that the individual object disk format isn't actually the 
> same as the pack-file object format for one object. The header is 
> different: a pack-file uses a very dense bit packing, while the individual 
> object format is a bit less dense.

I just stumbled over the same fact and asked myself why there are still
two formats. Wouldn't it make more sense to use the pack-file object
format for individual objects as well?

As it happens individual objects all start with nibble 7 (deflated with
default _zlib_ window size of 32K) whereas in the pack-file object
format nibble 7 indicates delta entries which never occur as individual
files.

Roadmap for using pack-file format as individual object disk format:

Step 1. When reading individual objects from disk check the first nibble
and decode accordingly (see above).

Step 2. When writing individual objects to disk write them in pack-file
object format. Make that optional (config-file parameter, command line
option etc.)?

Step 3. Remove code for (old) individual object disk format.

Please comment.

Regards
	Stephan
