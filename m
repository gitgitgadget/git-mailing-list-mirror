From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: co-authoring commits
Date: Thu, 18 Jun 2015 06:54:51 -0400
Organization: PD Inc
Message-ID: <FBF98192E9F44B6E97F211B961DC7905@black7>
References: <CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com> <xmqq4mm66r99.fsf@gitster.dls.corp.google.com> <CAOvwQ4j2bjR1jnLVyZbw1OCE=xQxbCEFGKcK1bpuv1K3s_Y2EQ@mail.gmail.com> <20150617225224.GF4076@thunk.org>
Reply-To: <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>,
	  "Josh Triplett" <josh@joshtriplett.org>,
	  "Tuncer Ayaz" <tuncer.ayaz@gmail.com>,
	  "Theodore Ts'o" <tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Josh Triplett'" <josh@joshtriplett.org>,
	"'Tuncer Ayaz'" <tuncer.ayaz@gmail.com>,
	"'Theodore Ts'o'" <tytso@mit.edu>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 18 13:56:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5YQq-0005wQ-Sy
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859AbbFRL41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:56:27 -0400
Received: from mail.pdinc.us ([67.90.184.27]:40670 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753768AbbFRL4W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:56:22 -0400
X-Greylist: delayed 3702 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jun 2015 07:56:22 EDT
Received: from black7 ([70.42.157.91])
	(authenticated bits=0)
	by mail.pdinc.us (8.14.4/8.12.11) with ESMTP id t5IAsX2s011493;
	Thu, 18 Jun 2015 06:54:34 -0400
In-Reply-To: <20150617225224.GF4076@thunk.org>
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdCpUFTdg9fPTqgTRK+aOEL6rnCLAwAY3K4g
X-MimeOLE: Produced By Microsoft MimeOLE V6.1.7601.17609
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272002>

> -----Original Message-----
> From: Theodore Ts'o
> Sent: Wednesday, June 17, 2015 6:52 PM
> 
> On Wed, Jun 17, 2015 at 10:26:32PM +0200, Tuncer Ayaz wrote:
> > 
> > By allowing multiple authors, you don't have to decide who's the 
> > primary author, as in such situations usually there is no 
> primary at 
> > all. I sometimes deliberately override the author when 
> committing and 
> > add myself just as another co-author in the commit message, but as 
> > others have noted it would be really great if we can just specify 
> > multiple authors.
<snip/>
> One could imagine some frankly, quite rare example where 
> there is a team of people who votes on each commit before it 
> gets sent out and where everyone is equal and there is no 
> hierarchy.  In that case, perhaps you could set the from 
> field to a mailing list address.

This is a perfect use the signed commit by multiple persons. Git already
supports it (under the hood and in reporting).

A quick google pulled up my notes on this:

http://marc.info/?l=git&m=140845378317052&w=2

$ cat merge-multisigs.sh
#!/bin/bash
(
 for i in "$@"
 do
  gpg --dearmor < "$i"
 done
) | gpg --enarmor

$ cat write-commit.ruby
#!/usr/bin/irb
require 'fileutils'
file = File.open(ARGV[0], "rb")
content = file.read
header = "commit #{content.length}\0"
store = header + content
require 'digest/sha1'
sha1 = Digest::SHA1.hexdigest(store)
require 'zlib'
zlib_content = Zlib::Deflate.deflate(store)
path = '.git/objects/' + sha1[0,2] + '/' + sha1[2,38]
FileUtils.mkdir_p(File.dirname(path))
File.open(path, 'w') { |f| f.write zlib_content }


--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 
