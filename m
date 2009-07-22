From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 10/12] Match config subsection names using case sensitive search
Date: Wed, 22 Jul 2009 23:37:55 +0200
Message-ID: <200907222337.56238.robin.rosenberg@dewire.com>
References: <1248207570-13880-1-git-send-email-spearce@spearce.org> <1248207570-13880-11-git-send-email-spearce@spearce.org> <85647ef50907220411w356000bcuda21e9318eab094@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 00:20:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTkB6-0002d2-SQ
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 00:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686AbZGVWUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 18:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754491AbZGVWUR
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 18:20:17 -0400
Received: from mail.dewire.com ([83.140.172.130]:4335 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753944AbZGVWUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 18:20:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DDF9B1481D9F;
	Thu, 23 Jul 2009 00:20:13 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OTq2b9gCT9C5; Thu, 23 Jul 2009 00:20:03 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id BC47E802D5D;
	Thu, 23 Jul 2009 00:20:02 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <85647ef50907220411w356000bcuda21e9318eab094@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123802>

onsdag 22 juli 2009 13:11:07 skrev Constantine Plotnikov <constantine.plotnikov@gmail.com>:
> This patch is incomplete. The method getRawEntry(...) and
> setStringList(...) should be fixed as part of this patch too. There is
> subsection is converted to lowercase. I was planning to submit it as
> separate patch.
> 
> Also I'm somewhat bothered by usage of toLowerCase() without locale
> specified and equalsIgnoreCase(). When turkish locale is default one
> there could be surprising results with the letter "I".  The program:
> 
> import java.util.Locale;
> public class Test {
> 	public static void main(String[] args) {
> 		Locale tr_TR = new Locale("tr", "TR");
> 		System.out.printf("i = U+%04x LC(I, tr_TR) = U+%04x\n", (int)'i',
> (int)"I".toLowerCase(tr_TR).charAt(0));
> 		System.out.printf("I = U+%04x UC(i, tr_TR) = U+%04x\n", (int)'I',
> (int)"i".toUpperCase(tr_TR).charAt(0));
> 	}
> }
> 
> Gives the following output:
> 
> i = U+0069 LC(I, tr_TR) = U+0131
> I = U+0049 UC(i, tr_TR) = U+0130
> 
> So I suggest to explicitly use Locale.US for all toLowerCase()
> invocation in Config class just in case and to replace
> equalsIgnoreCase() with something else. But this possibly should be
> some other patch series. I do not know what C git doing in case
> turkish locale and whether it is a bug or "feature".

Good catch. C Git operates in "C" locale (default for C/C++) so it should
not be a problem. We might have other places where this could be a problem.
Using Locale.US should be the right choice here since unicode is not allowed
in sections and keys anyway.  (Btw, java.lang.String.regionMatches has some info
on case insensitive matching for those interested, serving a reminder for
why home-brewed logic isn't always the best.)

As you say we should make this a separate patch.

--  robin
