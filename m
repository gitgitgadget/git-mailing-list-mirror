From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/2] restore legacy behavior for read_sha1_file()
Date: Tue, 15 Jul 2008 01:12:30 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807150111110.12484@xanadu.home>
References: <alpine.LFD.1.10.0807141641110.12484@xanadu.home>
 <7vbq10f7wr.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0807141904250.12484@xanadu.home>
 <7vod50dote.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0807141937180.12484@xanadu.home>
 <alpine.LFD.1.10.0807142134450.12484@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 07:13:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIcqw-0006YA-2g
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 07:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbYGOFMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 01:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753210AbYGOFMc
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 01:12:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50425 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbYGOFMb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 01:12:31 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K4100AXW7SUK1F0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 15 Jul 2008 01:12:31 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.1.10.0807142134450.12484@xanadu.home>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88525>

On Mon, 14 Jul 2008, Nicolas Pitre wrote:

> Since commit 8eca0b47ff1598a6d163df9358c0e0c9bd92d4c8, it is possible
> for read_sha1_file() to return NULL even with existing objects when they
> are corrupted.  Previously a corrupted object would have terminated the
> program immediately, effectively making read_sha1_file() return NULL 
> only when specified object is not found.
> 
> Let's restore this behavior for all users of read_sha1_file() and 
> provide a separate function with the ability to not terminate when
> bad objects are encountered.
> 
> Signed-off-by: Nicolas Pitre <nico@cam.org>

Grrrr.  Forgot to 'git add' one file.  So this goes with the same 
commit:

diff --git a/cache.h b/cache.h
index 4a8b125..bc52af6 100644
--- a/cache.h
+++ b/cache.h
@@ -540,6 +540,9 @@ extern int write_sha1_file(void *buf, unsigned long len, const char *type, unsig
 extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned char *);
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 
+/* just like read_sha1_file(), but non fatal in presence of bad objects */
+extern void *read_object(const unsigned char *sha1, enum object_type *type, unsigned long *size);
+
 extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
 
 extern int move_temp_to_file(const char *tmpfile, const char *filename);
