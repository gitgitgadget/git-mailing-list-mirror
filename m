From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] describe: when failing, tell the user about options that work
Date: Fri, 23 Oct 2009 10:34:07 +0200
Message-ID: <200910231034.09747.trast@student.ethz.ch>
References: <76c5b8580910220810n389d065di349339ab38909ef7@mail.gmail.com> <f1e86b9095d63c6541d0a8df6a1cf8eadfe247bb.1256226187.git.trast@student.ethz.ch> <7vljj3dkid.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Eugene Sajine <euguess@gmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 10:36:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1FcA-0003zN-NF
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 10:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbZJWIfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 04:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbZJWIfD
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 04:35:03 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:39544 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329AbZJWIfC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 04:35:02 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 23 Oct
 2009 10:35:04 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 23 Oct
 2009 10:34:43 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <7vljj3dkid.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131096>

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > @@ -259,7 +260,14 @@ static void describe(const char *arg, int last_one)
> >  			printf("%s\n", find_unique_abbrev(sha1, abbrev));
> >  			return;
> >  		}
> > -		die("cannot describe '%s'", sha1_to_hex(sha1));
> > +		if (unannotated_cnt)
> > +			die("cannot describe '%s'"
> > +			    " with only\nannotated tags. Try --tags.",
> 
> Did you mean UNannotated tags here?

No, but I think I see where the misunderstanding came from.

This code path means that we did not find a tag to describe with, but
we counted some unannotated tags (and because of how the counting
logic is wrapped, this only triggers when neither --all nor --tags are
in effect).

So I wanted it to say "it is impossible to describe this with the tags
you told me to use", which in this case are the annotated ones.

I tried to keep the general structure of the message ("cannot describe
..."), and with this restriction I can't seem to find a clearer
wording.  However, it could be written e.g.

  No annotated tags can describe '%s'.  However, there were
  unannotated tags: try --tags.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
