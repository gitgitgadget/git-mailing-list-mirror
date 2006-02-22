From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: How to not download objects more than needed?
Date: Tue, 21 Feb 2006 20:13:38 -0500
Message-ID: <20060222011338.GL5000@delft.aura.cs.cmu.edu>
References: <43FB6C42.5000208@gorzow.mm.pl> <BAYC1-PASMTP03A58A4F389365AC85DA68AEFC0@CEZ.ICE> <Pine.LNX.4.64.0602211635450.30245@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Feb 22 02:13:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBiZk-00052m-Db
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 02:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161073AbWBVBNj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 20:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161099AbWBVBNj
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 20:13:39 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:19866 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S1161073AbWBVBNi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 20:13:38 -0500
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1FBiZW-0002HL-00
	for <git@vger.kernel.org>; Tue, 21 Feb 2006 20:13:38 -0500
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602211635450.30245@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16578>

On Tue, Feb 21, 2006 at 04:42:34PM -0800, Linus Torvalds wrote:
> 
> 	git pull git://git.kernel.org/....
> 
> and the automatic tag following kicks in, it will first have fetched the 
> objects once, and then when it tries to fetch the tag objects, it will 
> fetch the objects it already fetched _again_ (plus the tags), because it 
> will do the same object pull, but the temporary branch (to be merged) will 
> never have been written as a branch head.

Isn't this easily avoided by fetching the tags first?

Jan


diff --git a/git-fetch.sh b/git-fetch.sh
index b4325d9..9c6748f 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -363,8 +363,6 @@ fetch_main () {
 
 }
 
-fetch_main "$reflist"
-
 # automated tag following
 case "$no_tags$tags" in
 '')
@@ -389,6 +387,8 @@ case "$no_tags$tags" in
 	esac
 esac
 
+fetch_main "$reflist"
+
 # If the original head was empty (i.e. no "master" yet), or
 # if we were told not to worry, we do not have to check.
 case ",$update_head_ok,$orig_head," in
