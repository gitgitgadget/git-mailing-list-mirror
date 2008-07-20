From: Nick Andrew <nick@nick-andrew.net>
Subject: Re: [PATCH] Enable git rev-list to parse --quiet
Date: Sun, 20 Jul 2008 22:04:37 +1000
Message-ID: <20080720120437.GC15586@mail.local.tull.net>
References: <20080718040459.13073.76896.stgit@marcab.local.tull.net> <7v8wvzeojm.fsf@gitster.siamese.dyndns.org> <20080718092001.GD16102@mail.local.tull.net> <7vwsjhc7kj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 14:05:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKXfb-0002Et-O5
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 14:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756377AbYGTMEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 08:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756379AbYGTMEp
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 08:04:45 -0400
Received: from vps1.tull.net ([66.180.172.116]:57247 "HELO vps1.tull.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756349AbYGTMEo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 08:04:44 -0400
Received: (qmail 18397 invoked by uid 1015); 20 Jul 2008 22:04:42 +1000
Received: from [10.0.0.67] (HELO tull.net) (10.0.0.67) by vps1.tull.net (qpsmtpd/0.26) with SMTP; Sun, 20 Jul 2008 22:04:42 +1000
Received: (qmail 27824 invoked by uid 1000); 20 Jul 2008 22:04:37 +1000
Content-Disposition: inline
In-Reply-To: <7vwsjhc7kj.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SMTPD: qpsmtpd/0.26, http://develooper.com/code/qpsmtpd/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89188>

On Sun, Jul 20, 2008 at 12:56:28AM -0700, Junio C Hamano wrote:
> Nick Andrew <nick@nick-andrew.net> writes:
> 
> > ...Without
> > a working "--quiet" nor exit code I can pipe the output to "wc -l"
> > but is there a more efficient/reliable way to implement the requirement?
> 
> Did you read the whole thread before asking the above question?

I took your answer to mean that I shouldn't be using git-rev-list
for this purpose, so I asked whether there's a better way to do
it. Johannes Schindelin gave a good answer to that.

> IOW, does this answer the above question?
> 
>     http://mid.gmane.org/7vy73zd8ok.fsf@gitster.siamese.dyndns.org

I'm not happy with that patch due to this:

 static void finish_commit(struct commit *commit)
 {
+       if (check_empty)
+               exit(0);

Exiting a process from within a callback function seems to me to violate
the principle of least surprise. If the return code should be zero then
the cmd_rev_list function should return zero, and run_command will
return zero and handle_internal_command will exit zero. There must be
a better way to avoid redundant processing for the empty set case.

Nick.
