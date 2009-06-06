From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 0/8] enhancing builds on Solaris
Date: Fri, 05 Jun 2009 19:41:02 -0500
Message-ID: <T7_w8K5IX5OgW5JLdf5peLzAiFf8SXQIHPcceb1qc4y8ncD9xtH3Cw@cipher.nrlssc.navy.mil>
References: <7vk53vlxhz.fsf@alter.siamese.dyndns.org> <67hZHClrEWQHxCRdWosE25_CVQVNIYpTaeW2DKuCCDfW4h-jHQ82zlGcCNn49KcxUKsj-TSJSVQ@cipher.nrlssc.navy.mil> <7vbpp2fcca.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 02:44:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCk1N-0001CS-FB
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 02:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037AbZFFAoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 20:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754155AbZFFAoS
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 20:44:18 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:35699 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598AbZFFAoR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 20:44:17 -0400
Received: by mail.nrlssc.navy.mil id n560f3Kx027462; Fri, 5 Jun 2009 19:41:03 -0500
In-Reply-To: <7vbpp2fcca.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 06 Jun 2009 00:41:03.0173 (UTC) FILETIME=[78429F50:01C9E63F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120851>

Junio C Hamano wrote:
> Looked good except for 3/8 which I did not quite understand.

I get this error when compiling using the SUNWspro c99 compiler
when delta.h is included in diff-delta.c:

"diff-delta.c", line 314: identifier redeclared: create_delta
        current : function(pointer to const struct delta_index {unsigned long memsize, pointer to const void src_buf, unsigned long src_size, unsigned int hash_mask, array[-1] of pointer to struct index_entry {..} hash}, pointer to const void, unsigned long, pointer to unsigned long, unsigned long) returning pointer to void
        previous: function(pointer to const struct delta_index {unsigned long memsize, pointer to const void src_buf, unsigned long src_size, unsigned int hash_mask, array[-1] of pointer to struct index_entry {..} hash}, pointer to const void, unsigned long, pointer to unsigned long, unsigned long) returning pointer to void : "delta.h", line 44
c99: acomp failed for diff-delta.c
gmake: *** [diff-delta.o] Error 2


I don't see any difference between those two "current" and "previous" statements.

I thought I knew why the error was occurring, but now I don't think I do.  There
are other function declarations in delta.h that are implemented in diff-delta.c,
and those functions are both declared and implemented _before_ create_delta in
delta.h and diff-delta.c respectively.

But, there does not seem to be anything declared in delta.h that is required by
diff-delta.c.

Maybe the commit message should be shortened to something more like:

   The SUNWspro C99 compiler complains: "identifier redeclared: create_delta" when
   delta.h is included.  There is nothing in "delta.h" that is required by
   diff-delta.c, so don't #include it.

Hmm, well, I just noticed that in the commit message I said "diff.h" everywhere when
I meant to say "delta.h".  Maybe that is the confusion.

-brandon
