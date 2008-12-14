From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] gitweb: Incremental blame - suggestions for improvements
Date: Sun, 14 Dec 2008 08:11:54 -0800 (PST)
Message-ID: <m34p16eny3.fsf_-_@localhost.localdomain>
References: <20081210200908.16899.36727.stgit@localhost.localdomain>
	<1229213850-12787-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 14 17:13:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBtal-0004Yf-0M
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 17:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbYLNQL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 11:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752939AbYLNQL5
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 11:11:57 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:7104 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbYLNQL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 11:11:56 -0500
Received: by nf-out-0910.google.com with SMTP id d3so392589nfc.21
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 08:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=ErJwMlS/JytZeQQiXo08pehK7tgj5STtYvyQvjGbf8Y=;
        b=Aee241Xx07FGlz9Pds1oH4r+Yh3daI0LEh9aG1ZqnqQCN0vaCIjz4SHoDUtBCQKbcv
         caIBFBRrXqwRetjCMFRV0cvtie+TdWf1ftVCsxJdhAb4FgWkv17IvqUHdw5JrMT5Iy/y
         AOde+MVqsvHKXlP+imgP06XStpZ2YwT/aQ4QQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=cR7JlVhr4mN4ofIzy87RHJv+s31vKQnNEJlLnhp4h4qyLtliUCaFFhLXgw7GhM/KEM
         cyzj5GFEJQHbsXMBLDC/D9mFVWCZoMnKcocrWevx34PSrjIbPXIQ85O91829GL58p5DY
         pYgfXzmLOq/+XjRV/4A/d0i6rhslnFMcbhFmU=
Received: by 10.210.79.9 with SMTP id c9mr3366868ebb.155.1229271114497;
        Sun, 14 Dec 2008 08:11:54 -0800 (PST)
Received: from localhost.localdomain (abxb72.neoplus.adsl.tpnet.pl [83.8.251.72])
        by mx.google.com with ESMTPS id 3sm814791eyi.30.2008.12.14.08.11.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Dec 2008 08:11:54 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBEGBob2018422
	for <git@vger.kernel.org>; Sun, 14 Dec 2008 17:11:50 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBEGBn2K018419;
	Sun, 14 Dec 2008 17:11:49 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1229213850-12787-1-git-send-email-jnareb@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103089>

A few suggestions for further improvement of blame_incremental:
 * Better support for data mining in 'blame_incremental' view,
   (for "lineno" links to (approximately) lead to previous version of
   line) would probably require for gitweb to accept "<rev>^" for 'hb'
   parameter (and perhaps resolve/parse it before saving to
   $hash_base). This would also help performance of 'blame' view.

 * Move some of processing to server, to 'blame_data' action, and for
   example send whole saved and processed info for a group of lines as
   JSON or as variation of "git blame --incremental" output.

 * Better error checking: not only check if scripting is turned on,
   but also if required methods like document.getElementById are
   available. Probably would require falback to *ugh* document.write.

 * Perhaps fallback on (slower) DOM methods if innerHTML is not
   available or doesn't work, which is the case for some versions of
   some browsers in strict XHTML (application/xml+html + XHTML DTD)
   mode.

 * Fallback on DOM Core methods of deleting cell if DOM HTML
   deleteCell method is not available; check that DOM Core way does
   not lead to memory leaks (by deleting element, but not its
   children).

 * Use 'one second spotlight' or other similar user interface patter
   to signal in more visible way than reaching 100% in progress info,
   and changing colors from 3-coloring to 2-color zebra in blame table
   that all blame data was received and entered.

 * Check in handleResponse if browser calls it on [each] server flush,
   by checking if it is called more than once with http.readyState == 3
   and with different http.responseText, and disable poll timer then.

 * Mark boundary commits (this applies both to 'blame' and
   'blame_incremental' views), using UNDOCUMENTED "boundary" header.

 * A toy. Make progress bar indicator more smooth by interpolating
   changes between updates, so it moves smoothly. This would make it
   provide impression for user, not an accurate measure of blamed
   percentage.

 * A toy. Make sure that 3-coloring during updating blame table use
   all three colors with similar frequency, for example by using the
   following implementation of chooseColorNoFrom function:

    // return one of given possible colors
    // example: chooseColorNoFrom(2, 3) might be 2 or 3
    var colorsFreq = [0, 0, 0];
    // assumes that  1 <= arguments[i] <= colorsFreq.length
    function chooseColorNoFrom() {
    	// choose the color which is least used
    	var colorNo = arguments[0];
    	for (var i = 1; i < arguments.length; i++) {
    		if (colorsFreq[arguments[i]-1] < colorsFreq[colorNo-1]) {
    			colorNo = arguments[i];
    		}
    	}
    	colorsFreq[colorNo-1]++;
    	return colorNo;
    }


Do you have your own suggestions?  Comments?
Would incremental blame help git-instaweb use?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
