From: sed <sed.nivo@gmail.com>
Subject: Casting and dereferencing of pointer
Date: Sat, 16 Aug 2008 09:33:30 +0000 (UTC)
Message-ID: <loom.20080816T093019-717@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 16 11:41:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUIHY-00024U-4W
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 11:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbYHPJkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 05:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbYHPJkJ
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 05:40:09 -0400
Received: from main.gmane.org ([80.91.229.2]:58978 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864AbYHPJkI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 05:40:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KUIGQ-00016P-Id
	for git@vger.kernel.org; Sat, 16 Aug 2008 09:40:02 +0000
Received: from ip-91-200-114-146.network.lviv.ua ([ip-91-200-114-146.network.lviv.ua])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Aug 2008 09:40:02 +0000
Received: from sed.nivo by ip-91-200-114-146.network.lviv.ua with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Aug 2008 09:40:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 91.200.114.146 (Opera/9.51 (Windows NT 5.1; U; en))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92538>

Maybe I should not post in this group but anyway...

Please look at my code that do the same, except of endianness.
static void _parseItems(const unsigned char *pBuffer)
{
  unsigned int itemSize;
  itemSize = *((unsigned int*)pBuffer); // this give system fault
  memcpy(&itemSize, pBuffer, sizeof(unsigned int)); // this works well
  .......
}

I'm not very experienced with C so I use git as example of good written code.
In object.c I've found two functions that looks like my one.

static unsigned int hash_obj(struct object *obj, unsigned int n)
{
	unsigned int hash = *(unsigned int *)obj->sha1;
	return hash % n;
}

static int hashtable_index(const unsigned char *sha1)
{
	unsigned int i;
	memcpy(&i, sha1, sizeof(unsigned int));
	return (int)(i % obj_hash_size);
}

I wonder why in the second used memcpy instead of:
unsigned int i = *(unsigned int *)sha1
Maybe there is explanation that will help to solve my problem.
Thank you
