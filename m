From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: [PATCH] fix potential infinite loop given large unsigned
	integer
Date: Mon, 10 Aug 2009 19:55:17 -0500
Message-ID: <20090811005517.GB32235@unpythonic.net>
References: <a3f15ee60908082141l7b2134cg5ddcef17c45fc888@mail.gmail.com> <7vy6pta4rd.fsf@alter.siamese.dyndns.org> <7v3a81a13z.fsf@alter.siamese.dyndns.org> <40aa078e0908090525h7b4d6efeh658e2edcfbe16c7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ryan Flynn <parseerror@gmail.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 02:55:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MafeD-00005j-3r
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 02:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbZHKAzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 20:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbZHKAzU
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 20:55:20 -0400
Received: from dsl.unpythonic.net ([206.222.212.217]:60902 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751800AbZHKAzU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 20:55:20 -0400
Received: by unpythonic.net (Postfix, from userid 1000)
	id 57B0811456C; Mon, 10 Aug 2009 19:55:17 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <40aa078e0908090525h7b4d6efeh658e2edcfbe16c7e@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125505>

On Sun, Aug 09, 2009 at 02:25:40PM +0200, Erik Faye-Lund wrote:
> log10() appears to be C99, but can be emulated on earlier C-versions by doing
> #define log10(x) (log(x) / log(10.0))

I don't think you'll like the results of this very much.
    #include <math.h>
    #include <stdio.h>

    int main(void) {
        double n=1;
        int i, j;
        for(i=0; i<10; i++, n*=10) {
            j = (int)(log(n)/log(10));
            if(i != j) printf("%d %d\n", i, (int)j);
        }
        return 0;
    }

(on my system, 3 of the 10 tested cases give the wrong answer due to
rounding)

For a tour of some of the difficulties of implementing log10,
    http://www.cs.berkeley.edu/~wkahan/LOG10HAF.TXT

Jeff
