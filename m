From: =?UTF-8?Q?Daniel?= <mjucde@o2.pl>
Subject: =?UTF-8?Q?Re:_Which_dates_'git_log_--since=3D_--after=3D'_compare=3F?=
Date: Tue, 20 Oct 2009 11:35:35 +0200
Message-ID: <16ee5f3.236584ce.4add8467.a19be@o2.pl>
References: <4c067ee1.a34185.4adc390d.a980c@o2.pl> <20091020083703.GA14740@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Jeff_King?= <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 20 11:35:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0B8B-00054w-Ks
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 11:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbZJTJfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 05:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbZJTJfi
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 05:35:38 -0400
Received: from mailout1.go2.pl ([193.17.41.11]:39571 "EHLO mailout1.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751594AbZJTJfh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 05:35:37 -0400
Received: from mailout1.go2.pl (unknown [10.0.0.105])
	by mailout1.go2.pl (Postfix) with ESMTP id CB8045F000A;
	Tue, 20 Oct 2009 11:35:36 +0200 (CEST)
Received: from o2.pl (unknown [10.0.0.38])
	by mailout1.go2.pl (Postfix) with SMTP;
	Tue, 20 Oct 2009 11:35:36 +0200 (CEST)
In-Reply-To: <20091020083703.GA14740@coredump.intra.peff.net>
X-Originator: 153.19.128.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130780>

Jeff King <peff@peff.net> wrote:

> On Mon, Oct 19, 2009 at 12:01:49PM +0200, Daniel wrote:
> 
> > I can see that 'git log --since= --after=' compares commit's dates,
> > not author's dates.How can I limit commits by Author's date?
> 
> AFAIK, there is currently no way to do it with a simple option. In fact,
> we don't even parse the author date when doing revision limiting.
> 
> So it would need a patch, but the "obvious" solution of just parsing and
> storing the author date in a "struct commit" might not be acceptable; as
> I recall, some performance tuning went into keeping the per-commit
> memory footprint as small as possible, which had a noticeable speed
> benefit (I'm not saying it couldn't be done, but care needs to be taken
> in that regard).
> 
> If it's not something you need to do often, I'd consider something like:
> 
>   git log --format='%H %at' |
>     perl -ane '
>       BEGIN {
>         use DateTime::Format::Natural;
>         $max_age = DateTime::Format::Natural->new->parse_datetime(
>                       "last friday"
>                    )->epoch;
>       }
>       print $F[0], "\n" if $F[1] < $max_age;
>   '
> 
> Of course that's awful to type, and it will be much slower than git
> doing the revision limiting itself.
> 
> -Peff

Thanks.
