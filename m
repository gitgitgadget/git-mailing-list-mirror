From: Ilya Basin <basinilya@gmail.com>
Subject: Re[2]: rewrite history
Date: Fri, 17 Jun 2011 00:06:44 +0400
Message-ID: <17721660.20110617000644@gmail.com>
References: <362053118.20110616231758@gmail.com> <20110616192644.GB13466@sigill.intra.peff.net> <7vhb7ph8aj.fsf@alter.siamese.dyndns.org> <20110616194911.GA14355@sigill.intra.peff.net>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 16 22:07:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXIqb-0006R7-20
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 22:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516Ab1FPUG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 16:06:59 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48590 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932398Ab1FPUG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 16:06:56 -0400
Received: by bwz15 with SMTP id 15so257842bwz.19
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 13:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-mailer:reply-to:x-priority
         :message-id:to:cc:subject:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=3SO7Pf7YepcCIS/v/+1vH9mkO5uBWTAM170pN9ZomY8=;
        b=TK90q/fAkCBLl1kTNXlAsEXWv2i3Env+EqpiwklTbAexY/UvGOf9LmO9ustDf5lEY2
         hoxa030Nn6f4tqqnnAUr5TzxhNCjyev+Fxqw/sVsjaoHWI6uYpcvMTBTYh35+NvElJ5l
         aL4vClJEWH8JD3D5jAEN5+DMO0p3iCgbdcUg0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-mailer:reply-to:x-priority:message-id:to:cc:subject
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        b=s76w3HAIsawcuU68TPgjaEoZ1ALVXqytIw1Ii1W4DxxpEv2l4ZT5GdFyyKJtDViY8I
         iRJWxYOIi74QW+cXS0B2SuEgBGFHVhzfCH2K8n2HuQJ7puXUtXAlKPbAsNST0alDyvg0
         OZkzjj8ewh6veUZiFJ42MaXxFEggMNyjCh9tk=
Received: by 10.204.74.21 with SMTP id s21mr1007004bkj.62.1308254814562;
        Thu, 16 Jun 2011 13:06:54 -0700 (PDT)
Received: from MAR2.localnet (pppoe.95-55-137-3.dynamic.avangarddsl.ru [95.55.137.3])
        by mx.google.com with ESMTPS id q20sm1440941bka.17.2011.06.16.13.06.51
        (version=SSLv3 cipher=OTHER);
        Thu, 16 Jun 2011 13:06:53 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <20110616194911.GA14355@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175923>

JK> On Thu, Jun 16, 2011 at 12:43:00PM -0700, Junio C Hamano wrote:

>> >> Hi list. There were 2 branches. One's HEAD was modified to match a
>> >> specific commit at another branch. Now, how to merge them according to
>> >> this scheme?
>> >> 
>> >> A---B---X---E---F
>> >>                      =>  C---D---X---E---F
>> >> C---D---X'
>> >> 
>> >> X and X' have no difference. I tried to write a script to cherry-pick
>> >> E and F, but some of commits are merges and cherry-pick fails.
>> >
>> > I think you just want to rebase using the "-p" option to preserve
>> > merges. Something like:
>> >
>> >   $ git checkout -b rebased-branch F
>> >   $ git rebase -p --onto D B
>> >
>> > that will pick X, E, and F, and replay them on top of D, resulting in
>> > the graph you showed above.
>> 
>> Eh, careful. Nobody said the change between B and X is any similar to the
>> change between D and X'. Replaying the changes E and F introduce on top of
>> X' to arrive at C--D--X'-E--F is the best you could do, i.e.

JK> I thought that was exactly what Ilya said with "X and X' have no
JK> difference". I assumed that meant "they are semantically similar commits
JK> on different bases" (i.e., a cherry-pick) and not "they have the exact
JK> same tree state" (i.e., "git diff X X'" is empty).

>> But wouldn't filter-branch a better tool for this?  Graft to pretend that
>> the parent of X is D instead of B, and filter the branch with F at its
>> tip, that is.

JK> If my assumption on the meanings is reversed (i.e., X and X' really are
JK> the same tree state, not introducing equivalent commits), then yeah,
JK> that would be better.

JK> -Peff

sorry,
git diff X X' is empty


-- 
