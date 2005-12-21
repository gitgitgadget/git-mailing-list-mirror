From: Junio C Hamano <junkio@cox.net>
Subject: Re: Am I doing something wrong?
Date: Wed, 21 Dec 2005 13:13:33 -0800
Message-ID: <7vk6dy5f2a.fsf@assigned-by-dhcp.cox.net>
References: <86k6dyxuke.fsf@blue.stonehenge.com>
	<7v3bkmcp83.fsf@assigned-by-dhcp.cox.net>
	<864q52xrm6.fsf@blue.stonehenge.com>
	<7vmziub9yw.fsf@assigned-by-dhcp.cox.net>
	<86zmmuwbzh.fsf@blue.stonehenge.com>
	<7vhd92b90w.fsf@assigned-by-dhcp.cox.net>
	<7vvexi8bo9.fsf@assigned-by-dhcp.cox.net>
	<43A9C33E.2070807@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 22:13:52 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpBHR-0008QV-5Y
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 22:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbVLUVNq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 16:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbVLUVNq
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 16:13:46 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:36305 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750995AbVLUVNp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 16:13:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051221211135.HIL17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Dec 2005 16:11:35 -0500
To: cel@citi.umich.edu, torvalds@osdl.org
In-Reply-To: <43A9C33E.2070807@citi.umich.edu> (Chuck Lever's message of "Wed,
	21 Dec 2005 16:03:58 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13900>

Chuck Lever <cel@citi.umich.edu> writes:

> maybe the Linux kernel repository needs the same treatment.  i'm getting 
> the "all zeros" commit error message when trying to pull from it.

Indeed.

Linus, sorry about bothering you, but could you do the same
band-aid for now and also apply the attached to your
server-info.c, please?

> Junio C Hamano wrote:
>>
>> As a band-aid, I just ran this command at the server that public
>> ones mirror from:
>>
>> 	$ echo >>objects/info/packs
>>

GIT 1.0.0a needs to follow soonish X-<.

-- >8 --
[PATCH] objects/info/packs: work around bug in http-fetch.c::fetch_indices()

The code to fetch pack index files in deployed clients have a
bug that causes it to ignore the pack file on the last line of
objects/info/packs file, so append an empty line to work it
around.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 server-info.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

21b1aced83195af50fd8bc9a88e7734c8ee77c0e
diff --git a/server-info.c b/server-info.c
index df19e49..6089765 100644
--- a/server-info.c
+++ b/server-info.c
@@ -200,6 +200,7 @@ static void write_pack_info_file(FILE *f
 	int i;
 	for (i = 0; i < num_pack; i++)
 		fprintf(fp, "P %s\n", info[i]->p->pack_name + objdirlen + 6);
+	fputc('\n', fp);
 }
 
 static int update_info_packs(int force)
-- 
1.0.0
