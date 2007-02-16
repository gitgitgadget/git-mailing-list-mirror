From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] Add git-unbundle - unpack objects and references for
 disconnected transfer
Date: Fri, 16 Feb 2007 16:58:01 -0500
Message-ID: <45D628E9.20605@verizon.net>
References: <28763990.2658921171630394111.JavaMail.root@vms064.mailsrvcs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 23:18:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIBPE-0001Zn-54
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 23:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946146AbXBPWSN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 17:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946153AbXBPWSN
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 17:18:13 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:38603 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946146AbXBPWSM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 17:18:12 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDK001YRT0O1YF0@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 16 Feb 2007 15:58:04 -0600 (CST)
In-reply-to: <28763990.2658921171630394111.JavaMail.root@vms064.mailsrvcs.net>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39953>

Mark Levedahl wrote:
>> Also as Shawn pointed out, the script too heavily depends on GNU
>> tar.  Can we do something about it
>>     
This one is easy, make tmp a directory, then build the tar file in that 
directory so the archive members don't include the tmp name, then just 
move the tar file to where it is needed...

tmp="$GIT_DIR/bundle_tmp$$"
references="$tmp/references"
pack="$tmp/pack"
trap 'rm -rf "$tmp"' 0 1 2 3 15

mkdir "$tmp" &&
echo "v1 git-bundle" > "$version" &&
------

# create the tar file, clean up
cd "$tmp" &&
tar cf bundle prerequisites references version pack &&
cd - &&
mv "$tmp/bundle" "$bfile" &&
rm -rf "$tmp"

I believe that as this works, tar needs only to understand c, f, and -O. 
It is easy enough to search for gtar and use that, or allow user to 
define TAR. So, I think this is a non-issue.

Mark
