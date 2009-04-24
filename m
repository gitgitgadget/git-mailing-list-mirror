From: James Cloos <cloos@jhcloos.com>
Subject: Re: [PATCH 1/1] Improve progress display in kB range.
Date: Fri, 24 Apr 2009 16:15:21 -0400
Message-ID: <m3zle5hkpa.fsf@lugabout.jhcloos.org>
References: <cover.1240115957.git.cloos@jhcloos.com>
	<d03620ac4d99f3280df31708032a072a4a6cd96e.1240115957.git.cloos@jhcloos.com>
	<alpine.LFD.2.00.0904210054190.6741@xanadu.home>
	<m3skk2szgv.fsf@lugabout.jhcloos.org>
	<alpine.LFD.2.00.0904211319570.6741@xanadu.home>
	<m3d4b5oj76.fsf@lugabout.jhcloos.org>
	<m34owgoj08.fsf@lugabout.jhcloos.org>
	<7vljps324a.fsf@gitster.siamese.dyndns.org>
	<m3ab68mi3q.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 22:22:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxRv4-0000gH-5v
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 22:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757483AbZDXUUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 16:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754931AbZDXUUd
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 16:20:33 -0400
Received: from eagle.jhcloos.com ([207.210.242.212]:2156 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920AbZDXUUc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 16:20:32 -0400
Received: by eagle.jhcloos.com (Postfix, from userid 10)
	id 4524740286; Fri, 24 Apr 2009 20:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=eagle; t=1240604431;
	bh=+lwuSxaXYJhnjSJoQKxQGSabBS+JP5Pw2iiLRrdorzk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type;
	b=muyMNui6iwPPpC3NDvwkw5muXY+ronJaZTXRVi4vShfCyuXrNfQhdDtJUdDc1JXEd
	 BoFepl4qcgAc6z/zlPotzioaYZUPkAxyahAbUkO6rzXRXtyXBG+wsiXclql6OefmWg
	 Hx0DhunKoNR0QZnvr3cUb+4sr+D5HkkKw6uyDz30=
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id B13338D9DA; Fri, 24 Apr 2009 20:15:45 +0000 (UTC)
In-Reply-To: <m3ab68mi3q.fsf@lugabout.jhcloos.org> (James Cloos's message of
	"Wed, 22 Apr 2009 18:35:45 -0400")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.92 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAI1J
 REFUOE+lU9ESgCAIg64P1y+ngUdxhl5H8wFbbM0OmUiEhKkCYaZThXCo6KE5sCbA1DDX3genvO4d
 eBQgEMaM5qy6uWk4SfBYfdu9jvBN9nSVDOKRtwb+I3epboOsOX5pZbJNsBJFvmQQ05YMfieIBnYX
 FK2N6dOawd97r/e8RjkTLzmMsiVgrAoEugtviCM3v2WzjgAAAABJRU5ErkJggg==
Copyright: Copyright 2009 James Cloos
OpenPGP: ED7DAEA6; url=http://jhcloos.com/public_key/0xED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
X-Hashcash: 1:29:090424:git@vger.kernel.org::cQM20gUIuq5ZKBCs:00000000000000000000000000000000000000000SSiYE
X-Hashcash: 1:29:090424:nico@cam.org::hvnPHwEZXyf9zN+K:0000SR6SP
X-Hashcash: 1:29:090424:gitster@pobox.com::N/Uj493hfxYJE+y0:0000000000000000000000000000000000000000000NvNSV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117484>

It turns out that the off by one is intentional.

>From upload-pack.c:

/* Data ready; we keep the last byte to ourselves
 * in case we detect broken rev-list, so that we
 * can leave the stream corrupted.  This is
 * unfortunate -- unpack-objects would happily
 * accept a valid packdata with trailing garbage,
 * so appending garbage after we pass all the
 * pack data is not good enough to signal
 * breakage to downstream.
 */

Upload-pack uses a buffer of 8193 octets, which is why it is always
the second xread() that returns 0xFFF.  It first sends 8191 octets,
then n chunks of 8192 and then the final chunk.

It seems to only way to fix the progress annoyance -- and it is most
annoying -- would be to round correctly in progress.c.

(The .99 comes from 1023/1024, which is .999 and therefor ought to
round up to 1.00, not down to 0.99.)

Will a patch which does round-to-nearest (instead of the current
round-to-zero) be accepted?

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
