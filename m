X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: protect blob and diff output lines from controls.
Date: Fri, 10 Nov 2006 02:22:14 -0800 (PST)
Message-ID: <976905.27021.qm@web31807.mail.mud.yahoo.com>
References: <7vlkmlkkq8.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 10 Nov 2006 10:22:28 +0000 (UTC)
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Luben Tuikov <ltuikov@yahoo.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=SaPzGijxvlMJMdiucYtO/+EiTH1wrTpoQnnUIToMUWSnMVs3qgfeD2zeB4DU9k3mPeoU9y16r55pScshNEfTwppscW+8wzXMNeNhwaxlTg1BEfjGzwWUcy6dUueej6t8o4dnqUX54GRzzdXEuhllv11FvrLYJ65uKBv+a+qOgLo=  ;
X-YMail-OSG: WRfvIQkVM1mddwlMXqjsdhNGvjOKSVc8d2RVFgq7DOi_XfASFcgnCAvBxauxOJ59dRgFkRuUTiLt12sR_9oZtT9zMlSP4X0qIPLeDU0HlV5C5oPjjnchiOGs_nTJlg9pWfqVndf5CNA-
In-Reply-To: <7vlkmlkkq8.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31206>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GiTWd-0007MK-F1 for gcvg-git@gmane.org; Fri, 10 Nov
 2006 11:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946304AbWKJKWR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 10 Nov 2006
 05:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946307AbWKJKWR
 (ORCPT <rfc822;git-outgoing>); Fri, 10 Nov 2006 05:22:17 -0500
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:17496 "HELO
 web31807.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1946304AbWKJKWP (ORCPT <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2006
 05:22:15 -0500
Received: (qmail 27150 invoked by uid 60001); 10 Nov 2006 10:22:15 -0000
Received: from [71.80.233.118] by web31807.mail.mud.yahoo.com via HTTP; Fri,
 10 Nov 2006 02:22:14 PST
To: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

--- Junio C Hamano <junkio@cox.net> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Jakub Narebski wrote:
> >> I'm not sure what quoting to choose for esc_attr, but there we could
> >> use even --no-control-chars quoting (replacing any control character
> >> by '?');  but perhaps in some cases like git_print_page_path
> >> subroutine CEC is better.
> 
> To be honest, I do not have strong preference between the
> escaping style.  If the gitweb cabal feel it is more natural to
> see "^L" in blobs and "\f" in path, I will very happily accept
> such a patch.

I've little preference either, as long as the intention
of the original name is preserved across gitweb (to a user's
git-repo/download).

> Yes.  It is unfortunate that there needs different types of
> quoting.  I think the first step would be to stop calling
> esc_html in esc_path.  I think it was a mistake, and I did not
> correct it when I started touching it.

When Jakub mentioned "to_qtext" he meant this patch:
http://marc.theaimsgroup.com/?l=git&m=116016249121781&w=2

   Luben


> Somehow I ended up spending sizeable part of my git day this
> week on fixing up blob/blame/tag/commit message view regarding
> this "make controls visible and safe" issues on the 'master'
> branch, but I have been consciously staying out of gitweb/ part
> of the system, primarily because there are many other people who
> are more interested and qualified in it than myself.
> 
> I'll step aside and try not to get in the way.  There is another
> thing I noticed while testing it with an artifitial test that I
> haven't fixed, but I think you already know about it (when the
> commitdiff is completely empty except mode changes, we end up
> with unbalanced div).  My test's tip can be found at
> 'gitweb-test-funny-char' branch temporarily in the git.git
> repository.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
