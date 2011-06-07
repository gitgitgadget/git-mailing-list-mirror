From: Alex Neronskiy <zakmagnus@google.com>
Subject: Re: [PATCH] Document the underlying protocol used by shallow repositories and --depth commands.
Date: Tue, 7 Jun 2011 20:47:34 +0000 (UTC)
Message-ID: <loom.20110607T224355-216@post.gmane.org>
References: <BANLkTi=SVZPebW2YXRnaLvkxEDGy_rrtJ3jayt8Oco6Sn8hciQ@mail.gmail.com> <7vvcwi95yi.fsf@alter.siamese.dyndns.org> <loom.20110606T213817-376@post.gmane.org> <7v1uz55r24.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 22:48:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU3Bs-0002ru-CM
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 22:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612Ab1FGUrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 16:47:51 -0400
Received: from lo.gmane.org ([80.91.229.12]:38043 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753350Ab1FGUrv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 16:47:51 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QU3Bm-0002ph-6a
	for git@vger.kernel.org; Tue, 07 Jun 2011 22:47:50 +0200
Received: from 216-239-45-4.google.com ([216.239.45.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 22:47:50 +0200
Received: from zakmagnus by 216-239-45-4.google.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 22:47:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 216.239.45.4 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110422 Ubuntu/10.04 (lucid) Firefox/3.6.17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175267>

Junio C Hamano <gitster <at> pobox.com> writes:

> "The same event which was already described in that document" meaning at
> the beginning of "Packfile Negotiation" section?  That is primarily about
> the "ls-remote" that probed the server for the list of current refs, which
> is received in connect.c::get_remote_heads(), but it also covers another
> case. When fetching, after connect.c::get_remote_heads() finds the list of
> current refs, do_fetch_pack() is called, and then everything_local() in it
> checks if we have all the objects we are going to ask. If so, we flush and
> jump to all_done to terminate the connection, skipping find_common(),
> without doing any of the want/shallow/depth/etc.
> 
> I don't seem to be able to find where in find_common() and its callee we
> could quit without telling the server anything (unless we crash . Even
> if get_rev() loop finds nothing, we would at least say "done".
> 

The part of the document I'm referring to starts at line 221 and reads: 

 Once all the "want"s (and optional 'deepen') are transferred,
 clients MUST send a flush-pkt. If the client has all the references
 on the server, client flushes and disconnects.

And I believe this refers to the code path beginning at line 308 of fetch-pack.c:

        if (!fetching) {
                strbuf_release(&req_buf);
                packet_flush(fd[1]);
                return 1;
        }

Am I wrong? 
