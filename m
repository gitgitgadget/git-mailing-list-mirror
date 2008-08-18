From: bdowning@lavos.net (Brian Downing)
Subject: Re: What's cooking in git.git (Aug 2008, #04; Sun, 17)
Date: Mon, 18 Aug 2008 17:41:05 -0500
Message-ID: <20080818224105.GA31114@lavos.net>
References: <7vej4o6j40.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 00:42:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVDQW-0004YD-C0
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 00:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246AbYHRWlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 18:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753992AbYHRWlM
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 18:41:12 -0400
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:44367
	"EHLO QMTA06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753266AbYHRWlL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Aug 2008 18:41:11 -0400
Received: from OMTA05.westchester.pa.mail.comcast.net ([76.96.62.43])
	by QMTA06.westchester.pa.mail.comcast.net with comcast
	id 3s6p1a00o0vyq2s56yh6VJ; Mon, 18 Aug 2008 22:41:06 +0000
Received: from mnementh.lavos.net ([98.212.138.194])
	by OMTA05.westchester.pa.mail.comcast.net with comcast
	id 3yh61a0064BqYqi3Ryh6Bb; Mon, 18 Aug 2008 22:41:06 +0000
X-Authority-Analysis: v=1.0 c=1 a=nfPrcmQaMz8A:10 a=cICym1YevYsA:10
 a=GANrI_Rz59SNd9fMMoQA:9 a=IJfaiy18UhdxY5PzURmWpf_LRhIA:4 a=LY0hPdMaydYA:10
Received: by mnementh.lavos.net (Postfix, from userid 1000)
	id DBC9D309F23; Mon, 18 Aug 2008 17:41:05 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7vej4o6j40.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92747>

On Sun, Aug 17, 2008 at 03:17:35AM -0700, Junio C Hamano wrote:
> * bd/diff-strbuf (Wed Aug 13 23:18:22 2008 -0700) 3 commits
>  + xdiff-interface: hide the whole "xdiff_emit_state" business from
>    the caller
>  + Use strbuf for struct xdiff_emit_state's remainder
>  + Make xdi_diff_outf interface for running xdiff_outf diffs
> 
> Gives measurable performance improvement to textual diff generation.  For
> improving "blame" performance, it might be more effective to hook directly
> to lower level of xdiff machinery so that we do not even have to generate
> patch only to discard after reading "@@ -l,k +m,n @@" lines, but that
> would be a separate topic.

I have done this, resulting in my blame test case going from about 100s
on master to about 50s, but I need to do some additional cleanup before
it's ready to be submitted.  I also have some more ideas for how to
speed it up some more.  (Basically, with the textual diff generation
removed, most of the time now is spent in xdiff hashing lines.  Since
blame in copy-detection mode tends to diff against the same file over
and over again, this is wasted work.  Allowing the xdiff machinery to
re-use a diff preparation looks to be a little involved, though...)

-bcd
