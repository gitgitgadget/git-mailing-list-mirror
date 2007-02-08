From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] qgit: Default the log window to wider than the file list and set monospaced font
Date: Thu, 8 Feb 2007 23:04:16 +0000
Message-ID: <200702082304.17775.andyparkins@gmail.com>
References: <200702072138.36787.andyparkins@gmail.com> <200702081913.09952.andyparkins@gmail.com> <e5bfff550702081129x6c94eaa4p40cf09e70c4e09cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 09 00:08:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFIMy-0007HX-Uk
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 00:08:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422966AbXBHXHj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 18:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423057AbXBHXHj
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 18:07:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:54319 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422966AbXBHXHi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 18:07:38 -0500
Received: by ug-out-1314.google.com with SMTP id 44so612229uga
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 15:07:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KB9P25GY6DfueOQm8cAL304yfsgLddx2gb5QLdtmwcgMSDCbvArFGX1OmRYyYOk97GCSKAPtz6TRvGxyUGANyxjUr/D4J3cviBfHw9gcEGZW+P0M9hoDVd1W3/oa4dHaIORVbu91VtCjtG09LScqQAZ8scM+O25HzoS0PLYU31s=
Received: by 10.78.136.9 with SMTP id j9mr4632945hud.1170976056245;
        Thu, 08 Feb 2007 15:07:36 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id s7sm3947459uge.2007.02.08.15.07.28;
        Thu, 08 Feb 2007 15:07:34 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <e5bfff550702081129x6c94eaa4p40cf09e70c4e09cd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39116>

On Thursday 2007, February 08 19:29, Marco Costalba wrote:

> qgit4 seems to have more layout weirdeness also in patch and file
> tabs. I didn't fixed it until because I'm still wondering if it is
> enough fixing the layout using stretch factors or bite the bullet and
> implement a geometry persistent saving with QSettings (Qt4 is quite
> powerful in this regard), of course saved geometry should work both
> with maximized and not-maximized window, so perhaps saving
> panes/splitters factors is better then save absolute value at least
> for 'internal' widget, and use absolute window geometry only for qgit
> main window.

Saving factors is definitely the way to go; and then you may as well use 
the stretch factors as that's all they are in essence.  Setting a 3:1 
stretch ratio would be the same as setting 75% and 25% factors.  The 
ideal solution is really to set one of them based on the contents, 
probably the file list; but that's difficult to do as you don't want 
excessively deep trees to make the thing stupidly wide.  In the end, I 
think making layouts that work in all situations in near impossible, so 
I usually just go for stretch factors that make it look reasonable in 
most situations.

> Please add dbg(text) line in git.cpp, just below
> Qt::convertFromPlainText(text) call
>
> 		text.append("\n\n    " + colorMatch(c->shortLog(), shortLogRE) +
> 		            '\n' + colorMatch(c->longLog(), longLogRE));
> 	}
> 	text = Qt::convertFromPlainText(text);
> dbg(text);

Good idea.  I tried it and the problem would seem to be that 
convertFromPlainText() doesn't do the conversion as completely as it 
should.  The spaces are being left as spaces, but of course when those 
get passed to the HTML-ish parser of QTextBrowser, the spaces are being 
swallowed - as with all HTML parsers.  I believe it should actually be 
replacing all the spaces with "&nbsp;" to /really/ do the plain->HTML 
conversion.  However, the point is moot now anyway because I've dropped 
it in favour of a div with "white-space: pre" set, which does the job.


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
