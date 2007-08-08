From: David Kastrup <dak@gnu.org>
Subject: Re: [install info (using perl) 1/2] Add support for an info version of the user manual
Date: Thu, 09 Aug 2007 01:25:59 +0200
Message-ID: <85k5s5pq0o.fsf@lola.goethe.zz>
References: <591c5679ea79b76cd5db57443b1d691bde842351.1186484406.git.dak@gnu.org>
	<7vabt11vkj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 01:26:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIuv9-0002I1-KB
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 01:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762867AbXHHX0G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 19:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762179AbXHHX0F
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 19:26:05 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:35644 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761552AbXHHX0B (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Aug 2007 19:26:01 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 76BA84C879;
	Thu,  9 Aug 2007 01:26:00 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id 6177528EE19;
	Thu,  9 Aug 2007 01:26:00 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-025-080.pools.arcor-ip.net [84.61.25.80])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 3904836E866;
	Thu,  9 Aug 2007 01:26:00 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id BA44D1C3C79D; Thu,  9 Aug 2007 01:25:59 +0200 (CEST)
In-Reply-To: <7vabt11vkj.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed\, 08 Aug 2007 15\:59\:56 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55396>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
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
>
> Historically (as you probably know, having suffered a lot more
> than me with this issue), multi-line command script in Makefile
> was hugely unportable.  Some "make" implementations stripped
> backslash linefeed at the end, some other implementations
> stripped only backslash, yet some other kept both backslash and
> linefeed.  It was a mess.
>
> Admittably we are already quite dependent on GNU make,

Yes, definitely.  That's why I did it that way in the first place.  It
is probably not inconceivable, however, that even then some
combination of make port and perl port to Windows would get into a
tizzy.

> so this is probably not a huge deal, but I have a vague recollection
> that even GNU make itself changed its behaviour over time with
> respect to this exact area, and I had to adjust a few Makefiles to
> accomodate both old and new GNU make.

I have to admit that I did not know in advance how this would work out
and adapted the code to the behavior.

> The standard workaround is of course to have this perl script
> part as a separate, "Documentation/fixup-texi.perl" script and
> invoke it from the Makefile.

I can code this as a single overlong line reasonably easy.  And it is
not actually necessary to do the @setfilename replacement: one can
just specify an override of the output file name.  That shortens the
Perl script.  I'll have to see whether I can get rid of it completely,
but the documentation for docbook2X is really bad (and the author did
not respond to Email yet).  And googling on the net showed that I am
not the only one who fixed up after docbook2X manually.

Don't expect a new patch in this area soon: I am messing with other
stuff right now and it does not make sense reworking this again when I
am not sure yet whether I can throw it out altogether.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
