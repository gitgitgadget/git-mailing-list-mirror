From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] write_sha1_file(): Perform Z_FULL_FLUSH between header and data
Date: Wed, 08 Mar 2006 03:04:14 -0800
Message-ID: <7vhd69i4ep.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
	<7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net>
	<20060224174422.GA13367@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
	<20060224183554.GA31247@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0602241350190.31162@localhost.localdomain>
	<20060224192354.GC387@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.64.0602241152290.22647@g5.osdl.org>
	<7vpslc8oni.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602241613030.31162@localhost.localdomain>
	<Pine.LNX.4.64.0602241637480.22647@g5.osdl.org>
	<Pine.LNX.4.64.0602242130030.31162@localhost.localdomain>
	<Pine.LNX.4.64.0602241952140.22647@g5.osdl.org>
	<Pine.LNX.4.64.0602242326381.31162@localhost.localdomain>
	<Pine.LNX.4.64.0602250012230.31162@localhost.localdomain>
	<7vzmk1izpa.fsf_-_@assigned-by-dhcp.cox.net>
	<20060308134519.78ea313d.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 08 12:05:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGwSs-0004TU-Fo
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 12:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWCHLET (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 06:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWCHLET
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 06:04:19 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:45761 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751313AbWCHLES (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Mar 2006 06:04:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060308110127.VKDU17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Mar 2006 06:01:27 -0500
To: Sergey Vlasov <vsu@altlinux.ru>
In-Reply-To: <20060308134519.78ea313d.vsu@altlinux.ru> (Sergey Vlasov's
	message of "Wed, 8 Mar 2006 13:45:19 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17369>

Sergey Vlasov <vsu@altlinux.ru> writes:

> However, a straight reuse still will not be possible, because
> sha1write_compressed() uses deflateInit(&stream, Z_DEFAULT_COMPRESSION),
> which writes zlib headers around the deflate stream, and the zlib footer
> contains adler32 checksum.  So, as a minimum, you will need to
> decompress the object data, calculate its adler32 checksum and write the
> zlib header yourself.

Hmph.  Thanks for helping, but it sounds like my original plan
was not useful at all.  Probably inflating would be still
cheaper than inflating and then deflating, but it would not be
as cool as a straight copy.  Sigh...
