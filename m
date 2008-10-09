From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH maint] builtin-merge.c: fix memory under-allocation
Date: Wed, 08 Oct 2008 19:27:40 -0500
Message-ID: <0LPLRUZaEHuEZTri_v38ySJHqYAhrfOpOkyUviUH9eOrx8IXBEAzYA@cipher.nrlssc.navy.mil>
References: <ZuhLzndR5Uvj7-_NyasP-FHF3AqTyLx-0sjNHMd0BC3LXC8LdLqBeQ@cipher.nrlssc.navy.mil> <20081009001727.GP536@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Oct 09 02:29:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnjPM-00035Z-D5
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 02:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757034AbYJIA15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 20:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756883AbYJIA15
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 20:27:57 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:56184 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152AbYJIA14 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 20:27:56 -0400
Received: by mail.nrlssc.navy.mil id m990ReuE001353; Wed, 8 Oct 2008 19:27:40 -0500
In-Reply-To: <20081009001727.GP536@genesis.frugalware.org>
X-OriginalArrivalTime: 09 Oct 2008 00:27:40.0654 (UTC) FILETIME=[D6C7F0E0:01C929A5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97816>

Miklos Vajna wrote:
> On Wed, Oct 08, 2008 at 07:07:54PM -0500, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>> While we're at it, change the allocation to reference the variable it is
>> allocating memory for to try to prevent a similar mistake if the type is
>> changed in the future.
> 
> If this is really a problem, then I think it would be good to mention
> this in Documentation/CodingGuidelines.

That's fine. Though I didn't mean to imply that the memory under-allocation
was caused by a change in variable type in this case. Re-reading my commit
message, maybe it sounds like that.

  Something like this sometimes happens:

-    struct a_struct *foo = xmalloc(sizeof(struct a_struct));
+    struct a_bigr_struct *foo = xmalloc(sizeof(struct a_struct));

  which would be avoided if we had started with:

     struct a_struct *foo = xmalloc(sizeof(*foo));

-brandon
