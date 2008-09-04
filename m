From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Teach "log -F --author=<match>" to behave better
Date: Thu, 4 Sep 2008 16:33:44 +0300
Message-ID: <20080904133344.GA3197@mithlond.arda.local>
References: <g9o0ac$qig$1@ger.gmane.org> <7v4p4w75b7.fsf@gitster.siamese.dyndns.org> <7vprnk5n3c.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 15:36:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbF07-0005SY-Pn
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 15:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbYIDNe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 09:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbYIDNe1
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 09:34:27 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:58829 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098AbYIDNe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 09:34:27 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.inet.fi (8.5.014)
        id 488F153401B50F43; Thu, 4 Sep 2008 16:33:44 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KbEy0-0000uK-3W; Thu, 04 Sep 2008 16:33:44 +0300
Content-Disposition: inline
In-Reply-To: <7vprnk5n3c.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94933>

Junio C Hamano wrote (2008-09-04 01:31 -0700):

> To handle --author=<match> request, the code created a grep
> instruction that tried to match a line that begins with 'author ' and
> <match> somewhere on the same line.  "begins with 'author '" obviously
> needs to be expressed with an regexp '^author '.
> 
> When the user specifies --fixed-string, this does not work at all.

> This extends the grep machinery so that a match insn can ignore user
> specified --fixed-string request, and uses the '( -e A --and -e B )'
> construct from the grep machinery in order to express "has to begin
> with '^author ', and also the same line must match the given pattern".

I want to add a side note here because this _may_ be related to what 
I found almost two months ago:

    "Patterns work unexpectedly with 'git log' commit limiting"
    http://thread.gmane.org/gmane.comp.version-control.git/88813

One of the problems was that with

    git log -E --author=pattern

the pattern is interpreted as basic regexp but with 

    git log --author=pattern -E

as extended rexexp.
