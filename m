From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: use correct mime type even if filename has multiple dots.
Date: Sun, 17 Sep 2006 10:23:45 +0200
Organization: At home
Message-ID: <eej0l8$36t$1@sea.gmane.org>
References: <20060916210933.GX17042@admingilde.org> <eehr7e$5i0$1@sea.gmane.org> <20060917075157.GY17042@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Sep 17 10:23:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOrvy-0005tw-H3
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 10:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWIQIXT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 04:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWIQIXT
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 04:23:19 -0400
Received: from main.gmane.org ([80.91.229.2]:5023 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751193AbWIQIXS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Sep 2006 04:23:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GOrvk-0005qN-Ck
	for git@vger.kernel.org; Sun, 17 Sep 2006 10:23:12 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 10:23:12 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 10:23:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27163>

Martin Waitz wrote:

> hoi :)
> 
> On Sat, Sep 16, 2006 at 11:44:52PM +0200, Jakub Narebski wrote:
>> Martin Waitz wrote:
>> 
>> > Match the last part of the filename agains the extention from the
>> > mime database instead of insisting that it starts at the first dot.
>> [...]
>> > -     $filename =~ /\.(.*?)$/;
>> > -     return $mimemap{$1};
>> 
>> Actually, that is non-greedy match, so the above code insist that 
>> extension starts at the _last_ dot.
> 
> hmm, but it didn't work for me.
> I had filenames like "man/program.8.html" which got served as
> "text/html" with the old code.

And why it shouldn't? From the extension it is HTML page, I would guess
manpage converted to HTML (pretty-printed manpage). And it should be served
with text/html mimetype.

> Besides, the new code would cope with extentions that contain a
> dot itself.

But is unnecessary complicated, and I guess performance suffers a bit.

> Looking at /etc/mime.types, it only contains pcf.Z but perhaps

So the *.pcf.Z file wouldn't get correct mimetype. No big.

> it should also contain tar.gz or similiar.

You can't properly serve tar.gz as something other than with
application/x-gzip mimetype. If you want to serve it as/with 
application/x-tar mimetype, you would need to add 
        Content-Encoding: x-gzip
in addition to
        Content-Type: application/x-tar
And your code doesn't do that.

The _last_ extension defines the type.


Besides, with the exception of files which can be displayed in browser, 
i.e. HTML files and images it doesn't matter what the mimetype is, if only
binary files get binary mimetype (e.g. generic application/octet-stream).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
