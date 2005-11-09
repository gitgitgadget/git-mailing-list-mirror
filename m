From: Blaisorblade <blaisorblade@yahoo.it>
Subject: [cogito] cg-merge does not remove files removed upstream on fast-forward
Date: Wed, 9 Nov 2005 01:08:33 +0100
Message-ID: <200511090108.51776.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 01:03:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZdPz-0005Di-Eb
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 01:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030433AbVKIACS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 19:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbVKIACS
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 19:02:18 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:38804 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030433AbVKIACR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 19:02:17 -0500
Received: (qmail 54497 invoked from network); 9 Nov 2005 00:02:15 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=gULuI71Pio/XlWqWtQrgrZ84cQ6K0vvpItotY6bnbxmIG6zw9GrQLYeKclmoOtBK45CSpFKstBh9qgrhVn7TYOQyVRRgDINduZTUYeEmxMBxvW++Ai/SCTaLLz8kt53r+39bv3Bi4OBhk575A1w1LiVfpS+Z9TqXsutVdXT8GRw=  ;
Received: from unknown (HELO ?151.97.230.52?) (blaisorblade@151.97.230.52 with login)
  by smtp001.mail.ukl.yahoo.com with SMTP; 9 Nov 2005 00:02:15 -0000
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.8.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11370>

Once again, (not the first time) when doing "cg-merge origin" (or cg-update I 
guess, too) I find a tons of files which were removed upstream and cogito 
didn't remove. It was a fast-forward merge on Linus' tree:

$ cg merge origin
Fast-forwarding d83c671fb7023f69a9582e622d01525054f23b66 -> 
a52e8381c430896d3bd6065a34fda99cb5c74c82
        on top of d83c671fb7023f69a9582e622d01525054f23b66...

cg version
cogito-0.15.1 (b07f98ba4cabdd9d208da28be932e547675e5cdf)
(The base id is ab91bd11258f8987fc8d537871c733e04f8c8248, I've added a trivial 
patch to add more options to cg-diff and cg-mkpatch, i.e. unrelated).

Below there is the excerpt of code in tree_timewarp:

       # Kill gone files
        git-diff-tree -z -r $base $branch | xargs -0 bash -c '
                while [ "$1" ]; do
                        header="$1"; shift
                        file="$1"; shift

                        # match ":100755 000000 14d43b1abf... 000000000... D"
                        if echo "$header" | egrep "^:([^ ][^ ]* ){4}D" 
>/dev/null; then
                                rm -- "$file"
                        fi
                done
        ' padding

I must say I also saw git-ls-files --deleted running with top (probably from 
cg-patch), but it didn't seem to help.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com
