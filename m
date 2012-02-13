From: "Heiko W. Rupp" <hwr@pilhuhn.de>
Subject: GitWeb and atom feed links
Date: Mon, 13 Feb 2012 21:43:33 +0100
Message-ID: <F3741779-8DDA-4275-BB68-24D02297C702@pilhuhn.de>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: jnareb@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 21:54:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx2uM-0005og-Kb
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 21:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758137Ab2BMUxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 15:53:45 -0500
Received: from mail.rackland.de ([212.86.200.188]:47884 "EHLO mail.rackland.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754971Ab2BMUxm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2012 15:53:42 -0500
X-Greylist: delayed 606 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Feb 2012 15:53:42 EST
Received: from [172.31.7.7] (unknown [85.183.68.38])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by mail.rackland.de (Postfix) with ESMTPSA id 779AD24D8B;
	Mon, 13 Feb 2012 21:43:32 +0100 (CET)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190669>

Hi,

( got this email from Junio )

when you e.g. look at http://git.kernel.org/?p=git/git.git;a=summary and then the lower right, there
are two buttons for feeds. If you click on e.g. atom, you end up with an url of http://git.kernel.org/?p=git/git.git;a=atom
where the output is not a feed in atom format, but plain html with tables etc.

If you change the url to http://git.kernel.org/?p=git/git.git&a=atom

the output is a correct atom feed (same for rss).

I've traced it down in my copy of gitweb to 

sub git_footer_html {
...
                     $href_params{'action'} = lc($format);
                      print $cgi->a({-href => href(%href_params),
                                    -title => "$href_params{'-title'} $format feed",
                                    -class => $feed_class}, $format)."\n";

and here to the usage of href()

Locally I've modified that to 

                     $href_params{'action'} = lc($format);
                      my $hr = "?p=$project&a="; 
                      $hr .= lc($format);
                      print $cgi->a({-href => $hr,
                                    -title => "$href_params{'-title'} $format feed",
                                    -class => $feed_class}, $format)."\n";

and it works.

Attached is a patch against current master that reflects above change

   Heiko

-- 
Heiko Rupp   hwr@pilhuhn.de
Blog: http://javablogs.com/ViewBlog.action?id=14468
