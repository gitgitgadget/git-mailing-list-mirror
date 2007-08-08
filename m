From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [install info (using perl) 1/2] Add support for an info version of the user manual
Date: Wed, 08 Aug 2007 16:05:12 -0700
Message-ID: <7v643p1vbr.fsf@assigned-by-dhcp.cox.net>
References: <591c5679ea79b76cd5db57443b1d691bde842351.1186484406.git.dak@gnu.org>
	<7vabt11vkj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 01:05:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIuaf-0004om-4G
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 01:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762368AbXHHXFP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 19:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761741AbXHHXFP
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 19:05:15 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:55687 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756245AbXHHXFO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 19:05:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070808230514.MXBC7349.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 8 Aug 2007 19:05:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Zb5C1X00Y1kojtg0000000; Wed, 08 Aug 2007 19:05:13 -0400
In-Reply-To: <7vabt11vkj.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 08 Aug 2007 15:59:56 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55392>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> @@ -139,6 +154,18 @@ XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
>>  user-manual.html: user-manual.xml
>>  	xsltproc $(XSLTOPTS) -o $@ $(XSLT) $<
>>  
>> +git.info: user-manual.xml
>> +	$(RM) $@ $*.texi
>> +	$(DOCBOOK2X_TEXI) user-manual.xml --to-stdout | \
>> +	perl -ne 'if (/^\@setfilename/) {$$_="\@setfilename git.info\
>> +"} elsif (/^\@direntry/) {print "\@dircategory Development\
>> +\@direntry\
>> +* Git: (git).           A fast distributed revision control system\
>> +\@end direntry\
>> +"} print unless (/^\@direntry/ .. /^\@end direntry/)' > $*.texi
>> +	$(MAKEINFO) --no-split $*.texi
>> +	$(RM) $*.texi
>> +
>
> This part worries me.

Aside from possible portability issue of multi-line script,
there is another slight problem I am not sure if it is worth
fixing.  If you do not have docbook2x-texi installed, nobody
notices that resulting $*.texi was a garbage and an almost empty
git.info is generated.
