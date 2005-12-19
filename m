From: Romano Giannetti <romano@dea.icai.upcomillas.es>
Subject: Best way to use gitweb with a non-utf8 git repository
Date: Mon, 19 Dec 2005 14:55:14 +0100
Message-ID: <20051219135514.GA22388@pern.dea.icai.upcomillas.es>
Reply-To: Romano Giannetti <romano@dea.icai.upcomillas.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
X-From: git-owner@vger.kernel.org Mon Dec 19 14:55:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoLU5-0004eH-Pj
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 14:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbVLSNyr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 08:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbVLSNyr
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 08:54:47 -0500
Received: from upco.es ([130.206.70.227]:48347 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S1751055AbVLSNyq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Dec 2005 08:54:46 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail1.upco.es (Postfix) with ESMTP id 9EBB145290
	for <git@vger.kernel.org>; Mon, 19 Dec 2005 14:54:43 +0100 (CET)
Received: from mail1.upco.es ([127.0.0.1])
	by localhost (mail1 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 01048-09 for <git@vger.kernel.org>;
	Mon, 19 Dec 2005 14:54:42 +0100 (CET)
Received: from pern.dea.icai.upcomillas.es (pern.dea.icai.upco.es [130.206.71.186])
	by mail1.upco.es (Postfix) with ESMTP id 7A10745344
	for <git@vger.kernel.org>; Mon, 19 Dec 2005 14:54:42 +0100 (CET)
Received: by pern.dea.icai.upcomillas.es (Postfix, from userid 1153)
	id CFE5A102D9; Mon, 19 Dec 2005 14:55:14 +0100 (CET)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: by amavisd-new-20030616-p7 (Debian) at upco.es
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13822>

Hi,

    I am trying to start using git for a little project I have here. I
    stumbled with a small difficulty with gitweb. 

    For historical reasons the 3 or 4 files in my project that are not ascii
    or binary blobs are encoded in iso-8859-1. I know that utf8 is better,
    but I cannot do anything to enforce it... Well, git obviously has no
    problem, "all-is-a-byte-stream" is a great thing. The only problem is in
    "tree" view of gitweb, were the files with iso-8859-1 are filled with
    "invalid unicode sequence" symbols. I horribly hacked gitweb like this: 


--- /home/romano/software/downloads/gitweb.cgi  2005-12-16 12:10:46.000000000 +0100
+++ /var/www/cgi-bin/gitweb.cgi 2005-12-19 12:20:25.000000000 +0100
@@ -221,6 +221,7 @@
 # replace invalid utf8 character with SUBSTITUTION sequence
 sub esc_html {
        my $str = shift;
+       Encode::from_to($str, "iso-8859-1", "utf8");
        $str = decode("utf8", $str, Encode::FB_DEFAULT);
        $str = escapeHTML($str);
        return $str;

     but I wonder, is there a way to say gitweb "if invalid utf-8 is found,
     assume whatever-encoding-is encoding"? 

     Thanks,
            Romano      
        
-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
http://www.dea.icai.upcomillas.es/romano/
